Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616054;
	b=A0Qb1BEEzCHHOH5r5z/PseGEmZcHn/4c44z1aW4n49OMRifwbwmzNFzXuwffCq2QlEoO
	 MghV9rAqa7/MR935J8qXNySBwKwazZYEvsE6sN97602IJu1frh3oGuKcFsMAlNWuUPCi1
	 gQwCsC2eYWLaQJWkhB3riVcrTTKHYu46d9o/RLkz5enZttM7BOtcXqgGEXWtERqqSw6XG
	 xsb5LkG+awUqR7B/3eDmz42zWMtO9yLROmrN7R5c9xv8ycFz9DUDFUhmj/+dUMAdS4xvr
	 s0bWczOoQ9s1CLdwnVU2xGM/fV2Xl7PlX+nZ3NO0ymGyP3z3owhcGKXHkbSxJNcRTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iTn0NZoro46Sdp/2BZxMZZqXSoDwoXBVp8gQg2zPl1U=;
	b=1EeCGzzcZ9bCjJOaNEqF0gDtTc514CZOhhj0qPcFOo4eSLpXg3vCHjOkWtbNfK0jOdIZ
	 lxCu+Z/UpQrByupwLQIPAAuvTa6UAZutdKS/Cyb6VGmUprx+rrOb2Ex6WGAwqWy1nNxAy
	 OTvCRFUPOmyqvAqNNp8hIfSgW4dRebVmrZQrTR2JO5/IEYRPjyG24TcubzBhHp9U8InBU
	 3mRQyPwZQYnJ27zyAiq3KNypm3kMmzWuhcl6NztzvwejIQlBtPyDgaTB9Wo/vyVZydOZU
	 haZt6lwtH8HUZOfVdNDjW7VggowWP7Y1p8DQI+bKzU3mPkjSmQZhB3fgtEjCzAipF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsbW+dwL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D4606A327
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsbW+dwL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C021F000E1;
	Wed, 25 Nov 2026 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616053;
	bh=iTn0NZoro46Sdp/2BZxMZZqXSoDwoXBVp8gQg2zPl1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EsbW+dwLxLPCn7sQn8dlY9xQxSyvjP38Mo5RieeJCTmhSWDjtn+pYVGNCG7QPKY0b
	 EJ4CsIlhr7jN+bxpxbUMqTc/rF81MvyWwKUeyIFegz1Ra+H1lzvdiYP0Yer2+iOdp5
	 L242w02rrUUco7swCEKJgOu48480UU2GSujLDs3DsJCpPCJONpxiD+XD/ve+SnNgmh
	 ClY3D0qMLQD8TRdCsMiT5r7h/Q9zHPBNweYE9waoGG+H9adHcnOrxaC0szmqKhDL2P
	 DG7X2kAiXlxHYOZifv06pQ9PMoRBetJKdkI5bS30l9yWSusmBSk0369RhvLlMoltFH
	 C5dMQiWUO9ZvQ==
Message-ID: <sashiko-outbox-233538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hid-core: sanitize user input in 'new_id_store'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawel Zalewski" <pzalewski@thegoodpenguin.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261125-acpi-sanitizer-v1-1-44b4aa8c538e@thegoodpenguin.co.uk>
References: <20261125-acpi-sanitizer-v1-1-44b4aa8c538e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 14:14:13 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: hid-core: missing Fixes trailer for new_id_store()
  driver_data fix
--

commit d1cb0e18023478a6fef5f2aabb283847ff8ab596
Author: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

> HID: hid-core: sanitize user input in 'new_id_store'
>
> Only accept 'driver_data' values that match an existing 'id_table' entry
> within the driver. This makes the field mandatory if the 'id_table' is
> defined in the HID module and disallows overriding pre-defined values
> within the driver module with arbitrary entries from the command line.
> This could lead to invalid access as 'driver_data' can be a pointer, hence
> the user input needs to be sanitized.
>
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

[Severity: Low]
This fixes a potential invalid memory access when arbitrary driver_data
values are passed through new_id.  Should this include:

  Fixes: 3a6f82f7a22c ("HID: add dynids facility")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-acpi-sanit=
izer-v1-1-44b4aa8c538e@thegoodpenguin.co.uk?part=3D1
