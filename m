From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 5/6] hid-multitouch: Switch to device groups
Date: Mon, 30 Apr 2012 20:51:28 +0200
Message-ID: <CAN+gG=Ekz8HMBP0ZOSts5ek9x38FW7v177K-p-kVBvCCkh6kOA@mail.gmail.com>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
	<1335175627-2270-6-git-send-email-rydberg@euromail.se>
	<CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
	<20120430183023.GA5585@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53462 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2D3Sv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 14:51:28 -0400
In-Reply-To: <20120430183023.GA5585@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <Benjamin_Tissoires@logitech.com>, Stephane Chatty <chatty@enac.fr>

On Mon, Apr 30, 2012 at 20:30, Henrik Rydberg <rydberg@euromail.se> wro=
te:
>> I remarked a small regression in this patch: the detection of the
>> serial protocol is not handled anymore. I was indeed relying on the
>> fact that the parameter "id" in mt_probe was null to know that the
>> device was not already in the list of known devices.
>
> I see. Will this suffice?

Yes, but I'd rather do the test against either id->product or
id->driver_data as we may use HID_ANY_ID for vendors specific
handling. For instance, I had the confirmation from EETI (eGalax) that
they will always use the same protocol for their usb products, thus
the same quirks could be handled by HID_DEVICE(BUS_USB,
HID_GROUP_MULTITOUCH, USB_VENDOR_ID_DWAV, HID_ANY_ID).

Thanks,
Benjamin

>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 125c1e7..507981e 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -673,8 +673,8 @@ static int mt_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> - =A0 =A0 =A0 if (!id && td->touches_by_report =3D=3D 1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* the device has been sent by hid-gene=
ric */
> + =A0 =A0 =A0 /* unknown serial devices need special quirks */
> + =A0 =A0 =A0 if ((!id || id->product =3D=3D HID_ANY_ID) && td->touch=
es_by_report =3D=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtclass =3D &td->mtclass;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtclass->quirks |=3D MT_QUIRK_ALWAYS_V=
ALID;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtclass->quirks &=3D ~MT_QUIRK_NOT_SEE=
N_MEANS_UP;
>
> Cheers,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
