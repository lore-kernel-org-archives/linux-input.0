From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] HID: rmi: Scan the report descriptor to determine if
 the device is suitable for the hid-rmi driver
Date: Wed, 17 Dec 2014 09:14:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412170914010.1680@pobox.suse.cz>
References: <1418408246-5360-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbaLQIOV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 03:14:21 -0500
In-Reply-To: <1418408246-5360-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, 12 Dec 2014, Andrew Duggan wrote:

> On composite HID devices there may be multiple HID devices on separate
> interfaces, but hid-rmi should only bind to the touchpad. The previous version
> simply checked that the interface protocol was set to mouse. Unfortuately, it
> is not always the case that the touchpad has the mouse interface protocol set.
> This patch takes a different approach and scans the report descriptor looking
> for the Generic Desktop Pointer usage and the Vendor Specific Top Level
> Collection needed by the hid-rmi driver to interface with the device.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> Here is the v3 version with Benjamin's comments addressed. I also updated it to
> apply to the version of hid-core.c in for-3.19/hid-rmi.

Applied to for-3.20/rmi. Thanks,

-- 
Jiri Kosina
SUSE Labs
