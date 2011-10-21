From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/6] Input: wacom - remove unused bamboo HID parsing
Date: Fri, 21 Oct 2011 12:26:29 -0500
Message-ID: <CAGzDe_Yr1nbAj1BZJa5Pvk3vqH8Rny664HS_hvgv5fcXVGFkfw@mail.gmail.com>
References: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
	<1318814981-30607-3-git-send-email-chris@cnpbagwell.com>
	<CAF8JNhJyJP4sffrqO=_jt5C56T6WsC843pOF7AyWww14k1vLKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47939 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411Ab1JUR0b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 13:26:31 -0400
Received: by eye27 with SMTP id 27so4071996eye.19
        for <linux-input@vger.kernel.org>; Fri, 21 Oct 2011 10:26:29 -0700 (PDT)
In-Reply-To: <CAF8JNhJyJP4sffrqO=_jt5C56T6WsC843pOF7AyWww14k1vLKw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Oct 20, 2011 at 4:17 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> On Sun, Oct 16, 2011 at 6:29 PM, =A0<chris@cnpbagwell.com> wrote:
>> From: Chris Bagwell <chris@cnpbagwell.com>
>>
>> Bamboo's do not declared a Digitizer-Stylus so the if() was
>> never executed. =A0wacom_features already contains correct stylus
>> packet length.
>
> Since this change affects all Bamboo series, I assume you have tested
> it with your old Bamboo pen and touch. If so,

Yes, been tested with 1st gen Bamboo as well.

>
>> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>
> Acked-by: Ping Cheng <pingc@wacom.com> for the whole set.

Thanks,
Chris

>
> Ping
>
>> ---
>> =A0drivers/input/tablet/wacom_sys.c | =A0 =A04 ----
>> =A01 files changed, 0 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index 4f35473..620f0c3 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -245,8 +245,6 @@ static int wacom_parse_hid(struct usb_interface =
*intf, struct hid_descriptor *hi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* penabled only accepts exact bytes of data=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_P=
KGLEN_GRAPHIRE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBFUN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0features->device_type =3D BTN_TOOL_PEN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0features->x_max =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i=
 + 3]);
>> @@ -295,8 +293,6 @@ static int wacom_parse_hid(struct usb_interface =
*intf, struct hid_descriptor *hi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* penabled only accepts exact bytes of data=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->type =3D=3D TABLETPC2FG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0features->pktlen =3D WACOM_P=
KGLEN_GRAPHIRE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKG=
LEN_BBFUN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0features->device_type =3D BTN_TOOL_PEN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0features->y_max =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_unaligned_le16(&report[i=
 + 3]);
>> --
>> 1.7.6.4
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
