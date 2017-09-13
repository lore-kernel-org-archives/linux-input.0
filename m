From: Michael Simms <micsim35-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Fwd: RH Bugzilla - Bug 1482649 - Logitech USB Unified
 Receiver+M570 need 'waking' up by click after kernel update
Date: Wed, 13 Sep 2017 09:02:01 +0100
Message-ID: <CAJDR56xJpSHr+QuEC+b3U=YoL4Pecgk2e6sMcSRygYFpA-hHAA@mail.gmail.com>
References: <Pine.LNX.4.44L0.1709112137130.29391-100000@netrider.rowland.org> <Pine.LNX.4.44L0.1709122358340.7168-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1709122358340.7168-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi, thanks for recreating and looking into this. What I've done is
disabled powertop auto tunables as a system service and then looked at
that value. With powertop not running it is indeed set to ON for both
kernels. With powertop running it gets set to AUTO. So I think as was
alluded to earlier power management for usb autosuspend prior to
kernel 4.12 may not have been working at all for this device. Now it
has been 'fixed' and does. I think the only way round this now would
be to script something myself to autostart powertop while masking that
device from powertop or investigate using something more granular like
tlp.

I think we can call this closed, it's obviously now down to the users
to decide to control this setting as it now does what it should.
Thanks everyone for all your help.

Mike Simms

On 13 Sep 2017 5:15 a.m., "Alan Stern" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:

On Mon, 11 Sep 2017, Alan Stern wrote:

> On Sun, 10 Sep 2017, Michael Simms wrote:
>
> > Hi Alan, thanks for the cat instruction, it was very helpful. As
> > suggested I'm replying from my Google Mail account to see if this will
> > be accepted by the kernel mail server.
>
> It did work.
>
> > /sys/bus/usb/devices/2-1.3/2-1.3:0/power empty for both 4.11 and 4.12 sessions.
> >
> > for both kernel sessions in the parent directory
> > "/sys/bus/usb/devices/2-1.3/2-1.3:0/" I found a file called
> > "supports_autosuspend" with a value of 1.
> >
> > the reason I posted from the sub-folder
> > "/sys/bus/usb/devices/2-1.3:1.0/0003:046D:C52B.0001/power" originally
> > is because that contains all the rest of device power information.
>
> Okay.  I have been able to replicate some of the things you are seeing,
> on my own computer.  I'll investigate and get back to you with some
> answers.

It turns out that what really matters is not what you were looking at.
The important file is /sys/bus/usb/devices/2-1.3/power/control.

If that file contains "on" then the system will not suspend the
joystick; if it contains "auto" then it will.  You can test this simply
by doing:

        echo on >/sys/bus/usb/devices/2-1.3/power/control

(or echo auto, as the case may be).  The result should be the same in
both 4.11 and 4.12.

When you first plug in the joystick or first boot the system with the
joystick already plugged in, the file should be set to "on".  It won't
change to "auto" unless something tells it to change.  That something
could be udev, powertop, or some other program.  I have no idea why its
behavior under 4.12 would be different from under 4.11.

Alan Stern
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
