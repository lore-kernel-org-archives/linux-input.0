Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA4286A5
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364582; cv=none; b=licc+hfj361GyId0m8VST/ts4w8mkV2OHo6aPt8dXFITPsPTNdmQQBPf644+Q7dX8KVWFUjroWXySPqj5/ufiuktrLPPDYfVtmp0C4haLGNSEFQEkKb1mIYWue8xxw2HPk8rqMz4hTJNyNXpio36ZXbR8YgtojVSTb7ouHRdhbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364582; c=relaxed/simple;
	bh=xvd5U3NeyB3WO1WRn0Ax8ZM6tWFzVFIgL6wDYtEa+AA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eDzLs7rBfqlTiUhlqirBt079EybkNIpORkBbkol59Ljm8e53e1oezEV7op/LTH7o1PpgznKbj3AzWEct9G2dCx7OFrGYYgcK8Vt2FcacmQkUVZ0KPHJOqpQEOQ0cVqqUx17BTTy/sfIq/08h9Dvy031MgWt4kG1gXGhAU8rpjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnRNB8Xn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnRNB8Xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809861F000C4;
	Sun, 18 Oct 2026 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792364580;
	bh=wdI6cpInVo1U5hVGAj/v3fIdQlaQZsHXYl75ljaiqnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnRNB8XnRigyKA64kDRM1/TSDBv5OmEyU4hSa3VAz5shlUMt1oD8IYUfx2WqJTPu3
	 Oe7qvnjDiKdkL7tVoVn3a0dMZPYSdrF0ePvKIJsVqiyQgbMFCMr5J6+ws58ojB5QHv
	 CJNeeNcMpG1GAaDyYuUZVtWzI5NbnDEnV3+pVmhhysQQw5i+P/cs3ZevMdl41Mp+Ds
	 mcPyVz0kvzbd/nLy94b31NXVVphVKNJHLddfU+bucmq+gLVzqaJbRCmIlS8UQ/6uaI
	 W0R/nP4iIp4l1dIItu0gV3zWYcyvIZbdUqB7FRHmGZveyiRR83J2M4nc3yQeE/Ntti
	 F6YR0wc4s6uMw==
Message-ID: <sashiko-outbox-176440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Re-announce connected devices on
 reset-resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Pariente" <markpariente@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018224627.60328-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 23:02:59 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: logitech-dj: broken Unifying device enumeration in logi_dj_=
reset_resume()
--

commit 00da9ba908cab58b8ccc5713c8e413562664314d
Author: Mark Pariente <markpariente@gmail.com>

HID: logitech-dj: Re-announce connected devices on reset-resume

This commit sends a HID++ fake device arrival request in
logi_dj_reset_resume() after switching the receiver back to DJ mode so
that connected devices are re-announced and reconfigured by their child
drivers after a USB reset on resume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D203421
Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/528

> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 6e8db01d27ec0..cdb20fdc7b21e 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -2010,6 +2010,16 @@ static int logi_dj_reset_resume(struct hid_device =
*hdev)
>  		return 0;
> =20
>  	logi_dj_recv_switch_to_dj_mode(djrcv_dev, 0);
> +
> +	/*
> +	 * Paired devices may have reconnected and lost their configuration
> +	 * (e.g. hi-res scrolling) while the receiver was unpowered or switched
> +	 * away by a KVM. Have the receiver re-announce connected devices so
> +	 * the child drivers run their connect handling again.
> +	 */
> +	if (djrcv_dev->dj_mode && logi_dj_recv_query_hidpp_devices(djrcv_dev))
> +		hid_err(hdev, "%s: failed to query connected devices\n", __func__);

[Severity: Medium]
Can calling logi_dj_recv_query_hidpp_devices() unconditionally here break
Unifying (recvr_type_dj) device enumeration when a slot in
djrcv_dev->paired_dj_devices[] is still NULL during logi_dj_reset_resume()?

For example, if logi_dj_probe() ran while a KVM switch was focused on
another host (where commit 36dcfa46852533 leaves dj_mode false and
paired_dj_devices[] unpopulated), or if a new device was paired while
switched away during suspend, paired_dj_devices[device_index] is NULL when
logi_dj_reset_resume() runs.

