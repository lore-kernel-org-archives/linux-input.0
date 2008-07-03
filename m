From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]powermate runtime pm
Date: Fri, 4 Jul 2008 00:08:49 +0200
Message-ID: <200807040008.50174.oliver@neukum.org>
References: <200807031753.16960.oliver@neukum.org> <20080703134107.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:53594 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbYGCWIP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jul 2008 18:08:15 -0400
In-Reply-To: <20080703134107.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, will@sowerbutts.com

Am Donnerstag 03 Juli 2008 19:43:28 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On Thu, Jul 03, 2008 at 05:53:16PM +0200, Oliver Neukum wrote:
> > Hi,
> > 
> > this should add runtime power management to the powermate driver.
> > In order to do so the driver had to be changed to provide open & close
> > methods. Please test.
> > 
> 
> I was workinf on adding suspend and resume hooks to input devices to
> reset them into sane state automatically. I am wondering if I should
> call driver's suspend and resume only for open input devices and

If you do that open() would have to redo all initialisation work probe()
would do.

> provide mutual exclusion with open and close. DO you think it will
> help with reagrd to adding autopm support to USB devices?

Mutual exclusion is a very good idea. And telling input devices that
they are open is also a good idea. But this will be difficult, as open()
will almost certainly wish to do as memory allocations can trigger
an autoresume.

	Regards
		Oliver



