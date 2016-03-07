From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: force retrieving of Win8 signature
 blob
Date: Mon, 7 Mar 2016 23:45:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603072343330.3656@cbobk.fhfr.pm>
References: <1457344958-9987-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcCGWpE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2016 17:45:04 -0500
In-Reply-To: <1457344958-9987-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 7 Mar 2016, Benjamin Tissoires wrote:

> The Synaptics 0x11e5 over I2C found in the Asus T100-CHI requires to
> fetch the signature blob to actually start sending events.
> 
> With this patch, we should be close enough to the Windows driver which
> checks the content of the blob at plugin to validate or not the
> touchscreen.

I have brought the 'Link' and 'Fixes' headers into slightly better shape 
:) and applied.

I will likely not be pushing this to Linus this week, but will make sure 
this ends up in -stable once this lands in his tree during the upcoming 
merge window, if you agree?

Thanks,

-- 
Jiri Kosina
SUSE Labs

