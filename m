From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Sun, 10 Sep 2017 11:06:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709101005410.718-100000@netrider.rowland.org>
References: <VI1PR0301MB251079237AC8705611FF8B5B876A0@VI1PR0301MB2510.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <VI1PR0301MB251079237AC8705611FF8B5B876A0-RmfN0l+Fl7AS7HWB96JEtciOivS/YiWQnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Simms <micsim2007-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Cc: Mike Simms <micsim2007-PkbjNfxxIAQqdlJmJB21zg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org " <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org " <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, 9 Sep 2017, Mike Simms wrote:

> > Did you do this?
> > 
> > Alan Stern
> 
> Yes, the information was already in the message quoted in your reply:
> 
> > > 4.11.11-300.fc26.x86_64 and 4.12.9-300.fc26.x86_64 
> > >  are showing identical settings - autosuspend definitely on for 
> > > device /sys/bus/usb/devices/2-1.3/2-1.3:1.0/0003:046D:C52B.0001/power 

This is not what I asked you to do.  I asked you to check the contents 
of /sys/bus/usb/devices/2-1.3/2-1.3:1.0/power.  Not
/sys/bus/usb/devices/2-1.3/2-1.3:1.0/0003:046D:C52B.0001/power.

> > > it shows in the powertop UI as good for both kernels and 
> > > 
> > > Folder contents are autosuspend_delay_ms (can't open), control
> > > (auto), runtime_active_time (0), runtime_status (unsupported), 
> 
> Frustratingly I can't CC the linux-usb or linux-input mailing lists, my
> emails are rejected as spam otherwise it would be a heck of a lot
> easier to share all this information with you. You are in my reply
> to all list, so you should get any further communications with Jiri too.

The mailing lists reject email in HTML format, but that's not the case
here.  Maybe there's something about outlook.com they don't like.  You
could try signing up for a gmail account and sending from it.

> Did you get the last email containing usbmon traces? You should have but
> please check your spam or junk folder just in case.

I did get it.  Nothing unusual jumped out.  The trace showed that when 
you started using the trackball again after it had been suspended, the 
wake-up procedure took a little under 0.1 seconds.  That's long enough 
to be perceptible, and it's understandable that the delay could be 
annoying.

(Incidentally, the output format is more condensed if instead of
running the usbmon program, you do:

	sudo cat /sys/kernel/debug/usb/usbmon/2u >/tmp/mon.out

or the equivalent.)

When you collected the data for the /dev/bus/.../power files, was that
while the trackball was active or while it was suspended?  The default
setting is to suspend it after a few seconds of inactivity, so you can
force it to remain at full power by clicking it and moving it around
while you copy the file data.  It would be worthwhile to compare this 
with the file contents collected while the device was suspended.

You know, this change in behavior could easily be the result of a bug
fix.  It's possible that a bug in the 4.11 kernel was preventing the
trackball from suspending, and when the bug was fixed in 4.12, the
kernel was then able to suspend the device automatically.  Perhaps Jiri
can find a change having that effect.

Anyway, if you don't want the trackball to be suspended while it's not
in use, you can simply turn off power-saving for that device.  Either
in powertop or in a shell script or in a udev script.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
