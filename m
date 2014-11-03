From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: core: cleanup .claimed field on disconnect
Date: Mon, 3 Nov 2014 23:45:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411032343360.19451@pobox.suse.cz>
References: <1415046812-3263-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33552 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbaKCWpI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Nov 2014 17:45:08 -0500
In-Reply-To: <1415046812-3263-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 3 Nov 2014, Benjamin Tissoires wrote:

> When a subdriver is rmmod-ed then re-insmod-ed, the hid device is not
> destroyed as it is owned by the transport layer.
> So when we re-probed the device, the hid device is assumed to be already
> claimed, and can lead to page faults if hid-core tries to forward the
> emitted data to the to-be-created claimed node.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi Jiri,
> 
> [keeping the people involved in the logitech-hidpp driver in CC]
> 
> this one was particularly nasty. I had several page faults when just
> rmmod && insmod the hid-logitech-hidpp driver. The page fault was occuring
> in hidraw :/
> I was not able to get a stacktrace which I could include here. The laptop was
> completely unresponsive and I could take only a picture to debug it.

Thanks a lot for tracking it down, Benjamin, tricky one indeed. Queuing 
for 3.18 still.

-- 
Jiri Kosina
SUSE Labs
