From: =?UTF-8?B?SsOpcsOpbXkgTGFs?= <kapouer@melix.org>
Subject: Re: hig_magicmouse HID_BATTERY_QUIRK_IGNORE
Date: Wed, 23 Nov 2016 01:33:21 +0100
Message-ID: <CAJxTCxzSj4Kd52fnc2Fs2buYO=YTtVP5-HRh0K9YXv_NOVKjtg@mail.gmail.com>
References: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
 <1E169F84-8B4E-4E63-B9BD-213FBBC1B36E@holtmann.org> <CAJxTCxxN7=fjNFQ4BJPKfU0jHY=uAQNq_g3iN_0mYhSHdc28ug@mail.gmail.com>
 <1479860674.16940.0.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:49940 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbcKWAd0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Nov 2016 19:33:26 -0500
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B7B8D56485E
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 01:33:22 +0100 (CET)
Received: by mail-io0-f177.google.com with SMTP id x94so90352377ioi.3
        for <linux-input@vger.kernel.org>; Tue, 22 Nov 2016 16:33:22 -0800 (PST)
In-Reply-To: <1479860674.16940.0.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

2016-11-23 1:24 GMT+01:00 Bastien Nocera <hadess@hadess.net>:
> On Wed, 2016-11-23 at 00:00 +0100, Jérémy Lal wrote:
>> Hi,
>> i've been using this patch for a while, as a workaround for
>> https://bugzilla.kernel.org/show_bug.cgi?id=103631
>> (mouse freeze when battery reports).
>>
>> --- a/drivers/hid/hid-input.c
>> +++ b/drivers/hid/hid-input.c
>> @@ -321,6 +321,9 @@
>>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>>    USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
>>    HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
>> +  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>> +    USB_DEVICE_ID_APPLE_MAGICMOUSE),
>> +    HID_BATTERY_QUIRK_IGNORE },
>>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
>>    USB_DEVICE_ID_ELECOM_BM084),
>>    HID_BATTERY_QUIRK_IGNORE },
>
> Doesn't that also stop the mouse from reporting its battery status?

Yes, it does. Still better than having it stop abruptly from time to time.

