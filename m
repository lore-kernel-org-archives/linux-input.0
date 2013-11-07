From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] INPUT: wacom: Added definition for Wacom CTH680 The Wacom
 Creative Pen & Touch Tablet M (CTH680, 056A:0303) is a newer revision of the
 Bamboo series. This patch adds product 0303 to wacom.ko.
Date: Thu, 7 Nov 2013 14:11:54 -0800
Message-ID: <CAF8JNhK3GBj8nywibKnxgeMGf19f4iw1GW83s9uM78F1OoxTiQ@mail.gmail.com>
References: <1383419089-31248-1-git-send-email-matthew@incomplete.io>
	<CAGzDe_ZSVEkH0BaU1oZjPWjKuR02ibs=r+jQEU7hF-R68q7rfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:38134 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab3KGWLz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Nov 2013 17:11:55 -0500
Received: by mail-la0-f54.google.com with SMTP id n7so984636lam.13
        for <linux-input@vger.kernel.org>; Thu, 07 Nov 2013 14:11:54 -0800 (PST)
In-Reply-To: <CAGzDe_ZSVEkH0BaU1oZjPWjKuR02ibs=r+jQEU7hF-R68q7rfA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: matthew@incomplete.io, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Nov 7, 2013 at 8:03 AM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> On Sat, Nov 2, 2013 at 2:04 PM,  <matthew@incomplete.io> wrote:
>> From: Matthew Geddes <matthew@incomplete.io>
>>
>
> Your whole commit message appears to be crammed into first summary
> line.  Could you please align with git conventions: put a line break
> after "CTH680", a blank line, and then the remaining description
> afterwards.
>
>> Signed-off-by: Matthew Geddes <matthew@incomplete.io>

Nacked-by: Ping Cheng <pingc@wacom.com>

Patch [1] that supports this device (and its friends) was posted early
last month. It was updated on Oct. 10 in version 2. Users at
linuxwacom.sf.net have tested the patch since then.

Dmitry,

We has 4 patches waiting to be merged. Do you have questions for any of them?

Ping

[1] http://www.spinics.net/lists/linux-input/msg27789.html

>> ---
>>  drivers/input/tablet/wacom_wac.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
>> index c59b797..5015269 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -2128,6 +2128,9 @@ static const struct wacom_features wacom_features_0x300 =
>>  static const struct wacom_features wacom_features_0x301 =
>>         { "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
>>           31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>> +static const struct wacom_features wacom_features_0x303 =
>> +       { "Wacom Creative Touch & Pen M", WACOM_PKGLEN_BBPEN, 21648, 13530,
>
> A search for model CTH680 shows this device is the newly released
> "Intuos Pen & Touch Medium"; which is also the new name for Bamboo's
> and with new form factor.  I do see occasional site that added
> Creative in there: "Intuos Creative Pen & Touch Medium".  Can you
> confirm if this is the model you have?
>
> I'd suggest using Wacom's terms closer (add in Intuos and swap Pen &
> Touch to their order; maybe drop phrase Creative).
>
> Also, the 21648/13530 values look copy&pasted from previous line.  Can
> you use "evtest" or similar to find real maximum values.  Previous
> "Bamboo Touch" models had 13700 as second number.  Since your tablet
> has different shape from previous Bamboo and the "Bamboo One" then
> there is good change you need unique values to get full usable area of
> tablet.
>
>> +         1023, 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>
> Can you update patch to exactly follow form of structures surrounding
> it?  Namely, put the "1023" value on first line like rest of lines do.
>
> Thanks!
> Chris
>
>
>>  static const struct wacom_features wacom_features_0x6004 =
>>         { "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>>           0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>> @@ -2258,6 +2261,7 @@ const struct usb_device_id wacom_ids[] = {
>>         { USB_DEVICE_WACOM(0x10F) },
>>         { USB_DEVICE_WACOM(0x300) },
>>         { USB_DEVICE_WACOM(0x301) },
>> +       { USB_DEVICE_WACOM(0x303) },
>>         { USB_DEVICE_WACOM(0x304) },
>>         { USB_DEVICE_WACOM(0x4001) },
>>         { USB_DEVICE_WACOM(0x47) },
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
