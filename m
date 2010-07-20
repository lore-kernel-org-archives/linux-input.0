From: Oliver Neukum <oneukum@suse.de>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Tue, 20 Jul 2010 12:03:43 +0200
Message-ID: <201007201203.43573.oneukum@suse.de>
References: <4C3F8A90.3020308@dv-life.ru> <201007201007.04518.oneukum@suse.de> <alpine.LNX.2.00.1007201058190.4741@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56994 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761158Ab0GTKEX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 06:04:23 -0400
In-Reply-To: <alpine.LNX.2.00.1007201058190.4741@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, x0r <x0r@dv-life.ru>, Linux Input <linux-input@vger.kernel.org>, Linux USB <linux-usb@vger.kernel.org>

Am Dienstag, 20. Juli 2010, 10:58:50 schrieb Jiri Kosina:
> On Tue, 20 Jul 2010, Oliver Neukum wrote:
> 
> > > It looks like ACRUX game controllers do not like autopm. There is
> > > a bug report over at Ubuntu's launchpad:
> > > 
> > > 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/448446
> > 
> > That report shows that the symptoms are consistent with autosuspend,
> > but it doesn't show that autosuspend was on.
> 
> That would be my first question -- who enabled autosuspend, if it was 
> really on? I thought it should be still off by default, shouldn't it?

It is off by default, but that doesn't stop Ubuntu having a udev rule to
switch it on or patching the kernel, so it might be on. We simply need
to know.

	Regards
		Oliver
