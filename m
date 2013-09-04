From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-wiimote: print small buffers via %*ph
Date: Wed, 4 Sep 2013 11:40:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041140080.3684@pobox.suse.cz>
References: <1378211544-16594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934422Ab3IDJkT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 05:40:19 -0400
In-Reply-To: <1378211544-16594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Tue, 3 Sep 2013, Andy Shevchenko wrote:

> Instead of passing each byte through stack let's use %*ph specifier to dump
> buffer as a hex string.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
