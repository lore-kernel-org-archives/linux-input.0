From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH V10] add 88pm80x onkey driver
Date: Wed, 25 Jul 2012 00:30:34 +0200
Message-ID: <20120724223034.GB11304@sortiz-mobl>
References: <1342509459-16976-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56449 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab2GXWag (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 18:30:36 -0400
Content-Disposition: inline
In-Reply-To: <1342509459-16976-1-git-send-email-zhouqiao@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Zhou

On Tue, Jul 17, 2012 at 03:17:38PM +0800, Qiao Zhou wrote:
> change log [v10->v9]:
> 1, change pr_err to dev_err.
> 2, add device_init_wakeup(,0) when device removes.
> 3, add ack by Dmitry.
Patch applied, sorry for the delay.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
