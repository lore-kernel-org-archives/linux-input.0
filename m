Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CB2FF675
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366331; cv=none; b=hNVUCtGCMbF4SId7ud6zWv21Wx8egXzkdqfC/7Gm6e/19nUz7WY3UvcynfAz/r4Cm4msxfafjv7i1+tBVD2iIR6cr+r5OR8LATlwv+w5XRoRXl27PeiKxtS+x1WWjTbRL3oQSfFIjkbFKA3ipwmAsJtbbDnZ4RBLJvUO6Nl5B4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366331; c=relaxed/simple;
	bh=TShDwzHw9mFKlhu36YY/k0jVavpcBMixXzWF/PR3m3M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qoEfqJJe3dGR3HQEkYIgx/1IBOBxrITh5nAdNuVqDNnlxJC+FP85c5d6Ta4+C1QNgbb/CTIY/YeZQasCpSZEbs/WYQ7Qm5NFJXf19rrUtHdPrCYrIqELsMfSdWdTAoXcH646oljHyhVKJdGREGWzSmx3CuUjZ/ocP1xdhjz9tTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnMcVvk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnMcVvk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A859B1F000E9;
	Sat, 22 Aug 2026 02:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366329;
	bh=qsYmL9BX7uikFZnFJYPWP+JUmNDy9qTNJGd8zvTTpsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnMcVvk77hofhczGTzWvtZ3BKetXB3+oS6FZK6xeyuzNksOAL99nOGaE92UmEoERs
	 T7oXSAVsrWqHUcW5ypX3A7bGixPg4D0HwwHWpMyc6hizSq/oN4DPMblfREtVZ3LZF1
	 If9s+XzMMr0wuX3tejbmm3keIxB9wkG4BklIOzjDv9AMH41Cx2EWnmmnT3+Myckb3J
	 uIWfw+p74YK9zgEUOrOeghlSixccnWaIpL//n7Q2nbZX9Lij5EJ6VwGOrQsuF7/jYj
	 5Y2nqdm1rM8C7dtz+qCm9Q+3WjpGUL2aNTID1LrQeNhA4TfEggp9uErw+NqYKzLciC
	 qsX+ip7IFdGmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/12] Input: xbox_gip - Add arcade stick support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-9-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-9-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:38:49 +0000
Message-Id: <20260822023849.A859B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Memory leak of `gip_arcade_stick_info` on device disconnect beca=
use the core framework never invokes the `.remove()` callback.
- [Medium] Missing event synchronization when an input report is truncated =
(2 to 5 bytes), leaving spurious events stuck in the input subsystem buffer.

Pre-existing issues:
- [High] Use-After-Free of `attachment->input` if `input_register_device` f=
ails.
- [High] Use-After-Free and DMA corruption in the teardown path due to fail=
ing to stop outbound URBs and the `send_fragment` work.
--

--- Patch [8]: [PATCH v4 08/12] Input: xbox_gip - Add arcade stick support =
---
commit 0a0bb97c59622a30366ca74123a1a5db969d555d
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add arcade stick support
   =20
This adds support for the arcade stick device type. Currently I'm only
aware of one Xbox controller that uses this device type, the Razer Atrox,
so testing coverage is limited.

> diff --git a/drivers/input/joystick/gip/gip-arcade-stick.c b/drivers/inpu=
t/joystick/gip/gip-arcade-stick.c
> new file mode 100644
> index 0000000000000..11ededfab8555
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-arcade-stick.c
> @@ -0,0 +1,173 @@

[ ... ]

> +static int gip_arcade_stick_probe(struct gip_attachment *attachment)
> +{
> +	struct gip_arcade_stick_info *info =3D kzalloc(sizeof(*info), GFP_KERNE=
L);
> +
> +	if (!info)
> +		return -ENOMEM;
> +
> +	attachment->quirks |=3D GIP_QUIRK_SWAP_LB_RB;
> +	attachment->driver_data =3D info;
> +
> +	return 0;
> +}
> +
> +static void gip_arcade_stick_remove(struct gip_attachment *attachment)
> +{
> +	kfree(attachment->driver_data);
> +	attachment->driver_data =3D NULL;
> +}

[Severity: Medium]
Will this leak gip_arcade_stick_info on device disconnect? Looking at the
core framework in gip-core.c, it doesn't appear to invoke the .remove()
callback of any attachment driver during device teardown (gip_disconnect),
so the memory allocated here might never get freed.

[ ... ]

> +static int gip_handle_arcade_stick_report(struct gip_attachment *attachm=
ent,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	struct gip_arcade_stick_info *info =3D attachment->driver_data;
> +	int rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	rc =3D gip_driver_navigation.handle_input_report(attachment, input, byt=
es, num_bytes);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (num_bytes < 6) {
> +		gip_dbg(attachment, "Discarding too-short input report\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Can this leave unsynchronized events in the input buffer if an input report=
 is
truncated (between 2 and 5 bytes)?=20

The base handler gip_driver_navigation.handle_input_report() may successful=
ly
process the first 2 bytes, report multiple EV_KEY events, and return 0. If
num_bytes is then evaluated as < 6, returning -EINVAL here causes the
core caller to skip input_sync().

[ ... ]

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 765d70033f205..da22545662e21 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -1554,7 +1556,7 @@ static int gip_handle_command_raw_report(struct gip=
_attachment *attachment,
>  	return 0;
>  }
> =20
> -static int gip_setup_input_device(struct gip_attachment *attachment)
> +int gip_setup_input_device(struct gip_attachment *attachment)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but can attachment->input become=
 a
dangling pointer if input_register_device() fails?=20

In gip_setup_input_device(), attachment->input is assigned the newly
allocated input device:

	rcu_assign_pointer(attachment->input, input);
	rc =3D input_register_device(input);
	if (rc)
		goto err_free_device;
    ...
err_free_device:
	input_free_device(input);
	return rc;

If registration fails, the error path frees the input device but doesn't set
attachment->input back to NULL. Later disconnects or input packets could
dereference the freed pointer.

>  	struct input_dev *input;
>  	int rc;

[Severity: High]
This is a pre-existing issue, but does the teardown path in gip_disconnect()
cause a use-after-free or DMA corruption?

Looking at gip_disconnect() in drivers/input/joystick/gip/gip-core.c:

static void gip_disconnect(struct usb_interface *intf)
{
    ...
	usb_kill_urb(gip->data.urb_in);
	if (gip->audio.intf)
		usb_kill_urb(gip->audio.urb_in);

	gip_shutdown(gip);

	spin_lock_irqsave(&gip->message_lock, flags);
	gip_deinit_input(&gip->data);
	gip_deinit_output(&gip->data);

It calls usb_kill_urb() for inbound URBs, but misses outbound URBs
(intf->out_queue[i].urb). It then calls gip_deinit_output(), which
unconditionally frees the coherent DMA buffers and the URB structures. If an
outbound URB is in flight, the USB host controller might perform DMA reads =
from
the freed memory.

Additionally, gip_disconnect() doesn't seem to cancel the
&intf->send_fragment work, meaning if an outbound URB completes, it could
schedule the work to access the freed gip device structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D8
