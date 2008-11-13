From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: next: 6a13378a5 (Don't allow KWorld radio...) is broken
Date: Thu, 13 Nov 2008 10:37:49 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811131037020.32143@jikos.suse.cz>
References: <491B3E90.5020307@gmail.com> <208cbae30811121824g2e2d4f3bvf2c982c9f54b30a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:32947 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750728AbYKMJhv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 04:37:51 -0500
In-Reply-To: <208cbae30811121824g2e2d4f3bvf2c982c9f54b30a2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Tobias Lorenz <tobias.lorenz@gmx.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 13 Nov 2008, Alexey Klimov wrote:

> > Alexey, did you actually test it?
> > I'd prefer taking this through my tree, if it doesn't impose any problem
> > on your side. Could you please fix it up and resend?
> It good thing to do. May i make patch against current kernel tree 
> (rc4-git3) ? I also going to make patch for radio-mr800 that has wrong 
> hidquirks too. I can send now, because this two patches ready.

Thanks, I have applied both patches to my tree (but please remember to 
always send kernel patches so that they apply using "patch -p1", I had to 
fix this by hand).

Thanks,

-- 
Jiri Kosina
SUSE Labs
