From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Prevent sending reports from racing with
 device reset
Date: Wed, 30 Dec 2015 23:57:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512302356340.9922@cbobk.fhfr.pm>
References: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39291 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987AbbL3W5M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 17:57:12 -0500
In-Reply-To: <1450704391-47008-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Dec 2015, Mika Westerberg wrote:

> When an i2c-hid device is resumed from system sleep the driver resets
> the device to be sure it is in known state. The device is expected to
> issue an interrupt when reset is complete.
[ ... snip ... ]
> Prevent sending of feature/output reports while the device is being
> reset by adding a mutex which is held during that time.

Thanks Mika. Applied to for-4.4/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

