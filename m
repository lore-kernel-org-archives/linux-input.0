From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Do not set the ACPI companion field in the
 HID device
Date: Wed, 3 Jun 2015 09:51:30 +0300
Message-ID: <20150603065130.GF4057@lahna.fi.intel.com>
References: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10857 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752938AbbFCGve (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 02:51:34 -0400
Content-Disposition: inline
In-Reply-To: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>

On Tue, Jun 02, 2015 at 02:46:20PM -0700, Andrew Duggan wrote:
> The HID device does not need to know about the ACPI device associated with
> the underlying i2c device. Setting the ACPI companion field in the HID device
> also has the side effect of causing HID to be set as wake capable, since
> acpi_bind_one uses's the companion ACPI device's wakeup flags to set the
> device as wake capable. Which results in power/wakeup files in sysfs for
> the HID device which do not do anything.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
