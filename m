From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Wed, 14 Dec 2011 12:22:40 +0100
Message-ID: <201112141222.41006.oneukum@suse.de>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org> <201112140901.35203.oneukum@suse.de> <CAGS+omA=9qfqDYtaLp67Xz+WhcpW_=jn9hoiaad43Z+oexjsFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52366 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754901Ab1LNLVL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 06:21:11 -0500
In-Reply-To: <CAGS+omA=9qfqDYtaLp67Xz+WhcpW_=jn9hoiaad43Z+oexjsFQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: jkosina@suse.cz, bleung@chromium.org, stern@rowland.harvard.edu, olofj@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

Am Mittwoch, 14. Dezember 2011, 11:33:03 schrieb Daniel Kurtz:
> On Wed, Dec 14, 2011 at 4:01 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Donnerstag, 17. November 2011, 12:23:50 schrieb Daniel Kurtz:
> >> Defer LED setting action to a workqueue.
> >> This is more likely to send all LED change events in a single URB.
> >
> > Hi,
> >
> > I hope I am looking at the correct version of this patch.
> > But as far as I can see the work for handling LEDs is not delayed
> > while a reset is going on. That is wrong.
> 
> Actually, I'm not sure why this is wrong.  I find the reset handling
> quite confusing in this driver.
> Can you point out what will fail, and recommend how to fix it?

That is part of the workings of a USB driver. After you return from
pre_reset() you don't do IO to the device. After post_reset() the
device should be in its default state whose LED states won't match
what they ought to be.

	Regards
		Oliver
