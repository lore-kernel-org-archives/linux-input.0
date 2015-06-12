From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RESEND PATCH v2 1/2] HID: hid-plantronics: Update to map volume
 up/down controls
Date: Fri, 12 Jun 2015 15:07:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506121506280.12753@pobox.suse.cz>
References: <1433798877-16751-1-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34738 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180AbbFLNHZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2015 09:07:25 -0400
In-Reply-To: <1433798877-16751-1-git-send-email-terry.junge@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Junge <terry.junge@plantronics.com>
Cc: linux-input@vger.kernel.org

On Mon, 8 Jun 2015, Terry Junge wrote:

> Resend with mail server adjustments to stop whitespace damage to patch.
> 
> Update Kconfig with enhanced help text for hid-plantronics driver.
> 
> Update hid-plantronics.c to identify device type and correctly map
> either the vendor unique or consumer control volume up/down usages
> to KEY_VOLUMEUP and KEY_VOLUMEDOWN events. Unmapped usages are ignored
> to prevent core mapping of unknown usages to random mouse events.
> 
> Patched against git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
> 
> Tested on ChromeBox/ChromeBook with various Plantronics devices.
> 
> Signed-off-by: Terry Junge <terry.junge@plantronics.com>

Applied to for-4.2/plantronics.

-- 
Jiri Kosina
SUSE Labs
