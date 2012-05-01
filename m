From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/6] hid: Introduce device groups
Date: Tue, 1 May 2012 13:03:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205011300540.1856@pobox.suse.cz>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42623 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab2EALDk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 May 2012 07:03:40 -0400
In-Reply-To: <1335175627-2270-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephane Chatty <chatty@enac.fr>

On Mon, 23 Apr 2012, Henrik Rydberg wrote:

> Hi Jiri,
> 
> Here is the third version of the extension to the device-driver
> matching mechanism. AFAICT, there are no outstanding issues. I think
> we are getting close. :-)

I have now updated the 'might-rebase/autoloading' branch of git.hid tree 
(this is a rebasing branch, so simple pull will not work for you as a 
fast-forward, you'll have to delete and repull the branch).

It's currently in a shape I would be okay to pushing out for -next and 
scheduling for next merge window, and I will do so tomorrow if nothing 
else pops up during testing or reviews.

Thanks everybody, especially Henrik of course, for excellent work on this.

-- 
Jiri Kosina
SUSE Labs
