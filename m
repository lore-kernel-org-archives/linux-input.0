From: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Mon, 1 Apr 2019 20:26:31 +0800
Message-ID: <017701d4e886$236cedb0$6a46c910$@emc.com.tw>
References: <20190325125704.6585-1-hotwater438@tutanota.com> <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com> <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com> <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com> <abe3eccb-1490-e088-1fd8-6af4dc1bd2ec@redhat.com> <CAE_wzQ8f6F7EvF-Jti=nPrUZw2bN1NGGCFJFohJv2m11GbMfGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ8f6F7EvF-Jti=nPrUZw2bN1NGGCFJFohJv2m11GbMfGw@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
To: 'Dmitry Torokhov' <dtor@chromium.org>, 'Hans de Goede' <hdegoede@redhat.com>
Cc: 'Vladislav Dalechyn' <vlad.dalechin@gmail.com>, 'Benjamin Tissoires' <benjamin.tissoires@redhat.com>, 'Jiri Kosina' <jikos@kernel.org>, kai.heng.feng@canonical.com, swboyd@chromium.org, bigeasy@linutronix.de, "'open list:HID CORE LAYER'" <linux-input@vger.kernel.org>, 'lkml' <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

-----Original Message-----
From: Dmitry Torokhov [mailto:dtor@chromium.org] 
Sent: Saturday, March 30, 2019 2:24 AM
To: Hans de Goede; 廖崇榮
Cc: Vladislav Dalechyn; Benjamin Tissoires; Jiri Kosina; kai.heng.feng@canonical.com; swboyd@chromium.org; bigeasy@linutronix.de; open list:HID CORE LAYER; lkml; hotwater438@tutanota.com
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix

On Fri, Mar 29, 2019 at 5:18 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/25/19 5:56 PM, Dmitry Torokhov wrote:
> > Hi Hans,
> >
> > On Mon, Mar 25, 2019 at 9:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 25-03-19 17:02, Dmitry Torokhov wrote:
> >>> Hi Vladislav,
> >>>
> >>> On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn 
> >>> <vlad.dalechin@gmail.com> wrote:
> >>>>
> >>>> From: Vladislav Dalechyn <hotwater438@tutanota.com>
> >>>>
> >>>> Description: The ELAN1200:04F3:303E touchpad exposes several 
> >>>> issues, all caused by an error setting the correct IRQ_TRIGGER flag:
> >>>> - i2c_hid incoplete error flood in journalctl;
> >>>> - Five finger tap kill's module so you have to restart it;
> >>>> - Two finger scoll is working incorrect and sometimes even when 
> >>>> you raised one of two finger still thinks that you are scrolling.
> >>>>
> >>>> Fix all of these with a new quirk that corrects the trigger flag 
> >>>> announced by the ACPI tables. (edge-falling).
> >>>
> >>> I do not believe this is right solution. The driver makes liberal 
> >>> use of disable_irq() and enable_irq() which may lead to lost edges 
> >>> and touchpad stopping working altogether.
> >>>
> >>> Usually the "extra" report is caused by GPIO controller clearing 
> >>> interrupt condition at the wrong time (too early), or in unsafe or 
> >>> racy fashion. You need to look there instead of adding quirk to 
> >>> i2c-hid.
> >>
> >> The falling-edge solution was proposed by Elan themselves.
> >>
> >> Also if you look at: 
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1543769
> >>
> >> And esp. the "cat /proc/interrupts" output there, then you will see 
> >> that the interrupt seems to be stuck at low level, which according 
> >> to the ACPI tables is its active level.
> >
> > So how does it generate a new edge if it is stuck at low?
> >
> > Is it bad touchpad firmware that does not deassert interrupt quickly 
> > enough?
>
> I do not believe it is not de-asserting it quick enough (I believe the 
> amount of interrups is too high for that.
>
> It seems to simply be low most of the time, or it is really really 
> slow with de-asserting.
>
> Vladislav can you check the output of /cat/interrupts on a kernel 
> without the patch and while *not* using the touchpad; and check if the 
> amount of touchpads-interrupts still keeps increasing in this case?
>
> Also I believe that you had contact with Elan about this and they told 
> you to change the interrupt type to falling-edge as work-around, 
> right?  Can you ask them why?

KT, do you know anything about using edge interrupts with your hid-over-i2c products?

Ya, I sent the patch to Vladislav for testing his 5 finger-tap issue.

The patch is created by Dell/Intel for debugging Elan PTP's incomplete report message.
Host tried to get report again while touchpad finish report transmission.

I excerpt from Dell's mail
===========Begin=========================
We have worked with Intel for a while to revise Linux kernel driver code to prevent Touch I2C error message show up,
And Intel dig out there’re 2 issues to cause this i2c error on Linux kernel 4.18.

Therefore Intel suggested to revised SW code into “trigger falling edge + pm_disabled + IRQF_SHARED | IRQF_COND_SUSPEND(i2c-designware-master.c)” 
and then we can get positive result that i2c error message disappeared when Touch Panel is working.

Since this issue only happened on ELAN touch pad + Intel GLK platform (Linux) and other Intel reference platform (Whisky lake) won’t, would you help check the solution (as patch attached)  and let us know if any question/concern for this modification?  
===========End=========================

I don't know the root cause of 5-finger issue with level trigger so far.
I will check it once I get the touchpad with the same issue.

>From previous issue list, it seems that some touchpad's crush issue will be fixed by edge trigger.

I have discussed with FW engineer, both level and edge trigger should be OK for our PTP(HID touchpad).
I summary the behavior of our HID touchpad's interrupt.
1. Assert for Every finger's report, which means 5 ISR for 5 finger operation.
2. We will de-assert INT pin after the last byte's NACK signal.
   I checked LA scope, 2nd finger's assert will happen after 10us if two finger touch.
   SYNAPTICS's touchpad will de-assert it after address byte sent. 
	 
I am not sure if SYNAPTICE's earlier de-asserting is a better way for level-trigger?
At least we never see issue happen on our PTP in Windows 10.
>
> This is quite unususal, I've collected quite a few DSDTs over time and 
> I've just checked about 40 of them all with a PNP0C50 in some form 
> (and in many cases multiple such devices) and NONE of them is using 
> edged-interrupts in the ACPI config.

That is because MS spec for HID over I2C requires level interrupts:

"7.4 Interrupt Line Management

DEVICE is responsible to assert the interrupt line (level trigger interrupt required) when it has data.

DEVICE must keep the interrupt line asserted until the data has been fully read by the HOST. After this point, the DEVICE must de-assert the interrupt line if it has no more data to report to the HOST.
When the DEVICE has new data to report, it must repeat the process above."

See https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)

