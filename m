Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D88346A14
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183280; cv=none; b=gYFjAfjzshArJFtGpZMCua7XEDjiBBNaJsJXd/b0ha4OCAXsRx+NeR6CWyC7qoHlRmS2Dn+7q0RJ4M6auAS6Pp1P/frXkSZMDc4pvbZSeFrkA4EGOI3Y7d3ifwrxmlDchdZOre0qpk1KVGnK0kuegRDIM47UhpI6JS033EJ5FDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183280; c=relaxed/simple;
	bh=gIXgFkELJG4Aic8SMEBsHigZFAW75pEFuW2Z6WgJRaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=quKZEjGncECZGhv99rYYa+6u+/WZk9FDF4yRTziinnBbkusqSF53gNu8qNmq2hM0w2SHxbpdt8DMnzwPA7OkoY05DgMpmyzjz7LYox54vMQQh3PAGrdSt63L+1Q/VKHcc/AjwCqDfa7CYxK8u1NTL503QoMyj2rnyXrq/F2GbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxacLTp3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxacLTp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5548C1F00893;
	Sat, 12 Sep 2026 03:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183275;
	bh=FQ3Cex6TxhNqHep7BDqcuGNTo+vpfnfmJYhgTGe+zH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FxacLTp3HvnDSBMRmxT1NDsTwwtFNy8cWSWq9kicsHfpoQQliAd02wo2gqBzZXiJi
	 lZosBoiX/j/EbGsVSpeJG/zw3WpI0XkiOr+hQGrSQmo1Vn3RpeaqZJ9cJu/4dd3n9K
	 codYoFL3bd8GjYWrw3TBR8ph3LJo162L8XfVx2SUw6xeQPZ6BZijat+qDoSPUeWGsV
	 8Ce+FTge9UkxrJD+JaWlK8kX5qpyv37LQQPeTJDnf9BA5bhHvUe0RXbikKyTsy6dEx
	 AwXrtih9zMUD2ENDFrJzukcaymxj6bGo6aRkY/VF+uk3lWhOpYDqBYxTZfCoN9hAeT
	 s0y26jgty2n6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/12] Input: xbox_gip - Add HID relaying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-5-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:21:14 +0000
Message-Id: <20260912032115.5548C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Use of hid_input_report instead of hid_safe_input_report can lead =
to out-of-bounds reads.
- [High] gip_hid_ll_raw_request returns 0 for an unimplemented feature, cau=
sing an infinite loop in userspace.
- [High] Calling strscpy() with a potentially NULL source pointer will caus=
e a kernel panic.
- [High] The patch removes ratelimiting from a warning triggered by incomin=
g USB packets, which can lead to kernel log spam.
- [Medium] Hardware HID reporting is enabled before the HID device is fully=
 created and published, leading to dropped early reports.
- [Low] Unnecessary synchronize_rcu() after publishing a new RCU pointer.

Pre-existing issues:
- [Critical] Potential use-after-free of the gip structure during device di=
sconnect because the receive_message workqueue can be rescheduled after it =
is cancelled.
--

commit a00262371994fa8e8d98c8d8041e5850d744198e
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add HID relaying

