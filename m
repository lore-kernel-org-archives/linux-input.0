From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-gfrm: Google Fiber TV Box remote controls
Date: Mon, 26 Oct 2015 16:01:25 +0900 (KST)
Message-ID: <alpine.LNX.2.00.1510261600220.8998@pobox.suse.cz>
References: <1445454286-134412-1-git-send-email-pgynther@google.com> <alpine.LNX.2.00.1510221055030.21100@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50511 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbbJZHBZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 03:01:25 -0400
In-Reply-To: <alpine.LNX.2.00.1510221055030.21100@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, 22 Oct 2015, Jiri Kosina wrote:

> > Add HID driver for Google Fiber TV Box remote controls
> 
> I am not particularly happy with drvdata not being actually used "the 
> usual way", i.e. to store a pointer, but apart from being unusual, I don't 
> see a real issue with it.
> 
> Dmitry, as this depends on a patch queued in your tree, would you be okay 
> with taking the patch with my signoff?

I discussed this Dmitry in person on Kernel Summit earlier today, and 
he'll be taking the driver through his tree.

For that purpose:
	
	Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

