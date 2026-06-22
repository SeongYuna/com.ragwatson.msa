import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '정성윤',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const PortfolioPage(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFFAFAFA),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: isDark ? Colors.white : Colors.black,
        onPrimary: isDark ? Colors.black : Colors.white,
        secondary: const Color(0xFF6366F1),
        onSecondary: Colors.white,
        surface: isDark ? const Color(0xFF111111) : const Color(0xFFF4F4F5),
        onSurface: isDark ? Colors.white : Colors.black,
        error: Colors.red,
        onError: Colors.white,
      ),
      fontFamily: 'Pretendard',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w500,
          letterSpacing: -1.0,
          color: isDark ? Colors.white : Colors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 17,
          height: 1.7,
          color: isDark ? const Color(0xFFE4E4E7) : const Color(0xFF18181B),
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: isDark ? const Color(0xFFA1A1AA) : const Color(0xFF71717A),
        ),
        labelSmall: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeroSection(),
              ContentSections(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final muted = cs.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('정성윤', style: tt.displayLarge),
          const SizedBox(height: 16),
          Text(
            'Crafting digital experiences.',
            style: tt.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 20,
              color: muted,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '풀스택 개발자로서 세련된 소프트웨어와 웹 경험을 구축합니다. '
            '사용자 인터페이스의 섬세한 디테일을 실험하고, '
            '접근성과 성능을 모두 갖춘 애플리케이션을 만드는 것에 열정을 가지고 있습니다.',
            style: tt.bodyLarge,
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: tt.bodyMedium,
              children: [
                const TextSpan(text: '현재 '),
                TextSpan(
                  text: '스타트업',
                  style: TextStyle(
                    color: cs.onSurface,
                    decoration: TextDecoration.underline,
                    decorationColor: cs.onSurface,
                  ),
                ),
                const TextSpan(
                  text: '에서 프론트엔드 엔지니어로 일하고 있으며, 이전에는 ',
                ),
                TextSpan(
                  text: 'Tech Company',
                  style: TextStyle(
                    color: cs.onSurface,
                    decoration: TextDecoration.underline,
                    decorationColor: cs.onSurface,
                  ),
                ),
                const TextSpan(text: '의 디자인 시스템과 웹사이트를 개발했습니다.'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _SocialIcon(
                icon: Icons.code,
                label: 'GitHub',
                url: 'https://github.com',
              ),
              const SizedBox(width: 24),
              _SocialIcon(
                icon: Icons.work_outline,
                label: 'LinkedIn',
                url: 'https://linkedin.com',
              ),
              const SizedBox(width: 24),
              _SocialIcon(
                icon: Icons.mail_outline,
                label: 'Email',
                url: 'mailto:hello@example.com',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialIcon({required this.icon, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);

    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Icon(icon, size: 22, color: muted),
    );
  }
}

// ── Content Sections ──────────────────────────────────────────────────────────

class ContentSections extends StatelessWidget {
  const ContentSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _ProjectsSection(),
          const SizedBox(height: 64),
          _ExperienceSection(),
          const SizedBox(height: 64),
          _WritingSection(),
          const SizedBox(height: 64),
          _ContactSection(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

// Projects ────────────────────────────────────────────────────────────────────

final _projects = [
  (
    title: 'Design System',
    description: '모던한 React 컴포넌트 라이브러리. Tailwind CSS와 Radix UI 기반.',
    tags: ['React', 'TypeScript', 'Tailwind'],
  ),
  (
    title: 'AI Dashboard',
    description: '실시간 데이터 시각화와 AI 인사이트를 제공하는 분석 대시보드.',
    tags: ['Next.js', 'AI SDK', 'Vercel'],
  ),
  (
    title: 'Mobile App',
    description: '크로스 플랫폼 모바일 애플리케이션. 네이티브 수준의 성능.',
    tags: ['Flutter', 'Dart', 'TypeScript'],
  ),
];

class _ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionLayout(
      label: 'PROJECTS',
      child: Column(
        children: _projects
            .map((p) => _ProjectItem(title: p.title, description: p.description, tags: p.tags))
            .toList(),
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;

  const _ProjectItem({required this.title, required this.description, required this.tags});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: tt.headlineMedium),
              const SizedBox(width: 6),
              Icon(Icons.north_east, size: 16, color: Theme.of(context).colorScheme.secondary),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: tt.bodyMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: tags.map((t) => _Tag(t)).toList(),
          ),
        ],
      ),
    );
  }
}

