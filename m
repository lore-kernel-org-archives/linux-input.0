From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/2] input : wacom - retrieve maximum number of touch points
Date: Wed, 1 Feb 2012 10:16:45 -0600
Message-ID: <CAGzDe_YgWep6N3cPFM4CXEG6KoEJCEaiGS=8wN9wq-BmW19Npw@mail.gmail.com>
References: <1328069031-16873-1-git-send-email-chris@cnpbagwell.com>
	<4F2927BE.4010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:55952 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab2BAQQs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Feb 2012 11:16:48 -0500
Received: by lbom4 with SMTP id m4so195541lbo.19
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2012 08:16:46 -0800 (PST)
In-Reply-To: <4F2927BE.4010905@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

On Wed, Feb 1, 2012 at 5:53 AM, Maurus Cuelenaere <mcuelenaere@gmail.co=
m> wrote:
> Op 01-02-12 05:03, chris@cnpbagwell.com schreef:
>
>> From: Ping Cheng<pinglinux@gmail.com>
>>
>> =A0From the HID usage table when it is supported.
>>
>> Tested-by: Chris Bagwell<chris@cnpbagwell.com>
>> Signed-off-by: Chris Bagwell<chris@cnpbagwell.com>
>> Signed-off-by: Ping Cheng<pingc@wacom.com>
>> ---
>>
>> These two patches were originally in a set of 4 from Ping.
>> 2 of those 4 have already been committed to next branch.
>>
>> The change between this version and Ping's last version is
>> making use of features to set the new touch_max value.
>> The 2nd patch is unmodified.
>>
>> =A0drivers/input/tablet/wacom_sys.c | =A0 26 +++++++++++++++++-
>> =A0drivers/input/tablet/wacom_wac.c | =A0 55
>> +++++++++++++++++++++++--------------
>> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
>> =A03 files changed, 60 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c
>> b/drivers/input/tablet/wacom_sys.c
>> index c9588ee..5004a75 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -28,6 +28,7 @@
>> =A0#define HID_USAGE_Y_TILT =A0 =A0 =A0 =A0 =A0 =A0 =A00x3e
>> =A0#define HID_USAGE_FINGER =A0 =A0 =A0 =A0 =A0 =A0 =A00x22
>> =A0#define HID_USAGE_STYLUS =A0 =A0 =A0 =A0 =A0 =A0 =A00x20
>> +#define HID_USAGE_CONTACTMAX =A0 =A0 =A0 =A0 =A0 0x55
>> =A0#define HID_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00xa1
>> =A0#define HID_COLLECTION_LOGICAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
2
>> =A0#define HID_COLLECTION_END =A0 =A0 =A0 =A0 =A0 =A00xc0
>> @@ -196,6 +197,24 @@ static int wacom_parse_logical_collection(unsig=
ned
>> char *report,
>> =A0 =A0 =A0 =A0return length;
>> =A0}
>>
>> +static void wacom_retrieve_report_data(struct usb_interface *intf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct wacom_features *features)
>> +{
>> + =A0 =A0 =A0 int result =3D 0;
>> + =A0 =A0 =A0 unsigned char *rep_data;
>> +
>> + =A0 =A0 =A0 rep_data =3D kmalloc(2, GFP_KERNEL);
>> + =A0 =A0 =A0 if (!rep_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
>
> Why not allocate this on the stack?
> This also can't leak memory (like you currently do).

Ah, thank you.  That leak got introduced in v2 and I missed it.

Agree with using stack.  I think we can spare the 2 bytes.  :)

In v1, this function was inlined in another function that was doing
malloc()'s for large message and it felt balanced there.

Chris

>
>> +
>> + =A0 =A0 =A0 rep_data[0] =3D 12;
>> + =A0 =A0 =A0 result =3D wacom_get_report(intf, WAC_HID_FEATURE_REPO=
RT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0], rep_data, 2, WAC_MSG_R=
ETRIES);
>> +
>> + =A0 =A0 =A0 if ((result>=3D 0)&& =A0(rep_data[1]> =A02))
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D rep_data[1];
>> +}
>> +
>
>
> --
> Maurus Cuelenaere
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
