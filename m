From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Thu, 17 Jan 2019 19:41:12 +0800
Message-ID: <1897F291-4EB4-4E4B-87AA-3C16EF321340@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
 <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
 <2149AEF5-ABBF-4745-89F9-7FF9719251B5@canonical.com>
 <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJLHm8b6X9kX1myz7xx1992VW2tVjdn6xw2n1MVX2dn0=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> On Jan 17, 2019, at 16:06, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Thu, Jan 17, 2019 at 6:02 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
[snipped]
>> Goodix says the firmware needs at least 60ms to fully respond ON and
>> SLEEP command.
> 
> I was about to say that this is not conformant to the specification.
> But looking at 7.2.8 SET_POWER of
> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
> 
> They say:
> "The DEVICE must ensure that it transitions to the HOST specified
> Power State in under 1 second. "
> But in the RESPONSE paragraph: "The DEVICE shall not respond back
> after receiving the command. The DEVICE is mandated to enter that
> power state imminently."
> 
> My interpretation was always that the device has to be in a ready
> state for new commands "immediately".
> However, the first sentence may suggest that the driver would block
> any command to the device before the 1 second timestamp.
> 
>> 
>> I’ll see if an 200ms autosuspend can solve all Goodix, LG and Raydium
>> touchpanels.
> 
> We already have a I2C_HID_QUIRK_DELAY_AFTER_SLEEP quirk that delay
> operations after sleep by 20ms. Maybe we can keep the runtime PM but
> use the same timers to not confuse the hardware.

Yes, but wouldn’t use pm_*_autosuspend() helpers can both solve the issue
and make the code more cleaner?

Kai-Heng

> 
> Cheers,
> Benjamin
