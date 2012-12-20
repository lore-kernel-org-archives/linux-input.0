From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC v2 0/4] uhid LED input events handling
Date: Thu, 20 Dec 2012 20:43:55 +0100
Message-ID: <CANq1E4S_TzeCZ-djPxBcOYHFEoBxUdQpruTe52mtTq-nkCdc2Q@mail.gmail.com>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
	<CACJA=fUYX0Wehd--Ay0bwSS+9visC5By=SCWaoVkvKjVsJySKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:63342 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab2LTUNX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 15:13:23 -0500
Received: by mail-ea0-f179.google.com with SMTP id i12so1522342eaa.24
        for <linux-input@vger.kernel.org>; Thu, 20 Dec 2012 12:13:22 -0800 (PST)
In-Reply-To: <CACJA=fUYX0Wehd--Ay0bwSS+9visC5By=SCWaoVkvKjVsJySKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Andre

On Mon, Dec 17, 2012 at 2:28 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> Ping.
>
> On Sat, Dec 1, 2012 at 4:07 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
>> Hi all,
>>
>> This patchset implements the support for handling LED input events in uhid
>> driver.
>>
>> As requested in the previous RFC, it was introduced a new helper in hid-input.c
>> to carry out a generic LED input events handling (hidinput_led_output_report).
>> The helper is used by uhid driver.
>>
>> The helper can also be used in i2c-hid driver since it does a very simply
>> handling of LED events too. I have no i2c device to test the i2c-hid patch,
>> so it requires some testing before applying it.
>>
>> As long as the helper relies on device's .hid_output_raw_report() and
>> hid-logitech-dj driver doesn't properly implement this callback, the helper is
>> not used in hid-logitech-dj driver.
>>
>> Also, this helper is not used in usbhid driver as long as it does a more
>> sophisticated handling than what hidinput_led_output_report helper does. For
>> further information about usbhid LEDs handling see comments in the patchset [1].

I actually don't like the idea to call hid_output_raw_report() from
atomic-contexts. Using a work-queue would allow to use your callback
from usbhid and hidp. Furthermore, you wouldn't need the GFP_ATOMIC
patch for uhid.
Also, please first apply the GFP_ATOMIC patch and after that fix uhid
to use hid_output_raw_report(). We want fully bisectable trees.

I am actually ok with all the uhid patches, but Jiri needs to ack the
hid-core patches. Maybe he is ok with it, but I'd like to see all
ll_drivers using this callback. Because the current solution doesn't
seem any better than just fixing uhid to use it's own implementation.
Also please elaborate why hidp and usbhid cannot use this callback.

Sorry for the delay, but I think this will have to wait until next
year or at least after the holidays. At least I am not very often
available during December.
Regards
David
