From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] hid-chicony: Add support for another ASUS Zen AiO keyboard
Date: Thu, 23 Mar 2017 13:00:12 -0600
Message-ID: <CAD8Lp451UxrFh_3ZesvVfzf82O4zwgvSDzDOGf27RmYhm3xvWw@mail.gmail.com>
References: <20170217134052.440-1-drake@endlessm.com> <20170301171514.GJ7064@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:36398 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755629AbdCWTAO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Mar 2017 15:00:14 -0400
Received: by mail-ot0-f179.google.com with SMTP id i1so193990930ota.3
        for <linux-input@vger.kernel.org>; Thu, 23 Mar 2017 12:00:13 -0700 (PDT)
In-Reply-To: <20170301171514.GJ7064@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>

Hi Benjamin,

I see this was applied by Jiri before I had a chance to update it
based on your feedback.

On Wed, Mar 1, 2017 at 11:15 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Feb 17 2017 or thereabouts, Daniel Drake wrote:
>> Add support for media keys on the keyboard that comes with the
>> Asus V221ID and ZN241IC All In One computers.
>>
>> The keys to support here are WLAN, BRIGHTNESSDOWN and BRIGHTNESSUP.
>>
>> This device is not visibly branded as Chicony, and the USB Vendor ID
>> suggests that it is a JESS device. However this seems like the right place
>> to put it: the usage codes are identical to the currently supported
>> devices, and this driver already supports the ASUS AIO keyboard AK1D.
>
> Except that the AK1D is branded as Chicony. So I think it will confuse
> users to ask them to load hid-chicony on a Asus keyboard branded as
> JESS.
>
> How about adding this one to hid-asus directly (with maybe a guard
> against either the PID or a quirk for it)?

Indeed the new keyboard added here is not branded as Chicony nor Jess,
but only as Asus.

We additionally now have another keyboard that needs the same key
handling, again only branded as Asus, but this time the USB ID is
0x062a:0x5110 suggesting manufacturer TURBOX.

I am assuming you'd prefer that we have both of these keyboards
handled by hid-asus instead of hid-chicony even that would duplicate a
bit of code. But is it really necessary to quirk it based on PID,
can't we just check for (usage->hid & HID_USAGE_PAGE) ==
HID_UP_MSVENDOR like hid-chicony does?

Thanks
Daniel
