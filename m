From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 21 Jan 2016 10:36:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601211035040.21446@cbobk.fhfr.pm>
References: <1447874755-8673-1-git-send-email-adi@adirat.com> <1448050742-10777-1-git-send-email-adi@adirat.com> <20151129122915.66ead7c2@adipc> <CANRwn3SU4zsxLAHUh4EP=LsGj1d_0-YV=je-Jfut4VXX3faBZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANRwn3SU4zsxLAHUh4EP=LsGj1d_0-YV=je-Jfut4VXX3faBZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Gerecke <killertofu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ping Cheng <pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, Ioan-Adrian Ratiu <adi-VBHIVgTnVYLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 20 Jan 2016, Jason Gerecke wrote:

> I've been prompted to resurrect this question after fielding yet another 
> question from a user encountering a locked-up system. We received a 
> surprising number of reports of people encountering this issue in the 
> past several weeks and that's only going to get worse as 4.4 works its 
> way into distros. Integrating back even just to 4.4 instead of 3.19 
> would be appreciated since this issue has (so far) only ever been 
> encountered with the new Intuos tablets that were added in 4.4...

I am in favor of pushing this to -stable. As you guys seem to be the ones 
able to test it with your hardware, would you guys (Ioan-Adrian? Jason?) 
be willing to prepare the backport and submit it once it passes your 
testing?

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
