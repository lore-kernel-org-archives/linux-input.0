From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.35.3] wacom: Fix mousewheel up/down regression for
 old wacom tablets
Date: Sat, 28 Aug 2010 21:40:57 -0700
Message-ID: <20100829044057.GA15369@core.coreip.homeip.net>
References: <4C755C78.4000801@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42940 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab0H2ElE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Aug 2010 00:41:04 -0400
Received: by pzk9 with SMTP id 9so1645916pzk.19
        for <linux-input@vger.kernel.org>; Sat, 28 Aug 2010 21:41:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C755C78.4000801@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Auty <ikelos@gentoo.org>
Cc: linux-input@vger.kernel.org

On Wed, Aug 25, 2010 at 07:10:00PM +0100, Mike Auty wrote:
> This fixes a regression introduced in
> 3b57ca0f80c5c8994b5b1e3d3f904cfe727951f2.
> 
> The data[6] byte contains either 1 or -1 depending on the whether the
> mouse wheel on older wacom tablets is moved down (1) or up (-1).  The
> patch introduced in the above commit changed the cast from (signed char)
> to (signed).  When cast as a signed integer and negated, the value of -1
> (stored in the byte as 0xff) became -255 rather than 1.  This patch
> reverts the cast to a (signed char) and also removes an unnecessary
> (signed) cast, as all the values operated on are bitmasked.
> 
> Signed-off-by: Mike Auty <ikelos@gentoo.org>
> Reviewed-by: Ping Cheng <pingc@wacom.com>

Applied, thank you Mike.

-- 
Dmitry
