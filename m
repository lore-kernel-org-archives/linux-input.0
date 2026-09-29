Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23803AEB38
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658907; cv=none; b=Wt99v5VFZgGC1t3hvmwFITR3I29NPCL0JKee6mWG/Ikn6f6Xy9DxXwHwGYqci4iGuVq6azfHp85fRTv1IfM6O2VHb3uLqQa4EUeZj/0LKuLEjATdZg6byOyZg31n4Y+/0qc7+m3XFhdDxTfn83h6Sq6VumkylrukjCKMTiObm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658907; c=relaxed/simple;
	bh=Rh5idD4Q1fcYe6P3Cddn3iT1pdfnzojCCgpuUG01L6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YaOliWAPjjYhVazFoC7dPYUVsbf0T3ZYQ3WBz1jCh58voaqQfV33O5QDwJCFOzIJZHrxvu0X0QYup5LofJbQpOY6AHEvSYJJfeIkiK3NZ5R0tmupEumIT5unn38iiy2zHHBfdHklgUd7PqQm105cQjv6kpxJrYvnq/w0k0d5LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TknSkTA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TknSkTA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC31F000FF;
	Tue, 29 Sep 2026 05:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790658905;
	bh=vJ/AWci17AWXEBgXf0iaE2ozAH09tS1gil5ZZmnccBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TknSkTA/hCACn9FdctMSubxds8dMKoLiXHJyJ4hviU14+cwz7RUen9m61akWMIg0J
	 0wAQc8JCJq4rpgUuaTQ6HH9IEqZIqhpnwH+Smwup3jpaWy80dq5ZpgT8KDWHIk6arq
	 IBwWqTq4kQWSfuLHOLdBgGMSw1SZ+6xcH66BOmLcAiPFkUS1up5v2kybHs1In5aYze
	 Dkd48DFWdzUTwlhzAyAVYtUqGXLR32SOZUl8FvRgmEtcJQSDlngFWWKpp0H4VzWgoF
	 uq1dnmTHYfGe8EoDsyCuk+bsonnNkt5/R1twQ40I+gK5K42/WSKfF7YB+Oxj69YFq3
	 K2TxiPGqRy1Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/4] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260929045607.2106149-3-vi@endrift.com>
References: <20260929045607.2106149-1-vi@endrift.com>
 <20260929045607.2106149-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:15:04 +0000
Message-Id: <20260929051505.05FC31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: timer catch-up storm in switch2_rumble_work() floods USB bus
--

commit d6948b1b7d2b1cb761599f94b49e78c667724675
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers

This commit adds rumble support for Switch 2 controllers, handling both the
HD Rumble linear resonant actuator type and the GameCube eccentric rotating
mass type. It implements a basic simulation of these rumble effects using
delayed work.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 3a7c35375be60..e965076b10345 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3251,6 +3305,128 @@ static void switch2_kref_put(struct kref *refcoun=
t)
[ ... ]
> +static void switch2_rumble_work(struct work_struct *work)
> +{
[ ... ]
> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		/* Reschedule a little early to make sure the buffer never underruns */
> +		interval -=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: Medium]
Could this logic lead to a timer catch-up storm?

If the worker execution is delayed (for example, due to CPU load, workqueue
starvation, or a suspend/resume cycle), the target time is only advanced by
4ms on each execution, while the system time may be much further ahead.

When this happens, the work immediately reschedules itself with a 0 delay.
Because it might take many executions to catch up to the current time 4ms
at a time, this could loop rapidly. Is there a risk that this will hog the
workqueue and flood the USB subsystem with back-to-back synchronous
hid_hw_output_report calls, which might also distort the intended 4ms haptic
cadence?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929045607.2106=
149-1-vi@endrift.com?part=3D2
