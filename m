Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF873D9DA6
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039219; cv=none; b=B1bjg1WUb+7/GKoKGuZrWCxhVacJd3Ji45NMscWVytTwRcT/optpMTWGyQRmSdxs5f3MI30UFmH515vOJLQUY775lDne+Ukn0GtOWrPqXIy+msTtDatmPz7LVYkqMCsRYRrIhyb/IrOeCxxpfA0O/E9DHy8cdCWiPV6Oky/vSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039219; c=relaxed/simple;
	bh=3kgPtJEgbEl2z6F/X2r1XyU9/IkN0wKcCzqlFSU/CEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LCmHExEed9hw+lFZ3/pI0y/mUd+IGoxa22DWZdqGYV0OAkZtOceaq9MzTw4id7cc1Afd8Bas9C+Lx3dFiYZNtIN6o4PbL+LIMkleqo4wo8UGAFsW2NLoMKeJUiye8BZ4YBNadf/LUjOl96Oul+uPPAiSwYon9nLvqU5du2XEyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FltjkNer; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FltjkNer"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857A41F000E9;
	Tue, 18 Aug 2026 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039217;
	bh=DIkgz21XsFbamI/SOv8mnuPVv0YjiSfxqwHzs5YbQmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FltjkNerPmvWP2ZVuzFUcNSLEtZ7G3bbZglm1fRb00Fh95Y1EgORNWtNgbAUuOJWF
	 WRYElrT1MQDZ+yIcUWg9dGeeV/0mVQ1nxSmIX16qDVFRnq2CoGfK4MhFoC5qaCzCmT
	 HMYt0qTF3yXn5yNXzeXA6HBrW+34SHv/ReR222pt/OnZ6qdjX6m+rG5/hbMisUgPp3
	 kfSjHZATT8kaSEmj7VP4K1GnsF9stM9I04Sf3fPrjCt8kJW/DYtBVmYSkh0MmE/WsE
	 4DATSJJagJ2qM8j0CMgfqKB6OxBZgchkyDwpVIfRYIF23YkDbyZ7aRb1/VDD1hQRlS
	 W8nJh1t0HhFAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V8] xpad: Overhaul device data for wireless devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818073159.909188-4-sanjay.govind9@gmail.com>
References: <20260818073159.909188-4-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:46:57 +0000
Message-Id: <20260818074657.857A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Forcing `xpad->pad_present =3D false` during suspend creates a per=
manent state mismatch, leading to an input device leak on disconnect and re=
using wrong device properties on reconnect.
- [Medium] Stale wireless properties (`wireless_vid`, `pid`, etc.) leak to =
subsequent controllers if a controller disconnects before the 500ms initial=
ization delay completes.
- [Medium] Wireless properties are written in interrupt context and read in=
 process context without synchronization, causing a data race.

Pre-existing issues:
- [High] Missing `cancel_delayed_work_sync` in the `xpad_probe` error path =
causes a Use-After-Free if initialization fails.
--

--- Patch [1]: [PATCH V8] xpad: Overhaul device data for wireless devices -=
--
commit 3361aff664031bdf598a6c0d59485911918ea3b4
Author: Sanjay Govind <sanjay.govind9@gmail.com>

xpad: Overhaul device data for wireless devices

