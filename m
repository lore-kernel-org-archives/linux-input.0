From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/7 v3] HID: magicmouse: simplify touch down logic
Date: Thu, 2 Sep 2010 16:50:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009021650170.26813@pobox.suse.cz>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>  <1283306184-28833-5-git-send-email-chase.douglas@canonical.com> <1283307807.16204.3.camel@graviton>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33185 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593Ab0IBOux (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 10:50:53 -0400
In-Reply-To: <1283307807.16204.3.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 Aug 2010, Michael Poole wrote:

> On Tue, 2010-08-31 at 21:56 -0400, Chase Douglas wrote:
> > From: Chase Douglas <chase.douglas@ubuntu.com>
> > 
> > For the MT protocol, we need to properly keep track of each down touch.
> > This change simplifies the logic, and should make things easier when
> > support for the Magic Trackpad is added.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> Thanks, this looks slightly cleaner than what I had in mind.
> 
> Acked-by: Michael Poole <mdpoole@troilus.org>

Applied ('magicmouse' branch). Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
