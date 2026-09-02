Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7D62D1913
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788312137; cv=none; b=G2Leny9XOGh/wkDz3YPwycwFo5makJ1ZgZPXtBIR3BwqwsZ2v96TArG6ckY+CIeGC4OmPv1PJrsnTTRTn32SkYhmmw1oUE/VsW4I5TU401ZbGsnbkheLOHgf14zJYVfL+R1C4vwXUQD0mQMRlUf5sJH1SyhUaYqgavWcwx30Stg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788312137; c=relaxed/simple;
	bh=UyUV9MIcYCJnX477wrS4j6mlhdIwVhAC1iNLzpDo9AY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PHYl0GGxYUffIhqV8lfyVMRwiYSXE6SL/9JySX4/w3I9arAaNzgArU+h5+CJVA30O+2NB8K8+MpRhSZw4ky5Po0eyp4nU6NEyl6Ip+Sik594GvwCjUCViml3oHqO+nv0z2u4vjgPlHIzpJpCVWwsGo0YvoHmx9Cw169bwNcU47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIloLmos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIloLmos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B138A1F000E9;
	Wed,  2 Sep 2026 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788312135;
	bh=VoHVlPC+AyPpmP7J7P8koUXKQUM5rZDtx/AFDwz6EyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIloLmosC1J8U+rmiGV4qLAYZ3CjrA6Bmlk4SVaqslKK6CxDWa0MbtBDLxwbYtcA2
	 oJMBnWEwvIjE67viXh6gRh2aiCfxGdgnWVAMnVOFOhesOz8I/SZzCAY6q6RPfBpTN3
	 r2l2GAooP2JcUVJGjXp/+dAKSU7BraoHhWBZYpu0g9ccyrQvnHq6N7EbmE4i351+Jh
	 DIAsFxk2Q6KelULFHjlPNpcEUfWWVgbUFBr7PRtZzjklFGSuSQ2p5vACAmJVUVU8vk
	 k/8JWTwnpT6OPW6IoqX1sBycr8DsTiSKQLe1x6KVQB04XKn04MNEXlDGXV1+3MAI71
	 pnmjtQRvKAJsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] Input: xbox_gip - Add HID relaying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902010237.865772-5-vi@endrift.com>
References: <20260902010237.865772-1-vi@endrift.com>
 <20260902010237.865772-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 01:22:15 +0000
Message-Id: <20260902012215.B138A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] gip_reset_metadata() frees hid_descriptor before destroying th=
e HID device, allowing a concurrent UAF during HID probe.
- [High] Fragmented HID reports are processed with a payload size of 0, cau=
sing the entire assembled report to be truncated and silently dropped.
- [Medium] Useless synchronize_rcu() call delays device initialization.
- [Medium] The hid_device fields `version`, `country`, and `uniq` are not i=
nitialized before calling `hid_add_device()`.

Pre-existing issues:
- [Critical] Use-after-free in receive worker due to incorrect shutdown ord=
ering.
--

commit e6352eb8b59489fd2119b2f3d053cfef65ac2c92
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add HID relaying

This patch allows tunneling of HID packets by creating a hid_device for
the HID descriptor embedded in the GIP metadata, and relays the packets.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 23ab0768580f5..3b033fe65dc40 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
> @@ -560,6 +560,54 @@ int gip_send_vendor_message(struct gip_attachment *a=
ttachment,
>  		bytes, num_bytes);
>  }
> =20
> +static int gip_hid_ll_parse(struct hid_device *hdev)
> +{
> +	struct gip_attachment *attachment =3D hdev->driver_data;
> +
> +	return hid_parse_report(hdev,
> +		attachment->metadata.device.hid_descriptor,
> +		attachment->metadata.device.hid_descriptor_size);
> +}

[Severity: Critical]
Can this lead to a use-after-free during a concurrent HID probe?

If a device reset or hotplug occurs, gip_reset_metadata() frees the
metadata before destroying the child devices:

gip_reset_metadata()
    gip_metadata_free(to_gip_device(attachment), &attachment->metadata);
    gip_free_devices(attachment);

Since gip_metadata_free() synchronously frees hid_descriptor, if the HID
core concurrently probes the device and calls gip_hid_ll_parse() before
gip_free_devices() unregisters the HID device, it would dereference the
freed descriptor memory.

