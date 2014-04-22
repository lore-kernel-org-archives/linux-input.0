From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Tue, 22 Apr 2014 08:31:42 +0200
Message-ID: <CANq1E4Q=HWPuwE4BAPnLY7Y3qrk4JDcTrMY333af_RR7FSLyPw@mail.gmail.com>
References: <1397601105-17771-1-git-send-email-dh.herrmann@gmail.com>
	<20140422042947.GB10735@yabbi.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:65471 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaDVGbn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 02:31:43 -0400
Received: by mail-ig0-f172.google.com with SMTP id hn18so2625043igb.5
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 23:31:42 -0700 (PDT)
In-Reply-To: <20140422042947.GB10735@yabbi.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Lennart Poettering <lennart@poettering.net>

Hi

On Tue, Apr 22, 2014 at 6:29 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>> +/* requires the buffer lock to be held */
>> +static bool __evdev_is_masked(struct evdev_client *client,
>> +                           unsigned int type,
>> +                           unsigned int code)
>> +{
>> +     unsigned long *mask;
>> +     size_t cnt;
>> +
>> +     /* EV_SYN and unknown codes are never masked */
>> +     if (!type || type >= EV_CNT)
>
> why not use type == EV_SYN?

You mean instead of "!type"? Yeah, probably easier to read.

>> +             return false;
>> +
>> +     /* first test whether the type is masked */
>> +     mask = client->evmasks[0];
>
> if mask is NULL, you already know it's not mask, you can return early.

Nope. If evmasks[0] is NULL, then no type-mask has been set. That
doesn't mean the given code-mask is NULL.

For instance:
  evmasks[0] == NULL
  evmasks[EV_KEY][KEY_A] == 0

In that case, the user wants all events but KEY_A (even though
evmasks[0] is NULL).

>>  #define EVIOCGRAB            _IOW('E', 0x90, int)                    /* Grab/Release device */
>>  #define EVIOCREVOKE          _IOW('E', 0x91, int)                    /* Revoke device access */
>> +#define EVIOCGMASK           _IOR('E', 0x92, struct input_mask)      /* Get event-masks */
>> +#define EVIOCSMASK           _IOW('E', 0x93, struct input_mask)      /* Set event-masks */
>
> This is missing from all other ioctls but while you're adding a new one
> anyway: please add documentation on what the ioctl does, the input and
> return value/output expected, side-effects etc. right now, understanding the
> evdev ioctls requires either reading the kernel code or existing user-space
> code, with the usual risk of getting it wrong.

Meh.. I thought no-one will notice.. Clearly, I was wrong. I will add
proper docs in v2.

Thanks a lot!
David
