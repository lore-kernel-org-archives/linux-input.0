From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Wacom Graphire Bluetooth driver (updated with a few
 fixes)
Date: Mon, 11 May 2009 17:20:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111719140.22712@wotan.suse.de>
References: <1236988799.32264.6310.camel@cookie.hadess.net>  <1237247755.32264.10664.camel@cookie.hadess.net> <1241622842.2535.8267.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43485 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbZEKPUc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 11:20:32 -0400
In-Reply-To: <1241622842.2535.8267.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, 6 May 2009, Bastien Nocera wrote:

> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> Based on the work by Andrew Zabolotny, an HID driver for the Bluetooth
> Wacom tablet. This is required as it uses a slightly different
> protocols from what's currently support by the drivers/input/wacom*
> driver, and those only support USB.

Hi Bastien,

thanks for the driver.

> +HID_COMPAT_LOAD_DRIVER(wacom);

We don't need this one anymore, the HID_COMPAT stuff has gone away 
completely already.

Otherwise, it looks good. So if you agree, I will remove the COMPAT stuff 
and queue it in my tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs
