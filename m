From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 3/5] hid: Parse the device before adding it
Date: Tue, 3 Apr 2012 10:41:56 +0200
Message-ID: <CAN+gG=G9KSjSFmWpxpPLzMzz14ePAhQKTJZjQBsPeq2iztZ17A@mail.gmail.com>
References: <1333436730-13008-1-git-send-email-rydberg@euromail.se>
	<1333436730-13008-4-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55837 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2DCIl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 04:41:56 -0400
In-Reply-To: <1333436730-13008-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Tue, Apr 3, 2012 at 09:05, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
> The hid bus is populated by devices created by the usb and bluetooth
> subsystems. The hid device is then broadcast to userland via uevents.
> Currently, the parsing of the hid reports is done during probe of
> the hid device, after the device has been broadcast. In order to
> allow for the report descriptors to influence the device properties,
> it is desirable to parse the device _before_ it is broadcast to
> userland. In actuality, the parsing depends only accidentally on
> the driver being present, so it can be trivially achieved.
>
> Something also needs to be done for the report_fixup handler, which
> seems to be the only hard device-driver coupling in the code.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/hid/usbhid/hid-core.c | =A0 =A05 +++++
> =A02 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 35ba9d9..8a7b59e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -658,7 +658,7 @@ int hid_parse_report(struct hid_device *device, _=
_u8 *start,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_parser_reserved
> =A0 =A0 =A0 =A0};
>
> - =A0 =A0 =A0 if (device->driver->report_fixup)
> + =A0 =A0 =A0 if (device->driver && device->driver->report_fixup)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start =3D device->driver->report_fixup=
(device, start, &size);

Well, this is not a good solution for the following drivers:
hid-zydacron
hid-prodikeys
hid-uclogic
hid-samsung
hid-sony, etc...

they all use report_fixup and as the parse is made only once, they
won't be able to work properly.


>
> =A0 =A0 =A0 =A0device->rdesc =3D kmemdup(start, size, GFP_KERNEL);
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index 5bf91db..e63613b 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1266,6 +1266,11 @@ static int usbhid_probe(struct usb_interface *=
intf, const struct usb_device_id *
> =A0 =A0 =A0 =A0if (usb_string(dev, dev->descriptor.iSerialNumber, hid=
->uniq, 64) <=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid->uniq[0] =3D 0;
>
> + =A0 =A0 =A0 ret =3D hid_parse(hid);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;

shouldn't we do the same for hidp?

Thanks,
Benjamin

> +
> +
> =A0 =A0 =A0 =A0usbhid =3D kzalloc(sizeof(*usbhid), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (usbhid =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
