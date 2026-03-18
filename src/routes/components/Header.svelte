<script lang="ts">
	let { environment, domain }: { environment: string; domain: string } = $props();

	function envBadgeClass(env: string): string {
		switch (env) {
			case 'prod':
				return 'badge-prod';
			case 'staging':
				return 'badge-staging';
			default:
				return 'badge-dev';
		}
	}

	const stages = [
		{ label: 'Dev', prefix: 'demo-dev' },
		{ label: 'Staging', prefix: 'demo-staging' },
		{ label: 'Prod', prefix: 'demo' }
	];
</script>

<header class="header">
	<div class="header-row">
		<h1 class="logo">EpochCloud</h1>
		<span class="env-badge {envBadgeClass(environment)}">{environment}</span>
	</div>
	<p class="tagline">Infrastructure Dashboard</p>
	<nav class="stage-nav">
		{#each stages as stage (stage.label)}
			<a
				href="https://{stage.prefix}.{domain}"
				class="stage-pill"
				class:active={environment === (stage.label === 'Prod' ? 'prod' : stage.label.toLowerCase())}
			>
				{stage.label}
			</a>
		{/each}
	</nav>
</header>

<style>
	.header {
		text-align: center;
		margin-bottom: 1.5rem;
	}

	.header-row {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.75rem;
	}

	.logo {
		font-size: 2rem;
		font-weight: 700;
		letter-spacing: -0.03em;
		margin: 0;
		color: var(--text);
	}

	.tagline {
		color: var(--text-secondary);
		font-size: 0.875rem;
		margin: 0.25rem 0 0.75rem;
	}

	.env-badge {
		display: inline-flex;
		align-items: center;
		padding: 0.2rem 0.6rem;
		border-radius: 9999px;
		font-size: 0.7rem;
		font-weight: 600;
		text-transform: uppercase;
		letter-spacing: 0.06em;
	}

	.badge-dev {
		background: rgba(99, 102, 241, 0.15);
		color: #818cf8;
		border: 1px solid rgba(99, 102, 241, 0.3);
	}

	.badge-staging {
		background: rgba(245, 158, 11, 0.15);
		color: #f59e0b;
		border: 1px solid rgba(245, 158, 11, 0.3);
	}

	.badge-prod {
		background: rgba(239, 68, 68, 0.15);
		color: #ef4444;
		border: 1px solid rgba(239, 68, 68, 0.3);
	}

	.stage-nav {
		display: flex;
		justify-content: center;
		gap: 0.375rem;
	}

	.stage-pill {
		padding: 0.3rem 0.875rem;
		border-radius: 9999px;
		font-size: 0.8rem;
		text-decoration: none;
		color: var(--muted-fg);
		background: transparent;
		border: 1px solid var(--border);
		transition: all 0.15s ease;
	}

	.stage-pill:hover {
		color: var(--text-secondary);
		border-color: var(--border-hover);
	}

	.stage-pill.active {
		color: var(--text);
		background: rgba(255, 255, 255, 0.06);
		border-color: var(--border-hover);
	}

	@media (max-width: 768px) {
		.logo {
			font-size: 1.5rem;
		}
	}
</style>
