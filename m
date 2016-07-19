From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 4/4] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Tue, 19 Jul 2016 07:17:32 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC04E39@SHSMSX101.ccr.corp.intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
 <cover.1467875142.git.lv.zheng@intel.com>
 <3f24a00df89f06661a64af6b4679a99bfff09aa7.1467875143.git.lv.zheng@intel.com>
 <CAN+gG=G5p6ztJODQBBAF7MY0kBNGVpexY-+a8RQY9JKuY1AB1Q@mail.gmail.com>
 <20160708175146.GA28589@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160708175146.GA28589@dtor-ws>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi, Dmitry

> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Subject: Re: [PATCH v2 4/4] ACPI / button: Add document for ACPI control
> method lid device restrictions
> 
> On Fri, Jul 08, 2016 at 11:17:39AM +0200, Benjamin Tissoires wrote:
> > Hi,
> >
> > On Thu, Jul 7, 2016 at 9:11 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> > > There are many AML tables reporting wrong initial lid state, and some
> of
> > > them never reports lid state. As a proxy layer acting between, ACPI
> button
> > > driver is not able to handle all such cases, but need to re-define the
> > > usage model of the ACPI lid. That is:
> > > 1. It's initial state is not reliable;
> > > 2. There may not be open event;
> > > 3. Userspace should only take action against the close event which is
> > >    reliable, always sent after a real lid close.
> > > This patch adds documentation of the usage model.
> > >
> > > Link: https://lkml.org/2016/3/7/460
> > > Link: https://github.com/systemd/systemd/issues/2087
> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > Cc: Bastien Nocera: <hadess@hadess.net>
> > > Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > ---
> > >  Documentation/acpi/acpi-lid.txt |   62
> +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >  create mode 100644 Documentation/acpi/acpi-lid.txt
> > >
> > > diff --git a/Documentation/acpi/acpi-lid.txt
> b/Documentation/acpi/acpi-lid.txt
> > > new file mode 100644
> > > index 0000000..7e4f7ed
> > > --- /dev/null
> > > +++ b/Documentation/acpi/acpi-lid.txt
> > > @@ -0,0 +1,62 @@
> > > +Usage Model of the ACPI Control Method Lid Device
> > > +
> > > +Copyright (C) 2016, Intel Corporation
> > > +Author: Lv Zheng <lv.zheng@intel.com>
> > > +
> > > +
> > > +Abstract:
> > > +
> > > +Platforms containing lids convey lid state (open/close) to OSPMs
> using a
> > > +control method lid device. To implement this, the AML tables issue
> > > +Notify(lid_device, 0x80) to notify the OSPMs whenever the lid state
> has
> > > +changed. The _LID control method for the lid device must be
> implemented to
> > > +report the "current" state of the lid as either "opened" or "closed".
> > > +
> > > +This document describes the restrictions and the expections of the
> Linux
> > > +ACPI lid device driver.
> > > +
> > > +
> > > +1. Restrictions of the returning value of the _LID control method
> > > +
> > > +The _LID control method is described to return the "current" lid state.
> > > +However the word of "current" has ambiguity, many AML tables
> return the lid
> > > +state upon the last lid notification instead of returning the lid state
> > > +upon the last _LID evaluation. There won't be difference when the
> _LID
> > > +control method is evaluated during the runtime, the problem is its
> initial
> > > +returning value. When the AML tables implement this control method
> with
> > > +cached value, the initial returning value is likely not reliable. There are
> > > +simply so many examples always retuning "closed" as initial lid state.
> > > +
> > > +2. Restrictions of the lid state change notifications
> > > +
> > > +There are many AML tables never notifying when the lid device state
> is
> > > +changed to "opened". But it is ensured that the AML tables always
> notify
> > > +"closed" when the lid state is changed to "closed". This is normally
> used
> > > +to trigger some system power saving operations on Windows. Since it
> is
> > > +fully tested, this notification is reliable for all AML tables.
> > > +
> > > +3. Expections for the userspace users of the ACPI lid device driver
> > > +
> > > +The userspace programs should stop relying on
> > > +/proc/acpi/button/lid/LID0/state to obtain the lid state. This file is
> only
> > > +used for the validation purpose.
> >
> > I'd say: this file actually calls the _LID method described above. And
> > given the previous explanation, it is not reliable enough on some
> > platforms. So it is strongly advised for user-space program to not
> > solely rely on this file to determine the actual lid state.
> >
> > > +
> > > +New userspace programs should rely on the lid "closed" notification
> to
> > > +trigger some power saving operations and may stop taking actions
> according
> > > +to the lid "opened" notification. A new input switch event -
> SW_ACPI_LID is
> > > +prepared for the new userspace to implement this ACPI control
> method lid
> > > +device specific logics.
> >
> > That's not entirely what we discussed before (to prevent regressions):
> > - if the device doesn't have reliable LID switch state, then there
> > would be the new input event, and so userspace should only rely on
> > opened notifications.
> > - if the device has reliable switch information, the new input event
> > should not be exported and userspace knows that the current input
> > switch event is reliable.
> >
> > Also, using a new "switch" event is a terrible idea. Switches have a
> > state (open/close) and you are using this to forward a single open
> > event. So using a switch just allows you to say to userspace you are
> > using the "new" LID meaning, but you'll still have to manually reset
> > the switch and you will have to document how this event is not a
> > switch.
> >
> > Please use a simple KEY_LID_OPEN event you will send through
> > [input_key_event(KEY_LID_OPEN, 1), input_sync(),
> > input_key_event(KEY_LID_OPEN, 0), input_sync()], which userspace
> knows
> > how to handle.
> >
> > > +
> > > +During the period the userspace hasn't been switched to use the new
> > > +SW_ACPI_LID event, Linux users can use the following boot parameter
> to
> > > +handle possible issues:
> > > +  button.lid_init_state=method:
> > > +   This is the default behavior of the Linux ACPI lid driver, Linux kernel
> > > +   reports the initial lid state using the returning value of the _LID
> > > +   control method.
> > > +   This can be used to fix some platforms if the _LID control method's
> > > +   returning value is reliable.
> > > +  button.lid_init_state=open:
> > > +   Linux kernel always reports the initial lid state as "opened".
> > > +   This may fix some platforms if the returning value of the _LID
> control
> > > +   method is not reliable.
> >
> > This worries me as there is no plan after "During the period the
> > userspace hasn't been switched to use the new event".
> >
> > I really hope you'll keep sending SW_LID for reliable LID platforms,
> > and not remove it entirely as you will break platforms.
> 
> How about we leave the kernel alone and userspace (which would have to
> cope with the new KEY_LID_OPEN anyway) would just have to know that if
> switch's parent is PNP0C0D:00 (or phys is PNP0C0D/button/input0) then
> it
> can't trust the events and it needs additional heuristics.

[Lv Zheng] 
I found a problem with the key event approach.
And need your suggestions.

Some AML tables invoke Notify(lid_device, ...) in several different places.
It may be invoked from different functions.

Finally, it's not guaranteed that one "lid close" action can only trigger one key close notification.
If we use EV_KEY, then there should be many platforms triggering multiple "lid close" events to the user space.

Original switch event based design can automatically eliminate the redundant events.

Does input layer has an event type that can handle such situation?
Or shall ACPI button driver handle this?

Thanks,
-Lv
