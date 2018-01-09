From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Tue, 9 Jan 2018 11:35:51 +1000
Message-ID: <20180109013551.GA29886@jelly>
References: <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
 <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
 <20180105162313.higyrbd6unumgtjb@dtor-ws>
 <20180107065201.q2xck62unijt3avr@dtor-ws>
 <20180108151101.GA2220@marax.lan.yath.de>
 <20180109004035.znq4alueyhds45f5@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:10314 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeAIBft (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Jan 2018 20:35:49 -0500
Content-Disposition: inline
In-Reply-To: <20180109004035.znq4alueyhds45f5@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Schmidt <yath@yath.de>, Aaron Ma <aaron.ma@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org

On Mon, Jan 08, 2018 at 04:40:35PM -0800, Dmitry Torokhov wrote:
> Hi Sebastian,
> 
> On Mon, Jan 08, 2018 at 04:11:01PM +0100, Sebastian Schmidt wrote:
> > Hi Dmitry,
> > 
> > On Sat, Jan 06, 2018 at 10:52:01PM -0800, Dmitry Torokhov wrote:
> > > Guys, could you please try the patch below? It will not solve the
> > > "speed" issue on 0x01 devices, but hopefully we won't be exposing
> > > non-existing controls on others.
> > 
> > Thanks for looking into this. Which speed issue on 0x01 devices? I
> > thought those were the legacy ones that used to work and still do as
> > ever.
> > 
> > I've tried your (slightly modified, see below) patch and the trackpoint
> > now gets apparently[1] correctly detected as "psmouse serio2:
> > trackpoint: Elan TrackPoint firmware: 0x04, buttons: 3/3". However, I
> > still have the feeling that it's a lot more sensitive (or faster?) than
> > with the regular PS/2 driver - even with libinput accel speed turned to
> > -1. I don't know how I could measure this objectively, but there must be
> > some difference between the trackpoint driver and the regular one. Is it
> > maybe an init sequence that causes it to report more sensitively, or a
> > different resolution, or ...? I really have no idea how mice work. :)
> 
> Hmm.. Can you try writing different values to "sensitivity" attribute
> and let me know if this changes behavior. Try 0x66, 0x73, 0x80, 0x8F,
> 0xA0, 0xB3, 0xC9, 0xE1, 0xFC values (smaller should be less sensitive).
> I believe we try to program it to 0x80 by default.
> 
> Also, I think libinput/udev is trying to "normalize" trackstick feel,
> see /lib/udev/hwdb.d/70-pointingstick.hwdb I am adding Peter Hutterer to
> see if he has any more info.

yeah, it is, and it also undoes the effect of the POINTINGSTICK_SENSITIVITY
udev property (for backwards compatibility we assume this always matches the
sysfs entry, we don't look at the sysfs entry directly). Having said that,
we only check that property on device plug, so if you keep messing with the
sysfs files you'll still see the various changes to the pointer speed.

in other words: messing around with the sensitivity attribute will still see
changes in pointer motion and is good enough for testing.

Cheers,
   Peter

> > Also, I'm wondering, since my trackpoint works just fine as "Generic
> > PS/2 Mouse", including the third button. The driver even says:
> > | /*
> > |  * Bare PS/2 protocol "detection". Always succeeds.
> > |  */
> > | static int ps2bare_detect(struct psmouse *psmouse, bool set_properties)
> > | {
> > | [...]
> > |         /*
> > |          * We have no way of figuring true number of buttons so let's
> > |          * assume that the device has 3.
> > |          */
> > |         __set_bit(BTN_MIDDLE, psmouse->dev->keybit);
> > |     }
> > | 
> > |     return 0;
> > | }
> > 
> > So I wonder what driver Aaron was using that didn't report a third
> > button. What vendor/firmwares did you (get reports of) have that middle
> > mouse button problem on, Aaron?
> 
> No, the functionality Aaron is after is scrolling with the trackpoint -
> if you hold middle button and press onto the trackpoint upwards or
> downwards it should scroll window content.
> 
> > 
> > Thanks,
> > 
> > Sebastian
> > 
> > 
> > 1: If it's actually Elan. I've taken out my battery but could only
> > find FRU numbers on the back of the keyboard, no signs of a vendor.
> > <https://photos.app.goo.gl/iafpfzvRY042dOBo2> or
> > <https://t.yath.de/IMG_20180108_143205.jpg>
> > 
> > In trackpoint_start_protocol:
> > > +   switch (param[0]) {
> > > +   case TP_VARIANT_IBM:
> > > +   case TP_VARIANT_ALPS:
> > > +   case TP_VARIANT_ELAN:
> > > +   case TP_VARIANT_NXP:
> > > +       if (variant_id)
> > > +           *variant_id = param[0];
> > > +       if (firmware_id)
> > > +           *firmware_id = param[1];
> > > +       break;
> >           ^^^^^
> >           That should be a return 0.
> 
> Yes, indeed.
> 
> > > +   }
> > > 
> > > -   return 0;
> > > +   return -ENODEV;
> > >  }
> 
> -- 
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
