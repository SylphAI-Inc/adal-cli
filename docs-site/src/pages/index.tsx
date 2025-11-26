import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';
import CodeBlock from '@theme/CodeBlock';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero', styles.heroBanner)}>
      <div className="container">
        <Heading as="h1" className="hero__title">
          AdaL CLI
        </Heading>
        <p className="hero__subtitle">
        AdaL CLI is your AI teammate for engineering and research.

        <br />

        Ada's vision, intelligence is more than calculation. Our vision: it is more than code.
        </p>
      </div>
    </header>
  );
}

function GetStartedSection() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          <div className="col col--12">
            <Heading as="h2">Get started in 30 seconds</Heading>

            <div className={styles.installSection}>
              <h3>Install AdaL CLI</h3>
              <p style={{marginBottom: '1rem'}}>
                <strong>Requirement:</strong> Node.js 20+ (<Link to="https://nodejs.org/en/download/">Download Node.js</Link>)
              </p>
              <CodeBlock language="bash">
                npm install -g @sylphai/adal-cli
              </CodeBlock>

              <h3 style={{marginTop: '2rem'}}>Start AdaL CLI in your project</h3>
              <CodeBlock language="bash">
{`# Navigate to your project
cd your-awesome-project

# Start AdaL CLI and you'll be prompted to log in on first use
adal`
}
              </CodeBlock>
            </div>
              
          </div>
        </div>
      </div>
    </section>
  );
}


function WhatAdalDoes() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          <div className="col col--12">
            <Heading as="h2">What ADAL CLI does for you</Heading>

            <h3 style={{marginTop: '2rem', marginBottom: '1rem'}}>Code & Development</h3>
            <ul className={styles.featureList}>
              <li>Write, edit, and refactor code in multiple languages</li>
              <li>Debug complex issues and implement comprehensive tests</li>
              <li>Search codebases and analyze project architecture</li>
              <li>Execute commands seamlessly (git, npm, docker, and more)</li>
            </ul>

            <h3 style={{marginTop: '2rem', marginBottom: '1rem'}}>Research & Analysis</h3>
            <ul className={styles.featureList}>
              <li>Search the web for up-to-date information and solutions</li>
              <li>Analyze technical documentation and best practices</li>
              <li>Provide guidance on architecture and design decisions</li>
            </ul>

            <div className={styles.buttons} style={{marginTop: '3rem'}}>
              <Link
                className="button button--primary button--lg"
                to="/docs/getting-started/your-first-session">
                Continue with Quickstart →
              </Link>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default function Home(): JSX.Element {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`${siteConfig.title} - Your AI/ML Engineer in Terminal`}
      description="ADAL CLI is an agentic coding tool that helps developers build faster">
      <HomepageHeader />
      <main>
        <GetStartedSection />
        <WhatAdalDoes />
      </main>
    </Layout>
  );
}