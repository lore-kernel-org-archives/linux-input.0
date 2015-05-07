From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: prodikeys, remove unused variable
Date: Thu, 7 May 2015 10:36:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071036160.8186@pobox.suse.cz>
References: <1430813393-28661-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48291 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbbEGIg2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 04:36:28 -0400
In-Reply-To: <1430813393-28661-1-git-send-email-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 5 May 2015, Jiri Slaby wrote:

> 'key' is set but never used in the first loop. So remove the set.
> 
> And indent the re-set of pm->last_key properly.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied to for-4.2/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs
