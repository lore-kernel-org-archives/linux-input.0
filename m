From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [eGalax] no click events with touchscreen
Date: Thu, 8 Jan 2015 17:54:56 -0500
Message-ID: <CAN+gG=GKpPhXm8HkxC6WAOQ5RY24WpSXUrOyY6xiPzJ6hGL=yw@mail.gmail.com>
References: <000701d02af4$cab68350$602389f0$@compacsort.com>
	<CAN+gG=Hw98OCcJZj-jUk6H64D+C_eyyXo52uvOdyomFFwELXQw@mail.gmail.com>
	<000b01d02b91$4303a8f0$c90afad0$@compacsort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35113 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757189AbbAHWy5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 17:54:57 -0500
Received: by mail-qg0-f43.google.com with SMTP id z107so5376225qgd.2
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 14:54:57 -0800 (PST)
In-Reply-To: <000b01d02b91$4303a8f0$c90afad0$@compacsort.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gavin Lambert <gavinl@compacsort.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi,


On Thu, Jan 8, 2015 at 5:20 PM, Gavin Lambert <gavinl@compacsort.com> wrote:
> On 9 January 2015 04:17, you quoth:
>> So here, everything seems fine except for the tracking ID and the BTN_TOUCH.
>> The kernel does not sends the touch begin and touch end information, thus the
>> device is not working :(
>>
>> Can you compile and install hid-recorder from http://bentiss.github.io/hid-
>> replay-docs/ ?
>> I would need a hid-record of your touchscreen so I can figure out why the
>> kernel does not handle it properly.
>
> Attached.  (Sent off-list to avoid spamming uninterested parties with the file; please feel free to reply on-list if you prefer.)
>
> During the recording, I made one touch and release to the centre of the screen, waited about three seconds, then did a staggered two-point multitouch (touch left, touch right, release left, release right).  Just in case both scenarios are useful to you.
>

Well, unfortunately, when I first read your bug report, I missed that
you are using one of the most buggy touchscreen available.
Egalax still tries to reuse the product id 0001 for *many* different
touchscreens. Some are multitouch, some are not.
With all this mess, it is impossible to figure out which way to go and
write something upstream about it :(

Anyway, given your hid outputs, if you run the following command
before plugging your touchscreen (at boot is a good idea), you should
be fine:
# echo 3 0eef 0001 16 > /sys/bus/hid/drivers/hid-multitouch/new_id

*BUT* the outputs show only _one_ touch when you said you made 2.

I must also say that this device presents itself as a Win8 certified
one whereas it is clearly not following the spec. So my best advice
would be to send it back to the store, and buy another one :(


> Not sure if this is significant, but when it was asking for the hidraw device it only listed one device for the touchscreen; it did not have a second "Pen" device as exists at the /dev/input/eventN level.
>

Yeah, that's expected. The second input node is created by looking at
the report descriptors and the splitting is done in hid-multitouch.

Cheers,
Benjamin
