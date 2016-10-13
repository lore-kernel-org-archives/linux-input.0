From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: exit if the IRQ is not valid
Date: Thu, 13 Oct 2016 13:25:14 +0300
Message-ID: <20161013102514.GQ2774@lahna.fi.intel.com>
References: <1476351045-8829-1-git-send-email-benjamin.tissoires@redhat.com>
 <1476351045-8829-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34605 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753389AbcJMK1o (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Oct 2016 06:27:44 -0400
Content-Disposition: inline
In-Reply-To: <1476351045-8829-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, David Arcari <darcari@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 13, 2016 at 11:30:45AM +0200, Benjamin Tissoires wrote:
> From: David Arcari <darcari@redhat.com>
> 
> When i2c-core doesn't find the IRQ associated to the GPIO because
> the gpiochip is not available, it assigns -EPROBE_DEFER to the irq.
> We need to bail out there and on any other error in an IRQ.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
