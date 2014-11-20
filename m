From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wacom - return ENODEV for failed
 wacom_setup_pad_input_capabilities
Date: Thu, 20 Nov 2014 17:30:19 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411201729360.4454@pobox.suse.cz>
References: <1416346068-11266-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34119 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaKTQaM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 11:30:12 -0500
In-Reply-To: <1416346068-11266-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, 18 Nov 2014, Ping Cheng wrote:

> ENODEV indicates no device is added. Hence, the associated pad input device
> is simply freed.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have now queued the series for 3.19. Thanks,

-- 
Jiri Kosina
SUSE Labs
