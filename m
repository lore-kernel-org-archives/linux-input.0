Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E43356756
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447346; cv=none; b=b7ffRl3/wwAskFCLTJDiQUIA26w9y/2f4qY6ajwt4DDTwtm1yMm5To+dQxpi7FlTqSNak9xZgbp1nw+2/zwTKFdBvZNLxhUL3ioXV9JdAN+VEqgDRKmnDYRXLsKw8vLYUJBsHa4hKf24b4pcsl8n1NdQUlRQmb5orw0pDQ+rxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447346; c=relaxed/simple;
	bh=BEgQPaJxK8O1At8zCqF8rtE7r1vWUDtIBaG6lQAz7F8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2HQYWCnZrUGsdgWAahC/dcnfBwz1hBoYV3iq85QW2216OJ0Xi6wkLenPSjXcViONYelEbEuyym/lIWnzCVIxUj5L0vnP+ObVw7iG62V/TQVDVQpIHwGp8HMaoA6qHO8a5eV/+h9l9kqpyaZ8qEWh8vYrMDmemZrUtBmqxxo2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN5ZpAUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN5ZpAUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB461F000E9;
	Fri, 22 May 2026 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779447345;
	bh=4tmVyxKxbrRmi/jzN5HG/FwM4dW6fFfbjx/91/gBtlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jN5ZpAUYOEqj8g7olUcGtrvdGCjFJFanIgYT+yQl0NcS8Z1EMAMMiGU8MDLuA9UI6
	 hZxIQT8+K6KlHoNNRnStjuyQN/6W5pAk25gWLBllwuLow0ku626YlQDYfhIEJuOAIr
	 XJZMHrPVc5odlChGBuaTb6LA58JKdhks9fnhOWlUS1GT45iyVrNduqgWGFOUd4Qbao
	 b75KEwUXz7G5oVanANl6wdXWiuD+3Ojg4FrwQTieQ5MiU6wXMjW9iPPjnxW0AeAicW
	 hqGM7Qcrb67AmtjOpywMFAq6Oqx28f8CJ10NkWo7lil8hPmoCqxi9UCpXUVNug5Q3J
	 J7QLgtuo4cxbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix usb_free_coherent() size in
 ims_pcu_buffers_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Fourier" <fourier.thomas@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260522085412.45430-2-fourier.thomas@gmail.com>
References: <20260522085412.45430-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 10:55:44 +0000
Message-Id: <20260522105545.0DB461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:

New issues:
- [Low] Commit message inaccuracy regarding the fixed function.

Pre-existing issues:
- [High] Failure to release explicitly claimed secondary data interface on =
disconnect leaves the interface permanently claimed.
- [High] Memory leak of firmware object in `ims_pcu_process_async_firmware(=
)`.
- [High] Missing interface verification in `ims_pcu_disconnect()` leads to =
Use-After-Free and Double-Free vulnerabilities.
- [High] Race condition in sysfs `reset_device` store callback due to missi=
ng mutex.
- [High] Type confusion vulnerability in CDC union descriptor parsing.
- [Medium] Missing endpoint type validation for the control interface.
- [Medium] Logic error in `ims_pcu_reset_packet()` breaks the parser state =
machine.
- [Medium] Out-of-bounds read and information leak due to missing response =
length checks.
- [Medium] Violation of DMA mapping rules by performing DMA on an embedded =
structure.
- [Low] Out-of-bounds read in `ims_pcu_irq()` debug logging.
--

commit b02b6acbca140f2c98e04a2bf7bf5d8b5b24ae41
Author: Thomas Fourier <fourier.thomas@gmail.com>

Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_alloc()

This commit changes the size passed to usb_free_coherent() in
ims_pcu_buffers_free() from max_out_size to max_in_size, properly matching
the input buffer's allocation size.

> Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_alloc()
>=20
> The input buffer size is pcu->max_in_size, but pcu->max_out_size is
> passed to usb_free_coherent().
>=20
> Change size to match the allocation size.

[Severity: Low]
Is the function name in the subject line accurate? This modifies
ims_pcu_buffers_free(), but the subject mentions ims_pcu_buffers_alloc().
The error handling path in ims_pcu_buffers_alloc() appears to already
correctly use pcu->max_in_size.