>
> <speculation>
>
> I think that the Elan touchpad firmware supports a mode to work on 
> devices which only support edge interrupts and that this mode is 
> accidentally enabled in this firmware.
>
> I think that the interrupt line is simply low all the time and gets 
> pulsed high then low again when the touchpad detects a finger. 
> Hopefully it does this pulsing on every event and not only when its 
> event "fifo" is empty.

This behavior would violate HID-over-I2C spec though.

>
> </speculation>
>
> > I scrolled through the bug but I do not see if it had been confirmed 
> > that original windows installation actually uses edge (it may very 
> > well be using it; Elan engineers pushed us to use edge in a few 
> > cases, but they all boiled down to an issue with pin control/GPIO 
> > implementation).
>
> This has not been checked on Windows AFAIK.
>
> >> As for this being a GPIO chip driver problem, this is using 
> >> standard Intel pinctrl stuff, which is not showing this same issue 
> >> with many other i2c-hid touchpads.
> >
> > Well, there have been plenty of issues in intel drivers, coupled 
> > with "interesting" things done by firmware and boards.
> >
> > If you want to keep on using edge you need to make sure that i2c-hid 
> > never loses edge, as replaying of previously disabled interrupts in 
> > not at all reliable. So you need to "kick" the device after
> > enable_irq() by initiating read from it and be ready to not get any 
> > data or get valid data and process accordingly.
>
> That is a good point and I agree.
>
> Vladislav, let me explain this a bit. Normally the touchpad driver the 
> IRQ line low when it has touch-data to respond, which means that if 
> touch-data is reported before the driver loads (or while the driver 
> has the irq disabled during e.g. suspend), it will immediately see an 
> interrupt. If we use edge mode then the IRQ will only trigger when the 
> IRQ line goes from high to low, if this happens when the driver is not 
> listening then we do not see the edge. And since we never read the 
> pending touch-data, the IRQ line never goes high again (which it does 
> when we have read all available data), so we will never see a 
> negative-edge and then things are stuck.
>
> It would be good, if running a kernel with your patch, you can try to 
> trigger this by:
>
> 1) Suspending the machine by selecting suspend from a menu in your 
> desktop environment, or by briefly pressing the power-button, do not 
> close the lid
> 2) As soon as the system starts suspending and while it is suspended, 
> move your finger around the touchpad
> 3) Wake the system up with the powerbutton while moving your finger 
> around
> 4) Check if the touchpad still works after this
>
> Or by:
>
> 1) Using ctrl + alt + f3 to switch to a text console
> 2) Move finger around on touchpad, keep moving it around
> 3) Switch back to X11 with alt + f2 or alt + f7, while still moving 
> the finger
> 4) Check if the touchpad still works after this
>
> If neither causes the touchpad to stop working, then at least the 
> problem Dmitry fears is not easy to trigger, but we should probably 
> still prepare to deal with it; and we really should try to better 
> understand the problem here, so if you can answer my questions above, then that would be great.

Thanks.

--
Dmitry
