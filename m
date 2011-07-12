From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: fix horizontal wheel for ms comfort mouse 4500
Date: Tue, 12 Jul 2011 10:33:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107121033070.5754@pobox.suse.cz>
References: <alpine.LNX.2.00.1107111445360.11049@pobox.suse.cz> <1310409772-6289-1-git-send-email-ari.m.savolainen@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57331 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab1GLIdT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 04:33:19 -0400
In-Reply-To: <1310409772-6289-1-git-send-email-ari.m.savolainen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Savolainen <ari.m.savolainen@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 11 Jul 2011, Ari Savolainen wrote:

> Microsoft comfort mouse 4500 report descriptor contains duplicate
> usages for horizontal wheel. This patch fixes the wrong mapping
> caused by that.
> 
> Signed-off-by: Ari Savolainen <ari.m.savolainen@gmail.com>

Applied, thanks Ari.

-- 
Jiri Kosina
SUSE Labs
