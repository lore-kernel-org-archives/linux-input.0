From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: sony: Set the Sixaxis cable state correctly
Date: Mon, 1 Sep 2014 11:21:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409011121390.2481@pobox.suse.cz>
References: <1409332312-2414-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46192 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbaIAJVu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Sep 2014 05:21:50 -0400
In-Reply-To: <1409332312-2414-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Fri, 29 Aug 2014, Frank Praznik wrote:

> Bit 3 in byte 31 of the Sixaxis report indicates whether the battery is
> charging or not charging as opposed to whether or not the cable is plugged in.
> As a result, when connected via USB and fully charged, the power_supply status
> is wrongly reported as 'Discharging' instead of 'Full'.
> 
> Use the battery level value to set the cable state so that the power status
> is reported correctly as that seems to be the only reliable way to determine the
> cable status on the Sixaxis.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
