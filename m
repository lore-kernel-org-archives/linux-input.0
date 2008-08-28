From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [patch]full runtime power management for usbhid
Date: Thu, 28 Aug 2008 09:59:59 +0200
Message-ID: <20080828075959.GC15474@elf.ucw.cz>
References: <200808261139.14410.oliver@neukum.org> <20080826142848.GB5496@ucw.cz> <200808261833.12355.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40483 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbYH1U1p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Aug 2008 16:27:45 -0400
Content-Disposition: inline
In-Reply-To: <200808261833.12355.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue 2008-08-26 18:33:11, Oliver Neukum wrote:
> Am Dienstag 26 August 2008 16:28:49 schrieb Pavel Machek:
> > Hmm... so numlock now costs ~3W... perhaps we should be defaulting to
> > numlock=off, again?
> 
> Estimate or measured quantity?

Measured on thinkpad x60 -- difference between no usb and usb active
(simulated by rmmod).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
