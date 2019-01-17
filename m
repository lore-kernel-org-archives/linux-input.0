From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Thu, 17 Jan 2019 09:06:07 +0100
Message-ID: <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm> <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Jan 16, 2019, at 16:21, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
> >
> >
> >
> >> On Jan 14, 2019, at 19:18, Jiri Kosina <jikos@kernel.org> wrote:
> >>
> >> On Mon, 14 Jan 2019, Kai-Heng Feng wrote:
> >>
> >>> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
> >>> but there's no input event from HID subsystem.
> >>>
> >>> Turns out it reports some invalid data:
> >>> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
> >>>
> >>> After some trial and error, it's another device that doesn't work well
> >>> with ON/SLEEP commands. Disable runtime PM to fix the issue.
> >>
> >> Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am
> >> wondering though we are we seeing these at all - do other OSes not do the
> >> runtime PM on i2c at all?
> >
> > According to the vendor, Windows does use ON/SLEEP, but infrequently.
> >
> > We can use pm_runtime_use_autosuspend() to reduce the frequency of
> > ON/SLEEP commands, but it’s just papering over the touchpad firmware
> > bug.
>
> Goodix says the firmware needs at least 60ms to fully respond ON and
> SLEEP command.

I was about to say that this is not conformant to the specification.
But looking at 7.2.8 SET_POWER of
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)

They say:
"The DEVICE must ensure that it transitions to the HOST specified
Power State in under 1 second. "
But in the RESPONSE paragraph: "The DEVICE shall not respond back
after receiving the command. The DEVICE is mandated to enter that
power state imminently."

My interpretation was always that the device has to be in a ready
state for new commands "immediately".
However, the first sentence may suggest that the driver would block
any command to the device before the 1 second timestamp.

>
> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
> touchpanels.

We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
operations after sleep by 20ms. Maybe we can keep the runtime PM but
use the same timers to not confuse the hardware.

Cheers,
Benjamin
