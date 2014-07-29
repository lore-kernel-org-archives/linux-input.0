From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: usbhid: Use flag HID_DISCONNECTED when a usb device
 is removed
Date: Tue, 29 Jul 2014 13:06:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291303570.16390@pobox.suse.cz>
References: <1406265181-4009-1-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42215 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbaG2LGy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 07:06:54 -0400
In-Reply-To: <1406265181-4009-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org

On Fri, 25 Jul 2014, Reyad Attiyat wrote:

> Set disconnected flag in struct usbhid when a usb device
> is removed. Check for disconnected flag before sending urb
> requests. This prevents a kernel panic when a hid driver calls
> hid_hw_request() after removing a usb device.
> 
> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>

I've included the full oops output into the changelog and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
