From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/5] Input: wacom - isolate input registration
Date: Mon, 6 Feb 2012 08:46:50 -0600
Message-ID: <CAGzDe_aNBqyS66E_gx3_NrQX_9Efs_3pGJtrX14EnE4eao9+qA@mail.gmail.com>
References: <1328496376-28502-1-git-send-email-chris@cnpbagwell.com>
	<1328496376-28502-2-git-send-email-chris@cnpbagwell.com>
	<4F2F477D.3040507@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:56155 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754899Ab2BFOqv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Feb 2012 09:46:51 -0500
Received: by lbom4 with SMTP id m4so1079150lbo.19
        for <linux-input@vger.kernel.org>; Mon, 06 Feb 2012 06:46:50 -0800 (PST)
In-Reply-To: <4F2F477D.3040507@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com

On Sun, Feb 5, 2012 at 9:22 PM, Wanlong Gao <gaowanlong@cn.fujitsu.com>=
 wrote:
> On 02/06/2012 10:46 AM, chris@cnpbagwell.com wrote:
>
>> From: Chris Bagwell <chris@cnpbagwell.com>
>>
>> Although this better co-locates input registration logic,
>> the main goal is to make it easier to optionally create
>> input devices or delay creation to later time periods.
>>
>> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> ---
>> =A0drivers/input/tablet/wacom_sys.c | =A0 53 +++++++++++++++++++++++=
--------------
>> =A01 files changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index c9588ee..43e82e9 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -822,6 +822,37 @@ static void wacom_destroy_leds(struct wacom *wa=
com)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int wacom_register_input(struct wacom *wacom)
>> +{
>> + =A0 =A0 struct input_dev *input_dev;
>> + =A0 =A0 struct usb_interface *intf =3D wacom->intf;
>> + =A0 =A0 struct usb_device *dev =3D interface_to_usbdev(intf);
>> + =A0 =A0 struct wacom_wac *wacom_wac =3D &(wacom->wacom_wac);
>> + =A0 =A0 int error;
>> +
>> + =A0 =A0 input_dev =3D input_allocate_device();
>> + =A0 =A0 if (!input_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 input_dev->name =3D wacom_wac->name;
>> + =A0 =A0 input_dev->dev.parent =3D &intf->dev;
>> + =A0 =A0 input_dev->open =3D wacom_open;
>> + =A0 =A0 input_dev->close =3D wacom_close;
>> + =A0 =A0 usb_to_input_id(dev, &input_dev->id);
>> + =A0 =A0 input_set_drvdata(input_dev, wacom);
>> +
>> + =A0 =A0 wacom_wac->input =3D input_dev;
>> + =A0 =A0 wacom_setup_input_capabilities(input_dev, wacom_wac);
>> +
>> + =A0 =A0 error =3D input_register_device(input_dev);
>> + =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_free_device(input_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom_wac->input =3D =A00;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^=
^
> spare space here. and better use NULL?

Thanks for review. I will be fixing both issues.

Chris

>
> Thanks
> -Wanlong Gao
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
