From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-multitouch.c: fix formatting warnings
Date: Wed, 30 Sep 2015 09:55:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509300954370.30132@pobox.suse.cz>
References: <1443470594-9878-1-git-send-email-brentadam@smarttech.com> <alpine.LNX.2.00.1509291457360.30132@pobox.suse.cz> <C29E0AF0-087D-418B-B1FD-87A7392BF3C8@smarttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43512 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbbI3HzX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 03:55:23 -0400
In-Reply-To: <C29E0AF0-087D-418B-B1FD-87A7392BF3C8@smarttech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brent Adam <BrentAdam@smarttech.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 29 Sep 2015, Brent Adam wrote:

> >> Fixed the following checkpatch.pl warnings:
> >> WARNING: line over 80 characters: line 163
> >> WARNING: Missing a blank line after declarations: line 359
> >> WARNING: Missing a blank line after declarations: line 572
> >> WARNING: Missing a blank line after declarations: line 708
> >> WARNING: Missing a blank line after declarations: line 926
> >> WARNING: Possible unnecessary 'out of memory' message: line 1034
> >> WARNING: Possible unnecessary 'out of memory' message: line 1048
> >> WARNING: line over 80 characters: line 1390
> >
> >For files which are already in tree I'd be taking such fixes only as a 
> >side-change if refactoring the code anyway in a substantial way. Otherwise 
> >I consider the ones below too minor to justify cluttering of git blame.
> 
> Ok, although Greg Kroah-Hartman inspires you in his video to submit patches
> to make the code checkpatch clean. https://www.youtube.com/watch?v=LLBrBBImJt4

HID is not a subsystem residing in drivers/staging playground though.

-- 
Jiri Kosina
SUSE Labs