GIP allows tunneling of HID packets, with the HID descriptor embedded in
the GIP metadata exchanged during the initial handshake. This patch creates
a hid_device for this HID descriptor if found, as well as relaying the HID
packets.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 9371d860a59b8..411b67399e018 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -560,6 +560,54 @@ int gip_send_vendor_message(struct gip_attachment *a=
ttachment,
> +static int gip_hid_ll_raw_request(struct hid_device *hdev,
> +	unsigned char reportnum, uint8_t *buf, size_t count,
> +	unsigned char report_type, int reqtype)
> +{
> +	/*
> +	 * TODO: Based on the metadata, output reports appear to be possible,
> +	 * but the chatpad doesn't have the LEDs it claims to support, so
> +	 * it's not clear how to test we're sending them properly.
> +	 */
> +	return 0;
> +}

[Severity: High]
Returning 0 indicates success with 0 bytes transferred. When a userspace
application calls write() on the hidraw device node, it will eventually call
this raw_request callback. Won't returning 0 here cause standard userspace
write loops to continuously retry indefinitely, resulting in a 100% CPU
infinite loop? Should this return a negative error code like -EOPNOTSUPP
instead?

[ ... ]
> @@ -1322,6 +1370,51 @@ static int gip_init_input_device(struct gip_attach=
ment *attachment)
[ ... ]
> +	if (attachment->name)
> +		strscpy(hdev->name, attachment->name);
> +	else
> +		strscpy(hdev->name, "Xbox Chatpad");
> +	strscpy(hdev->phys, attachment->phys);
> +	strscpy(hdev->uniq, attachment->uniq);

[Severity: High]
If attachment->uniq remains NULL (for example, if the earlier dynamic
allocation via devm_kasprintf() failed under memory pressure), strscpy()
will be called with a NULL source pointer. Since strscpy() doesn't
gracefully handle NULL source pointers, won't this trigger a kernel panic
during device hotplug?

> +	rc =3D hid_add_device(hdev);
> +	if (rc) {
> +		gip_err(attachment, "HID device add failed: %d\n", rc);
> +		hid_destroy_device(hdev);
> +	} else {
> +		rcu_assign_pointer(attachment->hdev, hdev);
> +		synchronize_rcu();

[Severity: Low]
Because there are no pre-existing readers that could be accessing the newly
published hdev pointer, is synchronize_rcu() needed here? Does this just add
an unnecessary latency penalty during device initialization?

> +	}
> +
> +	return rc;
> +}

[ ... ]
> @@ -1387,7 +1480,11 @@ static int gip_send_init_sequence(struct gip_attac=
hment *attachment)
>  	if (rc)
>  		return rc;
> =20
> -	return 0;
> +	rc =3D gip_create_hdev(attachment);
> +	if (rc)
> +		return rc;
> +
> +	return rc;
>  }

[Severity: Medium]
Earlier in gip_send_init_sequence(), the driver sends a GIP_STATE_START
command to the device, instructing it to begin reporting state. Because the
HID device is created and published here after that hardware command, won't
any early input reports arriving before gip_create_hdev() completes be
dropped and trigger spurious kernel warnings?

[ ... ]
> @@ -1783,9 +1886,16 @@ static int gip_handle_command_firmware(struct gip_=
attachment *attachment,
>  static int gip_handle_command_hid_report(struct gip_attachment *attachme=
nt,
>  	const struct gip_header *header, uint8_t *bytes, int num_bytes)
>  {
> -	gip_warn_ratelimited(attachment, "Unimplemented HID report message\n");
> +	struct hid_device *hdev;
> =20
> -	return -EOPNOTSUPP;
> +	guard(rcu)();
> +	hdev =3D rcu_dereference(attachment->hdev);
> +	if (hdev)
> +		return hid_input_report(hdev, HID_INPUT_REPORT, bytes, num_bytes, true=
);

[Severity: High]
If a malicious or malfunctioning USB device crafts a report exceeding bounds
because the descriptor defines more fields than the actual payload size,
could using hid_input_report() here cause an out-of-bounds read in the HID
core? The HID subsystem guidelines require transport drivers to use
hid_safe_input_report() so the core can perform boundary checks against the
allocated buffer size.

> +
> +	gip_warn(attachment, "Got HID report with no HID descriptor\n");

[Severity: High]
By changing gip_warn_ratelimited() to a standard gip_warn(), a
malfunctioning or malicious unprivileged USB device could send continuous
HID report packets before a descriptor is configured. Could this flood the
kernel log and lead to a denial of service?

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed a potential
use-after-free of the gip structure during device disconnect in the base
driver.

Looking at gip_disconnect() in gip-core.c:

gip_disconnect()
   gip_shutdown(gip); // synchronously cancels gip->receive_message
  =20
   usb_kill_anchored_urbs(&gip->data.out_anchor);
   if (gip->audio.intf)
       usb_kill_anchored_urbs(&gip->audio.out_anchor);
      =20
   gip_deinit_input(&gip->data); // kills IN URB here

Because the USB IN URB is not killed until gip_deinit_input(), if the IN URB
completes between gip_shutdown() and gip_deinit_input(), gip_urb_in() will
execute and reschedule gip->receive_message.

When gip_disconnect() subsequently frees the gip structure, won't the
rescheduled work execute on freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D4
