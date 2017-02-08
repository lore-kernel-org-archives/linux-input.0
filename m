From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: intel-ish-hid: ipc: check FW status to distinguish
 ISH resume paths
Date: Wed, 8 Feb 2017 12:13:32 +0900 (JST)
Message-ID: <alpine.LSU.2.20.1702081213190.25930@cbobk.fhfr.pm>
References: <1486103093-2375-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41075 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbdBHDdn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 22:33:43 -0500
In-Reply-To: <1486103093-2375-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Even Xu <even.xu@intel.com>
Cc: srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org

On Fri, 3 Feb 2017, Even Xu wrote:

> For ISH resume, there are two paths, they need different way to handle:
> one where ISH is not powered off, in that case a simple resume message
> is enough, in other case we need a reset sequence.
> 
> We can use ISH FW status to distinguish those two cases and handle them
> properly.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>

Applied to for-4.11/intel-ish. Thanks,

-- 
Jiri Kosina
SUSE Labs

