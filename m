From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/7] HID: logitech-hidpp: support non DJ devices
Date: Mon, 15 Oct 2018 14:34:56 +0200
Message-ID: <CAO-hwJJ8D6E3wMCAy4m2AX6AF9C=-S+iNi1uUM=MjQmAY-DQ8A@mail.gmail.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, simon@mungewell.org, ogay@logitech.com
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hello,

On Fri, Sep 7, 2018 at 12:34 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Jiri, Nestor,
>
> I have this series in my tree for a while now (first commit was in January).
> I never sent it (as far as I can remember*) because I was requesting
> feedback regarding the G920 wheel. I think I haven't break it, but
> mistakes can happen.
>
> Anyway, I think it's been too long, so I am just sending it now, as
> it will fix the names of the non-dj devices that share the same USB receiver
> (G900 and G403 for instance). Also, rebasing on top of new code is a pain
> I'd rather not do every 3 months.
>

Can anyone review this series?
It's been in my local tree for too long and feels too lonely there :)

Cheers,
Benjamin

>
> * looking into my archives, I actually sent those as a part of the
> battery support in hid-logitech-hidpp. Consider it as a fresh start though :)
>
> Benjamin Tissoires (7):
>   HID: logitech-hidpp: allow non HID++ devices to be handled by this
>     module
>   HID: logitech-hidpp: make .probe usbhid capable
>   HID: logitech-hidpp: support non-DJ receivers
>   HID: logitech-hidpp: get the name and serial of the other non-HID++
>     node
>   HID: logitech-hidpp: create a name based on the type if non available
>   HID: logitech-hidpp: support the G700 over wireless
>   HID: logitech-hidpp: support the G900 over wireless
>
>  drivers/hid/hid-ids.h            |   4 +
>  drivers/hid/hid-logitech-hidpp.c | 470 +++++++++++++++++++++++++++++++++------
>  2 files changed, 407 insertions(+), 67 deletions(-)
>
> --
> 2.14.3
>
