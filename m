From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 5/7 v3] HID: magicmouse: remove timestamp logic
Date: Thu, 2 Sep 2010 16:52:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009021652080.26813@pobox.suse.cz>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>  <1283306184-28833-6-git-send-email-chase.douglas@canonical.com> <1283307893.16204.5.camel@graviton>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50733 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0IBOwV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 10:52:21 -0400
In-Reply-To: <1283307893.16204.5.camel@graviton>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 Aug 2010, Michael Poole wrote:

> On Tue, 2010-08-31 at 21:56 -0400, Chase Douglas wrote:
> > From: Chase Douglas <chase.douglas@ubuntu.com>
> > 
> > The timestamps from the device are currently stored in the private data
> > structure. These aren't used, so remove them. I've left a comment
> > detailing the protocol for future reference.
> > 
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> Acked-by: Michael Poole <mdpoole@troilus.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
