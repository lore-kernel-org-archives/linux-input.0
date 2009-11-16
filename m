From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atkbd - add forced release kays quirk for
	Samsung N130
Date: Mon, 16 Nov 2009 11:54:43 -0800
Message-ID: <20091116195443.GE24026@core.coreip.homeip.net>
References: <20091116171814.GA26183@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65523 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbZKPTym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2009 14:54:42 -0500
Content-Disposition: inline
In-Reply-To: <20091116171814.GA26183@sig21.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Johannes,

On Mon, Nov 16, 2009 at 06:18:14PM +0100, Johannes Stezenbach wrote:
> Samsung N130 has the same function key quirks as the NC10.
> 
> Signed-off-by: Johannes Stezenbach <js@sig21.net>
> ---
> It would be nice if this could go into 2.6.32.  It might also be
> suitable for stable.

2.6.32 will allow manipulating force release quirk from userspace
(sysfs) so I stopped accepting in-kernel quirks like this one.

Thanks.

-- 
Dmitry
