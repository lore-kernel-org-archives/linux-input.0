Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795752308;
	b=rKPMpDXQuGR1llC/zEK9P2EmiJM7lhdMsery7R3h/Gdf8f7RW2d/Hd5VbjnL2p+qf24F
	 XT7lZO/aSTiirj3j7TSP9xVTKREf87Jl5z9+TRga9kjg5892uQTxQo0uIULZPQ81Hvsgg
	 HRZkq8vvkPFPmCFeR4wRbBYaz2YkBZYbRlVtsSdkMcs/heW2kKJQ2fEXkJA3I98MQwx+2
	 Cz8G3nhJ9CSI857K4FyZf/IqUhwTJNh1x+opoloGUphSAUSQrV7iVQPziPZdNrmKcoOWL
	 BLxexsltkB2d89iFd3mjKPTIh5xZHnKQY6xuUfsurRYdLkvQWw37GyGxLyRSgchmt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XqFzFSZ0jqaBNhF7xA7JJoB3o247oCFPjbqukrxfHYc=;
	b=pnGCAodShwOqBri5yGjs7J3nnUG6/cfj0dZQ7nzEO5ZgEQC+joB20JmV3VVw18Z7x/ZJ
	 7WD3OTw17XRDyi9HLeNU8kgqhYVvoIXxayukcQ5iuVUa9iOZumXtF3HQDm1l8D8L1j2V/
	 75KXo6tC8OGVL87ZY1X13ytD5Ro+sin4oLohxSePCmWXNkGGvQ5x8dkD7iBbeFNMVhOzq
	 qkIzLFY7c3SpleymdzUBQ6Zs8FevsSMdEdRiWmooEYJgE6VLtqeP7v1CfUNHCBhsqyTx5
	 bA5JHxJQC0RUn7R78qLKHlZVusw98mAMDFSRec8ujPatFYRSMmOLu0d7hiOrX4+OPjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJg2o7pS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC6C606A31C
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJg2o7pS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82571F00899;
	Fri, 27 Nov 2026 04:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795752307;
	bh=XqFzFSZ0jqaBNhF7xA7JJoB3o247oCFPjbqukrxfHYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJg2o7pSAm2kPxbiGpn9DJRGIc0yCfzBau62ahDL1oIpXDLRgecb85kLXNqdDuQra
	 4fg9H3mUkkE+MYO2+VbVbnmBBjmOyDJl0NuXgrFTTNO794sBFJMz3PvdNlI6d2DeGA
	 fHRa9TB2dsuPKmU6/ZNFBBaIXocw098EM/V26la6XCdvyk+3CJiK5VnEvlQ+IDz8tm
	 nnhbYdhKeGqPApvsP1gxL5xJWp1VpbzZPZaSAVBlmzMSZXy4Fx6UZlHnjJBbknh71w
	 NbeIKgPcRoRuFH5hvV7tyFstQJ7c9+Ab8WQHKm26Oe+pdmVPxAsB7JeIYhv4llM0fb
	 62V31Q+dB3cpw==
Message-ID: <sashiko-outbox-236572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: joystick: use scnprintf() for the device
 physical paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aibing Chen" <chenaibing@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261127034904.288-1-chenaibing@cmss.chinamobile.com>
References: <20261127034904.288-1-chenaibing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 04:05:07 +0000
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
- [Low] Input: joystick: cobra and stinger physical paths still use
  snprintf()
--

commit dad6d0895b43b6671b115696abcf12d42b3f99fb
Author: Aibing Chen <chenaibing@cmss.chinamobile.com>

Input: joystick: use scnprintf() for the device physical paths

This commit switches thirteen joystick drivers from snprintf() to
scnprintf() when formatting input device physical paths to silence W=3D1
-Wformat-truncation warnings.

> diff --git a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
> index 2a3f768a72186..f685a62cad6de 100644
> --- a/drivers/input/joystick/grip.c
> +++ b/drivers/input/joystick/grip.c
> @@ -333,7 +333,7 @@ static int grip_connect(struct gameport *gameport, st=
ruct gameport_driver *drv)
>  			goto fail3;
>  		}
> =20
> -		snprintf(grip->phys[i], sizeof(grip->phys[i]),
> +		scnprintf(grip->phys[i], sizeof(grip->phys[i]),
>  			 "%s/input%d", gameport->phys, i);
> =20
>  		input_dev->name =3D grip_name[grip->mode[i]];
> diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/m=
agellan.c
> index 201a049c8c06b..61fcf0620937c 100644
> --- a/drivers/input/joystick/magellan.c
> +++ b/drivers/input/joystick/magellan.c
> @@ -138,7 +138,7 @@ static int magellan_connect(struct serio *serio, stru=
ct serio_driver *drv)
>  		goto fail1;
> =20
>  	magellan->dev =3D input_dev;
> -	snprintf(magellan->phys, sizeof(magellan->phys), "%s/input0", serio->ph=
ys);
> +	scnprintf(magellan->phys, sizeof(magellan->phys), "%s/input0", serio->p=
hys);
> =20
>  	input_dev->name =3D "LogiCad3D Magellan / SpaceMouse";
>  	input_dev->phys =3D magellan->phys;

[Severity: Low]
Should cobra_connect() in drivers/input/joystick/cobra.c and
stinger_connect() in drivers/input/joystick/stinger.c also be converted to
scnprintf()?

They format 32-byte gameport->phys and serio->phys strings into 32-byte
phys buffers with snprintf() and hit the same W=3D1 -Wformat-truncation
error under CONFIG_WERROR:

drivers/input/joystick/cobra.c:cobra_connect() {
    ...
		snprintf(cobra->phys[i], sizeof(cobra->phys[i]),
			 "%s/input%d", gameport->phys, i);
    ...
}

drivers/input/joystick/stinger.c:stinger_connect() {
    ...
	snprintf(stinger->phys, sizeof(stinger->phys), "%s/serio0", serio->phys);
    ...
}

Also, the commit message says the drivers compose their physical path from
gameport->phys, whereas six of the modified drivers (magellan, spaceball,
spaceorb, twidjoy, warrior, and zhenhua) compose it from serio->phys.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127034904.288-=
1-chenaibing@cmss.chinamobile.com?part=3D1
