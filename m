From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fill in physical device providing HID
 functionality
Date: Tue, 29 Sep 2015 12:07:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509291207100.30132@pobox.suse.cz>
References: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com> <1443442508-94971-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39488 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934041AbbI2KH0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 06:07:26 -0400
In-Reply-To: <1443442508-94971-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, 28 Sep 2015, Mika Westerberg wrote:

> Currently hid_connect() prints out following when I2C connected HID devices
> is connected:
> 
>   hid-multitouch 0018:03EB:2136.0001: ... [ATML3432:00 03EB:2136] on
> 
> After "on " should read physical device name but it is left empty by the
> driver.
> 
> Make it look better and fill in the physical device name.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied to hid.git#for-4.4/i2c-hid.

Thanks,

-- 
Jiri Kosina
SUSE Labs

