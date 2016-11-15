From: "Xu, Even" <even.xu@intel.com>
Subject: RE: [PATCH 3/3] hid: intel-ish-hid: ipc: use msleep_interrupt() for
 wait
Date: Tue, 15 Nov 2016 14:37:14 +0000
Message-ID: <9577C59DB499174B9340876B077C2E956701E652@SHSMSX101.ccr.corp.intel.com>
References: <1478828433-31779-1-git-send-email-even.xu@intel.com>
 <alpine.LNX.2.00.1611151426300.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbcKOOhU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 09:37:20 -0500
In-Reply-To: <alpine.LNX.2.00.1611151426300.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

Hi, Jiri,

This issue was found by code inspection, no real bug was reported.
Thanks!

Best Regards,
Even Xu

-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Tuesday, November 15, 2016 9:27 PM
To: Xu, Even <even.xu@intel.com>
Cc: linux-input@vger.kernel.org; Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 3/3] hid: intel-ish-hid: ipc: use msleep_interrupt() for wait

On Fri, 11 Nov 2016, Even Xu wrote:

> set_current_task() must be called before schedule_timeout(), for this 
> driver, in order to avoid incorrect usage, use msleep_interrupt() 
> instead.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>

Is this fixing a bug that has been observed / reported in a real life, or has this been found purely via code inspection? (asking to schedule upstream merge properly).

Thanks,

--
Jiri Kosina
SUSE Labs

