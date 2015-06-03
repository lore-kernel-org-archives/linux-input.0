From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: Do not set the ACPI companion field in
 the HID device
Date: Wed, 3 Jun 2015 10:46:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506031046210.12753@pobox.suse.cz>
References: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56053 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbbFCIqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 04:46:44 -0400
In-Reply-To: <1433281580-8319-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>

On Tue, 2 Jun 2015, Andrew Duggan wrote:

> The HID device does not need to know about the ACPI device associated with
> the underlying i2c device. Setting the ACPI companion field in the HID device
> also has the side effect of causing HID to be set as wake capable, since
> acpi_bind_one uses's the companion ACPI device's wakeup flags to set the
> device as wake capable. Which results in power/wakeup files in sysfs for
> the HID device which do not do anything.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-4.2/i2c-hid.

-- 
Jiri Kosina
SUSE Labs
