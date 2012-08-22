From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH] hid: Remove QUANTA from special drivers list
Date: Wed, 22 Aug 2012 19:00:52 +0200
Message-ID: <20120822170052.GA6158@polaris.bitmath.org>
References: <1345630637-7142-1-git-send-email-simon.farnsworth@onelan.co.uk>
 <alpine.LNX.2.00.1208221648130.32304@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:17315 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab2HVQ4F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 12:56:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208221648130.32304@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Simon Farnsworth <simon.farnsworth@onelan.co.uk>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Henrik Rydberg <rydberg@bitmath.se>

> > Applying just this patch is enough to fix the problem I described in my mail
> > "QUANTA touchscreen controller integrated in HP2310ti no longer recognised
> > (regression in 3.5 and later as compared to 3.3)".
> > 
> > This looks like an oversight in commit 4fa3a58; that commit removes most
> > multitouch screens from this list, but missed this one. Henrik should be
> > able to confirm, though, so I'd appreciate his sign-off.

Yes, good find. We have two identifiers for the same device,
USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN and
USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, which might explain why it
was overlooked. I think we should get rid of one of them. Also, I
wonder if the HID_QUIRK_NOGET quirk is still necessary.

Thanks,
Henrik
