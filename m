Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBC388371;
	Fri,  7 Aug 2026 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084784; cv=none; b=IgfDYxyjkh2rjBCZg08crgxrkov4GrcsHsYldaw1ItWyhOgc82Jnu8vT6geqoizefVfLwP0Vj8sLHe6x0triglyV729uvWiGlO8vcK9Otdvez5oixXRORCD8e9r/CFWZJXg3SdFhShDkyYuDYb9A3M8oLjb7d2ogKNxx2tkyJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084784; c=relaxed/simple;
	bh=O39mtthsuaEhP25BSJnPzPVXX7n6+E8iSfJY719NyPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCNksVbwNECGCip4MVxq5arAaitp+uwgoJsbnNQEypkN1OpCQ1PyAz7H322+uaaW5RKq+BuWZDk1DZW/owiBxg24iIAQ1yjgC1tgQo7gLxfqoy9lidXjGClibHbpYdVrX3B+hexPmMu2T7goxrOfoYP1JE3N3Sp2/R2SgDGTS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/sUV11W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/sUV11W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818071F000E9;
	Fri,  7 Aug 2026 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786084783;
	bh=7VzOxyDn9wI0bfbyDl1PjXpvHjepzwru/s30OcTZ9Qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/sUV11W3+LboChFYnwF98DwjWfRe6pXs4VlClHsE5gu0hE72XadpgMj8mTBRjm+r
	 CBu4tUmHrdUslt1Uu2In4d++IgLSsbmUyidP1tEQo3JXIpFhvyRthCgbG7qbmnEXNp
	 Vbh1bDcU3TNqgqR7Q2T5B864I8wsqbUUecDJpHDfikIk6O3SSRwKl1p7WwSz3W5CNO
	 aSud/De5c5IjixZUuijQomm5wRnOLXEikSyqw49HR1ebD1n1AfdPFc8MLSpeJjuZGd
	 KQfNHlOdTSm5OBvPCRkx/85hQbmXngjYcInDjvSk9qqJ6tp8EJwmLVWQ7qj2pdDPfL
	 y/zvahrpDJavA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] input: misc: Add Qualcomm SPMI PMIC haptics
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
References: <20260806-qcom-spmi-haptics-v6-0-19fcecd5204f@oss.qualcomm.com>
 <20260806-qcom-spmi-haptics-v6-2-19fcecd5204f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 06:39:41 +0000
Message-Id: <20260807063942.818071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Haptic effect fails to stop if `stop_timeline` wraps around to e=
xactly 0.
--

--- Patch [2]: [PATCH v6 2/2] input: misc: Add Qualcomm SPMI PMIC haptics d=
river ---
commit 21a083ab5b9214e43c2b8143306bc686c7af6e1b
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

input: misc: Add Qualcomm SPMI PMIC haptics driver

This commit adds an initial driver for the Qualcomm PMIH0108 PMIC haptics
module. It supports DIRECT_PLAY and FIFO modes using the input
force-feedback framework.

> diff --git a/drivers/input/misc/qcom-spmi-haptics.c b/drivers/input/misc/=
qcom-spmi-haptics.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/input/misc/qcom-spmi-haptics.c
[ ... ]
> +static void haptics_stop_work(struct work_struct *work)
> +{
> +	struct qcom_haptics *h =3D container_of(to_delayed_work(work),
> +					      struct qcom_haptics, stop_work);
> +
> +	guard(mutex)(&h->play_lock);
> +
> +	if (h->active_effect_id !=3D -1 && h->stop_timeline &&
> +	    time_after_eq(jiffies, h->stop_timeline))

[Severity: Medium]
Will this skip stopping the haptic effect if jiffies wraps around such that
the calculated stop_timeline is exactly 0?

Since 0 is a valid jiffies value, checking stop_timeline for truthiness
can result in the motor continuing to vibrate indefinitely if this exact
wraparound value is hit.

> +		haptics_stop(h, false);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-qcom-spmi-=
haptics-v6-0-19fcecd5204f@oss.qualcomm.com?part=3D2
