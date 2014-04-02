From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 0/7] HID: sony: More Sony controller fixes and
 improvements.
Date: Thu, 3 Apr 2014 00:36:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404030035110.32122@pobox.suse.cz>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51920 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158AbaDBWge (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Apr 2014 18:36:34 -0400
In-Reply-To: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Wed, 2 Apr 2014, Frank Praznik wrote:

> v4 of this series has been rebased against jikos/hid.git/for-linus
> 
> There was another bit of mismerge code duplication in for-linus that caused
> merge conflicts with patches 3 and above in v3 of the series.
> 
> The first patch in v4 fixes the mismerge and the remaining patches now apply
> cleanly.
> 
> Patch 1 should be queued for 3.15 as soon as possible.

Hmm, you are right indeed. This conflict resolution is not something I'd 
be proud of.

Will be queuing the first patch shortly after Linus pulls, and will review 
the rest after merge window is closed.

Thanks,

-- 
Jiri Kosina
SUSE Labs
