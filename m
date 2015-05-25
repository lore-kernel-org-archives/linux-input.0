From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/2] HID: hid-plantronics: Update to map volume up/down
 controls
Date: Mon, 25 May 2015 13:45:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505251344260.13817@pobox.suse.cz>
References: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50824 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbbEYLpS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 07:45:18 -0400
In-Reply-To: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Junge <terry.junge@plantronics.com>
Cc: linux-input@vger.kernel.org

On Fri, 15 May 2015, Terry Junge wrote:

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

The patch is whitespace-damaged and can't really be applied. Could you 
please fix your mail setup and resubmit?

Thanks.

-- 
Jiri Kosina
SUSE Labs
