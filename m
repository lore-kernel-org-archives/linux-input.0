From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] add sur40 driver for Samsung SUR40 (aka MS Surface 2.0/Pixelsense)
Date: Wed, 2 Oct 2013 11:02:36 +0200
Message-ID: <CANq1E4S6ZkcCs8a6wo76kZq1R2vB3ti1Mw9y+_jE81c30gr6Pg@mail.gmail.com>
References: <1378934763-17938-1-git-send-email-floe@butterbrot.org>
	<20130918193853.GA2070@polaris.bitmath.org>
	<524BD2D8.505@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37722 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3JBJCg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Oct 2013 05:02:36 -0400
Received: by mail-ie0-f180.google.com with SMTP id u16so1130870iet.11
        for <linux-input@vger.kernel.org>; Wed, 02 Oct 2013 02:02:36 -0700 (PDT)
In-Reply-To: <524BD2D8.505@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Florian

On Wed, Oct 2, 2013 at 10:01 AM, Florian Echtler <floe@butterbrot.org> wrote:
>>> +struct sur40_blob {
>>> +
>>> +    uint16_t blob_id;
>>> +
>>> +    uint8_t action;      /* 0x02 = enter/exit, 0x03 = update (?) */
>>> +    uint8_t unknown;     /* always 0x01 or 0x02 (no idea what this is?) */
>>> +
>>> +    uint16_t bb_pos_x;   /* upper left corner of bounding box */
>>> +    uint16_t bb_pos_y;
>>> +
>>> +    uint16_t bb_size_x;  /* size of bounding box */
>>> +    uint16_t bb_size_y;
>>> +
>>> +    uint16_t pos_x;      /* finger tip position */
>>> +    uint16_t pos_y;
>>> +
>>> +    uint16_t ctr_x;      /* centroid position */
>>> +    uint16_t ctr_y;
>>> +
>>> +    uint16_t axis_x;     /* somehow related to major/minor axis, mostly: */
>>> +    uint16_t axis_y;     /* axis_x == bb_size_y && axis_y == bb_size_x */
>>> +
>>> +    float angle;         /* orientation in radians relative to x axis */
>>
>> float is unusual in the kernel - is it actually ieee 754 encoded?
>
> Yes - was also surprised to see this directly from the hardware.

How about renaming this to "__angle" or "angle_dont_use" or something
like that. Thing is, we don't restore FP registers in the kernel so if
there's a float somewhere around, we should never access it as float
(who knows what the compiler generates..). There might be FP macros to
save/restore the registers, but I haven't seen them used.

Or maybe even replace it by "u32 angle;". That should always be safe.
Once you make use of this field, you can reconsider whether it's worth
doing FP in the kernel. But as long as it's unused, I'd vote for
avoiding "float" entirely.

Thanks
David
