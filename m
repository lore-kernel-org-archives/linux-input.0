From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: add missed stylus_in_proximity line back
Date: Tue, 3 May 2016 12:06:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605031159140.27942@cbobk.fhfr.pm>
References: <1462249054-3515-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42520 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbcECKGG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2016 06:06:06 -0400
In-Reply-To: <1462249054-3515-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, 2 May 2016, Ping Cheng wrote:

> Patch 7e12978 removed stylus_in_proximity flag for Intuos series.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>

The changelog and metadata deserved some more love. I've fixed that up and 
applied to for-4.6/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

