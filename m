From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: wacom: generic: add 5 tablet touch keys
Date: Wed, 4 Jan 2017 00:02:08 +0100
Message-ID: <20170103230208.GM5767@mail.corp.redhat.com>
References: <1481930680-6023-1-git-send-email-pingc@wacom.com>
 <alpine.LSU.2.20.1612191129190.19203@cbobk.fhfr.pm>
 <20161223011323.GA27969@dtor-ws>
 <20170103093055.GI5767@mail.corp.redhat.com>
 <CAF8JNh+oQcQNmubQ_ChecUM4dQ_cB5=O05hRvGtpYwTUg5JeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934590AbdACXCO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 18:02:14 -0500
Content-Disposition: inline
In-Reply-To: <CAF8JNh+oQcQNmubQ_ChecUM4dQ_cB5=O05hRvGtpYwTUg5JeRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Jan 03 2017 or thereabouts, Ping Cheng wrote:
> Hi Dmitry,
> 
> On Tue, Jan 3, 2017 at 1:30 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > On Dec 22 2016 or thereabouts, Dmitry Torokhov wrote:
> >> On Mon, Dec 19, 2016 at 11:30:13AM +0100, Jiri Kosina wrote:
> >> > On Fri, 16 Dec 2016, Ping Cheng wrote:
> >> >
> >> > > Wacom Cintiq Pro [1] is a series of display tablets. They support
> >> > > 5 touch keys on the tablet. Those keys represent specific functions.
> >> > > They turn display off; bring up OSD; bring up On Screen Keyboard;
> >> > > bring up desktop control panel; and turn touch on/off.
> >> > >
> >> > > The most left touch key, that turns display on/off, is controlled by
> >> > > firmware. When the display is on, the mode is set. Otherwise, the
> >> > > mode is off. So, it works like a switch. That's why we introduced a
> >> > > new switch: SW_INDIRECT. The switch defauts to INDIRECT instead of DIRECT
> >> > > was a request from useland, more specifically Gnome, developers.
> >> > >
> >> > > Other four touch keys are true software keys. We use the existing
> >> > > KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
> >> > > we have to request two new keys: KEY_ONSCREEN_KEYBOARD and KEY_MUTE_DEVICE
> >> > > since none of the existing keys support those two actions.
> >> > >
> >> > > [1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro
> >> > >
> >> > > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> >> > > ---
> >> > > v3: Since no one has followed up with v2, let's add some more comments for
> >> > > SW_INDIRECT so we keep the offlist decision public ;).
> >> >
> >> > [ ... snip ... ]
> >> >
> >> > > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> >> > > index d6d071f..32ef894 100644
> >> > > --- a/include/uapi/linux/input-event-codes.h
> >> > > +++ b/include/uapi/linux/input-event-codes.h
> >> > > @@ -641,6 +641,9 @@
> >> > >   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
> >> > >   */
> >> > >  #define KEY_DATA                 0x275
> >> > > +/* same as SW_MUTE_DEVICE but triggered by a key */
> >> > > +#define KEY_MUTE_DEVICE          0x278
> >> > > +#define KEY_ONSCREEN_KEYBOARD            0x279
> >> > >
> >> > >  #define BTN_TRIGGER_HAPPY                0x2c0
> >> > >  #define BTN_TRIGGER_HAPPY1               0x2c0
> >> > > @@ -781,7 +784,8 @@
> >> > >  #define SW_LINEIN_INSERT 0x0d  /* set = inserted */
> >> > >  #define SW_MUTE_DEVICE           0x0e  /* set = device disabled */
> >> > >  #define SW_PEN_INSERTED          0x0f  /* set = pen inserted */
> >> > > -#define SW_MAX                   0x0f
> >> > > +#define SW_INDIRECT              0x10  /* set = not a direct input device */
> >> > > +#define SW_MAX                   0x1f
> >> >
> >> > I'd like to have explicit Ack from Dmitry on these ... Dmitry?
> >>
> >> Sorry for the delay, but I think adding SW_INDIRECT is actually wrong.
> >>
> >> What Wacom folks seem to need is way to re-classfiy the device (i.e.
> >> update its properties) and let userspace know somehow. We can't keep
> >> adding SW_INDIRECT and SW_NOTPOINTER and SW_NOTBUTTONPAD and so forth.
> >> We however have EV_SYN/SYN_CONFIG that we may use to let userspace know
> >> that device configuration changed and that userspace needs to
> >> interrogate the device again. We can emit this code both when we change
> >> properties as well as when we change ABS limits and changing keymaps and
> >> so forth.
> 
> By "to interrogate the device again",  do you mean once we report
> EV_SYN/SYN_CONFIG, userspace needs to reinitialize the device?

Something along those lines, yes. However, there is one thing which I am
not so sure after second thoughts. Devices are tagged by udev first
before they are handed to libinput. If we request a reconfigure, it's
possible that a mouse becomes a touchpad and the udev tags will be off.

It won't be an issue in our case (direct or indirect is not a udev
prop), but I wonder if this will be an issue in the future.

> 
> If not, how do we tell userspace which feature/info has been changed?

I guess the userspace is knowledgeable enough to detect them. If the
events are somewhat rare, it doesn't matter if we redo a full init.

> 
> >>
> >> Benjamin, Peter, any opinion on the above?
> >
> > Oooh, so that's the purpose of this event :) (the documentation says
> > "TBD"). I am fine with that. We would need to adapt the documentation in
> > Documentation/input/event-codes.txt and make sure the handlers are
> > properly adapted too (*maybe* add a SYN_DROP event to empty the queue of
> > the events in userspace).
> 
> Can you update the "TBD" in Documentation/input/event-codes.txt so we
> have an agreed description to follow?

I guess that will be the result of this thread and the re-spin of the
series that makes use of SYN_CONFIG :)

Cheers,
Benjamin

> 
> Thanks,
> 
> Ping
> 
> > On the userspace tool, I guess there will be some tweaks to do in
> > libevdev and libinput, but these are basically what would need to be
> > done with the creation of the new switches.
> >
> > Thanks for the suggestion. I'll let the Wacom engineers work on the
> > kernel code now :)
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> I'm OK with the other 2 new keycodes.
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
