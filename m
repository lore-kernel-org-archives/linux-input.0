From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: wacom: generic: add 5 tablet touch keys
Date: Tue, 3 Jan 2017 10:30:55 +0100
Message-ID: <20170103093055.GI5767@mail.corp.redhat.com>
References: <1481930680-6023-1-git-send-email-pingc@wacom.com>
 <alpine.LSU.2.20.1612191129190.19203@cbobk.fhfr.pm>
 <20161223011323.GA27969@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752671AbdACJbB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 04:31:01 -0500
Content-Disposition: inline
In-Reply-To: <20161223011323.GA27969@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, jason.gerecke@wacom.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>, peter.hutterer@who-t.net

On Dec 22 2016 or thereabouts, Dmitry Torokhov wrote:
> On Mon, Dec 19, 2016 at 11:30:13AM +0100, Jiri Kosina wrote:
> > On Fri, 16 Dec 2016, Ping Cheng wrote:
> > 
> > > Wacom Cintiq Pro [1] is a series of display tablets. They support
> > > 5 touch keys on the tablet. Those keys represent specific functions.
> > > They turn display off; bring up OSD; bring up On Screen Keyboard;
> > > bring up desktop control panel; and turn touch on/off.
> > > 
> > > The most left touch key, that turns display on/off, is controlled by
> > > firmware. When the display is on, the mode is set. Otherwise, the
> > > mode is off. So, it works like a switch. That's why we introduced a
> > > new switch: SW_INDIRECT. The switch defauts to INDIRECT instead of DIRECT
> > > was a request from useland, more specifically Gnome, developers.
> > > 
> > > Other four touch keys are true software keys. We use the existing
> > > KEY_BUTTONCONFIG and KEY_CONTROLPANEL for OSD and control panel. But,
> > > we have to request two new keys: KEY_ONSCREEN_KEYBOARD and KEY_MUTE_DEVICE
> > > since none of the existing keys support those two actions.
> > > 
> > > [1] http://www.wacom.com/en-us/products/pen-displays/wacom-cintiq-pro
> > > 
> > > Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> > > ---
> > > v3: Since no one has followed up with v2, let's add some more comments for
> > > SW_INDIRECT so we keep the offlist decision public ;).
> > 
> > [ ... snip ... ]
> > 
> > > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > > index d6d071f..32ef894 100644
> > > --- a/include/uapi/linux/input-event-codes.h
> > > +++ b/include/uapi/linux/input-event-codes.h
> > > @@ -641,6 +641,9 @@
> > >   * e.g. teletext or data broadcast application (MHEG, MHP, HbbTV, etc.)
> > >   */
> > >  #define KEY_DATA			0x275
> > > +/* same as SW_MUTE_DEVICE but triggered by a key */
> > > +#define KEY_MUTE_DEVICE 		0x278
> > > +#define KEY_ONSCREEN_KEYBOARD		0x279
> > >  
> > >  #define BTN_TRIGGER_HAPPY		0x2c0
> > >  #define BTN_TRIGGER_HAPPY1		0x2c0
> > > @@ -781,7 +784,8 @@
> > >  #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
> > >  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
> > >  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
> > > -#define SW_MAX			0x0f
> > > +#define SW_INDIRECT		0x10  /* set = not a direct input device */
> > > +#define SW_MAX			0x1f
> > 
> > I'd like to have explicit Ack from Dmitry on these ... Dmitry?
> 
> Sorry for the delay, but I think adding SW_INDIRECT is actually wrong.
> 
> What Wacom folks seem to need is way to re-classfiy the device (i.e.
> update its properties) and let userspace know somehow. We can't keep
> adding SW_INDIRECT and SW_NOTPOINTER and SW_NOTBUTTONPAD and so forth.
> We however have EV_SYN/SYN_CONFIG that we may use to let userspace know
> that device configuration changed and that userspace needs to
> interrogate the device again. We can emit this code both when we change
> properties as well as when we change ABS limits and changing keymaps and
> so forth.
> 
> Benjamin, Peter, any opinion on the above?

Oooh, so that's the purpose of this event :) (the documentation says
"TBD"). I am fine with that. We would need to adapt the documentation in
Documentation/input/event-codes.txt and make sure the handlers are
properly adapted too (*maybe* add a SYN_DROP event to empty the queue of
the events in userspace).

On the userspace tool, I guess there will be some tweaks to do in
libevdev and libinput, but these are basically what would need to be
done with the creation of the new switches.

Thanks for the suggestion. I'll let the Wacom engineers work on the
kernel code now :)

Cheers,
Benjamin

> 
> I'm OK with the other 2 new keycodes.
> 
> Thanks.
> 
> -- 
> Dmitry
