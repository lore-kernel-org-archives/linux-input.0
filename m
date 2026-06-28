Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC529994B
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666072; cv=none; b=IUYfeTE15d0qWkZ0nqV8lxtBhlpXysM70hYCwRYs6grLFqfntco+jFvbQLQlEL3IUpILd5hemyb/TKu6sEpKOXfZ+FFvlH3JYUzI1mT595WlhfZkL43toogzVnXfO1FrveZaeYcxOnokpsGMbCsMfl+0IPjw7lWtC2d4kZ3QpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666072; c=relaxed/simple;
	bh=S8hWimn9dGwsOM8n99bEqo5uasrHRdlBFDOGqQvvrbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ezF+qcBHkubOSWnbBVyzG+AR0N2K26Qa9/xYpuigrkHyn8CkFkyrtrTibD3Al5K5nFnBQYtRAz885wp0r7sjQ5vZI9jSkX3Z4rG2B05U6wBm+thZkUbo3gFtqzcXbMrOIwg6me5FucOrdeZOZ/Ym/nudQv/AbtTAPuMpn8WCpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbofTwtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbofTwtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB91F000E9;
	Sun, 28 Jun 2026 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782666070;
	bh=IQO3BpvyDCBBH38Uwkci+D4+2tKVXnUNDFjaf+RZw34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbofTwtY+GcvViiVMmGHBGJdtpqYzIWgFjJS9iGV3P3LJQ8cCMHMXEv1KUo3Cd0QB
	 PPPIZNQ6rDsbH3ZQFdJkAHQzTbmNFuAUncLLtyhC58N+FNH9Y/2nNWUxMpqK3+RCqJ
	 ZUQMBfZOJtyCo68IUBrpWBylwSsb6/OOD7wA0LwrJvZSDbfdyjbAC+vaZu2SQaY/sQ
	 dAfMOs57tKL7yWsYhB1uRyqA5Fl0vcaVKxnDraDIkblp5DeheyckTUEhqtQLL+nKWZ
	 9eA13NVOSDQatOU5UauY6cAO9PZhjAS7VvxB/ev1D2+7Qo6JFItwGbVSRIAWvt2pOC
	 JflB9zFS7HPqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] HID: roccat-ryos: reject short special reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260628164611.17467-6-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
 <20260628164611.17467-6-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:01:09 +0000
Message-Id: <20260628170110.71EB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `roccat_report_event()` function acquires sleepable mutexes wh=
ile running in an atomic context (USB URB completion handler), which leads =
to a "scheduling while atomic" BUG.
--

commit de88f5cf3ef84f642bf5e1815c5ed0d7ee05a061
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-ryos: reject short special reports

This commit fixes an out-of-bounds read in ryos_raw_event() by ensuring
that only complete special reports are forwarded to the character-device
layer. It drops reports that are shorter than the expected report size.

> diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
> index db83f42457da5..5087defc7c373 100644
> --- a/drivers/hid/hid-roccat-ryos.c
> +++ b/drivers/hid/hid-roccat-ryos.c
> @@ -189,7 +189,8 @@ static int ryos_raw_event(struct hid_device *hdev,
>  			!=3D RYOS_USB_INTERFACE_PROTOCOL)
>  		return 0;
> =20
> -	if (data[0] !=3D RYOS_REPORT_NUMBER_SPECIAL)
> +	if (data[0] !=3D RYOS_REPORT_NUMBER_SPECIAL ||
> +	    size < sizeof(struct ryos_report_special))
>  		return 0;
> =20
>  	if (ryos !=3D NULL && ryos->roccat_claimed)
>  		roccat_report_event(ryos->chrdev_minor, data);

[Severity: High]
This is a pre-existing issue, but is it safe to call roccat_report_event()
from this context?

The ryos_raw_event() callback executes in an atomic context (softirq)
during the USB URB completion handler:

hid_irq_in()
  hid_safe_input_report()
    __hid_input_report()
      hdrv->raw_event() -> ryos_raw_event()

However, looking at drivers/hid/hid-roccat.c, roccat_report_event() acquires
sleepable mutexes:

roccat_report_event()
{
        ...
        mutex_lock(&device->readers_lock);
        mutex_lock(&device->cbuf_lock);
        ...
}

Will this sequence trigger a scheduling while atomic bug when a valid
special report is received and forwarded?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D6
