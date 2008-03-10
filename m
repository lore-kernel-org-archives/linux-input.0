From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG in sermouse driver
Date: Mon, 10 Mar 2008 11:34:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803101130060.18589@twin.jikos.cz>
References: <20080310093039.GA26118@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:35557 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbYCJKeN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 06:34:13 -0400
In-Reply-To: <20080310093039.GA26118@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Mon, 10 Mar 2008, Ondrej Zajicek wrote:

> There is a bug in sermouse driver that inputattach program terminates 
> during suspend (or resume) to ram hence mouse does not work afer resume. 
> When i execute inputattach after resume, the mouse is working.

I know that Pavel (added to CC) knows where the problem is (improper fake 
signal handling around try_to_freeze() call), I guess he'd be able to 
provide a patch to test.

Thanks,

-- 
Jiri Kosina

