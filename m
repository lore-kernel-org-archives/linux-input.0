From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] hid: uhid: improve uhid example client
Date: Mon, 2 Sep 2013 15:21:46 +0200
Message-ID: <CANq1E4QwPRgCkROyLWNU7KtVDU6DAoLG+pD2_6brD90gSiJ9pg@mail.gmail.com>
References: <1378071918-1152-1-git-send-email-dh.herrmann@gmail.com>
	<CAN+gG=GbY9mQGQhRZcf9Osc1q5YjwpGVExhH6pAN9X0urcRv0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45868 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836Ab3IBNVr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Sep 2013 09:21:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id k14so8080082iea.33
        for <linux-input@vger.kernel.org>; Mon, 02 Sep 2013 06:21:46 -0700 (PDT)
In-Reply-To: <CAN+gG=GbY9mQGQhRZcf9Osc1q5YjwpGVExhH6pAN9X0urcRv0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Anderson Lizardo <anderson.lizardo@openbossa.org>

Hi

On Mon, Sep 2, 2013 at 3:16 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi David,
>
> On Sun, Sep 1, 2013 at 11:45 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> This extends the uhid example client. It properly documents the built-in
>> report-descriptor an adds explicit report-numbers.
>>
>> Furthermore, LED output reports are added to utilize the new UHID output
>> reports of the kernel. Support for 3 basic LEDs is added and a small
>> report-parser to print debug messages if output reports were received.
>>
>> To test this, simply write the EV_LED+LED_CAPSL+1 event to the evdev
>> device-node of the uhid-device and the kernel will forward it to your uhid
>> client.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>> ---
>> Hi Jiri
>>
>> This is actually the first time that I wrote an HID report-descriptor. The old
>> 3-button mouse was just copied from a real mouse. My descriptor works perfectly
>> well but I am kind of scared I am no longer allowed to make fun of firmware
>> authors..
>
> If you are affraid of legal issues, you should consider using the
> keyboard report descriptor given as an example on the page 69
> (Appendix E.6) of the USB HID specification 1.1.

Not afraid of legal issues at all. I reviewed it thoroughly,
documented the new one and I added my own extensions (like WHEEL). So
it is no longer based on the old one. But thanks for the usb-spec
hint, haven't looked there, yet.

> Other than that, I had also to deal with raw reports and report
> descriptors, so I have written some tools to decode them on:
> https://github.com/bentiss/hid-replay/tree/master/tools
> I am expecting in input the hid-replay file format, which you can
> retrieve an example from hid-recorder, and from the man.
>
> It's not 100% accurate (I had corner cases for some keyboards), but
> it's doing the decoding job quite properly.
> I am also thinking of a way to "reencode" it more efficiently from the
> human readable version, but this is not done yet.

Cool! Encoding-support is actually what I need, but the decoding is
nice to verify correctness.

>>
>> Anyway, I extended the example to have a test-case for uhid output reports and
>> it all works as expected. I got asked for some help on this so I wrote up this
>> patch to push it mainline.
>
> Great thanks!
>
> On overall, the example looks sane, but I will not be able to do an
> exhaustive review before Friday. So Jiri, I think you can take it
> unless David decides to change the report descriptors with the one I
> mentioned earlier.

No intention to modify it. Looks all good to me now.

Thanks!
David
