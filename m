From: "Xu, Even" <even.xu@intel.com>
Subject: RE: [PATCH 0/3] Clean up ipc wait times
Date: Thu, 17 Nov 2016 01:14:40 +0000
Message-ID: <9577C59DB499174B9340876B077C2E956701FF76@SHSMSX101.ccr.corp.intel.com>
References: <1478828319-31590-1-git-send-email-even.xu@intel.com>
 <alpine.LNX.2.00.1611161144220.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbcKQBOm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 20:14:42 -0500
In-Reply-To: <alpine.LNX.2.00.1611161144220.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

Thanks, Jiri!

Best Regards,
Even Xu

-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Wednesday, November 16, 2016 6:45 PM
To: Xu, Even <even.xu@intel.com>
Cc: linux-input@vger.kernel.org; Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 0/3] Clean up ipc wait times

On Fri, 11 Nov 2016, Even Xu wrote:

> This series addresses issue with schedule_timeout() calls and cleans 
> up code around this.
> 
> Even Xu (3):
>   hid: intel-ish-hid: ipc: remove unused macro
>   hid: intel-ish-hid: ipc: change timed_wait_for_timeout() to be a
>     function
>   hid: intel-ish-hid: ipc: use msleep_interrupt() for wait
> 
>  drivers/hid/intel-ish-hid/ipc/ipc.c   | 66 +++++++++++++++++++++++++++++++----
>  drivers/hid/intel-ish-hid/ipc/utils.h | 64 
> ---------------------------------
>  2 files changed, 60 insertions(+), 70 deletions(-)  delete mode 
> 100644 drivers/hid/intel-ish-hid/ipc/utils.h

Applied to hid.git#for-4.10/intel-ish. Thanks,

--
Jiri Kosina
SUSE Labs

