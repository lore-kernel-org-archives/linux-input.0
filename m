From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 16/20] HID: Only dump input if someone is listening
Date: Fri, 7 Sep 2012 14:52:45 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209071450190.21679@pobox.suse.cz>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se> <1346528835-363-17-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1209020927130.20709@pobox.suse.cz> <20120902085211.GA604@polaris.bitmath.org> <alpine.LNX.2.00.1209031515450.20709@pobox.suse.cz>
 <20120906205745.GA419@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41274 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2IGMw4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Sep 2012 08:52:56 -0400
In-Reply-To: <20120906205745.GA419@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 6 Sep 2012, Henrik Rydberg wrote:

> > Let's wait once Dmitry is finished with the input changes, and I can 
> > either take the set through my tree with his Signed-off-by: on the Input 
> > patches, or vice-versa.
> 
> Ok. Meanwhile, the current set is now in a temporary branch on github,
> see below. Given there are no more change requests, I can add the
> right SOBs and push it to my next tree for a while, before sending a
> proper pull request to either of you.
> 
> Thanks,
> Henrik
> 
> The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:
> 
>   Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/rydberg/linux.git maybe
> 
> for you to fetch changes up to 631ea780695fdc0d1efa91b6714bd85369daab06:
> 
>   HID: hid-multitouch: Add Flatfrog support (2012-09-06 22:21:02 +0200)
> 

Dmitry,

how do you want to handle this? I am fine with all the HID changes. So 
either I can take it through my tree and add your Sigoff to the Input 
patches (if you are fine with those), or vice versa (or take this through 
git branches, i.e. you apply the Input bits, I fetch that branch, and 
apply the rest on top of it).

Thanks,

-- 
Jiri Kosina
SUSE Labs
