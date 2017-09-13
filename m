From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Fwd: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Wed, 13 Sep 2017 00:15:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709122358340.7168-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1709112137130.29391-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:51649 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750849AbdIMEPF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 00:15:05 -0400
In-Reply-To: <Pine.LNX.4.44L0.1709112137130.29391-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Simms <micsim35@googlemail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

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

