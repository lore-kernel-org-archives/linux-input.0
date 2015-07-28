From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Only disable irq wake if it was
 successfully enabled during suspend
Date: Tue, 28 Jul 2015 14:33:37 +0300
Message-ID: <20150728113337.GD11956@lahna.fi.intel.com>
References: <1438042086-9827-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59202 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbbG1LeE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 07:34:04 -0400
Content-Disposition: inline
In-Reply-To: <1438042086-9827-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Jul 27, 2015 at 05:08:06PM -0700, Andrew Duggan wrote:
> On at least one platform the kernel prints a warning on resume saying
> "Unbalanced IRQ 37 wake disable". This is because enable_irq_wake in the
> suspend function is failing. This patch checks to see if the call to
> enable_irq_wake succeeded before calling disable_irq_wake.

While this looks okay, I'm wondering if this can also be fixed from the
irq chip side by setting IRQCHIP_SKIP_SET_WAKE to .flags, given that the
driver does not provide such function?
