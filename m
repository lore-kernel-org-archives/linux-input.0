From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
Date: Wed, 29 Jan 2014 14:13:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz>
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50206 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbaA2NNI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 08:13:08 -0500
In-Reply-To: <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 23 Jan 2014, Srinivas Pandruvada wrote:

> Remove the hard coded indexes, instead search for usage id and
> use the index to set the power and report state.
> This will fix issue, where the report descriptor doesn't contain
> the full list of possible selector for power and report state.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Jonathan, I'd probably take this together with the patch for HID API 
change. Could you please provide your Ack/Signoff, and I'll take it 
through my tree, if you agree?

Thanks.

-- 
Jiri Kosina
SUSE Labs
