Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2233DBD78
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157084; cv=none; b=DNbba1WxBadFpJxPCllZlFpatVc3njH2DX4C0DdTzV1+SXlGK4gjgBdGIOSu5SzUkI534xaesZQRPGu7W+ssq6kbeAingSqsxQfdbC5Nzezk8ojJnLZl+1n4HfhmycJ5zXFRHmX4EKoUvXy5wpsypKxz3too5Bzc0ZlSFz2F1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157084; c=relaxed/simple;
	bh=/QBdC++GbaBQyjB1q4iYeoCBW93SzumiiTd6eQKrSd0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=sSFaOdL/N2ezKVGRnv66Gq1NE7XLqYmt0S9l5c+6dHHG4n3NPjeuemH/gF4i4Emi0I/xnfsxf/jl+Zqx2imLQxmeoe3mORu5/oVVuZyyem+6U1LoVokYsjhdSA/TD40Xuig342FzhI/ZXSiWy49Z4bmrmNsXfPLhDWdBtT8t2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2rzm/pV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2rzm/pV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so1695175f8f.1
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775157081; x=1775761881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iEsiZZMbFHt80OCr7kAyoLIHwE2IId37jrReF/wXB0A=;
        b=p2rzm/pVtBLE+MTIxJitPS/sRmMxfu2cpTwgPrqnQRhztezNnMTTNB93r5HjQuPJFc
         qFwDP/QWonCWDiGT4bU6i5hyJkzrqfNsGZp9rkL3NvH/UnP5q6/Zfa5xRUpEQRD7fOts
         aKh1Y1/+z29GWANV3AkQOCKWF4PPMrcTlit50Bk8X0avEtDck8RiIC09gktZ4kFis6ZG
         fORdhJm5MiyI/Q23wRbTYu5Oc0w2Af0JkIjZdBdcE/Qwsw467Tt4ldbKKrnMPbf2johR
         SEyYNMTKAMtNpjQdVvZ8SmCjPdgR/PdC5LMN8rHMmIH9GSKYu4ncqb6V7Gd1GasyrMWE
         bKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157081; x=1775761881;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEsiZZMbFHt80OCr7kAyoLIHwE2IId37jrReF/wXB0A=;
        b=L4u0c7FWyxyfvQ0eJ4Li4fvMd8u4hX06GbEzr0L7kMSp1CGFjGLS58JLjPYu0ShCcN
         8PPToLyo4I68X+tWBPWEIcahhGlC31sycuFgymq8IsAyWbiEc5VNt0X/p5D2GxpR+uEp
         StvWlK/1sDuwTDcctsZLrpl/v5w7P0rV9YxMvfJ7RUrZNa4g9VlPpJCklAdDcHLEk7R7
         ywRKw1Y2ntZuszD3MCDGkZxP7/RW/BZb9dtRt8EPqDvx3yh0m08RmQWV/RD7qty0f9TM
         DggVm9dh3xaxjr7fDiG/6Yk2zTxKcIcQTkxomHLFtjpUcidC3quvtQYU1pscmzojLEy2
         P7vw==
X-Forwarded-Encrypted: i=1; AJvYcCWfR0De09aBKgMBy+lGlPeeJCnBVhkC5r3qFTH3SYs1/nlzQj5kSubtIX1ohKKWJOxFtTSJ3fnhd8IpGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzymBjkP/lmDcdJim03ihppAKIa982d51AA8ppFa7iNSCMFQM6
	muhwLAvbIa3oRwnCiG2zpUEXXUjcjvp2Q1kJU1b5jVgpvqu5n9T9OF6Z
X-Gm-Gg: AeBDievhMTehwtagcKCkLb9DjyEo0FiLJ4GuAK7i8C5GHS1IPcTs+5O9BCybFkHXZDP
	jqlisiJe8UEJhNktu+sOeBFG5R2UAnI3IkalV3lnFaQD1Ipund4Q0G1xzWwOL9FA5sefONOj31t
	eV8PE7KMyvphVDj3vcKJg4evgw0HiMBsNyZoFiMnCiEAQOQkzQC5NXgwN4lT9r7Ked2HZX4zc8+
	oFecGrtGjjKDB3wqGRuAmi4FJFYz6jBs1WJqS/PrnS1xVcVxDuY197wk/VuLnSogJaCuM3kuv6I
	9huq6aKDpZ1zf5msaE4A6pFkGN2YgJJO0xRRC+xMc0sswE2ryuHVeZBgdwcTC/km+DohBixOBBz
	F2N2PEZny+Qzu9bOH+55Zt6BU3WKYlZW5lNYvGxbFP07LlcEqkgH9ASsRIggtuFqonLsAFRPycu
	LBweyCBvx2Jogn4wE=
