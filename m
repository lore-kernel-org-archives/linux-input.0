From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Only disable irq wake if it was
 successfully enabled during suspend
Date: Tue, 18 Aug 2015 15:21:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508181521120.25821@pobox.suse.cz>
References: <1438292940-26711-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60980 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbbHRNV1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 09:21:27 -0400
In-Reply-To: <1438292940-26711-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, 30 Jul 2015, Andrew Duggan wrote:

> Enabling irq wake could potentially fail and calling disable_irq_wake
> after a failed call to enable_irq_wake could result in an unbalanced irq
> warning. This patch warns if enable_irq_wake fails and avoids other
> potential issues caused by calling disable_irq_wake on resume after
> enable_irq_wake failed during suspend.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> This patch is based on Jiri's for-4.3/i2c-hid and needs Gabriele Mazzotta's
> patch which moves where the HID driver's suspend callback call to apply
> cleanly.

Applied to for-4.3/i2c-hid. Thanks,

-- 
Jiri Kosina
SUSE Labs

