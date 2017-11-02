From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usb/misc/ims-pcu: slab-out-of-bounds in ims_pcu_parse_cdc_data
Date: Thu, 2 Nov 2017 09:25:35 -0700
Message-ID: <CAKdAkRQTU6DTm-kOyvPgEZH-TbHmu4ge9Oqkb1+ZefQBLpEFbw@mail.gmail.com>
References: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
 <20171007181433.GA14355@dtor-ws> <CAAeHK+x4aSp3HF_fgCsgUV=h2t8rNXOABZcNb0gWvvrqW+1vEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:53677 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdKBQZh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Nov 2017 12:25:37 -0400
In-Reply-To: <CAAeHK+x4aSp3HF_fgCsgUV=h2t8rNXOABZcNb0gWvvrqW+1vEQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

Hi Andrey,

On Thu, Nov 2, 2017 at 9:13 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Sat, Oct 7, 2017 at 8:14 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Sep 28, 2017 at 01:35:51PM +0200, Andrey Konovalov wrote:
>>> Hi!
>>>
>>> I've got the following report while fuzzing the kernel with syzkaller.
>>>
>>> On commit dc972a67cc54585bd83ad811c4e9b6ab3dcd427e (4.14-rc2+).
>>>
>>> There's no check that the length of intf->altsetting->extra is big
>>> enough to hold usb_cdc_union_desc struct.
>>
>> Can you please tell me if the following works for you?
>
> Hi Dmitry,
>
> Could you mail this patch upstream?

It is already there:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/input/misc/ims-pcu.c?id=ea04efee7635c9120d015dcdeeeb6988130cb67a

Thanks.

-- 
Dmitry
