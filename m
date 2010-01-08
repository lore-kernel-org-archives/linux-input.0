From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Date: Fri, 8 Jan 2010 17:36:56 +0100
Message-ID: <20100108163655.GA8328@elf.ucw.cz>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
 <20100108083020.GB3696@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58769 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909Ab0AHQhW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jan 2010 11:37:22 -0500
Content-Disposition: inline
In-Reply-To: <20100108083020.GB3696@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz

Hi!

> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
> 
> What this attribute is for?

Actually, all the new files this added need to be documented.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
