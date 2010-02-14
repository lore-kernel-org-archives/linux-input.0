From: Ed Tomlinson <edt-Yad3+ZauZac@public.gmane.org>
Subject: Re: [PATCH 0/2] Provide a driver for the Apple Magic Mouse - opps
Date: Sun, 14 Feb 2010 09:22:41 -0500
Message-ID: <201002140922.42014.edt@aei.ca>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz> <201002131429.29671.edt@aei.ca> <20100214080344.GA4423@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100214080344.GA4423-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sunday 14 February 2010 03:03:44 Dmitry Torokhov wrote:
> On Sat, Feb 13, 2010 at 02:29:29PM -0500, Ed Tomlinson wrote:
> > On Wednesday 10 February 2010 08:57:37 Jiri Kosina wrote:
> > > On Tue, 9 Feb 2010, Michael Poole wrote:
> > > 
> > > > I think this patch is ready for real review.  The Magic Mouse requires
> > > > that a driver send an unlock Report(Feature) command, similar to the
> > > > Wacom wireless tablet and Sixaxis controller quirks.  This turns on an
> > > > Input Report that isn't published in the input Report descriptor that
> > > > contains touch data (and usually overrides the normal motion and click
> > > > Report).
> > > > 
> > > > Because the mouse has only one switch and no scroll wheel, the driver
> > > > (under control of parameters) emulates a middle button and scroll wheel.
> > > > User space could also ignore and/or re-synthesize those events based on
> > > > the reported events.
> > > > 
> > > > The first patch exports hid_register_report() so the driver can turn on
> > > > the multitouch report.  The second patch adds the device ID and the
> > > > driver.  Some user-space tools to talk to the mouse directly (that is,
> > > > when it is not associated with the host's HIDP stack) are at
> > > > http://github.com/entrope/linux-magicmouse .
> > > 
> > > I have applied the driver into apple_magic_mouse branch and merged this 
> > > branch into for-next, so it should appear in the upcoming linux-next.
> > 
> 
> > This driver (or the hid changes) can triggers an opps.  What I did was
> > start X.  Turn on the magic mouse.  It connected on input7&8.  Then I
> > powered it off and on.  This time it conneced on input9&10.  Then I
> > exited X and got the opps.  Note my X does not hotplug the magic
> > mouse.  I've also included a trace of the udev events that generated
> > the log below (if there was a remove after X stopped it would not be
> > included).  To my eyes it looks like we leak an input device (there is
> > not a remove event for input8).
> >
> 
> Indeed, we seem to be missing call to input_unregister_device() in
> magicmouse_remove().

How does this look?  With this udevadm shows input8 being removed and
there is no more opps.

----
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f94b3e4..71a8669 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -429,8 +429,11 @@ static int magicmouse_probe(struct hid_device *hdev,
 
 static void magicmouse_remove(struct hid_device *hdev)
 {
+	struct magicmouse_sc *msc;
+	msc = hid_get_drvdata(hdev);
+	input_unregister_device(msc->input);
 	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
+	kfree(msc);
 }
 
 static const struct hid_device_id magic_mice[] = {
----

Thanks
Ed
