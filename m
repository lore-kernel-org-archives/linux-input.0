From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] usbhid: fix PIXART optical mouse
Date: Mon, 8 Sep 2014 11:26:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409081126180.5523@pobox.suse.cz>
References: <1410168109-16005-1-git-send-email-oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51849 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbaIHJ0h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Sep 2014 05:26:37 -0400
In-Reply-To: <1410168109-16005-1-git-send-email-oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, johan@kernel.org

On Mon, 8 Sep 2014, Oliver Neukum wrote:

> This mouse keeps disconnecting in runlevel 3. It needs the
> ALWAYS_POLL quirk.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Applied to hid.git#for-3.18/always-poll-quirk, thanks.

-- 
Jiri Kosina
SUSE Labs
