Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2D378D87
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036369; cv=none; b=Hz5RY66As/3K7G9y7mb6YUkztUSDlgTIpUdpfsB2yr3e2EXbhugaFt4yDC0v1SfnZzRp6FUPHv/yRwmyx8QJ+pnYV627D2bupaLkcyRhPpqZ4tR8gzmiVbTmKFNjYI2bg1Z9n0zu9e6WDpRo3cUKtHHynIebMDOKssBCZ58I1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036369; c=relaxed/simple;
	bh=GSHygDSU5ScehWALsDP/T59rkQz3/MRJ3n4T+hfI8xM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yp1WE21cqvEPEteqr7a4VH1S1ijjoaPr0bPLZ7KN8uVpsMvopgC8H+ctHlKOWS1V55k1NvbwzniEpl5VrmUDBglLywvJ3gH8TUwL+/xgPhJOYIB0+5b82dB6THSbLKbWSNaQypHxBqPNe+/BgqWHxmqIzacsGaw/a63ioahFYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDygZkbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDygZkbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3421F000E9;
	Tue, 18 Aug 2026 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036367;
	bh=2fFqLwuTInwYurE69GQV8boYI0jkjqI3mh//QmGGjwQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDygZkbvVhzTW0cKaNwTlJmuwsQBlAhlPCRFNER4Fh/ObWPxzlVz6N15EM22hWP6/
	 OwWhYCjZG/xIsCuQfyQKHHq9IgehoC+nymYYoXr1pxTXlAsfhSpV171+cgxMR7GZLM
	 aACpa3zp/TPZPX/0a6ncxZzzBbsVcHSpEJnJFK7FX/gvXZgHIw5rC1bUicyB8/PMMY
	 JB1tOkLaZX0jZzXASYFbTxM44qYkHXAhatlkvc2IQo13Sxshu8JhMQ308RFfuGUdJ2
	 tq1x35LT4perPRTrdz5AL94bldCDgPSwLyIc8wjzKRyg8AzHaOSW4wsPxHsbIyV3vH
	 1oaXbOXhhDHvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V7 RESEND] xpad: Overhaul device data for wireless
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818064557.872622-3-sanjay.govind9@gmail.com>
References: <20260818064557.872622-3-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:59:26 +0000
Message-Id: <20260818065927.4D3421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Canceling the delayed presence work during suspend leaves the de=
vice state machine permanently stuck upon resume.
- [Low] Stale wireless controller properties leak across rapid connect/disc=
onnect cycles.

Pre-existing issues:
- [High] Missing cancellation of delayed work in the xpad_probe() error pat=
h causes a Use-After-Free.
--

--- Patch [1]: [PATCH V7 RESEND] xpad: Overhaul device data for wireless de=
vices ---
commit fc7641a4c39d3980083db9bce9e3e7093ef644d0
Author: Sanjay Govind <sanjay.govind9@gmail.com>

xpad: Overhaul device data for wireless devices
   =20
Xbox 360 wireless controllers expose information in the link and
capabilities reports. Extract and use the vendor id for wireless controller=
s,
and use the subtype to build a nicer device name and product id.

> ---
> drivers/input/joystick/xpad.c | 209 ++++++++++++++++++++++++++++++----
>  1 file changed, 188 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..f5b61406adbc2 100644
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

[Severity: Low]
If a controller disconnects before the 500ms delayed work executes, does th=
is
early return bypass xpad_deinit_input()?

Because wireless controller properties (like flags and sub_type) are
accumulated using bitwise OR (xpad->flags |=3D data[20]) and not cleared up=
on a
new connection, could rapid reconnects of different device types into the s=
ame
wireless receiver slot cause state to leak? For example, could a Rock Band
drum kit be misidentified as a Guitar Hero drum kit if plugged in immediate=
ly
after one?

> +	if (xpad->input_created) {
>  		RCU_INIT_POINTER(xpad->x360w_dev, NULL);
>  		synchronize_rcu();
[ ... ]
> @@ -1870,8 +1980,8 @@ static void xpad360w_stop_input(struct usb_xpad *xp=
ad)
>  {
>  	usb_kill_urb(xpad->irq_in);
> =20
> -	/* Make sure we are done with presence work if it was scheduled */
> -	flush_work(&xpad->work);
> +	/* Cancel any pending presence work */
> +	cancel_delayed_work_sync(&xpad->work);

[Severity: Medium]
If the system suspends while the 500ms delayed presence work is pending, th=
is
cancels the work, leaving the state machine with pad_present =3D true but
input_created =3D false.

Upon resume, when xpad360w_start_input() sends a presence inquiry, and the
controller replies that it is present, xpad360w_process_packet() will compa=
re
the new state with pad_present. Since both are true, it ignores the packet:

xpad360w_process_packet()
    if (data[0] & 0x08) {
        present =3D (data[1] & 0x80) !=3D 0;
        if (xpad->pad_present !=3D present) {
            ...

Does this mean input_created will permanently remain false, and the control=
ler
will be unresponsive to all inputs until physically replugged?

>  }
> =20
>  static int xpad_open(struct input_dev *dev)
[ ... ]
> @@ -2084,7 +2251,7 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id
>  		xpad->delay_init =3D true;
> =20
>  	xpad->packet_type =3D PKT_XB;
> -	INIT_WORK(&xpad->work, xpad_presence_work);
> +	INIT_DELAYED_WORK(&xpad->work, xpad_presence_work);

[Severity: High]
This isn't a bug introduced by this patch, but missing cancellation of the =
work
in the xpad_probe() error path can cause a Use-After-Free, and the addition=
 of a
500ms delay in this patch makes it highly reliable to hit.

If xpad360w_start_input() succeeds in submitting the URB but fails later du=
ring
xpad_inquiry_pad_presence(), it kills the URB and returns an error:

xpad_probe()
    error =3D xpad360w_start_input(xpad);
    if (error)
        goto err_deinit_output;
    ...
err_free_mem:
    kfree(xpad);
    return error;

If the hardware replied immediately to the URB submission, the URB completi=
on
handler may have already queued the delayed presence work. xpad_probe() then
jumps to the error path and frees the xpad memory without cancelling the wo=
rk.
Could this result in the delayed work executing and dereferencing the freed
xpad memory?

> =20
>  	if (xpad->xtype =3D=3D XTYPE_UNKNOWN) {
>  		if (intf->cur_altsetting->desc.bInterfaceClass =3D=3D USB_CLASS_VENDOR=
_SPEC) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818064557.8726=
22-3-sanjay.govind9@gmail.com?part=3D1
