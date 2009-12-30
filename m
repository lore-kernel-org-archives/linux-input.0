From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Tue, 29 Dec 2009 19:23:27 -0800
Message-ID: <20091230032326.GC7049@core.coreip.homeip.net>
References: <4B26B824.8010403@physik.uni-muenchen.de>
 <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz>
 <4B2ABC62.2030600@physik.uni-muenchen.de>
 <alpine.LNX.2.00.0912181150240.3755@pobox.suse.cz>
 <20091218175046.GB23450@core.coreip.homeip.net>
 <4B2D6377.1020703@physik.uni-muenchen.de>
 <20091221074419.GD3234@core.coreip.homeip.net>
 <20091221082259.GG3234@core.coreip.homeip.net>
 <4B39FA1D.6070107@physik.uni-muenchen.de>
 <1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:36757 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbZL3DXc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Dec 2009 22:23:32 -0500
Received: by pwj9 with SMTP id 9so7124483pwj.21
        for <linux-input@vger.kernel.org>; Tue, 29 Dec 2009 19:23:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1AD572D6-2C2F-4664-9B52-36A8D1BE8B29@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Dec 29, 2009 at 02:40:21PM -0800, Dmitry Torokhov wrote:
>  Dec 29, 2009, at 4:46 AM, Johannes Ebke
> <johannes.ebke@physik.uni-muenchen.de> wrote:
> 
> >Dmitry Torokhov wrote:
> >>On Sun, Dec 20, 2009 at 11:44:19PM -0800, Dmitry Torokhov wrote:
> >>>On Sun, Dec 20, 2009 at 12:36:23AM +0100, Johannes Ebke wrote:
> >>>>Hi,
> >>>>
> >>>>It seems that the force feedback works well, I have ported
> >>>>the force
> >>>>feedback for my favorite game to linux now, and it works well.
> >>>>
> >>>>What does not work is updating effects - there just nothing
> >>>>happens, and
> >>>>the old event is played. I have circumvented this by
> >>>>deleting/re-uploading the effect, but this should probably
> >>>>been made to
> >>>>work. Does it work well with other hardware?
> >>>>
> >>>>Thirdly, I have re-discovered one kernel oops that occurs if the
> >>>>joystick is unplugged if some process still has the event
> >>>>device open.
> >>>>Steps to reproduce:
> >>>>* plug joystick in
> >>>>* fftest /dev/input/eventXX
> >>>>* unplug joystick
> >>>>
> >>>>(kern.log extract attached)
> >>>>
> >>>>Sometimes this just gives an oops, sometimes it escalates
> >>>>into a kernel
> >>>>panic.
> >>>>
> >>>Hmm, it looks like iforce unbinding is completely busted:
> >>>
> >>>static void iforce_usb_disconnect(struct usb_interface *intf)
> >>>{
> >>>       struct iforce *iforce = usb_get_intfdata(intf);
> >>>       int open = 0; /* FIXME! iforce->dev.handle->open; */
> >>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>
> >>>       usb_set_intfdata(intf, NULL);
> >>>       if (iforce) {
> >>>               iforce->usbdev = NULL;
> >>>               input_unregister_device(iforce->dev);
> >>>
> >>>               if (!open) {
> >>>                       iforce_delete_device(iforce);
> >>>                       kfree(iforce);
> >>>               }
> >>>       }
> >>>}
> >>>
> >>>
> >>>Any chance you could fix that FIXME ;) ?
> >>>
> >>
> >>Actually, does the below fixes it for you?
> >>
> >
> >This fixes the kernel oops - thanks! However it also disables FF,
> >unless
> >I remove "usb_kill_urb(iforce->out);" from iforce_close.
> >From some debug statements I found that iforce_close is called
> >twice if
> >you just plug in the joystick, so the effect is immediate.
> 
> I still believe that usb_kill_urb is needed however we need to wait
> for packet disabling FF to complete.
> 

Does the patch below (on top of the unmodofied previous one) fixes the
issue for you?

Thanks.

-- 
Dmitry


Input: iforce - wait for command completion when closing the device

We need to wait for the command to disable FF effects to complete before
continuing with closing the device.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/iforce/iforce-main.c |    3 +++
 drivers/input/joystick/iforce/iforce-usb.c  |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index acc3a9e..b1edd77 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -228,6 +228,9 @@ static void iforce_close(struct input_dev *dev)
 
 		/* Disable force feedback playback */
 		iforce_send_packet(iforce, FF_CMD_ENABLE, "\001");
+		/* Wait for the command to complete */
+		wait_event_interruptible(iforce->wait,
+			!test_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags));
 	}
 
 	switch (iforce->bus) {
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index c0ad883..b41303d 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -109,6 +109,7 @@ static void iforce_usb_out(struct urb *urb)
 	struct iforce *iforce = urb->context;
 
 	if (urb->status) {
+		clear_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags);
 		dbg("urb->status %d, exiting", urb->status);
 		return;
 	}

