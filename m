From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Tue, 9 Jan 2018 11:51:35 +1000
Message-ID: <20180109015135.GB29886@jelly>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com>
 <1483370825.2420.8.camel@hadess.net>
 <201701021809.58943@pali>
 <1483442481.2420.12.camel@hadess.net>
 <60c21c4d-bb81-342a-45e1-7e92313e05d7@gmail.com>
 <1483540655.2420.18.camel@hadess.net>
 <20170105124808.GF31083@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:48833 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932901AbeAIBvm (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Jan 2018 20:51:42 -0500
Content-Disposition: inline
In-Reply-To: <20170105124808.GF31083@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 05, 2017 at 01:48:08PM +0100, Pali Rohár wrote:
> On Wednesday 04 January 2017 15:37:35 Bastien Nocera wrote:
> > On Wed, 2017-01-04 at 09:43 +0200, Ivaylo Dimitrov wrote:
> > > 
> > > On  3.01.2017 13:21, Bastien Nocera wrote:
> > > > On Mon, 2017-01-02 at 18:09 +0100, Pali Rohár wrote:
> > > > > On Monday 02 January 2017 16:27:05 Bastien Nocera wrote:
> > > > > > On Sun, 2016-12-25 at 11:04 +0100, Pali Rohár wrote:
> > > > > > > This patch allows user to disable events from any input
> > > > > > > device so
> > > > > > > events
> > > > > > > would not be delivered to userspace.
> > > > > > > 
> > > > > > > Currently there is no way to disable particular input device
> > > > > > > by
> > > > > > > kernel.
> > > > > > > User for different reasons would need it for integrated PS/2
> > > > > > > keyboard or
> > > > > > > touchpad in notebook or touchscreen on mobile device to
> > > > > > > prevent
> > > > > > > sending
> > > > > > > events. E.g. mobile phone in pocket or broken integrated PS/2
> > > > > > > keyboard.
> > > > > > > 
> > > > > > > This is just a RFC patch, not tested yet. Original post about
> > > > > > > motivation
> > > > > > > about this patch is there: https://lkml.org/lkml/2014/11/29/9
> > > > > > > 2
> > > > > > 
> > > > > > Having implemented something of that ilk in user-space (we
> > > > > > automatically disable touch devices when the associated screen
> > > > > > is
> > > > > > turned off/suspended), I think this might need more thought.
> > > > > 
> > > > > How to implement such thing in userspace? I think you cannot do
> > > > > that
> > > > > without rewriting every one userspace application which uses
> > > > > input.
> > > > > 
> > > > > > What happens when a device is opened and the device disabled
> > > > > 
> > > > > through
> > > > > > sysfs, are the users revoked?
> > > > > 
> > > > > Applications will not receive events. Same as if input device
> > > > > does
> > > > > not
> > > > > generates events.
> > > > > 
> > > > > > Does this put the device in suspend in the same way that
> > > > > > closing
> > > > > 
> > > > > the
> > > > > > device's last user does?
> > > > > 
> > > > > Current code not (this is just RFC prototype), but it should be
> > > > > possible
> > > > > to implement.
> > > > > 
> > > > > > Is this not better implemented in user-space at the session
> > > > > > level,
> > > > > > where it knows about which output corresponds to which input
> > > > > 
> > > > > device?
> > > > > 
> > > > > How to do that without rewriting existing applications?
> > > > > 
> > > > > > Is this useful enough to disable misbehaving devices on
> > > > > > hardware,
> > > > > 
> > > > > so
> > > > > > that the device is not effective on boot?
> > > > > 
> > > > > In case integrated device is absolutely unusable and generates
> > > > > always
> > > > > random events, it does not solve problem at boot time.
> > > > > 
> > > > > But more real case is laptop with closed LID press buttons and
> > > > > here
> > > > > it
> > > > > is useful.
> > > > 
> > > > There's usually a display manager in between the application and
> > > > the
> > > > input device. Whether it's X.org, or a Wayland compositor. Even
> > > > David's
> > > >  https://github.com/dvdhrm/kmscon could help for console
> > > > applications.
> > > > 
> > > 
> > > I think the use cases are not clearly explained, will try to:
> > > 
> > > 1. Imagine you have a mobile phone, with a touchscreen, a slide 
> > > keyboard, a keyboard-slide sensor, a proximity sensor and a couple of 
> > > GPIOs, set-up as gpio keys. And you want to carry that phone in your 
> > > pocket, without being worried that it will pick-up an incoming call by 
> > > itself while in the pocket, so:
> > > 
> > > - slide keyboard is closed, you "lock" the phone before put it in your 
> > > pocket - in that state, touchscreen and most of the gpio-keys should be 
> > > "disabled", so no touches are registered waking-up the device without need.
> > > - a call comes, proximity gets "enabled", but TS should stay disabled as 
> > > proximity detects "the phone is in a pocket"
> > > - you get your phone out of your pocket - proximity detects no more 
> > > obstacles, so now TS has to be enabled giving you a chance to pick up 
> > > the incoming call.
> > > 
> > > "disabling" of gpio-keys is clear, but how to make TS and proximity 
> > > inactive when needed? Sure, touches can be simply ignored (by using 
> > > xinput "Device Enabled" 0 on x11), same for proximity, but keep in mind 
> > > this is a battery-operated device, so we don't want CPU wake-ups with no 
> > > need.
> > 
> > I'm pretty certain that the libinput or evdev Xorg drivers would close
> > the underlying device so that it can go into power save.
> 
> When they close evdev device? At least I need to explicitly call xinput.

yeah, because setting that property is the way to tell X that we don't need
to listen for events on that device. so we close the fd. libinput has the
"send events" API which does the same in most cases.

the only other way to tell X that you don't care about events from devices
is to VT-switch away, then we also close all fds.

Cheers,
   Peter

> And Xorg and libinput are not only applications/libraries which uses
> linux evdev. There are more...
> 
> E.g. in case of N900 there is mce which is not doing it.
> 
> > FWIW, your example is incomplete, as you'd probably want the
> > touchscreen to be usable even if the keyboard is folded in by pressing
> > the power button, and using the touchscreen only.
> 
> Maybe with combination of ambient light sensor for detection if phone is
> in pocket or not...
> 
> > > 2. The same device, "locked", but this time with slide keyboard opened:
> > > 
> > > - both keyboard and TS should be "disabled" so no touches neither key 
> > > presses wake-up the system. Only the power-button (or some other, 
> > > doesn't matter) should be enabled to activate the device.
> > 
> > Which is what disabling the device in Xorg should do.
> 
> You are expecting here that only Xorg is used... which does not have to
> be truth (and in more cases really is not).
> 
> > > There are more use-cases similar to the above as well as use-cases for 
> > > laptops, but I hope you're getting the idea.
> > > 
> > > Also, the interface to "disable" an input devices should be independent 
> > > to whether you use X11, wayland or your application draws directly to 
> > > the framebuffer.
> > 
> > I implemented behaviour similar to those at the session level, using D-
> > Bus to gather data from the various sensors and peripherals. In
> > addition, it also knows about the state of the display, which you
> > wouldn't have available at another level. This also means that it works
> > as expected for multi-user setups (which I understand isn't your
> > concern).
> > 
> > I don't doubt that the use cases should be catered for, I essentially
> > did that same work without kernel changes for GNOME. What I doubt is
> > the fuzzy semantics, the fact that the device is kept opened but no
> > data is sent (that's not power saving), that whether users are revoked
> > or should be revoked isn't clear, and that the goal is basically to
> > work around stupid input handling when at the console. When running a
> > display manager, this is all avoided.
> > 
> > If this were to go through, then the semantics and behaviour needs to
> > be better explained, power saving actually made possible, and make sure
> > that libinput can proxy that state to the users on the console. Or an
> > ioctl added to the evdev device to disable them.
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
