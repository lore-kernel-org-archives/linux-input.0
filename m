From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom - make sure touch_input is valid before using
 it
Date: Fri, 7 Nov 2014 16:42:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411071642260.29198@pobox.suse.cz>
References: <1415323851-16453-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51704 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbaKGPmj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Nov 2014 10:42:39 -0500
In-Reply-To: <1415323851-16453-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thu, 6 Nov 2014, Ping Cheng wrote:

> touch_input is stored in wacom_shared for pen data to report touch
> switch status. It is possible, although we didn't see it happen on
> Linux yet, that pen data is procesed before touch interface is
> fully probed.
> 
> As a by-product of this patch, it fixes the FreeBSD issue reported
> by Denis Akiyakov http://www.spinics.net/lists/linux-input/msg33971.html
> 
> Reviewed-by: Hans Petter Selasky <hps@selasky.org>
> Tested-by: Denis Akiyakov <d.akiyakov@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
