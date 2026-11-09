Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221016;
	b=MWPBRlJl84V5rm/n+gVT8FTmCp+rHLE7Fly5tdCiypCix81IZg8ARHhAwyDvAWrU/Mx0
	 2Tte57QsFNmOHyNB/47DclsH1auaqI7vCK7oeOQaQvShShok/u1SbJJS74x8IHKEvK08F
	 8KvUvl0ElkznH1UXlQbJQaJBvdC/CvJZzhqwZYdP+E9z2LK9e4Hj5sW3vGzEduZaFs1y6
	 kxfdGhIvemz8BvprCSBy7z5147noGVwnh78CKm7FuG1glG9RqboSyqDbVXdVg0mJORkt/
	 HUsRveE5/oCs+UYPYqE9YC+Er8UaI1yhvYDMbsR6djen67xL35XI7X6eiHzY9qwzphA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9a63u+GKqDfrFWV0R/CWBwp65M56Wr9C/n7xkZeCbjA=;
	b=cEr5ln7mLQPF1P+PPoSCPArJ+rsHDnCUlHgTdBQ6/9DYVzQE3q5OhzDh45nheoiJtJHo
	 BuedWDd3928ZmEaQqB/LdVdmUUj/PJ0SOL15hc4oyjTIL0QNq5l6zS5LULbbq9yfrZBaB
	 h+cgqfpnxSoV3lC7lD2MJPmfoWEmhIJsxyK0HkQYczJZszQ6l/Gk3xpcprk7H7V8Gye+Y
	 Gu89pGCXkuC6EfPpbG3cWmLhhVSYfyAK/NuU220ecIpKGXHJv160CjUnv7fiqH4LLo16o
	 YM5YuMQ/yAd9Ybl0yPSazk/rW89OIGVk9tA9xLXYjwyXLVHiWVwwK698Kn6RqdCqK0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBjl5PSf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5D606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBjl5PSf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6367D1F008A4;
	Mon,  9 Nov 2026 10:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794221015;
	bh=9a63u+GKqDfrFWV0R/CWBwp65M56Wr9C/n7xkZeCbjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBjl5PSfcujkWidrgYYWk4WuYlJRWGbuYO9/OgtMI0uKv95gB6Mg7zXMPOLPgtyqZ
	 pkF1tzZ2n5vArUMmrezqGzkbWp7QeTJno94RnQSywiab0+wUiub4hTqmHz0e/MkVMn
	 3/hccFncJhiv4pMrfGHKOUREU81QnVAuv/NSlOczTvNT8OrN4E15xA8dvP9tmmNAV4
	 avhRQfRo1Y2yGYidIQ0tRa8bduXhXUXjZk40iyfRLtVYMnPmB8aywiNIRdyM2BhlSD
	 5r6Z0umhpLimItChZaHd9L1hdYRPyH3LCu+oFVemi059hxewOokvHLuRO5sdW+R6DJ
	 VSs+XOhfmQH0g==
Message-ID: <sashiko-outbox-204846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] [PATCH v2] xpad.c: Add support to Hori Real Arcade
 Pro 4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juan Parrado" <jparrado.1817@gmail.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261109103715.11017-1-jparrado1817@gmail.com>
References: <CAFkAFXq-avEh2KP5vdpzK1cxvg9X+5nwc12-5m3NG47Kg7HWcA@mail.gmail.com>
 <20261109103715.11017-1-jparrado1817@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:43:34 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] Input: xpad - missing MAP_TRIGGERS_TO_BUTTONS for Hori Real
  Arcade Pro 4
- [Low] Input: xpad - Author/Signed-off-by email mismatch and changelog
  issues
--

commit ae6f93fb0a7ea08dae09b3962836f14f01d5f458
Author: Juan Parrado <jparrado.1817@gmail.com>

> xpad.c: Add support to Hori Real Arcade Pro 4
>
> Add specific support to Hori Real Arcade Pro 4.
>
> v2 fixed format
>
> Signed-off-by: Juan Parrado <jparrado1817@gmail.com>

[Severity: Low]
The Author address (jparrado.1817@gmail.com) does not match the
Signed-off-by address (jparrado1817@gmail.com), and the "v2 fixed format"
revision note should be placed below the "---" separator rather than in the
commit log.

Also, the commit subject should use the "Input: xpad - ..." prefix, and the
changelog should explain why an explicit xpad_device[] entry is needed when
vendor 0x0f0d is already matched by XPAD_XBOX360_VENDOR(0x0f0d) in
xpad_table[].

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 810e52782ae89..2567ea3bd2604 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -255,6 +255,7 @@ static const struct xpad_device {
>  	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) Xbox One", MAP_T=
RIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
>  	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
>  	{ 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai Xbox One", MAP_TRIGGERS_T=
O_BUTTONS, XTYPE_XBOXONE },
> +	{ 0x0f0d, 0x008c, "Real Arcade Pro 4", 0, XTYPE_XBOX360 },
>  	{ 0x0f0d, 0x00c5, "Hori Fighting Commander ONE", MAP_TRIGGERS_TO_BUTTON=
S, XTYPE_XBOXONE },
>  	{ 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch", MAP_TRIGGERS_TO_BU=
TTONS, XTYPE_XBOX360 },
>  	{ 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X", 0, X=
TYPE_XBOXONE },

[Severity: Medium]
Should this entry set MAP_TRIGGERS_TO_BUTTONS instead of 0?

The Hori Real Arcade Pro 4 is an arcade fightstick with digital pushbuttons
for L2/R2 rather than analog triggers, and the other Hori Real Arcade Pro
entries in xpad_device[] set MAP_TRIGGERS_TO_BUTTONS so LT/RT are reported
as BTN_TL2/BTN_TR2 instead of ABS_Z/ABS_RZ.  Previously, 0x0f0d:0x008c bound
via XPAD_XBOX360_VENDOR(0x0f0d) with XTYPE_UNKNOWN, where xpad_probe()
auto-detected XTYPE_XBOX360 and still honored the triggers_to_buttons module
parameter; adding an explicit XTYPE_XBOX360 entry with mapping 0 bypasses
that XTYPE_UNKNOWN fallback in xpad_probe() and prevents overriding the
trigger mapping via module parameters.

Also, all surrounding 0x0f0d entries in xpad_device[] include the "Hori "
vendor prefix in the device name string ("Hori Real Arcade Pro 4").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109103715.1101=
7-1-jparrado1817@gmail.com?part=3D1
