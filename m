From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated with a few
 fixes)
Date: Mon, 11 May 2009 17:12:35 +0100
Message-ID: <1242058355.22847.10330.camel@cookie.hadess.net>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	 <1237247755.32264.10664.camel@cookie.hadess.net>
	 <1241622842.2535.8267.camel@cookie.hadess.net>
	 <alpine.LNX.2.00.0905111719140.22712@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36019 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbZEKQNW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 12:13:22 -0400
In-Reply-To: <alpine.LNX.2.00.0905111719140.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, 2009-05-11 at 17:20 +0200, Jiri Kosina wrote:
> On Wed, 6 May 2009, Bastien Nocera wrote:
> 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > 
> > Based on the work by Andrew Zabolotny, an HID driver for the Bluetooth
> > Wacom tablet. This is required as it uses a slightly different
> > protocols from what's currently support by the drivers/input/wacom*
> > driver, and those only support USB.
> 
> Hi Bastien,
> 
> thanks for the driver.
> 
> > +HID_COMPAT_LOAD_DRIVER(wacom);
> 
> We don't need this one anymore, the HID_COMPAT stuff has gone away 
> completely already.
> 
> Otherwise, it looks good. So if you agree, I will remove the COMPAT stuff 
> and queue it in my tree.

Fine by me. Thanks!

