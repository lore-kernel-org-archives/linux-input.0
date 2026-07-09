Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A8039903A
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568324; cv=none; b=ocWz5PVMz6YJad3BWrhW4T4Q5KUROE4uJS/pFDTUe75+aIA+Ai1lpcXJDywE0tLb9ru9TM2s2d0/xTCqyTvvqzAI8FlWDVGkFkH/vW/4YS/Ksvvg2tp5i83hsnQkHRhPMGPrhQGMR9i9uKaKvufVZQhlPh6/CyELGEUsDwznSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568324; c=relaxed/simple;
	bh=N3sI+OoQHlzQ3iSPzLYoNouRMzKJevTIdZQeWSTSWMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JNyM/xTBO/ZPgt+4N3FCm1tx5t7tp4Lg9LnhQtoya/LS3/gMs/WvI/SnJb2ZFfCExmMUEQ6RjM084Bz+DlNKFbSSmgRu34XmJ9Av+nrveCPC+iBwnd/KyphICecli2G7Yjce/R7HD1i8dv/04vERwlZe5w+UFSIaD5YREhX7xF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+MfPeXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+MfPeXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE801F000E9;
	Thu,  9 Jul 2026 03:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568323;
	bh=K22I1M89T8yzTOHOd5XifrZDHlD5hAJPVCFfgyAm4uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+MfPeXzGLkFL8tcYaMBeAwt28i17lCWA9iXf0mhFEEThEDWyhAMwl18MR/OlR+yu
	 mRx2QW4lpRlaJdl4z/y6nqJXkB15VvD/EpFRdQj0PUAN68XHSwuN5gcZy1paorylRV
	 D7vhAXENZNSCd3WFwRMS/0IIg5ANMzVGRGRha52+XB95jYtT0TWFcQOHljWd5sc6le
	 7I4wSolfSu9kjZjmdnLFjFP1NZwo4UhqYzt0THQIbPpgmhFoQn98AGDAZ+k7R1bJHN
	 LTKTHf6spAdmYi+UeOeapG0n4vMEGMQLuq8JhDYVkJ7uliDFMjRMsr7HkMyDc9+c+c
	 +0XFbQhlOOqFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] HID: steelseries: Manage battery lifetime with
 refcounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260709032316.1908460-8-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
 <20260709032316.1908460-8-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:38:42 +0000
Message-Id: <20260709033842.BDE801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless access to `sd->battery` in `steelseries_arctis_raw_event(=
)` creates a TOCTOU race with `remove()`, potentially causing a Use-After-F=
ree.
--

--- Patch [7]: [PATCH v6 7/9] HID: steelseries: Manage battery lifetime wit=
h refcounting ---
commit acac88b3e3a741b01e199d1d54e37c2b85ec3b35
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Manage battery lifetime with refcounting

This patch converts the steelseries_device structure to use a kref so its s=
tate
can outlive a single HID interface. It also registers and unregisters the p=
ower
supply explicitly instead of using devm, and clears sd->battery under a
spinlock in the remove function.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c

[ ... ]

> @@ -387,13 +405,20 @@ static void steelseries_arctis_remove(struct hid_de=
vice *hdev)
>  	if (interface_num =3D=3D sd->info->sync_interface) {
>  		spin_lock_irqsave(&sd->lock, flags);
>  		sd->removed =3D true;
> +		battery =3D sd->battery;
> +		sd->battery =3D NULL;
>  		spin_unlock_irqrestore(&sd->lock, flags);
> =20
>  		cancel_delayed_work_sync(&sd->status_work);
> +
> +		if (battery)
> +			power_supply_unregister(battery);
>  	}
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

[Severity: High]
Can this lead to a use-after-free if a battery status report arrives just as
the device is being removed?

In steelseries_arctis_raw_event(), sd->battery is accessed locklessly:

    if (sd->battery) {
        steelseries_headset_set_wireless_status(sd->hdev,
                               sd->headset_connected);
        power_supply_changed(sd->battery);
    }

If a raw event checks sd->battery and then gets preempted, this remove() pa=
th
can clear sd->battery and unregister the power supply because hid_hw_stop()
hasn't been called yet to halt the delivery of USB URBs.

When raw_event() resumes, wouldn't it call power_supply_changed() on the ne=
wly
freed battery pointer?

> +
> +	kref_put(&sd->refcnt, steelseries_device_release);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709032316.1908=
460-1-68172138+srimanachanta@users.noreply.github.com?part=3D7
