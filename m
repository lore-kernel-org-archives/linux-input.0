From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 3/3] HID: rmi: Add support for the touchpad in the
 Razer Blade 14 laptop
Date: Mon, 12 Jan 2015 10:14:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501121014310.15299@pobox.suse.cz>
References: <1420757496-3955-1-git-send-email-aduggan@synaptics.com> <1420757496-3955-2-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42923 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbbALJOl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 04:14:41 -0500
In-Reply-To: <1420757496-3955-2-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 8 Jan 2015, Andrew Duggan wrote:

> Have hid-rmi handle all of the Razer Blade HID devices that are part of the
> composite USB device. This will allow hid-rmi to operate the touchpad in rmi
> mode while passing events from the other devices to hid-input.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-3.20/rmi, thanks.

-- 
Jiri Kosina
SUSE Labs
