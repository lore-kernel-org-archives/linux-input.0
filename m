From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: [PATCH] HID: check for HID_QUIRK_IGNORE during probing
Date: Wed, 26 May 2010 08:24:23 +0200
Message-ID: <20100526082423.627f8cac@holly>
References: <20100523204725.6e9e8dad@holly>
	<20100525225323.134b2c00@holly>
	<1274827262.27274.19170.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45625 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab0EZGYe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 02:24:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1OHA2a-0003U7-Tv
	for linux-input@vger.kernel.org; Wed, 26 May 2010 08:24:32 +0200
Received: from rb5cl3.net.upc.cz ([89.176.217.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 26 May 2010 08:24:32 +0200
Received: from makovick by rb5cl3.net.upc.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 26 May 2010 08:24:32 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Tue, 25 May 2010 23:41:02 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Tue, 2010-05-25 at 22:53 +0200, Jindrich Makovicka wrote:
> > Updated to current git:
> > 
> > --- hid-core.c.orig	2010-05-25 22:04:58.000000000 +0200
> > +++ hid-core.c	2010-05-25 22:08:53.791241376 +0200
> > @@ -1759,7 +1759,8 @@
> >  
> >  	/* we need to kill them here, otherwise they will stay
> > allocated to
> >  	 * wait for coming driver */
> > -	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE) &&
> > hid_ignore(hdev))
> > +	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE)
> > +            && (hid_ignore(hdev) || (hdev->quirks &
> > HID_QUIRK_IGNORE))) return -ENODEV;
> >  
> >  	/* XXX hack, any other cleaner solution after the driver
> > core
> 
> Wouldn't that mean that a device with HID_QUIRK_IGNORE for which we
> pass HID_QUIRK_NO_IGNORE, would still be ignored?

With HID_QUIRK_NO_IGNORE, the whole expression will be FALSE, and the 
part after && wouldn't be even evaluated in both current and patched
version. So, NO_IGNORE takes precedence over IGNORE.

-- 
Jindrich Makovicka


