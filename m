From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: remove redundant check for -ve err
Date: Thu, 6 Apr 2017 20:34:44 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704061447230.28004@cbobk.fhfr.pm>
References: <20170327175118.28322-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbdDFSeq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Apr 2017 14:34:46 -0400
In-Reply-To: <20170327175118.28322-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 27 Mar 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> err is being checked for failure each time it is being updated
> so this err check is totally redundant and can be removed
> 
> Detected with CoverityScan, CID#1420665 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-4.12/sony.

-- 
Jiri Kosina
SUSE Labs

