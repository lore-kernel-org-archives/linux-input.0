From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] hid:Change vendor id for USB_DEVICE_ID_MS_TYPE_COVER_3
 to correct id in hid-ids.h
Date: Wed, 20 May 2015 16:38:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505201636410.8186@pobox.suse.cz>
References: <1431666292-27622-1-git-send-email-xerofoify@gmail.com> <alpine.LNX.2.00.1505151247130.8186@pobox.suse.cz> <8032D262-870E-4071-9B32-767239EB8E31@gmail.com> <555C97CF.3040502@gmail.com> <alpine.LNX.2.00.1505201627070.8186@pobox.suse.cz>
 <555C9B72.6090207@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54552 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbbETOi2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 10:38:28 -0400
In-Reply-To: <555C9B72.6090207@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 20 May 2015, nick wrote:

> That's a good question and we discussed with Alan about this. Basically 
> the only id that works on non JP models is the one he checked. 

And now you are removing it.

> Your right there may be two vendor ids for the product a.k.a maybe for 
> revisions however to my knowledge there have been no major revisions of 
> the Surface Pro Three. In addition what is the likely hood that a vendor 
> has two ids for the same area 

It's quite common to have multiple PIDs for devices with the same 
internals.

> in the world, as I can't think of one vendor that does this unless 
> differencing between two of the products is important a.k.a like MAC 
> addresses 

MAC address is about distinguishing individial device instances from each 
other. PIDs are something completely different.

-- 
Jiri Kosina
SUSE Labs
