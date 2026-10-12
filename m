Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF82377A9C
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836782; cv=none; b=Po5vG/ZwOsRUw23d+L4Zaqc5qA33SaPb8OUjdbt7MndEK+n1bJFgXnQx51BPEp2tc+bFT6sJvL+6FlDrqvFWGv6Xz2XwSGImKF+gBfUIPQYhcTfnSN19AVyIEl2wUFvvqYnQehT7/bPFpFyW2fOZSWhwg8bkEJsiRBJ4Kf5Kr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836782; c=relaxed/simple;
	bh=vmKXvAzGauadXk5SWMgQIxyQpwUsT0AMS3T0wesoca4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QWApMjQGTcHAbMmTcpgqglL2hFfzWkqpdCOvPcM0wtyAS9cmUsv7T/M36lyrDT5yF0MYV2L60rNR0Mb237PYJCvCpHwNmbjpEkWAhHdvwtLSMTUj7s6Q+0TkXtXr3pQUjIrkT2di1e1ynGQrGZhiv2+/+3ecoczLhN0oJ51ChB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8VjpzdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8VjpzdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7FF1F0089B;
	Mon, 12 Oct 2026 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836781;
	bh=s5HMsQUj3eyOAA8WKI6L3gMxkzf/QzUN91FYWAjqeR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8VjpzdRaDJiSr4N/a2Kk78l3g7MH6bEyrvp/FMeXLYSLcx3nGc/snroSx4y1jwm8
	 dbkLWuIoZhU7TM+X32ihMZcsIk1RSfzyHso4XkSPzRmxe2iHL8+lTGu2S2q0I238zO
	 fKRPbL9Ali5DDSy0J5tYr+2R7uW2PP5xynUKoZQmuect7a0u7q33XJIjXykwgc/OSU
	 vYo8hvl5n701Oo0pVJSfXbhxUo/jcnJlAk6LVhrabWbsZ7ijiIBlxtwh2Syyrysa4N
	 u0PZPKm5CHC0cD0o9cPHEufIhCx7jTwCJntNKamd5MbcJuhoi+6340MVLEOykq8JBe
	 xtmHNyeqWLr+Q==
Message-ID: <sashiko-outbox-168593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: UNCTRL: add periodic battery reporting using a
 workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bishwa Bhusan Saha" <contact@bishwasaha.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-3-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
 <20261013-b4-unctrl-m1-battery-v1-3-4a50203b7177@bishwasaha.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 20:26:20 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] hid: unctrl: initial battery query reply dropped during probe
- [Medium] pm: battery polling work wakes CPU every 5s during s2idle
--

commit 96156a773d135475c7c9f3eca5f3c8ad662fe691
Author: Bishwa Bhusan Saha <contact@bishwasaha.com>

HID: UNCTRL: add periodic battery reporting using a workqueue

This patch adds a delayed workqueue to check the battery status every
5 seconds for the UNCTRL HID device.

> diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
> index 59259dee7e429..1e73cad1e3f91 100644
> --- a/drivers/hid/hid-unctrl-m1.c
> +++ b/drivers/hid/hid-unctrl-m1.c

[ ... ]

> @@ -132,6 +137,17 @@ static void unctrl_fetch_battery(struct hid_device *=
hdev)
>  	kfree(write_buf);
>  }
> =20
> +static void unctrl_battery_timer_tick(struct work_struct *work)
> +{
> +	struct unctrl_dev *dev =3D
> +		container_of(work, struct unctrl_dev, battery_work.work);
> +
> +	unctrl_fetch_battery(dev->hdev);
> +
> +	schedule_delayed_work(&dev->battery_work,
> +			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
> +}

[Severity: Medium]
Will this scheduled work continuously wake up the CPU during system suspend?

Since schedule_delayed_work() implicitly queues to the non-freezable system=
_wq
and the driver does not implement suspend/resume callbacks to cancel this w=
ork,
it appears this timer will keep firing every 5 seconds.

If the system enters s2idle suspend, could this prevent deep sleep and cause
unnecessary power drain?

[ ... ]

> @@ -155,6 +171,8 @@ static int unctrl_battery_register(struct unctrl_dev =
*dev)
>  		 dev->battery_desc.name);
> =20
>  	unctrl_fetch_battery(dev->hdev);
> +	schedule_delayed_work(&dev->battery_work,
> +			      msecs_to_jiffies(UNCTRL_BATTERY_TIMEOUT_MS));
> =20
>  	return 0;
>  }

[Severity: Medium]
Could the initial battery query reply be dropped by the HID core?

This function is called during unctrl_probe(), and it sends a battery query
via unctrl_fetch_battery(), but hid_device_io_start() hasn't been called to
unblock the input path.

If the device replies quickly before unctrl_probe() finishes and the
driver_input_lock is released, wouldn't the HID core silently drop the inco=
ming
report with -EBUSY?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-unctrl-=
m1-battery-v1-0-4a50203b7177@bishwasaha.com?part=3D3