>=20
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe84..7a1cb9333f53c 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1624,7 +1624,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pc=
u)
>  	usb_kill_urb(pcu->urb_in);
>  	usb_free_urb(pcu->urb_in);
> =20
> -	usb_free_coherent(pcu->udev, pcu->max_out_size,
> +	usb_free_coherent(pcu->udev, pcu->max_in_size,
>  			  pcu->urb_in_buf, pcu->read_dma);
> =20
>  	kfree(pcu->urb_out_buf);


[Severity: High]
This is a pre-existing issue, but does ims_pcu_disconnect() leak the claimed
secondary data interface?

drivers/input/misc/ims-pcu.c:ims_pcu_disconnect() {
[ ... ]
	if (alt->desc.bInterfaceClass !=3D USB_CLASS_COMM)
		return;

	ims_pcu_stop_io(pcu);
[ ... ]
	ims_pcu_buffers_free(pcu);
	kfree(pcu);
}

During ims_pcu_probe(), the driver claims the secondary data interface using
usb_driver_claim_interface(), but ims_pcu_disconnect() never calls
usb_driver_release_interface() for pcu->data_intf when the primary control
interface is unbound. Does this leave the data interface permanently claime=
d,
causing subsequent binds to fail with -EBUSY?


[Severity: High]
This is a pre-existing issue, but can this logic in ims_pcu_disconnect() le=
ad
to a use-after-free or double-free?

drivers/input/misc/ims-pcu.c:ims_pcu_disconnect() {
[ ... ]
	/*
	 * See if we are dealing with control or data interface. The cleanup
	 * happens when we unbind primary (control) interface.
	 */
	if (alt->desc.bInterfaceClass !=3D USB_CLASS_COMM)
		return;
[ ... ]
	kfree(pcu);
}

If a malicious USB device creates a secondary data interface with the
USB_CLASS_COMM class, and the user unbinds this malicious data interface via
sysfs, does ims_pcu_disconnect() bypass the return statement and prematurely
free the pcu structure while the primary interface is still active?
Should it verify if (intf !=3D pcu->ctrl_intf) instead?


[Severity: High]
This is a pre-existing issue, but does this code cause a type confusion
regression during probe?

In ims_pcu_parse_cdc_data(), the driver looks up the control interface using
union_desc->bMasterInterface0 from the untrusted CDC union descriptor, and
assigns it to pcu->ctrl_intf without validating that pcu->ctrl_intf matches
the interface currently being probed.

drivers/input/misc/ims-pcu.c:ims_pcu_probe() {
[ ... ]
	error =3D ims_pcu_parse_cdc_data(intf, pcu);
	if (error)
		goto err_free_mem;
[ ... ]
	usb_set_intfdata(pcu->ctrl_intf, pcu);
[ ... ]

If a malicious device points bMasterInterface0 to an interface owned by a
completely different driver, does usb_set_intfdata() overwrite the other
driver's private data pointer, potentially leading to memory corruption?


[Severity: High]
This is a pre-existing issue, but does this error path leak the firmware
object?

If ihex_validate_fw(fw) returns an error in ims_pcu_process_async_firmware(=
),
the function jumps to the out label, which bypasses the release_firmware(fw)
call. Since fw is a valid pointer when ihex_validate_fw() is called, does t=
his
directly leak the firmware object memory?


[Severity: High]
This is a pre-existing issue, but is there a race condition in the sysfs
reset_device store callback?

The ims_pcu_reset_device() sysfs callback directly calls
ims_pcu_execute_command() without acquiring pcu->cmd_mutex. This function
manipulates shared variables like pcu->expected_response, pcu->cmd_done, and
pcu->cmd_buf. If triggered concurrently with other commands (such as LED
brightness updates which properly lock the mutex), does this cause data rac=
es
and corruption of the shared command buffer?


[Severity: Medium]
This is a pre-existing issue, but does the driver validate the endpoint type
for the control interface?

In ims_pcu_parse_cdc_data(), the driver extracts the first endpoint:
pcu->ep_ctrl =3D &alt->endpoint[0].desc

Does it fail to verify that it is an IN interrupt endpoint? If a malicious
device provides a different endpoint type (e.g., bulk OUT), which is then
passed to usb_fill_int_urb() and usb_submit_urb(), does this trigger a
BOGUS urb xfer kernel warning?


[Severity: Medium]
This is a pre-existing issue, but is there a logic error in
ims_pcu_reset_packet() that breaks the parser state machine?

ims_pcu_reset_packet() is intended to reset the protocol state machine to w=
ait
for the next packet, but it sets pcu->have_stx =3D true.

Does this cause the state machine to bypass the wait for the next STX byte
after the first packet is processed, and immediately accept garbage bytes? =
When
the actual STX byte later arrives, does the driver spam the kernel log with
Unexpected STX at byte X, discarding old data warnings?


[Severity: Medium]
This is a pre-existing issue, but does this code lead to out-of-bounds reads
and information leaks?

Functions like ims_pcu_report_events() and ims_pcu_get_info() process data
directly from the response buffers (e.g., pcu->read_buf[3] or pcu->cmd_buf)
without checking pcu->read_pos or pcu->cmd_buf_len to ensure the device
actually sent enough data.

If a device sends a shortened response, does the driver parse stale,
uninitialized data remaining in the buffer from previous commands?


[Severity: Medium]
This is a pre-existing issue, but does this code violate DMA mapping rules?

In ims_pcu_line_setup(), pcu->cmd_buf is passed to usb_control_msg() for a =
DMA
transfer:

drivers/input/misc/ims-pcu.c:ims_pcu_line_setup() {
[ ... ]
	struct usb_cdc_line_coding *line =3D (void *)pcu->cmd_buf;
[ ... ]
	error =3D usb_control_msg(pcu->udev, usb_sndctrlpipe(pcu->udev, 0),
				USB_CDC_REQ_SET_LINE_CODING,
				USB_TYPE_CLASS | USB_RECIP_INTERFACE,
				0, interface->desc.bInterfaceNumber,
				line, sizeof(struct usb_cdc_line_coding),
				5000);
[ ... ]

Since pcu->cmd_buf is an array embedded directly inside the struct ims_pcu
allocation, and embedded fields are not guaranteed to be strictly cacheline
aligned, can cache maintenance operations on this buffer corrupt adjacent
fields in the struct ims_pcu on architectures without hardware cache cohere=
ncy?


[Severity: Low]
This is a pre-existing issue, but is there an out-of-bounds read in the
ims_pcu_irq() debug logging?

In ims_pcu_irq(), the debug logging unconditionally prints data from
pcu->urb_in_buf up to urb->actual_length bytes. If the interrupt fired for
pcu->urb_ctrl, the actual transferred data resides in pcu->urb_ctrl_buf.

Does this result in printing unrelated stale data, and if urb->actual_length
from the control URB exceeds pcu->max_in_size, does it read out of bounds up
to the format limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522085412.4543=
0-2-fourier.thomas@gmail.com?part=3D1
