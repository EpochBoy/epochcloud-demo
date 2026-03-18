<footer class="footer">
	<span>EpochCloud Demo</span>
	<span class="footer-sep"></span>
	<span>{new Date().toISOString()}</span>
</footer>

<style>
	.footer {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.5rem;
		padding: 1rem;
		color: var(--muted-fg);
		font-size: 0.75rem;
		border-top: 1px solid var(--border);
		margin-top: 1rem;
	}

	.footer-sep {
		width: 3px;
		height: 3px;
		border-radius: 50%;
		background: var(--muted-fg);
	}
</style>
