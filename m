From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: logitech-hidpp: detect HID++ 2.0 errors too
Date: Fri, 19 Dec 2014 11:44:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412191144140.1680@pobox.suse.cz>
References: <1418691016-30681-1-git-send-email-peter@lekensteyn.nl> <1418691016-30681-2-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57259 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbaLSKoa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2014 05:44:30 -0500
In-Reply-To: <1418691016-30681-2-git-send-email-peter@lekensteyn.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 16 Dec 2014, Peter Wu wrote:

> Devices speaking HID++ 2.0 report a different error code (0xff). Detect
> these errors too to avoid 5 second delays when the device reports an
> error. Caught by... well, a bug in the QEMU emulation of this receiver.
> 
> Renamed fap to rap for HID++ 1.0 errors because it is more logical,
> it has no functional difference.
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

Applied to for-3.20/logitech.

-- 
Jiri Kosina
SUSE Labs
