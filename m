From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-wiimote: print small buffers via %*ph
Date: Wed, 4 Sep 2013 11:43:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041142490.3684@pobox.suse.cz>
References: <1378211544-16594-1-git-send-email-andriy.shevchenko@linux.intel.com> <alpine.LNX.2.00.1309041140080.3684@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47325 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934563Ab3IDJnI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 05:43:08 -0400
In-Reply-To: <alpine.LNX.2.00.1309041140080.3684@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Wed, 4 Sep 2013, Jiri Kosina wrote:

> > Instead of passing each byte through stack let's use %*ph specifier to dump
> > buffer as a hex string.
> 
> Applied, thanks.

I acutally applied the phC one, but replied to wrong thread, sorry for the 
noise.

-- 
Jiri Kosina
SUSE Labs
