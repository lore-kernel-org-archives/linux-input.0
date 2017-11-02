From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/misc/ims-pcu: slab-out-of-bounds in ims_pcu_parse_cdc_data
Date: Thu, 2 Nov 2017 17:28:27 +0100
Message-ID: <CAAeHK+wLAiNYDNDBALoJb07BgqivPWkBJxHyYWwiba9hPTNoTA@mail.gmail.com>
References: <CAAeHK+w_9oFs4=2PLY++EKgVme7KJ07F8AkOgwePdX+p2tK1qQ@mail.gmail.com>
 <20171007181433.GA14355@dtor-ws> <CAAeHK+x4aSp3HF_fgCsgUV=h2t8rNXOABZcNb0gWvvrqW+1vEQ@mail.gmail.com>
 <CAKdAkRQTU6DTm-kOyvPgEZH-TbHmu4ge9Oqkb1+ZefQBLpEFbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQTU6DTm-kOyvPgEZH-TbHmu4ge9Oqkb1+ZefQBLpEFbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 2, 2017 at 5:25 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Andrey,
>
> On Thu, Nov 2, 2017 at 9:13 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> On Sat, Oct 7, 2017 at 8:14 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> On Thu, Sep 28, 2017 at 01:35:51PM +0200, Andrey Konovalov wrote:
>>>> Hi!
>>>>
>>>> I've got the following report while fuzzing the kernel with syzkaller.
>>>>
>>>> On commit dc972a67cc54585bd83ad811c4e9b6ab3dcd427e (4.14-rc2+).
>>>>
>>>> There's no check that the length of intf->altsetting->extra is big
>>>> enough to hold usb_cdc_union_desc struct.
>>>
>>> Can you please tell me if the following works for you?
>>
>> Hi Dmitry,
>>
>> Could you mail this patch upstream?
>
> It is already there:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/input/misc/ims-pcu.c?id=ea04efee7635c9120d015dcdeeeb6988130cb67a

Totally missed this, thanks!

>
> Thanks.
>
> --
> Dmitry
