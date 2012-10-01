From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hidraw: don't deallocate memory when it is in use
Date: Mon, 1 Oct 2012 10:48:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1210011048300.27440@pobox.suse.cz>
References: <20120922184630.GA23401@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49870 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab2JAIsq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Oct 2012 04:48:46 -0400
In-Reply-To: <20120922184630.GA23401@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ratan Nalumasu <ratan@google.com>
Cc: linux-input@vger.kernel.org

On Sat, 22 Sep 2012, Ratan Nalumasu wrote:

> When a device is unplugged, wait for all processes that have opened the device
> to close before deallocating the device.
> 
> Signed-off-by: Ratan Nalumasu <ratan@google.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
