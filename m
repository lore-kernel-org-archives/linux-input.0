From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 5/6] Input: wacom - read 3rd gen Bamboo Touch HID data
Date: Fri, 21 Oct 2011 12:29:21 -0500
Message-ID: <CAGzDe_ZFkbfwCCZ4vQDA9mSkGOBSiuoP=jj12MswsvZ5kg+RkA@mail.gmail.com>
References: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
	<1318814981-30607-6-git-send-email-chris@cnpbagwell.com>
	<201110201953.16567.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64080 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab1JUR3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 13:29:22 -0400
Received: by eye27 with SMTP id 27so4074099eye.19
        for <linux-input@vger.kernel.org>; Fri, 21 Oct 2011 10:29:21 -0700 (PDT)
In-Reply-To: <201110201953.16567.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com

On Thu, Oct 20, 2011 at 9:53 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sunday, October 16, 2011 06:29:40 PM chris@cnpbagwell.com wrote:
>> From: Chris Bagwell <chris@cnpbagwell.com>
>>
>> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> ---
>> =A0drivers/input/tablet/wacom_sys.c | =A0 48
>> ++++++++++++++++++++++++++++++++++++- 1 files changed, 46
>> insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c
>> b/drivers/input/tablet/wacom_sys.c index 5e1539c..d19886a 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -28,7 +28,9 @@
>> =A0#define HID_USAGE_Y_TILT =A0 =A0 =A0 =A0 =A0 =A0 0x3e
>> =A0#define HID_USAGE_FINGER =A0 =A0 =A0 =A0 =A0 =A0 0x22
>> =A0#define HID_USAGE_STYLUS =A0 =A0 =A0 =A0 =A0 =A0 0x20
>> -#define HID_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0xc0
>> +#define HID_COLLECTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0xa1
>> +#define HID_COLLECTION_LOGICAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> +#define HID_COLLECTION_END =A0 =A0 =A0 =A0 =A0 0xc0
>>
>> =A0enum {
>> =A0 =A0 =A0 WCM_UNDEFINED =3D 0,
>> @@ -165,6 +167,34 @@ static void wacom_close(struct input_dev *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_autopm_put_interface(wacom->intf);
>> =A0}
>>
>> +static int wacom_parse_logical_collection(unsigned char *report,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct wacom_features *features)
>> +{
>> + =A0 =A0 int length =3D 0;
>> +
>> + =A0 =A0 if (features->type =3D=3D BAMBOO_PT) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Logical collection is only used by 3rd =
gen Bamboo Touch */
>> + =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGLEN_BBTOUCH3=
;
>
> Compile dies here because WACOM_PKGLEN_BBTOUCH3 is defined in the
> next patch.
>
> Please make sure the series is bisectable.

Ah, yes.  I will resend.  I reordered this one patch right before
submitting.  I should have compiled each patch after that.

Thank you for feedback,
Chris

>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
