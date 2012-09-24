From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: picoLCD: off by one in dump_buff_as_hex()
Date: Mon, 24 Sep 2012 23:07:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209242307120.1391@pobox.suse.cz>
References: <20120914110414.GA1152@elgon.mountain> <20120917225437.6f2847ee@neptune.home> <20120919213535.34712fb5@neptune.home> <20120922125512.GG4587@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45224 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab2IXVHk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 17:07:40 -0400
In-Reply-To: <20120922125512.GG4587@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, 22 Sep 2012, Dan Carpenter wrote:

> > What's your opinion on below alternative patch?
> > In addition to yours it makes would-overflow visible.
> > 
> > It does not check for output buffer having non-zero size but
> > as callers are local with #defined buffer size I don't think that would
> > be needed.
> > 
> 
> Sorry for the delay.  Looks good to me.

I am picking Bruno's patch. Thanks,

-- 
Jiri Kosina
SUSE Labs
