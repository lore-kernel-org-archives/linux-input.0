From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbhid: extend polling interval configuration to
 joysticks
Date: Mon, 6 Mar 2017 14:35:17 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061435060.31814@cbobk.fhfr.pm>
References: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752907AbdCFNg5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 08:36:57 -0500
In-Reply-To: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 25 Feb 2017, Tobias Jakobi wrote:

> For mouse devices we can currently change the polling interval
> via usbhid.mousepoll. Implement the same thing for joysticks, so
> users can reduce input latency this way.
> 
> This has been tested with a Logitech RumblePad 2 with jspoll=2,
> resulting in a polling rate of 500Hz (verified with evhz).
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Applied to for-4.12/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

