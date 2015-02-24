From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] HID: i2c-hid: Add support for ACPI GPIO interrupts
Date: Tue, 24 Feb 2015 21:02:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502242102250.19920@pobox.suse.cz>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com> <1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60749 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbBXUCl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 15:02:41 -0500
In-Reply-To: <1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Feb 2015, Mika Westerberg wrote:

> The HID over I2C specification allows to have the interrupt for a HID
> device to be GPIO instead of directly connected to the IO-APIC.
> 
> Add support for this so that when the driver does not find proper interrupt
> number from the I2C client structure we check if it has ACPI GpioInt()
> resource listed in _CRS. If it is found we convert it to an interrupt
> number and use it instead.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
