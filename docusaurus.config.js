// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Pintar Help',
  tagline: 'Documentation for Pintar Webiste',
  favicon: 'https://storage.googleapis.com/cdn-1.pintaria.com/pintaria/pico/logo_pintaria_mobile.png',

  // Set the production url of your site here
  url: 'https://help.pintar.co',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'Pintar-Pemenang-Asia', // Usually your GitHub org/user name.
  projectName: 'help.pintar.co', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'id'],
    localeConfigs: {
      id: {
        label: 'Bahasa Indonesia',
        htmlLang: 'id-ID',
      }
    }
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/Pintar-Pemenang-Asia/help.pintar.co/blob/main',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/Pintar-Pemenang-Asia/help.pintar.co/blob/main/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'https://storage.googleapis.com/cdn-1.pintaria.com/pintaria/v6/images/logo_pintar.svg',
      navbar: {
        title: 'Help',
        logo: {
          alt: 'Pintar Logo',
          src: 'https://storage.googleapis.com/cdn-1.pintaria.com/pintaria/v6/images/logo_pintar.svg',
        },
        items: [
          {to: '/', label: 'Home', position: 'left'},
          {
            type: 'docSidebar',
            sidebarId: 'degrees',
            position: 'left',
            label: 'Degrees',
          },
          {
            type: 'docSidebar',
            sidebarId: 'enterprise',
            position: 'left',
            label: 'Enterprise',
          },
          {
            type: 'docSidebar',
            sidebarId: 'skills',
            position: 'left',
            label: 'Skills',
          },
          {
            type: 'docSidebar',
            sidebarId: 'prakerja',
            position: 'left',
            label: 'Prakerja',
          },
          {
            type: 'docSidebar',
            sidebarId: 'faq',
            position: 'left',
            label: 'FAQ',
          },
          {to: '/blog', label: 'Blog', position: 'right'},
          {
            type: 'localeDropdown',
            position: 'right',
          },
          {
            href: 'https://github.com/Pintar-Pemenang-Asia/help.pintar.co',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Degree',
                to: '/docs/degrees/introduction',
              },
              {
                label: 'Enterprise',
                to: '/docs/enterprise/introduction',
              },
              {
                label: 'FAQ',
                to: '/docs/faq/introduction',
              },
              {
                label: 'Blog',
                to: '/blog',
              },
            ],
          },
          {
            title: 'Social',
            items: [
              {
                label: 'Instagram',
                href: 'https://www.instagram.com/pintar_co',
              },
              {
                label: 'Tik Tok',
                href: 'https://www.tiktok.com/@pintar_co',
              },
              {
                label: 'Linked In',
                href: 'https://www.linkedin.com/company/pintarco/',
              },
              {
                label: 'GitHub',
                href: 'https://github.com/Pintar-Pemenang-Asia/help.pintar.co',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: "About Us",
                to: "https://pintar.co/about",
              },
              {
                label: "Contact Us",
                to: "https://pintar.co/page/contact-us",
              }
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} PT. PINTAR PEMENANG ASIA.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