[ ... ]

> @@ -1303,6 +1351,48 @@ static int gip_init_input_device(struct gip_attach=
ment *attachment)
>  	return rc;
>  }
> =20
> +static int gip_create_hdev(struct gip_attachment *attachment)
> +{
> +	struct hid_device *hdev;
> +	int rc;
> +
> +	if (!attachment->metadata.device.hid_descriptor)
> +		return 0;
> +
> +	rcu_read_lock();
> +	hdev =3D rcu_dereference(attachment->hdev);
> +	rcu_read_unlock();
> +	if (hdev)
> +		return 0;
> +
> +	hdev =3D hid_allocate_device();
> +
> +	if (IS_ERR(hdev))
> +		return PTR_ERR(hdev);
> +
> +	hdev->ll_driver =3D &gip_hid_ll_driver;
> +	hdev->bus =3D BUS_GIP;
> +	hdev->vendor =3D attachment->vendor_id;
> +	hdev->product =3D attachment->product_id;
> +	hdev->dev.parent =3D to_gip_device(attachment);
> +	hdev->driver_data =3D attachment;
> +	if (attachment->name)
> +		strscpy(hdev->name, attachment->name);
> +	else
> +		strscpy(hdev->name, "Xbox Chatpad");
> +	strscpy(hdev->phys, attachment->phys);
> +	rc =3D hid_add_device(hdev);

[Severity: Medium]
Are we missing the initialization of some standard hid_device fields here?

It appears that the version, country, and uniq fields are not populated
before calling hid_add_device(). This might break userspace expectations
that rely on these standard HID properties for device matching or
configuration.

> +	if (rc) {
> +		gip_err(attachment, "HID device add failed: %d\n", rc);
> +		hid_destroy_device(hdev);
> +	} else {
> +		rcu_assign_pointer(attachment->hdev, hdev);
> +		synchronize_rcu();
> +	}

[Severity: Medium]
Is this synchronize_rcu() call necessary on the successful allocation path?

Since we are publishing a new pointer where the previous value was NULL,
there are no existing readers holding an old pointer that needs to be
reclaimed. This seems to delay device initialization by a full RCU grace
period unnecessarily.

[ ... ]

> @@ -1768,9 +1868,17 @@ static int gip_handle_command_firmware(struct gip_=
attachment *attachment,
>  static int gip_handle_command_hid_report(struct gip_attachment *attachme=
nt,
>  	const struct gip_header *header, uint8_t *bytes, int num_bytes)
>  {
> -	gip_warn(attachment, "Unimplemented HID report message\n");
> +	struct hid_device *hdev;
> =20
> -	return -EOPNOTSUPP;
> +	guard(rcu)();
> +	hdev =3D rcu_dereference(attachment->hdev);
> +	if (hdev)
> +		return hid_safe_input_report(hdev, HID_INPUT_REPORT, bytes,
> +			num_bytes, umin(header->length, num_bytes), true);

[Severity: High]
Could this cause large fragmented HID reports to be silently dropped?

When gip_receive_fragment() reassembles a fragmented message, it completes
upon receiving a terminator fragment where header->length is 0. It then
calls gip_handle_message() using this final header.=20

If umin(header->length, num_bytes) is evaluated with header->length =3D=3D =
0,
the payload size passed to hid_safe_input_report() will be 0, causing the
entire reassembled HID report to be truncated.

> +
> +	gip_warn(attachment, "Got HID report with no HID descriptor\n");
> +
> +	return -EPROTO;
>  }

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free risk in the
receive worker due to incorrect shutdown ordering in gip_disconnect()?

Looking at gip_disconnect():

	gip_shutdown(gip);
	...
	usb_kill_urb(gip->data.urb_in);

The gip_shutdown() function synchronously cancels the receive worker.
However, this happens before usb_kill_urb() is called. If an incoming URB
completes right after cancel_work_sync() returns, gip_urb_in() could
re-queue the worker.

When gip_disconnect() then proceeds to free the gip structure, the
re-queued worker will execute gip_receive_work() and access the freed
memory. Should the URBs be killed before cancelling the workers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902010237.8657=
72-1-vi@endrift.com?part=3D4
