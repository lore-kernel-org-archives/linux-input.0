From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some
 keyboards
Date: Tue, 9 Sep 2014 11:42:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409091141340.5523@pobox.suse.cz>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com> <CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42014 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097AbaIIJnA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Sep 2014 05:43:00 -0400
In-Reply-To: <CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 9 Sep 2014, Fredrik Hallenberg wrote:

> Hi, time for a bump on this one.

Do you have any idea how common this pattern is? How many keyboards have 
you encountered doing this?

I hate to be polluting generic code with such strange quirks ... we've 
spent quite some time factoring those out to specific drivers.
So knowing how commong this is could be helpful in deciding how to handle 
this.

Thanks.

-- 
Jiri Kosina
SUSE Labs
