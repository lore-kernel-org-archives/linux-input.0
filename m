From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Make the HID bus visible in the Kconfig options
Date: Fri, 20 Jul 2012 13:38:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207201337570.21929@pobox.suse.cz>
References: <1340356731-4745-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35519 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653Ab2GTLiN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 07:38:13 -0400
In-Reply-To: <1340356731-4745-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, 22 Jun 2012, Henrik Rydberg wrote:

> The HID subsystem was made a proper bus in 2008, but the config
> options do not reflect this. Modify the HID and USB_HID entries
> to better explain what they do.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Jiri,
> 
> As the HID subsystem moves more and more towards a regular bus, the
> config options become less and less apt. This patch, for next, only
> scratches the surface but hopefully in the right direction.

Applied, thank you Henrik.

-- 
Jiri Kosina
SUSE Labs
