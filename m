From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hidraw: fix unproper mutex release
Date: Tue, 30 Jul 2013 23:52:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307302351190.18809@pobox.suse.cz>
References: <CAMyfujd=SvO_Fod-rj6nztdreYJJmO9vnN8R9M6XKytvMQTpnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56691 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab3G3VwN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 17:52:13 -0400
In-Reply-To: <CAMyfujd=SvO_Fod-rj6nztdreYJJmO9vnN8R9M6XKytvMQTpnw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: yonghua zheng <younghua.zheng@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 30 Jul 2013, yonghua zheng wrote:

> Hi Jiri,
> 
> We were seeing kernel crash while connect and disconnect a BT remote
> controller on Android system and kernel was crashing because of null
> pointer access in hidraw_open() in line 271 as follows:

Hi,

thanks a lot for the fix. I'd like to have it pushed to Linus for 3.11 
still.

However you patch is missing Signed-off-by: line, as documented in 
Documentation/SubmittingPatches.

Could you please provide that, so that I can apply your patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs
