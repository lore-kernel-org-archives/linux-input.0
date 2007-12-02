From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: REGRESSION: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 2 Dec 2007 19:09:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712021907490.13260@jikos.suse.cz>
References: <4752DB8C.50608@rtr.ca> <4752E432.10504@rtr.ca> <4752E5AD.40905@rtr.ca>
 <4752F226.1090003@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:54578 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752226AbXLBSJR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 13:09:17 -0500
In-Reply-To: <4752F226.1090003@garzik.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <lkml@rtr.ca>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org

On Sun, 2 Dec 2007, Jeff Garzik wrote:

> My USB mouse recently started giving me phantom scrolls (movements of 
> the mouse wheel, even I made sure the wheel was in a resting position) 
> in recently kernels.  It happened too infrequently for me to care.

Did this also start in 2.6.24, as in Mark's case?

> USB HID is a fun place to be.

Yes, especially with tons of USB HID devices violating the specs in many 
creative ways :(

Thanks,

-- 
Jiri Kosina
