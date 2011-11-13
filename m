From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: wacom: Move parsing to a separate function
Date: Sun, 13 Nov 2011 21:34:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111132133450.15187@pobox.suse.cz>
References: <1320492502-11976-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37792 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab1KMUeC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 15:34:02 -0500
In-Reply-To: <1320492502-11976-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, pinglinux@gmail.com, chris@cnpbagwell.com

On Sat, 5 Nov 2011, Przemo Firszt wrote:

> This patch doesn't change the way driver works. Parsing logic is now in a
> separate function. It's a first step to add Intuos4 Wireless support to
> hid-wacom driver.
> 
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> Acked-by: Ping Cheng <pinglinux@gmail.com>
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

I have applied both patches, thanks Przemo.

-- 
Jiri Kosina
SUSE Labs
