From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: wm97xx - use EBUSY instead of EINVAL
Date: Thu, 04 Jun 2009 10:26:40 +0900
Message-ID: <4A2722D0.5000906@samsung.com>
References: <4A260DEB.2040306@samsung.com>
 <20090603100120.GA31919@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:41237 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbZFDB0j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2009 21:26:39 -0400
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KKO009REXCG2E@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 04 Jun 2009 10:26:40 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KKO00BVYXCG6C@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 04 Jun 2009 10:26:40 +0900 (KST)
In-reply-to: <20090603100120.GA31919@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On 6/3/2009 7:01 PM, Mark Brown wrote:
> On Wed, Jun 03, 2009 at 02:45:15PM +0900, Joonyoung Shim wrote:
>> If request_irq() fails, we have to return -EBUSY instead of -EINVAL.
> 
> Could you provide a bit more explanation for this one, please?  -EBUSY
> seems to give entirely the wrong impression to applications since in the
> systems where this driver will be deployed a failure to acquire the IRQ
> is most likely to be due to incorrect platform data and it is highly
> unlikely to resolve itself.

-EBUSY is used in many touchscreen drivers currently, but i agree dmitry
opinion to propagate what request_irq() returned because request_irq() can
return different errnos.

Thanks.
