From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE
 Chips
Date: Mon, 28 Dec 2015 07:00:15 -0800
Message-ID: <1451314815.4194.1.camel@linux.intel.com>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1512281309320.9922@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21814 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbbL1PCj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 10:02:39 -0500
In-Reply-To: <alpine.LNX.2.00.1512281309320.9922@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, nish.aravamudan@gmail.com, linux-input@vger.kernel.org

On Mon, 2015-12-28 at 13:09 +0100, Jiri Kosina wrote:
> On Fri, 18 Dec 2015, Srinivas Pandruvada wrote:
> 
> > This needs same quirk as applied to other YOGA sensor hubs.
> > Refer to
> > 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with
> ITE")
> 
> Which tree is this SHA from?

Good question. I copied the description from commit
 e8e88438008375b17561dcc6a22abc24decf04ac
Which has referred to 47eeca8a48.

I resubmitted my patch with the the correct SHA id.

Thanks,
Srinivas


> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
