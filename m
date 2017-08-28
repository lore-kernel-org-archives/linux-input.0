From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 1/4] Input: Add new property INPUT_PROP_JOYDEV_IGNORE
Date: Mon, 28 Aug 2017 14:08:54 -0700
Message-ID: <CANndSKk4LqEu_48VG+b4eQUjMRjLJ4=uzEyuL3d5X6vKq_dMkg@mail.gmail.com>
References: <20170824231153.8809-1-roderick@gaikai.com> <20170824231153.8809-2-roderick@gaikai.com>
 <1503650742.12938.4.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35398 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1VIz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Aug 2017 17:08:55 -0400
Received: by mail-oi0-f46.google.com with SMTP id k77so13692430oib.2
        for <linux-input@vger.kernel.org>; Mon, 28 Aug 2017 14:08:55 -0700 (PDT)
In-Reply-To: <1503650742.12938.4.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Fri, Aug 25, 2017 at 1:45 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander wrote:
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>
>> This new property can be set on input devices to blacklist them
>> from getting picked up by joydev. This is meant for devices, which
>> pass joydev its heuristics, but for which there is no good generic
>> way of updating the heuristics.
>
> I can't make sense of that last sentence, and the possessive for
> "heuristics" (here and below in the documentation) is, IMO,
> unnecessary.
>
>> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
>> ---
>>  Documentation/input/event-codes.rst    | 9 +++++++++
>>  include/uapi/linux/input-event-codes.h | 1 +
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/input/event-codes.rst
>> b/Documentation/input/event-codes.rst
>> index a8c0873..ae8c546 100644
>> --- a/Documentation/input/event-codes.rst
>> +++ b/Documentation/input/event-codes.rst
>> @@ -356,6 +356,15 @@ can report through the rotational axes (absolute
>> and/or relative rx, ry, rz).
>>  All other axes retain their meaning. A device must not mix
>>  regular directional axes and accelerometer axes on the same event
>> node.
>>
>> +INPUT_PROP_JOYDEV_IGNORE
>> +------------------------
>> +
>> +The joydev interface uses heuristics to determine whether it should
>> expose an
>> +input device through joydev. Some devices pass its heuristics, but
>> don't
>> +make sense to expose. In some cases the generic heuristics can be
>> updated,
>> +but in other cases this is not easy. The INPUT_PROP_JOYDEV_IGNORE
>> flag can
>> +be set by drivers to explicit request blacklisting by joydev.
>
> The "don't make sense to expose" is not what we're trying to do here
> though. The problem is rather that "we used not to show this device
> through joydev, but programs using joydev are limited and usually not
> updated so we should only show what we used to".
>

Thanks, I will change the wording. Originally I wrote it like this,
because I thought joydev applications could not determine at all which
axes were being used except for 'an axis number' and for that reason
thought that the match function had some heuristics (e.g. filtering
out touchpad devices and others), making sure a joystick has buttons
etcetera. I wasn't aware of JSIOCGAXMAP, which does allow applications
to get more information about a device, but you can't easily determine
if something is e.g. a motion sensor device you would need to do a
string compare on known strings or make assumptions if you see a
device with axes, but no buttons.

Thanks,
Roderick
