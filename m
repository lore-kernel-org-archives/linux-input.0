From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Sun, 20 Dec 2009 23:59:07 -0800
Message-ID: <20091221075907.GE3234@core.coreip.homeip.net>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de> <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz> <20091218175046.GB23450@core.coreip.homeip.net> <4B2D6377.1020703@physik.uni-muenchen.de> <20091221074419.GD3234@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47548 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbZLUH7N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Dec 2009 02:59:13 -0500
Received: by pwj9 with SMTP id 9so3032431pwj.21
        for <linux-input@vger.kernel.org>; Sun, 20 Dec 2009 23:59:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091221074419.GD3234@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
> On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
> > Hi,
> > 
> > It seems that the force feedback works well, I have ported the force
> > feedback for my favorite game to linux now, and it works well.
> > 
> > What does not work is updating effects - there just nothing happens, and
> > the old event is played. I have circumvented this by
> > deleting/re-uploading the effect, but this should probably been made to
> > work. Does it work well with other hardware?
> > 
> > Thirdly, I have re-discovered one kernel oops that occurs if the
> > joystick is unplugged if some process still has the event device open.
> > Steps to reproduce:
> > * plug joystick in
> > * fftest /dev/input/eventXX
> > * unplug joystick
> > 
> > (kern.log extract attached)
> > 
> > Sometimes this just gives an oops, sometimes it escalates into a kernel
> > panic.
> > 
> 
> Hmm, it looks like iforce unbinding is completely busted:
> 
> static void iforce_usb_disconnect(struct usb_interface *intf)
> {
>         struct iforce *iforce = usb_get_intfdata(intf);
>         int open = 0; /* FIXME! iforce->dev.handle->open; */
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>         usb_set_intfdata(intf, NULL);
>         if (iforce) {
>                 iforce->usbdev = NULL;
>                 input_unregister_device(iforce->dev);
> 
>                 if (!open) {
>                         iforce_delete_device(iforce);
>                         kfree(iforce);
>                 }
>         }
> }
> 
> 
> Any chance you could fix that FIXME ;) ?
> 

BTW, could I get you "Signed-off-by: ... " for the Cyborg patch so that
I can apply it to my tree?

Thanks.

-- 
Dmitry