X-Received: by 2002:a05:6000:2305:b0:43c:a352:c353 with SMTP id ffacd0b85a97d-43d21171c7dmr6992194f8f.11.1775157081262;
        Thu, 02 Apr 2026 12:11:21 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f08sm11581737f8f.6.2026.04.02.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:11:20 -0700 (PDT)
Date: Thu, 02 Apr 2026 21:11:20 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260318030850.289712-1-vi@endrift.com>
 <20260318030850.289712-3-vi@endrift.com>
In-Reply-To: <20260318030850.289712-3-vi@endrift.com>
Message-Id: <3U78BIOKQYHLQ.2R4S088LJCLSC@homearch.localdomain>
User-Agent: mblaze/1.4-1-g5a69507 (2026-01-24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

Just one typo below.

Vicki Pfau <vi@endrift.com> wrote:
> This adds rumble support for both the "HD Rumble" linear resonant actuato=
r
> type as used in the Joy-Cons and Pro Controller, as well as the eccentric=

> rotating mass type used in the GameCube controller. Note that since there=
's
> currently no API for exposing full control of LRAs with evdev, it only
> simulates a basic rumble for now.
>=20
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
>  drivers/hid/Kconfig        |   8 +-
>  drivers/hid/hid-nintendo.c | 179 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 181 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 1a293a6c02c26..d8ce7451d8578 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -842,10 +842,10 @@ config NINTENDO_FF
>  	depends on HID_NINTENDO
>  	select INPUT_FF_MEMLESS
>  	help
> -	Say Y here if you have a Nintendo Switch controller and want to enable
> -	force feedback support for it. This works for both joy-cons, the pro
> -	controller, and the NSO N64 controller. For the pro controller, both
> -	rumble motors can be controlled individually.
> +	Say Y here if you have a Nintendo Switch or Switch 2 controller and wan=
t
> +	to enable force feedback support for it. This works for Joy-Cons, the P=
ro
> +	Controllers, and the NSO N64 and GameCube controller. For the Pro
> +	Controller, both rumble motors can be controlled individually.
> =20
>  config HID_NTI
>  	tristate "NTI keyboard adapters"
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 4ab8d4e7558a1..73d732ceb7116 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2976,6 +2976,18 @@ struct switch2_stick_calibration {
>  	struct switch2_axis_calibration y;
>  };
> =20
> +struct switch2_hd_rumble {
> +	uint16_t hi_freq : 10;
> +	uint16_t hi_amp : 10;
> +	uint16_t lo_freq : 10;
> +	uint16_t lo_amp : 10;
> +} __packed;
> +
> +struct switch2_erm_rumble {
> +	uint16_t error;
> +	uint16_t amplitude;
> +};
> +
>  struct switch2_controller {
>  	struct hid_device *hdev;
>  	struct switch2_cfg_intf *cfg;
> @@ -2997,8 +3009,45 @@ struct switch2_controller {
> =20
>  	uint32_t player_id;
>  	struct led_classdev leds[4];
> +
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	spinlock_t rumble_lock;
> +	uint8_t rumble_seq;
> +	union {
> +		struct switch2_hd_rumble hd;
> +		struct switch2_erm_rumble sd;
> +	} rumble;
> +	unsigned long last_rumble_work;
> +	struct delayed_work rumble_work;
> +	uint8_t rumble_buffer[64];
> +#endif
> +};
> +
> +enum gc_rumble {
> +	GC_RUMBLE_OFF =3D 0,
> +	GC_RUMBLE_ON =3D 1,
> +	GC_RUMBLE_STOP =3D 2,
>  };
> =20
> +/*
> + * The highest rumble level for "HD Rumble" is strong enough to potentia=
lly damage the controller,
> + * and also leaves your hands feeling like melted jelly, so we set a sem=
i-abitrary scaling factor
s/abitrary/arbitrary/

Cheers,
Silvan
