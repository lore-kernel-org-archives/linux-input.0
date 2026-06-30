Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE93DE446
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841172; cv=none; b=AEXdD3ONBNxJHMeVnMBcjRKAHNnGlK3vQfWGYHge+zf4q/S+qaHXBRH5/VzpOZWH4z49rWF6btdPqYBC3At36JoZSWrdtgFjgi+Kl6WTPA/Kz5q7vnkAEu4nV3FZOYeNKEl5IIXoc90zNwPrkaRpKNrS3Q9RIxRwla2GeWAr35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841172; c=relaxed/simple;
	bh=8YZbDuzHGPpGqbZCx9LQQb4/Vh3HbHXxBtc23R7IZrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R11JFsNj8GlEZlPgavk8Dqq2aa85QT3NqMi/4AiIgtNun1jQn/mVaYQ9jP3CTtqpMeaCtKr/Xneo2JaSKqO+El5kUsfrju+KIdManhWWC9zS3jPYQc6Ceyc+5uPcFVYixMPiPQ1FYCPTD/EGncFQ56e8MDZn/xAPJLKTHX/cMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOYCJuRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOYCJuRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F8F1F000E9;
	Tue, 30 Jun 2026 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841170;
	bh=IvTb/O4koCx6Mpfe+FaBTAWPe8ax6yw6J3SN7xXfq1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOYCJuRkIInNjF27aNjt/Ch16FqrXFbGaDmsk0K8c9YAhc9nPGVwUqp5xV2uBK15S
	 kfOcYq0PJMfvYUiTt8KInYjI2lC9iT8+ytKvOk8RK7EDivpkWf+9rqj+nIjNw/fPfH
	 CST/j+SdgbyesIbrZGM4Ff2sk48MRdbJ+z++4uiWo70uT2Oh46UY/1A87bauoGv6pE
	 M7sBrH8/i+3i4Piv+27gsbj2B4RG1tA7dDRWg2LwbP/kYCn9M7ctPgkU+kwgFzkuHc
	 mx7MBM0jsmzF+PAYe2E5oDfAoRO6PPgfGUxv0+aeY0iGZ5w25p3RTnv89z19YHeiEv
	 xuH2pzecYWdsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] HID: steelseries: Report
 POWER_SUPPLY_STATUS_FULL when full
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <3d06ba7fcb4873c9d9d69c1fcbcd3d6bc21fadd0.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
 <3d06ba7fcb4873c9d9d69c1fcbcd3d6bc21fadd0.1782840133.git.srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:39:29 +0000
Message-Id: <20260630173929.E7F8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch incorrectly reports POWER_SUPPLY_STATUS_FULL for an un=
plugged, actively discharging wireless headset solely because its capacity =
is 100%.
--

commit 7a846a17b1f3241f94405b831860eba9d3123648
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full

This commit updates the battery status reporting for SteelSeries headsets.
It now returns POWER_SUPPLY_STATUS_FULL when the headset is connected, not
charging, and at 100% capacity instead of returning DISCHARGING.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
> @@ -215,6 +215,8 @@ static int steelseries_battery_get_property(struct po=
wer_supply *psy,
>  			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
>  		else if (sd->battery_charging)
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (sd->battery_capacity >=3D 100)
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;

[Severity: Medium]
Will this incorrectly report POWER_SUPPLY_STATUS_FULL for an unplugged,
actively discharging wireless headset just because its capacity is at 100%?

When the headset is unplugged from external power but still fully charged,
sd->battery_charging is false and sd->battery_capacity is 100. It appears
this logic will now return POWER_SUPPLY_STATUS_FULL instead of
POWER_SUPPLY_STATUS_DISCHARGING, because there is no explicit check to veri=
fy
if the device is currently receiving external power.

Is there a way to ensure the headset is actually plugged in before returning
FULL, so that userspace tools don't incorrectly hide the discharge state
until the capacity drops below 100%?

>  		else
>  			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782840133.gi=
t.srimanachanta@gmail.com?part=3D5
