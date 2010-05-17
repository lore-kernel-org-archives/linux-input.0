From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2.6.34-rc7 v4] HID: hid-samsung: add support for Creative
 Desktop Wireless 6000
Date: Mon, 17 May 2010 13:38:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005171338440.28092@pobox.suse.cz>
References: <4BF11D9F.80605@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57712 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab0EQLi6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 07:38:58 -0400
In-Reply-To: <4BF11D9F.80605@yahoo.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Don Prince <dhprince.devel@yahoo.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 17 May 2010, Don Prince wrote:

> Add support for the multimedia buttons of the Creative Desktop Wireless
> 6000 keyboard/mouse combo which are not currently handled by the
> default/samsung HID driver.
> 
> Signed-off-by: Don Prince <dhprince-devel@yahoo.co.uk>
> 
> ---
> 
> Added comments as requested by Robert Schedel <r.schedel@yahoo.de>
> 
> As requested by Jiri Kosina, made key mapping code more concise
> i.e. ignored checkpatch.pl's wingeing about code style.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
