From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
Date: Sun, 7 Aug 2016 12:15:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53337 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbcHGKPu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Aug 2016 06:15:50 -0400
In-Reply-To: <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org

On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:

> Some platforms power off sensor hubs during S3 suspend, which will require
> longer time to resume. This hurts system resume time, so resume
> asynchronously.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Jonathan, are you going to cherry-pick this patch from the series? 
Alternatively, if you're okay with it, I can pull it in together with the 
whole set with your Acked-by or Reviewed-by.

Thanks,

-- 
Jiri Kosina
SUSE Labs

