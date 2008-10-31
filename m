From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 2.6.28-rc2: USB/INPUT: slab error in cache_alloc_debugcheck_after():
 double free?
Date: Fri, 31 Oct 2008 12:55:08 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0810311254400.7585@twin.jikos.cz>
References: <200810310011.08618.deller@gmx.de> <20081031044553.50882e86@epia.jer-c2.orkz.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:40606 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbYJaLz1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 07:55:27 -0400
In-Reply-To: <20081031044553.50882e86@epia.jer-c2.orkz.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeroen Roovers <jer@gentoo.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, 31 Oct 2008, Jeroen Roovers wrote:

> I am seeing the same USB problem but without the SLAB errors - [1] is
> the Gentoo bug report. The kernel boots fine with both USB keyboard and
> mouse detached.

Could you please provide your config? I am still not able to reproduce it 
here. Thanks.

-- 
Jiri Kosina
SUSE Labs

