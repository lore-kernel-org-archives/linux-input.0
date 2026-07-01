Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CA4CA296
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934353; cv=none; b=q3d7IBxXLdxVv5X0ZMhHiSjiZIZ54+yXkmrZCNM0KOYkWYh+2aDOW22pahr2qW4WHj42ehZ/ACzms3l044fqkrKdjD7uGrWUsWfhiGRYilGQco2loVPX593vrLYkVl5IRLlOJXhA8lMaaPw37bTjK6zzbRj+rYoJ5P+khDTFKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934353; c=relaxed/simple;
	bh=ygro6yKXxNeG6O2sbzZ+yQKjJFKwQrNC6BlstkcWwr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLI5+IaYStjWoLXyuiViqYLVnPACJe0I5RQnmbHFQZLswxDiuLTSV290xn8XUwpPTxaI3xHodY7s7vAIwTA2KSOJCGRtSTXb1wZl6k3gQO9mlOcQHfSnGJ3IjVJcbMwZhrDHrR4OS4IWljO1pO3tZ8XlhX1v1c0BLyBtfbyRL6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYLESgEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYLESgEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A5B1F00A3E;
	Wed,  1 Jul 2026 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934351;
	bh=x3GD33psYlLkF6l6QujnUzAulpZ+fBGOzET5UbXjSE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYLESgEHhYqK/SodqPu4Js6ruruGrNKLTkF9OzlKrVMFLFjUCoAFBGs8lY4X/C4xc
	 MQBijMJhGBhl1gpY1LFs3PzmZ5zpPPuMBLLa12JxDAm4RSvCU/0d5SuO1GiKDCwYas
	 c9c5jFtI5IaTfYA8HDTkAeB0Tb8drGnBF3zKYZnwCNrdRNQUEzDVjontwyKn4+N+3j
	 MRVjINZvHxdNAHKIIKotlVWMCMxc/um81N3xWaTb2WXrBNNl6ftXeW5bfr8K1BLBdC
	 qdXz5G9oV7F98EJq2uijR3fS2YgXtUDGf5YPzo0SZYbPPp4NF5gRKTcYLEI/Uf0UJb
	 f56X4dtm/qEqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: focaltech - fix array out-of-bounds in
 focaltech_process_rel_packet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Davies" <richard@arachsys.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260701190932.14960-1-richard@arachsys.com>
References: <20260701190932.14960-1-richard@arachsys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 19:32:30 +0000
Message-Id: <20260701193231.78A5B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unsigned coordinate wrapping causes the cursor to incorrectly ju=
mp to the opposite edge when processing relative movements.
--

commit 7c58aa99b660b4d96ec349d279fd307555360fd9
Author: Richard Davies <richard@arachsys.com>

Input: focaltech - fix array out-of-bounds in focaltech_process_rel_packet

Make finger2 (and also finger1) unsigned, so that if the finger index in
the packet is 0 then subtracting 1 creates an array index which overflows
above the existing check for FOC_MAX_FINGERS, as the existing comment says
it should, instead of writing to state->fingers[-1].

> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focalt=
ech.c
> index 43f9939b7c63c..d3ad4af5aa09d 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -197,7 +197,7 @@ static void focaltech_process_rel_packet(struct psmou=
se *psmouse,
>  {
>  	struct focaltech_data *priv =3D psmouse->private;
>  	struct focaltech_hw_state *state =3D &priv->state;
> -	int finger1, finger2;
> +	unsigned int finger1, finger2;
> =20
>  	state->pressed =3D packet[0] >> 7;
>  	finger1 =3D ((packet[0] >> 4) & 0x7) - 1;

[Severity: Medium]
This isn't a bug introduced by this patch, but does the unsigned type of the
finger coordinates cause them to incorrectly wrap around when applying
relative movements?

When processing relative packets:

drivers/input/mouse/focaltech.c:focaltech_process_rel_packet() {
    ...
		state->fingers[finger1].x +=3D (s8)packet[1];
		state->fingers[finger1].y +=3D (s8)packet[2];
    ...
}

Because x and y are defined as unsigned int, subtracting a value that drops
the coordinate below 0 causes an integer underflow, wrapping it to a large
positive number.

Then, when clamping the coordinates:

drivers/input/mouse/focaltech.c:focaltech_report_state() {
    ...
			clamped_x =3D clamp(finger->x, 0U, priv->x_max);
			clamped_y =3D clamp(finger->y, 0U, priv->y_max);
    ...
}

The underflowed unsigned value is incorrectly clamped to the maximum bound
instead of 0. This could cause the user's cursor to jump erratically to the
opposite edge of the screen when dragging a finger near the left or bottom
edge of the touchpad.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701190932.1496=
0-1-richard@arachsys.com?part=3D1
