From: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Provide a driver for the Apple Magic Mouse
Date: Tue, 09 Feb 2010 13:37:34 -0800
Message-ID: <4B71D59E.2060102@gmail.com>
References: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>	<dd18b0c31002082322m4238a4a6m73fc30752ba30447@mail.gmail.com>	<1265710460.2383.5685.camel@localhost.localdomain>	<201002090736.55576.edt@aei.ca>	<alpine.LNX.2.00.1002091339190.30967@pobox.suse.cz> <87y6j2eeqv.fsf_-_@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87y6j2eeqv.fsf_-_-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 02/09/10 05:10, Michael Poole wrote:
> I think this patch is ready for real review.  The Magic Mouse requires
> that a driver send an unlock Report(Feature) command, similar to the
> Wacom wireless tablet and Sixaxis controller quirks.  This turns on an
> Input Report that isn't published in the input Report descriptor that
> contains touch data (and usually overrides the normal motion and click
> Report).
>
> Because the mouse has only one switch and no scroll wheel, the driver
> (under control of parameters) emulates a middle button and scroll wheel.
> User space could also ignore and/or re-synthesize those events based on
> the reported events.
>
> The first patch exports hid_register_report() so the driver can turn on
> the multitouch report.  The second patch adds the device ID and the
> driver.  Some user-space tools to talk to the mouse directly (that is,
> when it is not associated with the host's HIDP stack) are at
> http://github.com/entrope/linux-magicmouse .
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


First, is I made a mistake with the procedure(early post) i.g.
sudo /usr/bin/test-device trusted D4:9A:20:88:C7:48
forgot to add yes at the end.
(so rebooting works and so forth).

As to this module I pulled the latest mainstream
added:
http://lkml.org/lkml/2010/1/29/146
plus the two other patches you had submitted with this thread and
everything compiled good.

Glad to see the mouse is working with these patches(thank you vary much 
gentlemen).

I can scroll up and down(need to get used to this).
copy/past works
right/left click works.
(need to figure out forward/reverse with firefox probably).

suspend works. I'm getting a resumbit urb, but that's been there
prior to this module. Although there was a moment after wakeup
I turned off the mouse, then reconnecting didnt, but then on another 
go(reboot)it worked(maybe hit some odd thing).

Other than not seeing any menu entry under hid
with make menuconfig, I would have to say vary nice
job with this, all functions I need to function are
there(scroll,right/left click, copy/past).

nice job, and thanks for this..
(without this I would of had a non
functional magic mouse).

Justin P. Mattock
