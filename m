From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 6 Jan 2015 22:29:37 +0100
Message-ID: <CANq1E4TYhDzpLofxCr05hvHJMAvtMHEM210ALsB_UOi2=4c7kQ@mail.gmail.com>
References: <1419862886-1319-1-git-send-email-dh.herrmann@gmail.com>
	<alpine.LNX.2.00.1501062218200.25732@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36249 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714AbbAFV3i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 16:29:38 -0500
In-Reply-To: <alpine.LNX.2.00.1501062218200.25732@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Adam Goode <adam@spicenitz.org>, Fredrik Hallenberg <megahallon@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, stable <stable@vger.kernel.org>

Hi

On Tue, Jan 6, 2015 at 10:19 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 29 Dec 2014, David Herrmann wrote:
>
>> On an PC-101/103/104 keyboard (American layout) the 'Enter' key and its
>> neighbours look like this:
>>
>>            +---+ +---+ +-------+
>>            | 1 | | 2 | |   5   |
>>            +---+ +---+ +-------+
>>              +---+ +-----------+
>>              | 3 | |     4     |
>>              +---+ +-----------+
>
> [ ... snip ... ]
>
> Alright, I can't really see this introducing any regressions. I have now
> queued this for 3.20.

As Fredrik wrote, we need to also check for VARIABLE:

    if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
                  HID_MAIN_ITEM_BUFFERED_BYTE)) &&
        (field->flags & HID_MAIN_ITEM_VARIABLE) &&
        usage->usage_index < field->maxusage &&
        value == field->value[usage->usage_index]) {

the added line is:

            (field->flags & HID_MAIN_ITEM_VARIABLE) &&

I'll not be at home until tomorrow. Feel free to add it yourself,
otherwise, basic HID keyboards that use ARRAY reports are broken.

Thanks
David
