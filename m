From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v3] HID: wacom: generic: add 5 tablet touch keys
Date: Wed, 4 Jan 2017 09:29:07 +1000
Message-ID: <20170103232907.GA23789@jelly>
References: <1481930680-6023-1-git-send-email-pingc@wacom.com>
 <alpine.LSU.2.20.1612191129190.19203@cbobk.fhfr.pm>
 <20161223011323.GA27969@dtor-ws>
 <20170103093055.GI5767@mail.corp.redhat.com>
 <CAF8JNh+oQcQNmubQ_ChecUM4dQ_cB5=O05hRvGtpYwTUg5JeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:57965 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdACX3T (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2017 18:29:19 -0500
Content-Disposition: inline
In-Reply-To: <CAF8JNh+oQcQNmubQ_ChecUM4dQ_cB5=O05hRvGtpYwTUg5JeRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, Jan 03, 2017 at 02:33:36PM -0800, Ping Cheng wrote:
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
> 
> If not, how do we tell userspace which feature/info has been changed?
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

Here's a first attempt:

 * SYN_CONFIG:
   - Used to indicate that the device's static description has changed. This
     can happen when
     - at least one event type or code has been added or removed, or
     - at least one device property has been added or removed, or
     - at least one absolute axis has changed properties, or
     - the keycode has changed, or
     - the name, id, phys or unique identifier of the device has changed,
     A client should re-query the device once a SYN_CONFIG has been received
     as if the device was newly added. SYN_CONFIG does not indicate which
     information changed, a client is required to re-read the full 
     state. A SYN_CONFIG may be triggered even by types/codes/... that the
     client is not aware of, i.e. the state before and after may look
     identical to any given client.
     Dynamic values such as key state, switch state, absolute axis value,
     force feedback, etc. do not trigger a SYN_CONFIG. A SYN_CONFIG may
     trigger a SYN_DROPPED to terminate ongoing event sequences.

We should also add a blurb to the EVIOC*MASK ioctls about SYN_CONFIG.

Cheers,
   Peter


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