// Experience ──────────────────────────────────────────────────────────────────

final _experiences = [
  (
    period: '2023 — 현재',
    role: 'Senior Frontend Engineer',
    company: 'Startup Inc.',
    description: '프론트엔드 아키텍처 설계 및 개발. 디자인 시스템 구축과 팀 리딩.',
    tags: ['Next.js', 'TypeScript', 'React'],
  ),
  (
    period: '2021 — 2023',
    role: 'Frontend Engineer',
    company: 'Tech Corp.',
    description: '웹 애플리케이션 개발 및 성능 최적화. 접근성 개선 주도.',
    tags: ['React', 'Node.js', 'GraphQL'],
  ),
  (
    period: '2019 — 2021',
    role: 'Junior Developer',
    company: 'Agency Studio',
    description: '다양한 클라이언트 프로젝트 개발. UI/UX 구현에 집중.',
    tags: ['JavaScript', 'Vue.js', 'SCSS'],
  ),
];

class _ExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionLayout(
      label: 'EXPERIENCE',
      child: Column(
        children: _experiences
            .map(
              (e) => _ExperienceItem(
                period: e.period,
                role: e.role,
                company: e.company,
                description: e.description,
                tags: e.tags,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String period;
  final String role;
  final String company;
  final String description;
  final List<String> tags;

  const _ExperienceItem({
    required this.period,
    required this.role,
    required this.company,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final accent = Theme.of(context).colorScheme.secondary;
    final muted = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(period, style: tt.bodyMedium?.copyWith(color: muted, fontSize: 13)),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              style: tt.headlineMedium,
              children: [
                TextSpan(text: '$role · '),
                TextSpan(text: company, style: TextStyle(color: accent)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(description, style: tt.bodyMedium),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 6, children: tags.map((t) => _Tag(t)).toList()),
        ],
      ),
    );
  }
}

// Writing ─────────────────────────────────────────────────────────────────────

final _writings = [
  (title: 'React 성능 최적화 가이드', description: '효율적인 렌더링을 위한 패턴과 기법들.'),
  (title: '디자인 시스템 구축하기', description: '일관된 UI를 위한 컴포넌트 설계 원칙.'),
  (title: '접근성을 고려한 웹 개발', description: '모든 사용자를 위한 포용적 디자인.'),
];

class _WritingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionLayout(
      label: 'WRITING',
      child: Column(
        children: _writings
            .map((w) => _WritingItem(title: w.title, description: w.description))
            .toList(),
      ),
    );
  }
}

class _WritingItem extends StatelessWidget {
  final String title;
  final String description;

  const _WritingItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: tt.headlineMedium?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: cs.onSurface.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 4),
          Text(description, style: tt.bodyMedium),
        ],
      ),
    );
  }
}

// Contact ─────────────────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final muted = cs.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);

    return _SectionLayout(
      label: 'CONTACT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '프로젝트 논의나 단순히 인사를 나누고 싶다면, 언제든 연락 주세요.',
            style: tt.bodyLarge,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse('mailto:hello@example.com')),
            child: Text(
              'hello@example.com',
              style: tt.bodyMedium?.copyWith(color: muted),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _TextLink(label: 'GitHub', url: 'https://github.com'),
              const SizedBox(width: 24),
              _TextLink(label: 'LinkedIn', url: 'https://linkedin.com'),
              const SizedBox(width: 24),
              _TextLink(label: 'X / Twitter', url: 'https://twitter.com'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TextLink extends StatelessWidget {
  final String label;
  final String url;

  const _TextLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: muted, fontSize: 14),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);
    final dividerColor = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFF27272A)
        : const Color(0xFFE4E4E7);

    return Column(
      children: [
        Divider(color: dividerColor, height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2026 정성윤. All rights reserved.',
                  style: tt.bodyMedium?.copyWith(color: muted, fontSize: 13)),
              Text('Built with Flutter',
                  style: tt.bodyMedium?.copyWith(color: muted, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Shared Widgets ────────────────────────────────────────────────────────────

class _SectionLayout extends StatelessWidget {
  final String label;
  final Widget child;

  const _SectionLayout({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.brightness == Brightness.dark
        ? const Color(0xFFA1A1AA)
        : const Color(0xFF71717A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: muted,
                letterSpacing: 1.5,
              ),
        ),
        const SizedBox(height: 24),
        child,
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF27272A) : const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: isDark ? const Color(0xFFD4D4D8) : const Color(0xFF52525B),
        ),
      ),
    );
  }
}
