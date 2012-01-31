From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/4 v2] input : wacom - retrieve maximum number of touch points
Date: Mon, 30 Jan 2012 20:08:28 -0600
Message-ID: <CAGzDe_ZqstN7wOtHtVoCZNTrmg1EE9jVPUY_vWszDWV1edrSvw@mail.gmail.com>
References: <1325717032-6378-1-git-send-email-pinglinux@gmail.com>
	<20120129070448.GF23595@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53406 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752493Ab2AaCI3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jan 2012 21:08:29 -0500
Received: by lagu2 with SMTP id u2so2579866lag.19
        for <linux-input@vger.kernel.org>; Mon, 30 Jan 2012 18:08:28 -0800 (PST)
In-Reply-To: <20120129070448.GF23595@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Sun, Jan 29, 2012 at 1:04 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 04, 2012 at 02:43:52PM -0800, Ping Cheng wrote:
>> From the HID usage table when it is supported.
>>
>> Tested-by: Chris Bagwell <chris@cnpbagwell.com>
>> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>>
>> v2: updated with Chris' comments.
>>
>> =A0drivers/input/tablet/wacom_sys.c | =A0 31 +++++++++++++++++++++++=
+++++++-
>> =A0drivers/input/tablet/wacom_wac.c | =A0 10 ++++------
>> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
>> =A03 files changed, 35 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index c9588ee..f7fe091 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -28,6 +28,7 @@
>> =A0#define HID_USAGE_Y_TILT =A0 =A0 =A0 =A0 =A0 =A0 0x3e
>> =A0#define HID_USAGE_FINGER =A0 =A0 =A0 =A0 =A0 =A0 0x22
>> =A0#define HID_USAGE_STYLUS =A0 =A0 =A0 =A0 =A0 =A0 0x20
>> +#define HID_USAGE_CONTACTMAX =A0 =A0 =A0 =A0 0x55
>> =A0#define HID_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0xa1
>> =A0#define HID_COLLECTION_LOGICAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> =A0#define HID_COLLECTION_END =A0 =A0 =A0 =A0 =A0 0xc0
>> @@ -191,11 +192,30 @@ static int wacom_parse_logical_collection(unsi=
gned char *report,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max =3D features->y_max =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_unaligned_le16(&repo=
rt[10]);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 16;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D 11;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return length;
>> =A0}
>>
>> +static void wacom_retrieve_report_data(struct usb_interface *intf,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct wacom_features *features)
>> +{
>> + =A0 =A0 int result =3D 0;
>> + =A0 =A0 unsigned char *rep_data;
>> +
>> + =A0 =A0 rep_data =3D kmalloc(2, GFP_KERNEL);
>> + =A0 =A0 if (!rep_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 rep_data[0] =3D 12;
>> + =A0 =A0 result =3D wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0rep_data[0], rep_data, 2, WAC_MSG_RETRI=
ES);
>> +
>> + =A0 =A0 if ((result >=3D 0) && (rep_data[1] > 2))
>> + =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D rep_data[1];
>> +}
>> +
>> =A0/*
>> =A0 * Interface Descriptor of wacom devices can be incomplete and
>> =A0 * inconsistent so wacom_features table is used to store stylus
>> @@ -286,16 +306,19 @@ static int wacom_parse_hid(struct usb_interfac=
e *intf,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->touch_max =3D 2;
>
> Why do we set it dynamically for devices where number of contacts is
> constant? Or, even if it is not constant, we could seed it in the
> features that we set in driver_info and only adjust when we encounter
> HID_USAGE_CONTACTMAX?
>
> Thanks.
>

Since Ping will not be able to respond to this for a while, I will see
if I can address your comments.

It is true for other devices its fixed to 1, 2, or 16 touches and we
can seed that with features I believe (just need to make sure the seed
is ignored for stylus interface).  I'll flush that out and resend
updated patch.

Do you still have a copy of PATCH 1/4 and have any comments?  I can
take up any comments on it at same time.  I somehow deleted it but
here is googled version:
http://comments.gmane.org/gmane.linux.kernel.input/23163

I could probably address minor comments on 3 and 4 if needed as well.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
