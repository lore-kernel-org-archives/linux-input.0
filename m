Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68FF1F3B8A
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773114; cv=none; b=S59C+W8BI1ZX7mZ27yz9tqiF5ShAjkDa0SzAluuQPrY9s4BYujS1mTmPYarmb5/94iluGZ6/n8SpfTFCfRdxXcMCd/ItcM+Sg1M2S9Of1ZpUOZO0IDjL93kLkFQGMANzshigOqZ4Aoz80y1AVrIpwggLBpZ/K/apuo7KB6e2QkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773114; c=relaxed/simple;
	bh=xoe2Kh8HJMiIRYxG2G/je/a4CdSivYsDfF3l2Uh+ZTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TvUrJj9n6fQLl4oYLNfCR3G6ykxeUjEUunDrBcxNi2Ed7aCV1tsXHMsYTOmQLBt2Z9yrpQjKvCoIzpE7o4NehiwGo5aENwNIXr7Q2bAnFX672fawpAXV0na7WsD9yaT3vjSZ3thLiCKGEpmUXX3W3Oa7Eof6v5MHbM6nUA44ZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKiTiyJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKiTiyJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730DF1F000E9;
	Mon,  3 Aug 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773112;
	bh=sfc9EJkfzNC5IMppbZiIGzaQdJK8RbZ5QBO6z4jYuRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKiTiyJ0sRgc5j6X216itKLXATGxK0OYehzirXNqzX01UOub57q/fAGe9c160HM6U
	 65ahZur+OFSKauWk5wClt4euFPaYTX8p5XJWamgNja+sG0E4CZ4tHl++hHEo2OS453
	 PPk2nhLlRy+s5QdQJKDMaaJOJ7MWIn8Cc7QrPvVpd2RGdf5EWaujDvS0zyfjEgnQeP
	 AdtZoR//CWzl31edN0XLNAV9lRlCn4CmlH3a0Q1NqO9xz3LqBHy4pjdpIGGwk6Pzlm
	 ByWeCwAalEFPKXsvbAtGP+tGG4HilOef3CHdF3upMpJYiBV8O+Hvt4W608Yqv9EhH3
	 PQQA+xByFUk2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: xpad - add sdata_check() to xpad360 branches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260803-xpadone_packet_fix-v1-3-280da203f15c@kroah.com>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
 <20260803-xpadone_packet_fix-v1-3-280da203f15c@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:05:11 +0000
Message-Id: <20260803160512.730DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Zero-length packets incorrectly pass validation and are processe=
d as valid empty states, spuriously releasing all controller buttons.

Pre-existing issues:
- [High] Blocking USB APIs and GFP_KERNEL allocations are unsafely invoked =
from the atomic URB completion handler.
- [High] Error paths during initialization destroy the input device while l=
eaving a dangling pointer for presence_work to dereference.
- [Medium] 16-bit multi-byte reads and direct array modifications completel=
y bypass the new length validation, leading to stale data leakage.
--

--- Patch [3]: [PATCH 3/3] Input: xpad - add sdata_check() to xpad360 branc=
hes ---
commit 0a84609d4ff81bead2c2c2c26f83c5c8f9cc506a
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add sdata_check() to xpad360 branches

This commit adds the sdata_check() safety wrapper to the xpad360_process_pa=
cket()
and xpad360w_process_packet() functions. It bounds-checks array accesses to=
 prevent
