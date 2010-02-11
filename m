From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-magicmouse: Coding style and probe failure fixes.
Date: Thu, 11 Feb 2010 11:26:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002111124030.30967@pobox.suse.cz>
References: <87y6j2eeqv.fsf_-_@troilus.org> <87pr4eeemz.fsf_-_@troilus.org> <20100210182024.GA29610@core.coreip.homeip.net> <873a18e3qu.fsf_-_@troilus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38993 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab0BKK0Y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 05:26:24 -0500
In-Reply-To: <873a18e3qu.fsf_-_@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 11 Feb 2010, Michael Poole wrote:

> I haven't had a chance to run-test these changes yet -- hid/for-next
> causes corrupt X display on my laptop, whereas v2.6.33-rc6 and -rc7 are
> fine; 

That's indeed quite strange. I'd be curious to see the result of the 
bisection, thanks a lot for doing this.

I have applied your patch to the branch containing your driver.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
