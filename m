From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/2] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Fri, 22 Jul 2016 10:02:03 -0700
Message-ID: <20160722170203.GB5036@dtor-ws>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <84ca7337d20620946b671f212abfc82698ddcbf4.1468915808.git.lv.zheng@intel.com>
 <20160721203246.GA9841@dtor-ws>
 <1AE640813FDE7649BE1B193DEA596E883BC05AAA@SHSMSX101.ccr.corp.intel.com>
 <20160722043707.GB7060@dtor-ws>
 <CAN+gG=EArk3tPDkyim8eoxOXHHb7QNRXe4o4zAVs+M6x8ZPrSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=EArk3tPDkyim8eoxOXHHb7QNRXe4o4zAVs+M6x8ZPrSA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 22, 2016 at 08:55:00AM +0200, Benjamin Tissoires wrote:
> On Fri, Jul 22, 2016 at 6:37 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Lv,
> >
> > On Fri, Jul 22, 2016 at 12:24:50AM +0000, Zheng, Lv wrote:
> >> Hi, Dmitry
> >>
> >>
> >> Thanks for the review.
> >>
> >> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> >> > Subject: Re: [PATCH v4 2/2] ACPI / button: Add document for ACPI control
> >> > method lid device restrictions
> >> >
> >> > On Tue, Jul 19, 2016 at 04:11:21PM +0800, Lv Zheng wrote:
> >> > > This patch adds documentation for the usage model of the control
> >> > method lid
> >> > > device.
> >> > >
> >> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> >> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> > > Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> >> > > Cc: Bastien Nocera: <hadess@hadess.net>
> >> > > Cc: linux-input@vger.kernel.org
> >> > > ---
> >> > >  Documentation/acpi/acpi-lid.txt |   89
> >> > +++++++++++++++++++++++++++++++++++++++
> >> > >  1 file changed, 89 insertions(+)
> >> > >  create mode 100644 Documentation/acpi/acpi-lid.txt
> >> > >
> >> > > diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-
> >> > lid.txt
> >> > > new file mode 100644
> >> > > index 0000000..2addedc
> >> > > --- /dev/null
> >> > > +++ b/Documentation/acpi/acpi-lid.txt
> >> > > @@ -0,0 +1,89 @@
> >> > > +Usage Model of the ACPI Control Method Lid Device
> >> > > +
> >> > > +Copyright (C) 2016, Intel Corporation
> >> > > +Author: Lv Zheng <lv.zheng@intel.com>
> >> > > +
> >> > > +
> >> > > +Abstract:
> >> > > +
> >> > > +Platforms containing lids convey lid state (open/close) to OSPMs using
> >> > a
> >> > > +control method lid device. To implement this, the AML tables issue
> >> > > +Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state has
> >> > > +changed. The _LID control method for the lid device must be
> >> > implemented to
> >> > > +report the "current" state of the lid as either "opened" or "closed".
> >> > > +
> >> > > +This document describes the restrictions and the expections of the
> >> > Linux
> >> > > +ACPI lid device driver.
> >> > > +
> >> > > +
> >> > > +1. Restrictions of the returning value of the _LID control method
> >> > > +
> >> > > +The _LID control method is described to return the "current" lid state.
> >> > > +However the word of "current" has ambiguity, many AML tables return
> >> > the lid
> >> >
> >> > Can this be fixed in the next ACPI revision?
> >> [Lv Zheng]
> >> Even this is fixed in the ACPI specification, there are platforms already doing this.
> >> Especially platforms from Microsoft.
> >> So the de-facto standard OS won't care about the change.
> >> And we can still see such platforms.
> >>
> >> Here is an example from Surface 3:
> >>
> >> DefinitionBlock ("dsdt.aml", "DSDT", 2, "ALASKA", "A M I ", 0x01072009)
> >> {
> >>     Scope (_SB)
> >>     {
> >>         Device (PCI0)
> >>         {
> >>             Name (_HID, EisaId ("PNP0A08"))  // _HID: Hardware ID
> >>             Name (_CID, EisaId ("PNP0A03"))  // _CID: Compatible ID
> >>             Device (SPI1)
> >>             {
> >>                 Name (_HID, "8086228E")  // _HID: Hardware ID
> >>                 Device (NTRG)
> >>                 {
> >>                     Name (_HID, "MSHW0037")  // _HID: Hardware ID
> >>                 }
> >>             }
> >>         }
> >>
> >>         Device (LID)
> >>         {
> >>             Name (_HID, EisaId ("PNP0C0D"))
> >>             Name (LIDB, Zero)
> >
> > Start with lid closed? In any case might be wrong.
> 
> Actually the initial value doesn't matter if the gpiochip triggers the
> _EC4 at boot, which it should
> (https://github.com/hadess/fedora-surface3-kernel/commit/13200f81662c1c0b58137947c3e6c000fe62a2ba,
> still unsubmitted)
> 
> >
> >>             Method (_LID, 0, NotSerialized)
> >>             {
> >>                 Return (LIDB)
> >
> > So "_LID" returns the last state read by "_EC4". "_EC4" is
> > edge-triggered and will be evaluated every time gpio changes state.
> 
> That's assuming the change happens while the system is on. If you go
> into suspend by closing the LID. Open it while on suspend and then hit
> the power button given that the system doesn't wake up when the lid is
> opened, the edge change was made while the system is asleep, and we
> are screwed (from an ACPI point of view). See my next comment for a
> solution.

Can we extend the patch you referenced above and do similar thing on
resume? Won't help Surface but might others.

> 
> >
> >>             }
> >>         }
> >>
> >>         Device (GPO0)
> >>         {
> >>             Name (_HID, "INT33FF")  // _HID: Hardware ID
> >>             OperationRegion (GPOR, GeneralPurposeIo, Zero, One)
> >>             Field (GPOR, ByteAcc, NoLock, Preserve)
> >>             {
> >>                 Connection (
> >>                     GpioIo (Shared, PullNone, 0x0000, 0x0000, IoRestrictionNone,
> >>                         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
> >>                         )
> >>                         {   // Pin list
> >>                             0x004C
> >>                         }
> >>                 ),
> >>                 HELD,   1
> >
> > Is it possible to read state of this GPIO from userspace on startup to
> > correct the initial state?
> >
> >>             }
> >>             Method (_E4C, 0, Serialized)
> >>             {
> >>                 If (LEqual(HELD, One))
> >>                 {
> >>                     Store(One, ^^LID.LIDB)
> >>
> >> There is no "open" event generated by "Surface 3".
> >
> > Right so we update the state correctly, we just forgot to send the
> > notification. Nothing that polling can't fix.
> 
> Actually, I have a better (though more hackish) way of avoiding polling:
> https://github.com/hadess/fedora-surface3-kernel/blob/5e5775b9bdc308d665064387e0b144ee48e7b243/0002-WIP-add-custom-surface3-platform-device-for-controll.patch
> 
> Given that the notification is forwarded to the touchscreen anyway, we
> can unregister the generic (and buggy) acpi button driver for the LID
> and create our own based on this specific DSDT.
> We can also make sure the LID state is also correct because of the WMI
> method which allows to read the actual value of the GPIO connected to
> the cover without using the cached (and most of the time wrong) acpi
> LID.LIDB value.
> 
> I still yet have to submit this, but with this patch, but we can
> consider the Surface 3 as working and not an issue anymore.
> 
> >
> >>
> >>                 }
> >>                 Else
> >>                 {
> >>                     Store(Zero, ^^LID.LIDB)
> >>                     Notify (LID, 0x80)
> >>
> >> There is only "close" event generated by "Surface 3".
> >> Thus they are not paired.
> >>
> >>                 }
> >>                 Notify (^^PCI0.SPI1.NTRG, One) // Device Check
> >>             }
> >>         }
> >>     }
> >> }
> >>
> >> >
> >> > > +state upon the last lid notification instead of returning the lid state
> >> > > +upon the last _LID evaluation. There won't be difference when the _LID
> >> > > +control method is evaluated during the runtime, the problem is its
> >> > initial
> >> > > +returning value. When the AML tables implement this control method
> >> > with
> >> > > +cached value, the initial returning value is likely not reliable. There are
> >> > > +simply so many examples always retuning "closed" as initial lid state.
> >> > > +
> >> > > +2. Restrictions of the lid state change notifications
> >> > > +
> >> > > +There are many AML tables never notifying when the lid device state is
> >> > > +changed to "opened". Thus the "opened" notification is not guaranteed.
> >> > > +
> >> > > +But it is guaranteed that the AML tables always notify "closed" when
> >> > the
> >> > > +lid state is changed to "closed". The "closed" notification is normally
> >> > > +used to trigger some system power saving operations on Windows.
> >> > Since it is
> >> > > +fully tested, the "closed" notification is reliable for all AML tables.
> >> > > +
> >> > > +3. Expections for the userspace users of the ACPI lid device driver
> >> > > +
> >> > > +The ACPI button driver exports the lid state to the userspace via the
> >> > > +following file:
> >> > > +  /proc/acpi/button/lid/LID0/state
> >> > > +This file actually calls the _LID control method described above. And
> >> > given
> >> > > +the previous explanation, it is not reliable enough on some platforms.
> >> > So
> >> > > +it is advised for the userspace program to not to solely rely on this file
> >> > > +to determine the actual lid state.
> >> > > +
> >> > > +The ACPI button driver emits 2 kinds of events to the user space:
> >> > > +  SW_LID
> >> > > +   When the lid state/event is reliable, the userspace can behave
> >> > > +   according to this input switch event.
> >> > > +   This is a mode prepared for backward compatiblity.
> >> > > +  KEY_EVENT_OPEN/KEY_EVENT_CLOSE
> >> > > +   When the lid state/event is not reliable, the userspace should behave
> >> > > +   according to these 2 input key events.
> >> > > +   New userspace programs may only be prepared for the input key
> >> > events.
> >> >
> >> > No, absolutely not. If some x86 vendors managed to mess up their
> >> > firmware implementations that does not mean that everyone now has to
> >> > abandon working perfectly well for them SW_LID events and rush to
> >> > switch
> >> > to a brand new event.
> >> [Lv Zheng]
> >> However there is no clear wording in the ACPI specification asking the vendors to achieve paired lid events.
> >>
> >> >
> >> > Apparently were are a few issues, main is that some systems not reporting
> >> > "open" event. This can be dealt with by userspace "writing" to the
> >> > lid's evdev device EV_SW/SW_LID/0 event upon system resume (and
> >> > startup)
> >> > for selected systems. This will mean that if system wakes up not because
> >> > LID is open we'll incorrectly assume that it is, but we can either add
> >> > more smarts to the process emitting SW_LID event or simply say "well,
> >> > tough, the hardware is crappy" and bug vendor to see if they can fix the
> >> > issue (if not for current firmware them for next).
> >> [Lv Zheng]
> >> The problem is there is no vendor actually caring about fixing this "issue".
> >> Because Windows works well with their firmware.
> >> Then finally becomes a big table customization business for our team.
> >
> > Well, OK. But you do not expect that we will redo up and down the stack
> > lid handling just because MS messed up DSDT on Surface 3? No, let them
> > know (they now care about Linux, right?) so Surface 4 works and quirk
> > the behavior for Surface 3.
> >
> 
> From what I understood, it was more than just the Surface 3. Other
> laptops were having issues and Lv's team gave up on fixing those
> machines.
> 
> >>
> >> >
> >> > As an additional workaround, we can toggle the LID switch off and on
> >> > when we get notification, much like your proposed patch does for the key
> >> > events.
> 
> I really don't like this approach. The problem being that we will fix
> the notifications to user space, but nothing will tell userspace that
> the LID state is known to be wrong.
> OTOH, I already agreed for a hwdb in userspace so I guess this point is moot.

Yeah, I do not like this too much either, I would prefer if we could dig
out and communicate real state of LID to userspace. It sounds we have
reasonable way for the Surfaces (I assume the others will have the same
issues as 3), and we need to figure out what the other troublemakers
are.

> 
> Having both events (one SW for reliable HW, always correct, and one
> KEY for unreliable HW) allows userspace to make a clear distinction
> between the working and non working events and they can continue to
> keep using the polling of the SW node without extra addition.

At this point I would prefer not adding any "unreliable" events just yet
and concentrate on finding working solution for SW_LID.

Thanks.

-- 
Dmitry