Normally, logi_dj_recv_query_paired_devices() enumerates recvr_type_dj
receivers using REPORT_TYPE_CMD_GET_PAIRED_DEVICES so that devices are
created from DJ REPORT_TYPE_NOTIF_DEVICE_PAIRED notifications containing
the full 32-bit reports_supported bitmask:

drivers/hid/hid-logitech-dj.c:logi_dj_recv_query_paired_devices() {
	if (djrcv_dev->type !=3D recvr_type_dj) {
		retval =3D logi_dj_recv_query_hidpp_devices(djrcv_dev);
		goto out;
	}

	dj_report =3D kzalloc_obj(struct dj_report);
	if (!dj_report)
		return -ENOMEM;
	dj_report->report_id =3D REPORT_ID_DJ_SHORT;
	dj_report->device_index =3D HIDPP_RECEIVER_INDEX;
	dj_report->report_type =3D REPORT_TYPE_CMD_GET_PAIRED_DEVICES;
	...
}

When logi_dj_recv_query_hidpp_devices() sends HIDPP_FAKE_DEVICE_ARRIVAL to
a Unifying receiver instead, the receiver replies with a HID++
REPORT_TYPE_NOTIF_DEVICE_CONNECTED (0x41) notification with protocol type
0x04 (eQUAD step 4 DJ). Because dj_dev is NULL, logi_dj_hidpp_event()
routes this to logi_hidpp_recv_queue_notif() rather than queuing unknown
work to run logi_dj_recv_query_paired_devices():

drivers/hid/hid-logitech-dj.c:logi_dj_hidpp_event() {
	if (dj_dev) {
		logi_dj_recv_forward_report(dj_dev, data, size);
	} else {
		if (hidpp_report->sub_id =3D=3D REPORT_TYPE_NOTIF_DEVICE_CONNECTED)
			logi_hidpp_recv_queue_notif(hdev, hidpp_report);
		else
			logi_dj_recv_queue_unknown_work(djrcv_dev);
	}
}

That schedules delayedwork_callback() -> logi_hidpp_dev_conn_notif_equad()
-> logi_dj_recv_add_djhid_device():

drivers/hid/hid-logitech-dj.c:logi_hidpp_dev_conn_notif_equad() {
	workitem->type =3D WORKITEM_TYPE_PAIRED;
	workitem->device_type =3D hidpp_report->params[HIDPP_PARAM_DEVICE_INFO] &
				HIDPP_DEVICE_TYPE_MASK;
	...
	switch (workitem->device_type) {
	case REPORT_TYPE_KEYBOARD:
		workitem->reports_supported |=3D STD_KEYBOARD | MULTIMEDIA |
					       POWER_KEYS | MEDIA_CENTER |
					       HIDPP;
		...
		break;
	case REPORT_TYPE_MOUSE:
		workitem->reports_supported |=3D STD_MOUSE | HIDPP | MULTIMEDIA;
		break;
	}
}

Because logi_hidpp_dev_conn_notif_equad() only populates reports_supported
for REPORT_TYPE_KEYBOARD and REPORT_TYPE_MOUSE, Unifying Trackballs,
Touchpads, Numpads, Presenters, and Remote Controls end up with
reports_supported =3D=3D 0, causing logi_dj_ll_parse() to pass a 0-byte rep=
ort
descriptor that hid_parse_collections() rejects with -EINVAL, while
Unifying keyboard+touchpad combos such as the K400 lose STD_MOUSE and
KBD_LEDS.

Furthermore, because paired_dj_devices[device_index] is then populated,
logi_dj_recv_add_djhid_device() will ignore any subsequent DJ
REPORT_TYPE_NOTIF_DEVICE_PAIRED notification for that slot until the
receiver is unplugged:

drivers/hid/hid-logitech-dj.c:logi_dj_recv_add_djhid_device() {
	if (djrcv_dev->paired_dj_devices[device_index]) {
		/* The device is already known. No need to reallocate it. */
		dbg_hid("%s: device is already known\n", __func__);
		return;
	}
	...
}

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018224627.6032=
8-1-markpariente@gmail.com?part=3D1
