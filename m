Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853146;
	b=v2wqRmLZLH4sQ71DYPVpEeizTsOGKObfMVRGVvwH7fBvjb9wb70UAcEx2U0lBSBTUSSU
	 o8GhV+ClPC7/6C2DTMIw9rkjK9T5U745nTFspSJCsTRnJHhXgOh4vSBKMUj9TxThLXnx3
	 oinzxzculD/PFOj/8YQH8pDWF8mFfXJQEx0PJ1xwaTn3q9t8v3DrD0futzAPhCvvX6mrn
	 qYQGn3+zzKC8356uG3ItyZ91aN+PTf7t1A3f9oFVPCLCCLr9omDqPbpcCk7e13YD0KQ8o
	 J71iijqOUjuvdnNUBCofVfhNKQsBDYNxhwqaqSkGdOxFd9s7xksSIpS/KDawrIQ+DOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rlElVctePMUaBfo4QJsUtsig92pZ0/DoTD6PbQyU4Hc=;
	b=lmIspsgtvbXgpIalnDlE3W/j0BD9m6EGHzyy1pzK6zPYT0C2CkHMMJ57knfkD1+IxzQW
	 XrY4K0AdbeuUu9WEJH4J4AMvbm+XuXxhg4lr8GJKm9jpIKLcUD11kPlUmxMMbwTYuVm9Q
	 BqvLPSvBVhD80BlTX+GWQ6qHDO9Q1RWR7CZfGGsmNR1ZgIt//FVNAr6RuQ5rz5lvyF/3W
	 qXF32xDrzrFfZI9hOXMGTJXxX56M/p3v824f0znJS5w9CU0T00puLDB8J0fns7QaPiZcW
	 Je9IjyophVz2TfaqjlnENMwDukLZW2Yqf7dBgqLikT1n148yQvvfqOakp7OYwO+3etg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHtpNAph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C1606A328
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHtpNAph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B021F000C1;
	Thu,  5 Nov 2026 04:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853146;
	bh=rlElVctePMUaBfo4QJsUtsig92pZ0/DoTD6PbQyU4Hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHtpNAphfA0BZnjJBmuw8Dfle9Wfrj/8r/Un7jHMOHyldXAFVO0NESq12QtY+rcP+
	 AClQjMntsec6bSabp/Zr9CZ21tpF31PKcbDl61ZwTld0YUqZnKHi7rE236s5rN8ieM
	 UUoly98m8Vz6pit41fIYgtiV9kIBllZ/hUCp3vfPzt+Io7y3c1EOJ+ym8SIh37YRE8
	 5fFQ0cDFYtBAKm1gARdUxKNl2T1jECWBDup18prmOhFDMt90KVxdbB+v0Yt+tzO9mf
	 7lAXo/JvzAvz59R7thVqfmANBuv5if2iwzBV2Vbbdzzw/Y9Ydqllfe0gxh8Curnn4l
	 GgKvqRxYeOiUQ==
Message-ID: <sashiko-outbox-198552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - make InterTouch quirks table driven
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lovekesh Solanki" <lovekeshsolanki00@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
References: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:32:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Input: synaptics - unused synaptics_intertouch_blocklist when SMBUS=
 disabled
--

commit aa71c39dd9b45d27ea00e706a72ba8889d1bd158
Author: Lovekesh Solanki <lovekeshsolanki00@gmail.com>

Input: synaptics - make InterTouch quirks table driven

This commit moves the ThinkPad T440p InterTouch quirk check out of
synaptics_setup_intertouch() into a dedicated synaptics_intertouch_blocklist
table and helper function synaptics_intertouch_disabled().

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index b007e642ea765..d366fd3398c69 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -214,6 +214,23 @@ static const char * const forcepad_pnp_ids[] =3D {
>  	NULL
>  };
> =20
> +struct synaptics_intertouch_quirk {
> +	u32 board_id;
> +	const char *pnp_id;
> +};
> +
> +/*
> + * List of devices with broken board revisions.
> + */
> +static const struct synaptics_intertouch_quirk
> +synaptics_intertouch_blocklist[] =3D {
> +	{
> +		/* ThinkPad T440p */
> +		.board_id =3D 2722,
> +		.pnp_id =3D "LEN0036",
> +	},
> +};

[Severity: Low]
Will defining synaptics_intertouch_blocklist[] outside of
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS trigger an unused-const-variable warning w=
hen
CONFIG_MOUSE_PS2_SYNAPTICS is enabled and CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS =
is
disabled?

Here synaptics_intertouch_blocklist[] is placed under:

#if defined(CONFIG_MOUSE_PS2_SYNAPTICS) || \
    defined(CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS)

However, its only caller, synaptics_intertouch_disabled(), is inside the
#ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS block (similar to how smbus_pnp_ids=
[]
needed to be guarded by CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS in commit
496b7d2e5b93).

Should struct synaptics_intertouch_quirk and synaptics_intertouch_blocklist=
[]
be guarded by #ifdef CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS or moved down next to
synaptics_intertouch_disabled()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105042614.6883=
12-1-lovekeshsolanki00@gmail.com?part=3D1
