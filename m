From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Simplify 'wacom_pl_irq'
Date: Tue, 11 Aug 2015 01:09:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508110109420.27871@pobox.suse.cz>
References: <1438622290-6844-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48435 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933197AbbHJXKB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 19:10:01 -0400
In-Reply-To: <1438622290-6844-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 3 Aug 2015, Jason Gerecke wrote:

> Unlike other IRQ functions, 'wacom_pl_irq' uses the second element of
> the 'tool' array to store information about its single pen. This makes
> the function more difficult to understand (since it doesn't follow the
> general pattern of other IRQ functions) and prevents the possibility of
> refactoring how pen state is stored.
> 
> This patch rewrites 'wacom_pl_irq' to follow the usual IRQ conventions,
> including storing tool type in 'tool[0]' and implicitly tracking prox
> with the 'id[0]' variable.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Nice cleanup. Applied to for-4.3/wacom.

-- 
Jiri Kosina
SUSE Labs

