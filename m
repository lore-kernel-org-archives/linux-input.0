From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: corsair: fix mapping of non-keyboard usages
Date: Tue, 23 Feb 2016 14:23:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602231422530.22700@cbobk.fhfr.pm>
References: <20160216173824.GA23019@untxi.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53576 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbcBWNXG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 08:23:06 -0500
In-Reply-To: <20160216173824.GA23019@untxi.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= <clement.vuchener@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 16 Feb 2016, =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= wrote:

> This fixes a bug where the Volume Up key was ignored because it uses the 
> same usage code as G18. Special Corsair usage codes are in the keyboard 
> page, other pages should be left to the generic driver.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

