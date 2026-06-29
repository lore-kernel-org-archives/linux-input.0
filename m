Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C367F4D
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748465; cv=none; b=jmDNZV+C7C/mwIRm1xm29VzdNR8q+c2SJ4oHZp/CmJPkbkkneG9Ht9v3RswnSVNEfTfgqS8Sugn73RfCa0RFSCeGffLF07tZGpi9hvAYCzXLBIV/xyYesUGdeVRwGb/Dp+2uKlmvvpBf5nnHsY5SMACubBqjHgH4vH+kU8GdLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748465; c=relaxed/simple;
	bh=56xz5v6PyqqWPOk6TxAiiSurYSFMz+dDcCQ94t5asc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pjo2Nk7+43FxTkG9++O44cfKVulsTP318kC1S7uEF1bfaIMkBPIiqhBfeX9nD0bVapetI0HMTByiMDZ+N6QVBLTyaiwjCwv1RD4HzoW8VyoSPgHcFN9ttB1fNwT25gYhaLFXy8+6oDFOFBWQzLnFxoxbczxsaAGEftF0YO/2iBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOmcDvuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOmcDvuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757351F000E9;
	Mon, 29 Jun 2026 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748463;
	bh=HZF/LajL6Lhix0OM0/c6URvWXRRqc2mBtZbsQBptjG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OOmcDvuzNfgvmi2cipYgmCu9OqSnG0D4QKOp7Vukowh66WCVKf76TqWf26JLFmefi
	 CWHiT3fo8o6kqT4v86ocUwLHsltA8m6pnq0TMZnwDODEckOCFM0qw8l/N6nxoTEc5f
	 ywAV9Dmd5elV38oWuYxupGjUFtr8hy5vxpKA4tHsyPBSUQmVS5gkcQMM3nHoVhRPha
	 ICyOPDKzXxRFwSibrhq7zF2cj6wbZLDyevePocwDqgX1ewgBXyxzjjoo8lIAIXt/L3
	 7aABy+va1Fh4k1a2F0TvJOEE51Ro9/gOILqFTc3Ku8uLn1QGXQPVgbUvpajcVzN7Gv
	 E7Y9hrKkJF9yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: hiddev: keep state alive through disconnect
 unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260629152947.13821-1-alhouseenyousef@gmail.com>
References: <20260629152947.13821-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:54:22 +0000
Message-Id: <20260629155423.757351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition in `hiddev_connect()` exposes the character devic=
e before initialization is complete, allowing bypass of `HID_QUIRK_NO_INIT_=
REPORTS`.
- [Medium] Runtime PM reference on the USB interface is leaked when the dev=
ice is unbound while a hiddev file is open.
- [Low] An off-by-one error in the `array_index_nospec()` clamping logic pr=
events reading the last valid usage index during `HIDIOCGUSAGES`.
--

commit afdbfd4c2b634bf186c79d8a144039cac66bc1c8
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: hiddev: keep state alive through disconnect unlock

This commit fixes a use-after-free issue in the hiddev mutex slow unlock
path. It gives the connection and each open file an explicit reference,
dropping the reference only after the existancelock critical section
completes.

Link: https://syzkaller.appspot.com/bug?extid=3D563191a4939ddbfe73d4

> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 6378801b22c6d..21396481995b2 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
[ ... ]
> @@ -216,26 +222,21 @@ static int hiddev_fasync(int fd, struct file *file,=
 int on)
>  static int hiddev_release(struct inode * inode, struct file * file)
>  {
>  	struct hiddev_list *list =3D file->private_data;
> +	struct hiddev *hiddev =3D list->hiddev;
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&list->hiddev->list_lock, flags);
> +	spin_lock_irqsave(&hiddev->list_lock, flags);
>  	list_del(&list->node);
> -	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
> +	spin_unlock_irqrestore(&hiddev->list_lock, flags);
> =20
> -	mutex_lock(&list->hiddev->existancelock);
> -	if (!--list->hiddev->open) {
> -		if (list->hiddev->exist) {
> -			hid_hw_close(list->hiddev->hid);
> -			hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
> -		} else {
> -			mutex_unlock(&list->hiddev->existancelock);
> -			kfree(list->hiddev);
> -			vfree(list);
> -			return 0;
> -		}
> +	mutex_lock(&hiddev->existancelock);
> +	if (!--hiddev->open && hiddev->exist) {
> +		hid_hw_close(hiddev->hid);
> +		hid_hw_power(hiddev->hid, PM_HINT_NORMAL);
>  	}

[Severity: Medium]
This is a pre-existing issue, but does this create a runtime PM reference l=
eak
when the device is unbound while a hiddev file is open?

If a device unbind occurs while the file remains open, hiddev_disconnect()
clears hiddev->exist. When hiddev_release() is subsequently called, the
code avoids the hid_hw_power() call because hiddev->exist is 0.

Since the disconnect path does not call hid_hw_power() with PM_HINT_NORMAL,
could this leave the power domain permanently active and defeat USB autosus=
pend
until physical unplug?

> =20
> -	mutex_unlock(&list->hiddev->existancelock);
> +	mutex_unlock(&hiddev->existancelock);
> +	hiddev_put(hiddev);
>  	vfree(list);
> =20
>  	return 0;
[ ... ]
> @@ -897,6 +899,7 @@ int hiddev_connect(struct hid_device *hid, unsigned i=
nt force)
>  	INIT_LIST_HEAD(&hiddev->list);
>  	spin_lock_init(&hiddev->list_lock);
>  	mutex_init(&hiddev->existancelock);
> +	refcount_set(&hiddev->refcount, 1);
>  	hid->hiddev =3D hiddev;
>  	hiddev->hid =3D hid;
>  	hiddev->exist =3D 1;

[Severity: High]
This is a pre-existing issue, but does this create a race condition exposing
the character device before initialization is complete?

Shortly after this block, hiddev_connect() calls usb_register_dev() which
makes the device available to userspace. However, hiddev->initialized is set
later based on HID_QUIRK_NO_INIT_REPORTS.

If a userspace process immediately opens the newly registered device and
issues a HIDIOCGUSAGE ioctl before hiddev->initialized is set, could it
bypass the quirk and improperly trigger usbhid_init_reports() in
hiddev_ioctl()?

[ ... ]
> @@ -937,9 +940,7 @@ void hiddev_disconnect(struct hid_device *hid)
>  	if (hiddev->open) {
>  		hid_hw_close(hiddev->hid);
>  		wake_up_interruptible(&hiddev->wait);
> -		mutex_unlock(&hiddev->existancelock);
> -	} else {
> -		mutex_unlock(&hiddev->existancelock);
> -		kfree(hiddev);
>  	}
> +	mutex_unlock(&hiddev->existancelock);
> +	hiddev_put(hiddev);
>  }

[Severity: Low]
This is a pre-existing issue, but is there an off-by-one error in the clamp=
ing
logic within hiddev_ioctl_usage() that prevents reading the last valid usage
index?

When a user issues HIDIOCGUSAGES or HIDIOCSUSAGES, the code does:

	uref->usage_index =3D
		array_index_nospec(uref->usage_index,
				   field->report_count -
				   uref_multi->num_values);

Because array_index_nospec() strictly requires the index to be less than the
size, does an index exactly equal to the size (which is valid here) get
incorrectly clamped to 0?

Would this silently return the first block of usages instead of the last
valid block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629152947.1382=
1-1-alhouseenyousef@gmail.com?part=3D1