Xbox 360 wireless controllers expose information in the link and
capabilities reports. Extract and use the vendor id for wireless controller=
s,
and use the subtype to build a nicer device name and product id.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..ad24e3dd15fbb 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -958,19 +982,12 @@ static void xpad360_process_packet(struct usb_xpad =
*xpad, struct input_dev *dev,
> =20
>  static void xpad_presence_work(struct work_struct *work)
>  {
> -	struct usb_xpad *xpad =3D container_of(work, struct usb_xpad, work);
> +	struct usb_xpad *xpad =3D container_of(work, struct usb_xpad, work.work=
);
>  	int error;
> -
> -	if (xpad->pad_present) {
> -		error =3D xpad_init_input(xpad);
> -		if (error) {
> -			/* complain only, not much else we can do here */
> -			dev_err(&xpad->dev->dev,
> -				"unable to init device: %d\n", error);
> -		} else {
> -			rcu_assign_pointer(xpad->x360w_dev, xpad->dev);
> -		}
> -	} else {
> +	/* Check if the pad presence has changed */
> +	if (xpad->pad_present =3D=3D xpad->input_created)
> +		return;

[Severity: Medium]
If a controller connects and schedules xpad->work with a 500ms delay, and
then disconnects before the timer expires, xpad->pad_present becomes false.
When xpad_presence_work() runs, it will see pad_present (false) =3D=3D=20
input_created (false) and return early.

Does this early return prevent xpad_deinit_input() from clearing the stale
wireless properties, allowing a subsequent controller to erroneously inherit
them if it connects without a Link report?

[ ... ]

> @@ -995,10 +1021,11 @@ static void xpad_presence_work(struct work_struct =
*work)
>   * 01.1 - Pad state (Bytes 4+) valid
>   *
>   */
> -static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data)
> +static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsi=
gned char *data, u32 len)
>  {
>  	struct input_dev *dev;
>  	bool present;
> +	u16 parsed_vid;

[ ... ]

> +	/* Link report */
> +	if (len >=3D 26 && data[0] =3D=3D 0x00 && data[1] =3D=3D 0x0F) {
> +		xpad->sub_type =3D data[25] & 0x7f;
> +
> +		/* Decode vendor id from link report */
> +		parsed_vid =3D ((data[0x16] & 0xf) | data[0x18] << 4) << 8 | data[0x17=
];
> +
> +		/*
> +		 * If the link report doesn't provide a proper vid, it sets the vid to=
 1.
> +		 * In that case we zero out wireless_vid, so that we fall back to the =
vid
> +		 * from the receiver instead.
> +		 */
> +		if (parsed_vid =3D=3D 1)
> +			parsed_vid =3D 0;
> +
> +		/*
> +		 * x360w controllers on windows put the subtype into the product
> +		 * for wheels and gamepads, but it makes sense to do it for all
> +		 * subtypes. This will be used if the capabilities report
> +		 * doesn't provide us with a product id later.
> +		 */
> +		xpad->wireless_vid =3D parsed_vid;
> +		xpad->wireless_pid =3D 0x02a0 + xpad->sub_type;
> +		xpad->wireless_version =3D 0;
> +
> +		if ((data[25] & 0x80) !=3D 0)
> +			xpad->flags |=3D FLAG_FORCE_FEEDBACK;

[Severity: Medium]
This function executes in interrupt context, modifying properties like
wireless_vid, sub_type, and flags.

Concurrently, xpad_init_input() runs in process context (workqueue) after
the 500ms delay and reads these exact fields. Since the irq_in URB remains
active, a late Link or Capabilities report can arrive while the workqueue
executes.

Could this data race lead to torn reads or an inconsistent property state
being applied to the device?

[ ... ]

> @@ -2084,7 +2251,7 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id
>  		xpad->delay_init =3D true;
> =20
>  	xpad->packet_type =3D PKT_XB;
> -	INIT_WORK(&xpad->work, xpad_presence_work);
> +	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);

[Severity: High]
This is a pre-existing issue, but by changing this to a delayed work with a
500ms window, it becomes much easier to trigger.

If a connection packet arrives immediately after the irq_in URB is submitte=
d,
the interrupt handler will schedule xpad->work with a 500ms delay.

If a subsequent initialization step in xpad_probe() fails, the error path
frees the xpad struct:

err_free_idata:
        usb_free_coherent(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
err_free_mem:
        kfree(xpad);
        return error;

Since the error path does not call cancel_delayed_work_sync(), will the
pending work execute 500ms later and trigger a use-after-free on the freed
xpad struct?

[ ... ]

> @@ -2265,6 +2432,7 @@ static int xpad_suspend(struct usb_interface *intf,=
 pm_message_t message)
>  		 */
>  		if (auto_poweroff && xpad->pad_present)
>  			xpad360w_poweroff_controller(xpad);
> +		xpad->pad_present =3D false;
>  	} else {
>  		guard(mutex)(&input->mutex);

[Severity: High]
If the system suspends, xpad->pad_present is forced to false here, but
xpad->input_created remains true.

If the controller disconnects during suspend, the resume sequence receives a
status packet with present =3D false. Then xpad360w_process_packet() sees
xpad->pad_present !=3D present (false !=3D false) and drops the event.

Will this prevent xpad_presence_work() from ever being scheduled to call
xpad_deinit_input(), leaking the input device?

Furthermore, if a new controller connects, pad_present becomes true. Would
xpad_presence_work() see pad_present (true) =3D=3D input_created (true) and
return early, failing to apply the new controller's properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818073159.9091=
88-4-sanjay.govind9@gmail.com?part=3D1
