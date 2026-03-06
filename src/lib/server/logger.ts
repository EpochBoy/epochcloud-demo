export function log(level: 'info' | 'warn' | 'error', message: string, fields: Record<string, unknown> = {}) {
	const entry = {
		timestamp: new Date().toISOString(),
		level,
		service: 'epochcloud-demo',
		message,
		...fields
	};
	const out = JSON.stringify(entry);
	if (level === 'error') {
		console.error(out);
	} else if (level === 'warn') {
		console.warn(out);
	} else {
		console.log(out);
	}
}
