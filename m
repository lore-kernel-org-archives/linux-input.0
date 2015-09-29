From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Add suffix for HID_DG_TOUCHPAD
Date: Tue, 29 Sep 2015 12:09:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509291208490.30132@pobox.suse.cz>
References: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39601 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933838AbbI2KJH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 06:09:07 -0400
In-Reply-To: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, 28 Sep 2015, Mika Westerberg wrote:

> Instead of printing "UNKNOWN" as device suffix for HID_DG_TOUCHPAD call
> the device as "Touchpad".
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to hid.git#for-4.4/multitouch.

-- 
Jiri Kosina
SUSE Labs

