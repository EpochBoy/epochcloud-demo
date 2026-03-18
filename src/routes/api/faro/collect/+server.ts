import type { RequestHandler } from './$types';

const FARO_RECEIVER = 'http://alloy.alloy.svc.cluster.local:12347/collect';

export const POST: RequestHandler = async ({ request }) => {
	const body = await request.text();

	const response = await fetch(FARO_RECEIVER, {
		method: 'POST',
		headers: {
			'Content-Type': request.headers.get('content-type') || 'application/json'
		},
		body
	});

	return new Response(response.body, {
		status: response.status,
		headers: {
			'Content-Type': response.headers.get('content-type') || 'application/json'
		}
	});
};
