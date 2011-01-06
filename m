From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Thu, 6 Jan 2011 11:32:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101061131460.26685@pobox.suse.cz>
References: <5171053.20.1294278131468.JavaMail.root@butch.jtdata.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37025 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab1AFKcX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 05:32:23 -0500
In-Reply-To: <5171053.20.1294278131468.JavaMail.root@butch.jtdata.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "James T. Dickson" <james.dickson@jtdata.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 5 Jan 2011, James T. Dickson wrote:

> I have applied this patch and can report that it has fixed the problem Ubuntu 10.10. 

Thanks a lot for reporting back.

> However, the mouse freezes when a coming out of suspend and the system 
> will not shutdown.

And that doesn't happen with the touchpad being only in PS/2 mode, right?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
