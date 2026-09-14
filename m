Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68563290C9
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428534; cv=none; b=Jv7m8nDrNvEhDopOixN+pko6h6f+4bunT6446ozuD8XScJdrt3rXCHhP7luKTHDWBJ2UXG7su4m+cnXynd6WdfMYyMkd2i+Va/U5iGoYt13CYCVxgUSd1Y2aCJbmlsQt8hvU3xg1W8O7N4WKfHum5nPWSKQAaH+XTfBW/G0Kq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428534; c=relaxed/simple;
	bh=DbfdutATFxRQxuXgUKprs4ABA737w/IjIUUHy81v89E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LV51j0JysHXgWRyhuAJ1/1xLedFVrUzP2KY6vORGWFeszkF1FOanhdywpMJC0B8ZEo+wZmaiYa/O/eX6eZS1CxsZCxVnE088DK8EEXWy8ubkAQefBnYqbaR/n9zFxntCuY3uv27GS0aRVGMqGhvVzTyup9oX4WlwHDoGqQ9aXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUIUtdDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUIUtdDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E91F00893;
	Mon, 14 Sep 2026 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428532;
	bh=EsFEF+7JkJjb85t8Eag71XuKWkkY6nQc+W3lf4tvsQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUIUtdDEhpp3HYrHdHURGaBQCpekik7nKvNI0BGl6QK48wnLEZyLeTytz2j5/Hg0K
	 LJVkxDfNistik4DStxZI9spiytwsx1lU9sevVAbihoPoqqYmpLrj+KEZs+ykAP06qS
	 DD6rdqAjWVQHbmHnUZFjynoxKTUQMp5HWbUnj9TNLegJ5ucqRVajxlm/r4dYndSTDG
	 U/NwZN0ZbkadU8UZ0lGo5YiBDSrXLA0ks1CBNfplLX01rIjEVyw8HjP50lPc293h5K
	 wJJGlPzC9sdfrKJr1o6NpeHVADDnj8g4wc9zlKy2hnczCn90P8mlkMv+T69+1Sj0DV
	 /BJZcQ9B9cylQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] HID: hid-lenovo-go-s: Prevent deadlock if device
 removed during setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260914225303.868569-4-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
 <20260914225303.868569-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:28:52 +0000
Message-Id: <20260914232852.975E91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid-lenovo-go-s: UAF in usbhid_output_report due to unprotected sy=
sfs access during remove
--

commit 5d8a6b9ab527316bf05d3abf3dffc7d80baf351f
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Prevent deadlock if device removed during setup

This commit fixes a deadlock by removing the cfg_mutex guard in
hid_gos_cfg_remove() before stopping the delayed work. It also switches
from cancel_delayed_work_sync() to disable_delayed_work_sync().

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 36505d8402ff1..8b16fc7d151e0 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1442,8 +1442,7 @@ static int hid_gos_cfg_probe(struct hid_device *hde=
v,
> =20
>  static void hid_gos_cfg_remove(struct hid_device *hdev)
>  {
> -	guard(mutex)(&drvdata.cfg_mutex);
> -	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
> +	disable_delayed_work_sync(&drvdata.gos_cfg_setup);

[Severity: High]
Does removing this mutex guard expose hid_hw_stop() to concurrent sysfs
accesses, potentially leading to a use-after-free?

Because the LED class device is registered using devres, its sysfs
attributes remain active until after hid_gos_cfg_remove() returns. Without
this mutex, a concurrent sysfs write to the LED brightness or RGB effect
attributes can invoke mcu_property_out() and then hid_hw_output_report()
while hid_hw_stop() is executing.

When hid_hw_stop() calls down to usbhid_stop(), it frees usbhid->urbout
and sets it to NULL without locking against concurrent
usbhid_output_report() calls. A racing usbhid_output_report() could pass
the !usbhid->urbout check and dereference the freed URB in
usb_interrupt_msg(), leading to a kernel panic if a local user writes to
sysfs during device hot-unplug.

Could the mutex be reacquired after disable_delayed_work_sync() to protect
the remaining teardown sequence?

>  	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914225303.8685=
69-1-derekjohn.clark@gmail.com?part=3D3
