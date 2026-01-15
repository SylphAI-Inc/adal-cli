import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'AdaL',
  tagline: 'Your Agentic Coding Tool in Terminal',
  favicon: 'adal-face-logo.svg',

  // Set the production url of your site here
  url: 'https://adal-cli-docs.onrender.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For Render deployment, use root
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'SylphAI-Inc', // Usually your GitHub org/user name.
  projectName: 'adal-cli', // Usually your repo name.

  onBrokenLinks: 'throw',

  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          sidebarCollapsible: false, // Keep all categories expanded
          routeBasePath: '/', // Docs as homepage
          // Disabled - users can find edit instructions in README
          // editUrl: 'https://github.com/SylphAI-Inc/adal-cli/tree/main/docs-site/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],


  themeConfig: {
    // Replace with your project's social card
    // image: 'img/docusaurus-social-card.jpg',
    colorMode: {
      defaultMode: 'dark',
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: '',
      logo: {
        alt: 'AdaL Logo',
        src: 'adal-face-logo.svg',
        srcDark: 'logo_dark.png',

      },
      items: [
        {
          to: '/',
          label: 'Get Started',
          position: 'left',
        },
        {
          to: '/features/slash-commands',
          label: 'Features',
          position: 'left',
        },
        {
          to: '/troubleshooting/installation',
          label: 'Troubleshooting',
          position: 'left',
        },
        {
          to: '/changelog',
          label: 'Changelog',
          position: 'left',
        },
        {
          href: 'https://github.com/SylphAI-Inc/adal-cli',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Company',
          items: [
            {
              label: 'SylphAI',
              href: 'https://sylph.ai',
            },
            {
              label: 'Careers',
              href: 'https://sylph.ai/careers',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Follow AdaL',
              href: 'https://x.com/adaboringai',
            },
            {
              label: 'Discord',
              href: 'https://discord.gg/sylphai',
            },
            {
              label: 'GitHub Discussions',
              href: 'https://github.com/SylphAI-Inc/adal/discussions',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'Doc GitHub',
              href: 'https://github.com/SylphAI-Inc/adal-cli',
            },
            {
              label: 'AdalFlow GitHub',
              href: 'https://github.com/SylphAI-Inc/AdalFlow',
            },
          ],
        },
      ],
      copyright: `> Built by AdaL & SylphAI © ${new Date().getFullYear()}`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bash', 'json', 'yaml', 'typescript', 'python', 'markdown', 'diff'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;