out-of-bounds reads on the controller data buffer.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 319a4c4a695fe..304229782e455 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -891,19 +891,24 @@ static void xpad_process_packet(struct usb_xpad *xp=
ad, u16 cmd, unsigned char *d
>   */
> =20
>  static void xpad360_process_packet(struct usb_xpad *xpad, struct input_d=
ev *dev,
> -				   u16 cmd, unsigned char *data)
> +				   u16 cmd, unsigned char *data, u32 len)
>  {
> +	struct safe_data sdata;
> +
> +	sdata.data =3D data;
> +	sdata.len =3D len;
> +
>  	/* valid pad data */
> -	if (data[0] !=3D 0x00)
> +	if (sdata_check(&sdata, 0) !=3D 0x00)
>  		return;

[Severity: Medium]
Does this inadvertently allow zero-length packets to be treated as valid
pad data? Because sdata_check() safely returns 0 when the index is out of
bounds, a zero-length packet will successfully pass this !=3D 0x00 check
and spuriously release all controller buttons.

> =20
>  	/* digital pad */
>  	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {

[ ... ]

> @@ -915,27 +920,29 @@ static void xpad360_process_packet(struct usb_xpad =
*xpad, struct input_dev *dev,
>  	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
>  	    xpad->xtype =3D=3D XTYPE_XBOX360W) {

[ ... ]

>  	/* buttons A,B,X,Y,TL,TR and MODE */
> -	input_report_key(dev, BTN_A,	data[3] & BIT(4));
> -	input_report_key(dev, BTN_B,	data[3] & BIT(5));
> -	input_report_key(dev, BTN_X,	data[3] & BIT(6));
> -	input_report_key(dev, BTN_Y,	data[3] & BIT(7));
> -	input_report_key(dev, BTN_TL,	data[3] & BIT(0));
> -	input_report_key(dev, BTN_TR,	data[3] & BIT(1));
> -	input_report_key(dev, BTN_MODE,	data[3] & BIT(2));
> +	input_report_key(dev, BTN_A,	sdata_check(&sdata, 3) & BIT(4));
> +	input_report_key(dev, BTN_B,	sdata_check(&sdata, 3) & BIT(5));
> +	input_report_key(dev, BTN_X,	sdata_check(&sdata, 3) & BIT(6));
> +	input_report_key(dev, BTN_Y,	sdata_check(&sdata, 3) & BIT(7));
> +	input_report_key(dev, BTN_TL,	sdata_check(&sdata, 3) & BIT(0));
> +	input_report_key(dev, BTN_TR,	sdata_check(&sdata, 3) & BIT(1));
> +	input_report_key(dev, BTN_MODE,	sdata_check(&sdata, 3) & BIT(2));
> =20
>  	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
>  		/* left stick */

[Severity: Medium]
This isn't a bug introduced by this patch, but will the 16-bit stick axis=20
reads immediately following this code bypass the new length checks?

xpad_process_packet(), xpad360_process_packet(), and xpadone_process_packet=
()
read multi-byte values using le16_to_cpup() directly against the raw data
buffer:

    input_report_abs(dev, ABS_X,
                     (__s16) le16_to_cpup((__le16 *)(data + 6)));

A short packet would still cause out-of-bounds reads here since these
accesses completely bypass the sdata_check() wrapper, potentially leaking
uninitialized DMA memory into input events.

[ ... ]

> @@ -1019,14 +1026,18 @@ static void xpad_presence_work(struct work_struct=
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
> +	struct safe_data sdata;
>  	bool present;
> =20
> +	sdata.data =3D data;
> +	sdata.len =3D len;
> +
>  	/* Presence change */
> -	if (data[0] & 0x08) {
> -		present =3D (data[1] & 0x80) !=3D 0;
> +	if (sdata_check(&sdata, 0) & 0x08) {
> +		present =3D (sdata_check(&sdata, 1) & 0x80) !=3D 0;
> =20
>  		if (xpad->pad_present !=3D present) {
>  			xpad->pad_present =3D present;
>  			schedule_work(&xpad->work);

[Severity: High]
This is a pre-existing issue, but can the xpad_presence_work thread
dereference a freed pointer if initialization fails?

If xpad_init_input() encounters an error (like during device registration),
it takes the err_free_input path:

xpad_init_input() {
    ...
err_free_input:
    input_free_device(input_dev);
    return error;
}

This frees the device but leaves xpad->dev pointing to the freed memory.
When xpad_presence_work() processes the failure, it logs the error:

xpad_presence_work() {
    ...
    dev_err(&xpad->dev->dev, "unable to init device: %d\n", error);
}

Could this use-after-free lead to memory corruption or a crash?

[ ... ]

> @@ -1262,10 +1273,10 @@ static void xpad_irq_in(struct urb *urb)
> =20
>  	switch (xpad->xtype) {
>  	case XTYPE_XBOX360:
> -		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
> +		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata, urb->actual_le=
ngth);
>  		break;
>  	case XTYPE_XBOX360W:
> -		xpad360w_process_packet(xpad, 0, xpad->idata);
> +		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
>  		break;
>  	case XTYPE_XBOXONE:
>  		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);

[Severity: High]
This is a pre-existing issue, but does xpadone_process_packet() execute
blocking calls and GFP_KERNEL allocations from an atomic context?

When xpad_irq_in() processes an Xbox One GIP_CMD_ANNOUNCE packet from
interrupt context, it follows this call chain:

xpad_irq_in()
  xpadone_process_packet()
    xpad_start_input()
      usb_submit_urb(xpad->irq_in, GFP_KERNEL)

xpad_start_input() also calls xpad_start_xbox_one(), which invokes
usb_set_interface(), a synchronous and blocking USB API. Calling these
from the atomic URB completion handler could lead to scheduling while
atomic warnings and potential deadlocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-xpadone_pa=
cket_fix-v1-0-280da203f15c@kroah.com?part=3D3
