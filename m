From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: usbhid: add quirk HID_QUIRK_NOGET to TPV optical
 touchscreen
Date: Thu, 15 Nov 2012 10:36:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211151036190.15877@pobox.suse.cz>
References: <1352912036-6670-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59332 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422860Ab2KOJgc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Nov 2012 04:36:32 -0500
In-Reply-To: <1352912036-6670-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chris MacDonald <chris@fourthandvine.com>

On Wed, 14 Nov 2012, Benjamin Tissoires wrote:

> Without this, the device is blocked in dmesg at:
> hid-multitouch 0003:25AA:8883.000X: usb_submit_urb(ctrl) failed: -1
> hid-multitouch 0003:25AA:8883.000X: timeout initializing reports
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
