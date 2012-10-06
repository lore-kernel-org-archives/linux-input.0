From: Cedric Sodhi <manday@gmx.net>
Subject: Re: HID-USB Touchpad not working again
Date: Sat, 6 Oct 2012 10:05:15 +0200
Message-ID: <20121006080515.GA3208@slate>
References: <20121005160312.6710@gmx.net>
 <20121005204538.GA2118@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:54315 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750955Ab2JFHHY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Oct 2012 03:07:24 -0400
Content-Disposition: inline
In-Reply-To: <20121005204538.GA2118@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Consider the problem solved. A recent kernel seems to fix it.

On Fri, Oct 05, 2012 at 10:45:38PM +0200, Cedric Sodhi wrote:
> In fact it appears that the release is whats not registered in some of
> the cases.
> 
> On Fri, Oct 05, 2012 at 06:03:12PM +0200, Cedric Sodhi wrote:
> > Hello, I changed my tablet from an ASUS EEE Slate w/ EEFI eGalax Multitouch device to a SAMSUNG XE700T1A w/ AtmelmaXTouch Digitizer 03eb:211c
> > 
> > Both evdev and wacom give strange results. In particular, only a percentage of the touches are registered as clicks (all are registered as moves, but only a few of them as clicks).
> > 
> > I'll submit evtest logs as soon as I can. In the meantime, has anyone heard of this? There have been similar regressions in the past for usb-hid, so perhaps this is another.
> > 
> > Thank you, I'll get evtest logs as soon as I can.
> > 
> > Cedric
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
