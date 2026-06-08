Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAC3D5661
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937570; cv=none; b=cQvFcbKdVXQQJSs+x4xxmYGv/OUMkrUVQTQyUOwL6L5HOP9s4G0L49UM82N7LIXIGVODICPQL092vScCL/LJKPVSwqmZlv7cx6je631/HfgSRPnlIPYl+fMm8293d0sElpPXHfo+WPrEDhE/r5Wy+w6KRjh3QmODA2loe1PLsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937570; c=relaxed/simple;
	bh=L3rWcPejSox9gqf0UXk9t/IR9yrbj2VRstKMyFRvVHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGyKXz4iniLvlDSyUMPazELfcV9gkrggwoE4QvGdSPUV52MCw2uEHOTeeSVFDm5RRuoDhL4qFRd4XSNTUkDSZY2GR0sg+kz/XUMQOybRu1Jl7c7Nyvt6V0eucZyqjgdWgJ9sd+ePhon8R8oQ4CbrWFjacx++U8jhq3rYgyBWiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auXDpQ/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auXDpQ/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F0B1F00893;
	Mon,  8 Jun 2026 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937568;
	bh=KJQzOP6XdKJlUxBn5xuiTqzixHvTBnOxMwbyE7bzFE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=auXDpQ/9tYx1KivLEIekD8Oac/dxKodySIcyXLkR7JJAnSglprOjjxdLNK9tw9SpN
	 qkm78gySO67RFktr7GSoXEeChKZ2RwDYVCvw5MJJluW9MHzeeT0m1FyVOxEUleZ8Li
	 YtwlW9vzCFCH+dbFMTD8uhC8nfyFxweH/IlW7wAftXpoJW7NhnzBwaJMnMDe+/Kohs
	 WYmuwZEEStdC1SnomtynEBMEeyDacUPjGz5PWrFqeBqgMlq16ie2bYDEe18H2KGptx
	 4GMA+2DqshIbIx9Ry68qm/SPBMut3oztppGImoTKC4A5OUgv5elyoOCzLbYfGPXq7T
	 Bp/BeVLU22U0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: hiddev: Use kref to track struct hiddev lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heitor Alves de Siqueira" <halves@igalia.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>
References: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:52:47 +0000
Message-Id: <20260608165248.59F0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free in hiddev_send_event due to race between hid_di=
sconnect and usbhid_irq_in.
--

commit a4056f7ab6df2200de09a38f314eabfb8dd4a066
Author: Heitor Alves de Siqueira <halves@igalia.com>

HID: hiddev: Use kref to track struct hiddev lifetime

This commit fixes a race between hiddev_disconnect() and hiddev_release()
by introducing a kref in struct hiddev. It moves the deallocation into a
dedicated release callback, ensuring the structure is only freed after both
functions are complete.

Closes: https://syzkaller.appspot.com/bug?extid=3D563191a4939ddbfe73d4

> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 6378801b22c6d..1f2802920beee 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c

[ ... ]

> @@ -933,13 +947,11 @@ void hiddev_disconnect(struct hid_device *hid)
> =20
>  	mutex_lock(&hiddev->existancelock);
>  	hiddev->exist =3D 0;
> -
>  	if (hiddev->open) {
>  		hid_hw_close(hiddev->hid);
>  		wake_up_interruptible(&hiddev->wait);
> -		mutex_unlock(&hiddev->existancelock);
> -	} else {
> -		mutex_unlock(&hiddev->existancelock);
> -		kfree(hiddev);
>  	}
> +	mutex_unlock(&hiddev->existancelock);
> +
> +	kref_put(&hiddev->kref, hiddev_kref_free);

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a use-after-free
race condition when freeing struct hiddev while URBs are still active?

When a USB HID device is disconnected, usbhid_disconnect() eventually calls
hid_hw_stop(), which tears down the high-level structures before stopping
the low-level driver:

drivers/hid/hid-core.c:hid_hw_stop() {
	hid_disconnect(hdev);
	hdev->ll_driver->stop(hdev);
}

Because hid_disconnect() calls hiddev_disconnect() (which drops the kref
here), if no userspace process holds the file open, struct hiddev will be
freed immediately.

Since the input URBs have not yet been killed by hdev->ll_driver->stop(),
can an URB complete concurrently on another CPU?=20

If the URB completes, the completion handler usbhid_irq_in() propagates to
hid_input_report() -> hid_input_field() -> hiddev_send_event(), which then
dereferences the freed hiddev pointer:

drivers/hid/usbhid/hiddev.c:hiddev_send_event() {
	struct hiddev *hiddev =3D hid->hiddev;
	struct hiddev_list *list;
	unsigned long flags;

	spin_lock_irqsave(&hiddev->list_lock, flags);

Would this cause a use-after-free panic in interrupt context when it tries
to acquire list_lock?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-hiddev_kre=
f-v1-1-cd240c95423f@igalia.com?part=3D1
