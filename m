From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 8/8] hid-multitouch: correct eGalax a001 protocol
Date: Wed, 23 Nov 2011 12:20:22 -0600
Message-ID: <CAGzDe_aMHb6Uy7Mw7bBcKbmTY_aTLprY44W3-95KxDtUUg3zPw@mail.gmail.com>
References: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
	<1322042074-3759-9-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36653 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab1KWSUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 13:20:23 -0500
In-Reply-To: <1322042074-3759-9-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Cedric Sodhi <manday@gmx.net>

On Wed, Nov 23, 2011 at 3:54 AM, Benjamin Tissoires
<benjamin.tissoires@enac.fr> wrote:
> From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>
> This device use another protocol while sending the events.
> It's the same as the one described as "serial" by Microsoft.
> We are keeping here the sn_move and sn_pressure parameters for
> egalax devices.
>
> CC: Cedric Sodhi <manday@gmx.net>
> CC: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---

Thanks for sending this patch.  If you like, you can add this for all
the patches except #2.  I'm not the best for reviewing sysfs code.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

3-5 are nice cleanups to have.

Chris

> =A0drivers/hid/hid-multitouch.c | =A0 =A09 ++++++++-
> =A01 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 77210d6..f0f3632 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -97,6 +97,7 @@ struct mt_device {
> =A0#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x0101
> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x0102
> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x0103
> +#define MT_CLS_EGALAX_SERIAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
104
>
> =A0#define MT_DEFAULT_MAXCONTACT =A010
>
> @@ -174,6 +175,12 @@ static struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_move =3D 4096,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_pressure =3D 32,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 { .name =3D MT_CLS_EGALAX_SERIAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACT=
ID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_ALWAYS_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
> + =A0 =A0 =A0 },
>
> =A0 =A0 =A0 =A0{ }
> =A0};
> @@ -705,7 +712,7 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_EGALAX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH_7302) },
> - =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 { .driver_data =3D MT_CLS_EGALAX_SERIAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH_A001) },
>
> --
> 1.7.4.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
