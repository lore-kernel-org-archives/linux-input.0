From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom - fix sparse warning
Date: Tue, 1 May 2012 11:19:40 -0500
Message-ID: <CAGzDe_bpXmyfTEn5f2hL-zr3o--n00yQcNjqva5QSOLZRgPa_w@mail.gmail.com>
References: <20120430040807.GA3013@core.coreip.homeip.net>
	<CAGzDe_Zkq9BNTeMf_t9HsJoBWUyQoMfT-gGmvRRvztQ=whrmjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40966 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758082Ab2EAQTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 May 2012 12:19:41 -0400
Received: by lahj13 with SMTP id j13so2567066lah.19
        for <linux-input@vger.kernel.org>; Tue, 01 May 2012 09:19:40 -0700 (PDT)
In-Reply-To: <CAGzDe_Zkq9BNTeMf_t9HsJoBWUyQoMfT-gGmvRRvztQ=whrmjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, May 1, 2012 at 11:18 AM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
>
>
>
> On Sun, Apr 29, 2012 at 11:08 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>>
>> This fixes the following warning from sparse
>>
>> =A0 =A0 =A0 =A0warning: Using plain integer as NULL pointer
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>
>
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>
>>
>> ---
>> =A0drivers/input/tablet/wacom_sys.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c
>> b/drivers/input/tablet/wacom_sys.c
>> index be13223..e785fcd 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -1015,13 +1015,13 @@ static void wacom_wireless_work(struct
>> work_struct *work)
>> =A0 =A0 =A0 =A0wacom =3D usb_get_intfdata(usbdev->config->interface[=
1]);
>> =A0 =A0 =A0 =A0if (wacom->wacom_wac.input)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_unregister_device(wacom->wacom_=
wac.input);
>> - =A0 =A0 =A0 wacom->wacom_wac.input =3D 0;
>> + =A0 =A0 =A0 wacom->wacom_wac.input =3D NULL;
>>
>> =A0 =A0 =A0 =A0/* Touch interface */
>> =A0 =A0 =A0 =A0wacom =3D usb_get_intfdata(usbdev->config->interface[=
2]);
>> =A0 =A0 =A0 =A0if (wacom->wacom_wac.input)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_unregister_device(wacom->wacom_=
wac.input);
>> - =A0 =A0 =A0 wacom->wacom_wac.input =3D 0;
>> + =A0 =A0 =A0 wacom->wacom_wac.input =3D NULL;
>>
>> =A0 =A0 =A0 =A0if (wacom_wac->pid =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "wacom: wireless tab=
let disconnected\n");
>> --
>> 1.7.7.6
>>
>>
>> --
>> Dmitry
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
