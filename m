From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 5/5] HID: sony: Handle multiple touch events input record
Date: Wed, 5 Oct 2016 10:25:56 -0700
Message-ID: <CANndSK=p2r-P_mDZFEhKjUB1R9f9_vxrav9Aekdez87HYQCQ9A@mail.gmail.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-6-git-send-email-roderick@gaikai.com> <20161005083548.GC19261@mail.corp.redhat.com>
 <03619b65564e2a66b392b048b1bdc519.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33502 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbcJERZ6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2016 13:25:58 -0400
Received: by mail-ua0-f172.google.com with SMTP id p102so45450444uap.0
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 10:25:57 -0700 (PDT)
In-Reply-To: <03619b65564e2a66b392b048b1bdc519.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, Oct 5, 2016 at 8:29 AM, Simon Wood <simon@mungewell.org> wrote:
> On Wed, October 5, 2016 2:35 am, Benjamin Tissoires wrote:
>> On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:
>
>>> +            /*
>>> +             * The first 7 bits of the first byte is a counter and bit 8 is
>>> +             * a touch indicator that is 0 when pressed and 1 when not
>>> +             * pressed.
>>> +             * The next 3 bytes are two 12 bit touch coordinates, X and Y.
>>> +             * The data for the second touch is in the same format and
>>> +             * immediately follows the data for the first.
>>> +             */
>>> +            for (n = 0; n < 2; n++) {
>>> +                    u16 x, y;
>>> +                    bool active;
>>> +
>>> +                    x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
>>> +                    y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
>>> +
>>> +                    active = !(rd[offset] >> 7);
>>> +                    input_mt_slot(input_dev, n);
>>>
>>
>> Just to be sure, the device reports 2 touches only, and the
>> "num_touch_data" chunks are just the history of these 2 touches, the
>> last chunk being the last known touches?
>
> FYI - Community knowledge/understanding...
> http://www.psdevwiki.com/ps4/DS4-BT#HID_INPUT_reports
>
> Simon
>

Hi Ben and Simon,

Correct, the DS4 sends a touch history. The last element is the
latest. An input report can contain multiple touch samples, because
the device internally samples at a rate which is higher than at which
it generates HID reports. On USB you can easily see multiple touch
events and it is even easier on Bluetooth (especially if it is set to
a low frequency). The extra history is important for gestures.

Thanks,
Roderick
