From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v4 2/2] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Fri, 22 Jul 2016 08:37:50 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC05D64@SHSMSX101.ccr.corp.intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
 <84ca7337d20620946b671f212abfc82698ddcbf4.1468915808.git.lv.zheng@intel.com>
 <20160721203246.GA9841@dtor-ws>
 <1AE640813FDE7649BE1B193DEA596E883BC05AAA@SHSMSX101.ccr.corp.intel.com>
 <20160722043707.GB7060@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722043707.GB7060@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, "Bastien Nocera:" <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi, Dmitry

Thanks for the review.

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Subject: Re: [PATCH v4 2/2] ACPI / button: Add document for ACPI control
> method lid device restrictions
> 
> Hi Lv,
> 
> On Fri, Jul 22, 2016 at 12:24:50AM +0000, Zheng, Lv wrote:
> > Hi, Dmitry
> >
> >
> > Thanks for the review.
> >
> > > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > > Subject: Re: [PATCH v4 2/2] ACPI / button: Add document for ACPI
> control
> > > method lid device restrictions
> > >
> > > On Tue, Jul 19, 2016 at 04:11:21PM +0800, Lv Zheng wrote:
> > > > This patch adds documentation for the usage model of the control
> > > method lid
> > > > device.
> > > >
> > > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > > > Cc: Bastien Nocera: <hadess@hadess.net>
> > > > Cc: linux-input@vger.kernel.org
> > > > ---
> > > >  Documentation/acpi/acpi-lid.txt |   89
> > > +++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 89 insertions(+)
> > > >  create mode 100644 Documentation/acpi/acpi-lid.txt
> > > >
> > > > diff --git a/Documentation/acpi/acpi-lid.txt
> b/Documentation/acpi/acpi-
> > > lid.txt
> > > > new file mode 100644
> > > > index 0000000..2addedc
> > > > --- /dev/null
> > > > +++ b/Documentation/acpi/acpi-lid.txt
> > > > @@ -0,0 +1,89 @@
> > > > +Usage Model of the ACPI Control Method Lid Device
> > > > +
> > > > +Copyright (C) 2016, Intel Corporation
> > > > +Author: Lv Zheng <lv.zheng@intel.com>
> > > > +
> > > > +
> > > > +Abstract:
> > > > +
> > > > +Platforms containing lids convey lid state (open/close) to OSPMs
> using
> > > a
> > > > +control method lid device. To implement this, the AML tables issue
> > > > +Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state
> has
> > > > +changed. The _LID control method for the lid device must be
> > > implemented to
> > > > +report the "current" state of the lid as either "opened" or "closed".
> > > > +
> > > > +This document describes the restrictions and the expections of the
> > > Linux
> > > > +ACPI lid device driver.
> > > > +
> > > > +
> > > > +1. Restrictions of the returning value of the _LID control method
> > > > +
> > > > +The _LID control method is described to return the "current" lid
> state.
> > > > +However the word of "current" has ambiguity, many AML tables
> return
> > > the lid
> > >
> > > Can this be fixed in the next ACPI revision?
> > [Lv Zheng]
> > Even this is fixed in the ACPI specification, there are platforms already
> doing this.
> > Especially platforms from Microsoft.
> > So the de-facto standard OS won't care about the change.
> > And we can still see such platforms.
> >
> > Here is an example from Surface 3:
> >
> > DefinitionBlock ("dsdt.aml", "DSDT", 2, "ALASKA", "A M I ", 0x01072009)
> > {
> >     Scope (_SB)
> >     {
> >         Device (PCI0)
> >         {
> >             Name (_HID, EisaId ("PNP0A08"))  // _HID: Hardware ID
> >             Name (_CID, EisaId ("PNP0A03"))  // _CID: Compatible ID
> >             Device (SPI1)
> >             {
> >                 Name (_HID, "8086228E")  // _HID: Hardware ID
> >                 Device (NTRG)
> >                 {
> >                     Name (_HID, "MSHW0037")  // _HID: Hardware ID
> >                 }
> >             }
> >         }
> >
> >         Device (LID)
> >         {
> >             Name (_HID, EisaId ("PNP0C0D"))
> >             Name (LIDB, Zero)
> 
> Start with lid closed? In any case might be wrong.
[Lv Zheng] 
And we validated with qemu that during boot, Windows7 evaluates _LID once but doesn't get suspended because of this value.
So we think Windows only suspends against "notification" not _LID evaluation result.

> 
> >             Method (_LID, 0, NotSerialized)
> >             {
> >                 Return (LIDB)
> 
> So "_LID" returns the last state read by "_EC4". "_EC4" is
> edge-triggered and will be evaluated every time gpio changes state.
[Lv Zheng] 
Right.

> 
> >             }
> >         }
> >
> >         Device (GPO0)
> >         {
> >             Name (_HID, "INT33FF")  // _HID: Hardware ID
> >             OperationRegion (GPOR, GeneralPurposeIo, Zero, One)
> >             Field (GPOR, ByteAcc, NoLock, Preserve)
> >             {
> >                 Connection (
> >                     GpioIo (Shared, PullNone, 0x0000, 0x0000, IoRestrictionNone,
> >                         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
> >                         )
> >                         {   // Pin list
> >                             0x004C
> >                         }
> >                 ),
> >                 HELD,   1
> 
> Is it possible to read state of this GPIO from userspace on startup to
> correct the initial state?
[Lv Zheng] 
I think Benjamin has a proposal of fixing this in GPIO driver.

> 
> >             }
> >             Method (_E4C, 0, Serialized)
> >             {
> >                 If (LEqual(HELD, One))
> >                 {
> >                     Store(One, ^^LID.LIDB)
> >
> > There is no "open" event generated by "Surface 3".
> 
> Right so we update the state correctly, we just forgot to send the
> notification. Nothing that polling can't fix.
> 
[Lv Zheng] 
However, polling is not efficient, and not power efficient.
OTOH, according to the validation result, Windows never poll _LID.

> >
> >                 }
> >                 Else
> >                 {
> >                     Store(Zero, ^^LID.LIDB)
> >                     Notify (LID, 0x80)
> >
> > There is only "close" event generated by "Surface 3".
> > Thus they are not paired.
> >
> >                 }
> >                 Notify (^^PCI0.SPI1.NTRG, One) // Device Check
> >             }
> >         }
> >     }
> > }
> >
> > >
> > > > +state upon the last lid notification instead of returning the lid state
> > > > +upon the last _LID evaluation. There won't be difference when the
> _LID
> > > > +control method is evaluated during the runtime, the problem is its
> > > initial
> > > > +returning value. When the AML tables implement this control
> method
> > > with
> > > > +cached value, the initial returning value is likely not reliable. There
> are
> > > > +simply so many examples always retuning "closed" as initial lid
> state.
> > > > +
> > > > +2. Restrictions of the lid state change notifications
> > > > +
> > > > +There are many AML tables never notifying when the lid device
> state is
> > > > +changed to "opened". Thus the "opened" notification is not
> guaranteed.
> > > > +
> > > > +But it is guaranteed that the AML tables always notify "closed"
> when
> > > the
> > > > +lid state is changed to "closed". The "closed" notification is normally
> > > > +used to trigger some system power saving operations on Windows.
> > > Since it is
> > > > +fully tested, the "closed" notification is reliable for all AML tables.
> > > > +
> > > > +3. Expections for the userspace users of the ACPI lid device driver
> > > > +
> > > > +The ACPI button driver exports the lid state to the userspace via the
> > > > +following file:
> > > > +  /proc/acpi/button/lid/LID0/state
> > > > +This file actually calls the _LID control method described above. And
> > > given
> > > > +the previous explanation, it is not reliable enough on some
> platforms.
> > > So
> > > > +it is advised for the userspace program to not to solely rely on this
> file
> > > > +to determine the actual lid state.
> > > > +
> > > > +The ACPI button driver emits 2 kinds of events to the user space:
> > > > +  SW_LID
> > > > +   When the lid state/event is reliable, the userspace can behave
> > > > +   according to this input switch event.
> > > > +   This is a mode prepared for backward compatiblity.
> > > > +  KEY_EVENT_OPEN/KEY_EVENT_CLOSE
> > > > +   When the lid state/event is not reliable, the userspace should
> behave
> > > > +   according to these 2 input key events.
> > > > +   New userspace programs may only be prepared for the input key
> > > events.
> > >
> > > No, absolutely not. If some x86 vendors managed to mess up their
> > > firmware implementations that does not mean that everyone now has
> to
> > > abandon working perfectly well for them SW_LID events and rush to
> > > switch
> > > to a brand new event.
> > [Lv Zheng]
> > However there is no clear wording in the ACPI specification asking the
> vendors to achieve paired lid events.
> >
> > >
> > > Apparently were are a few issues, main is that some systems not
> reporting
> > > "open" event. This can be dealt with by userspace "writing" to the
> > > lid's evdev device EV_SW/SW_LID/0 event upon system resume (and
> > > startup)
> > > for selected systems. This will mean that if system wakes up not
> because
> > > LID is open we'll incorrectly assume that it is, but we can either add
> > > more smarts to the process emitting SW_LID event or simply say "well,
> > > tough, the hardware is crappy" and bug vendor to see if they can fix
> the
> > > issue (if not for current firmware them for next).
> > [Lv Zheng]
> > The problem is there is no vendor actually caring about fixing this "issue".
> > Because Windows works well with their firmware.
> > Then finally becomes a big table customization business for our team.
> 
> Well, OK. But you do not expect that we will redo up and down the stack
> lid handling just because MS messed up DSDT on Surface 3? No, let them
> know (they now care about Linux, right?) so Surface 4 works and quirk
> the behavior for Surface 3.
[Lv Zheng] 
I think there are other platforms broken.

> 
> >
> > >
> > > As an additional workaround, we can toggle the LID switch off and on
> > > when we get notification, much like your proposed patch does for the
> key
> > > events.
> > [Lv Zheng]
> > I think this is doable, I'll refresh my patchset to address your this
> comment.
> > By inserting open/close events when next close/open event arrives after
> a certain period,
> > this may fix some issues for the old programs.
> > Where user may be required to open/close lid twice to trigger 2nd
> suspend.
> >
> > However, this still cannot fix the problems like "Surface 3".
> > We'll still need a new usage model for such platforms (no open event).
> 
> No, for surface 3 you simply need to add polling of "_LID" method to the
> button driver.
> 
> What are the other devices that mess up lid handling?
[Lv Zheng] 
The patch lists 3 of them.
Which are known to me because they all occurred after I started to look at the lid issues.

According to my teammates.
They've been fixing such wrong "DSDT" using customization for years.
For example, by adding _LID(); Notify(lid) into _WAK() or EC._REG().

Thanks and best regards
-Lv
