From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4 1/7] HID: sony: Fix cancel_work_sync mismerge
Date: Thu, 3 Apr 2014 14:24:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404031424140.32122@pobox.suse.cz>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com> <1396456285-23755-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35070 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbaDCMYd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Apr 2014 08:24:33 -0400
In-Reply-To: <1396456285-23755-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Wed, 2 Apr 2014, Frank Praznik wrote:

> Remove redundant cancel_work_sync() call caused by mismerge.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Queued for 3.15, thanks for spotting it, Frank.

-- 
Jiri Kosina
SUSE Labs
