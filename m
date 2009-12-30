From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Wed, 30 Dec 2009 02:47:45 -0800
Message-ID: <20091230104744.GB2214@core.coreip.homeip.net>
References: <4B2ABC62.2030600@physik.uni-muenchen.de>
 <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz>
 <20091218175046.GB23450@core.coreip.homeip.net>
 <4B2D6377.1020703@physik.uni-muenchen.de>
 <20091221074419.GD3234@core.coreip.homeip.net>
 <20091221082259.GG3234@core.coreip.homeip.net>
 <4B39FA1D.6070107@physik.uni-muenchen.de>
 <1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com>
 <20091230032326.GC7049@core.coreip.homeip.net>
 <4B3B16CD.1050700@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:40656 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZL3Kru (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2009 05:47:50 -0500
Received: by pxi27 with SMTP id 27so6776416pxi.4
        for <linux-input@vger.kernel.org>; Wed, 30 Dec 2009 02:47:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B3B16CD.1050700@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Dec 30, 2009 at 10:01:01AM +0100, Johannes Ebke wrote:
> Dmitry Torokhov wrote:
> > On Tue, Dec 29, 2009 at 02:40:21PM -0800, Dmitry Torokhov wrote:
> >>  Dec 29, 2009, at 4:46 AM, Johannes Ebke
> >> <johannes.ebke@physik.uni-muenchen.de> wrote:
> >>
> >>> Dmitry Torokhov wrote:
> >>>> On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
> >>>>> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> It seems that the force feedback works well, I have ported
> >>>>>> the force
> >>>>>> feedback for my favorite game to linux now, and it works well.
> >>>>>>
> >>>>>> What does not work is updating effects - there just nothing
> >>>>>> happens, and
> >>>>>> the old event is played. I have circumvented this by
> >>>>>> deleting/re-uploading the effect, but this should probably
> >>>>>> been made to
> >>>>>> work. Does it work well with other hardware?
> >>>>>>
> >>>>>> Thirdly, I have re-discovered one kernel oops that occurs if the
> >>>>>> joystick is unplugged if some process still has the event
> >>>>>> device open.
> >>>>>> Steps to reproduce:
> >>>>>> * plug joystick in
> >>>>>> * fftest /dev/input/eventXX
> >>>>>> * unplug joystick
> >>>>>>
> >>>>>> (kern.log extract attached)
> >>>>>>
> >>>>>> Sometimes this just gives an oops, sometimes it escalates
> >>>>>> into a kernel
> >>>>>> panic.
> >>>>>>
> >>>>> Hmm, it looks like iforce unbinding is completely busted:
> >>>>>
> >>>>> static void iforce_usb_disconnect(struct usb_interface *intf)
> >>>>> {
> >>>>>       struct iforce *iforce = usb_get_intfdata(intf);
> >>>>>       int open = 0; /* FIXME! iforce->dev.handle->open; */
> >>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>>>
> >>>>>       usb_set_intfdata(intf, NULL);
> >>>>>       if (iforce) {
> >>>>>               iforce->usbdev = NULL;
> >>>>>               input_unregister_device(iforce->dev);
> >>>>>
> >>>>>               if (!open) {
> >>>>>                       iforce_delete_device(iforce);
> >>>>>                       kfree(iforce);
> >>>>>               }
> >>>>>       }
> >>>>> }
> >>>>>
> >>>>>
> >>>>> Any chance you could fix that FIXME ;) ?
> >>>>>
> >>>> Actually, does the below fixes it for you?
> >>>>
> >>> This fixes the kernel oops - thanks! However it also disables FF,
> >>> unless
> >>> I remove "usb_kill_urb(iforce->out);" from iforce_close.
> >> >From some debug statements I found that iforce_close is called
> >>> twice if
> >>> you just plug in the joystick, so the effect is immediate.
> >> I still believe that usb_kill_urb is needed however we need to wait
> >> for packet disabling FF to complete.
> >>
> > 
> > Does the patch below (on top of the unmodofied previous one) fixes the
> > issue for you?
> > 
> > Thanks.
> > 
> 
> This fixes it completely, both the FF and the clean shutdown on
> unexpected disconnect! Thank you very much!

Ah, great!
 
> Finally, for correct orientation of the rudder axis, I have attached one
> small change to packets - this makes it work for me if i remove the old
> configuration.

Hmm, that might break some other users though (or does it only kick in
for Cyborg?

> 
> One other question: Since the USB HID driver can actually discover the
> joystick buttons and axis ranges sucessfully, would it not be easier to
> use that for generic input and only add force-feedback in iforce, or is
> that just too much overhead?

We do prefer to have HID driver handle the devices and have only
non-HID-compliant devices use specialized drivers. Iforce is an older
driver though, working with both USB devices and devices attached to
serial ports.

Does your joystick works well with HID driver (sans FF)?

-- 
Dmitry
