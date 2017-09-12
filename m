From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Fwd: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Mon, 11 Sep 2017 21:39:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709112137130.29391-100000@netrider.rowland.org>
References: <CAJDR56zTrZ4P9BTsn1sBaPmDFgyO5AvSXuAv-ohnb6d4T1J2yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJDR56zTrZ4P9BTsn1sBaPmDFgyO5AvSXuAv-ohnb6d4T1J2yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Simms <micsim35-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, 10 Sep 2017, Michael Simms wrote:

> Hi Alan, thanks for the cat instruction, it was very helpful. As
> suggested I'm replying from my Google Mail account to see if this will
> be accepted by the kernel mail server.

It did work.

> /sys/bus/usb/devices/2-1.3/2-1.3:0/power empty for both 4.11 and 4.12 sessions.
> 
> for both kernel sessions in the parent directory
> "/sys/bus/usb/devices/2-1.3/2-1.3:0/" I found a file called
> "supports_autosuspend" with a value of 1.
> 
> the reason I posted from the sub-folder
> "/sys/bus/usb/devices/2-1.3:1.0/0003:046D:C52B.0001/power" originally
> is because that contains all the rest of device power information.

Okay.  I have been able to replicate some of the things you are seeing,
on my own computer.  I'll investigate and get back to you with some
answers.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
