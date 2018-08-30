From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 3/3] Enable high-resolution scrolling on Logitech mice
Date: Thu, 30 Aug 2018 13:37:58 -0700
Message-ID: <CA+jURcsDJbL_3aF7wE0MQ_6ZSVV3Aba-tUDX-f=1+y+LBhqmng@mail.gmail.com>
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-4-hcutts@chromium.org>
 <CAO-hwJ+rR8ft96AGjoEApr1ZkythKfcxjVzdULzgpRy-aRv_vg@mail.gmail.com>
 <CA+jURcvguwXAVnpQ9+84QQOaJG74oeV8U4zzM1X0UabaY5DJBQ@mail.gmail.com> <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJ+tb6XdEM76r0jxBfCx2r_PqQp9T5=A2ALociyHOKUeMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

On Thu, 30 Aug 2018 at 00:18, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>> On Thu, Aug 30, 2018 at 1:06 AM Harry Cutts <hcutts@chromium.org> wrote:
> > > The conversion input_report_rel(... REL_WHEEL,...) to
> > > hid_scroll_counter_handle_scroll() should be dealt in a separate
> > > patch.
> >
> > OK, I'll do that in v2, but might I ask why? I don't see how this
> > particular hunk is special.
>
> I tend to consider that existing code rewrite need to be in their
> special commit, especially if the change isn't supposed to change the
> behaviour. This is my personal taste in case something goes wrong and
> (in this case) a m560 suddenly starts complaining about an issue with
> this mouse.
> I wouldn't mind too much if you rather keep the
> hid_scroll_counter_handle_scroll() introduction to this commit though.

Yes, I see the reasoning for that, but this hunk is pretty tied to the
main change in that scrolling on the M560 would be 8x too fast without
it. I'll keep it in the same one, if you don't mind.

> > [snip]
> > Yes, it seems to work fine without it (at least for the MX Master 2S).
> > Unfortunately, while testing this I encountered a bug with high-res
> > scrolling over Bluetooth. (It seems that if you turn off the MX Master
> > 2S while it's connected over Bluetooth, we don't detect that and
> > remove the input device, meaning that when it reconnects the driver
> > thinks it's in high-res mode but the mouse is in low-res.) I'm
> > investigating, but in the meantime I'll remove the Bluetooth support
> > from v2 and add it back in later.
>
> As far as I can see, the MX Master 2S is connected over BLE. Bluez
> keeps the uhid node opened (and thus the existing bluetooth HID
> device) to be able to reconnect faster.
> I would suppose you should get notified in the connect event of a
> reconnection, but it doesn't seem to be the case.
>
> Nestor, is there any event emitted by the mouse when it gets
> reconnected over BLE or is that a bluez issue?

Ah, interesting. The MX Master 2S is indeed using BLE, and testing
with another Logitech BLE mouse (the M585) also leaves the input
device around. I think this is something Logitech-specific, though, as
the Microsoft Surface Precision mouse (also BLE) does have its input
device removed when it turns off. I notice that btmon does show
"device disconnected" and "device connected" events when I turn the
M585 on and off; maybe we need to plumb those through to the driver.
We've decided to delay Bluetooth support for high-res scrolling until
the Chrome OS Bluetooth stack is more stable.

Harry Cutts
Chrome OS Touch/Input team
