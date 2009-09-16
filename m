From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v4] Input: add touchscreen driver for MELFAS MCS-5000
 controller
Date: Thu, 17 Sep 2009 08:53:24 +0900
Message-ID: <4AB17A74.7080609@samsung.com>
References: <4AB07B5E.7040501@samsung.com>
 <20090916060017.GG2756@core.coreip.homeip.net> <4AB08383.9080107@samsung.com>
 <4AB088CF.7080002@samsung.com> <20090916072702.GH2756@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38179 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbZIPXx3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 19:53:29 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KQ3009X2912WI@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 17 Sep 2009 08:53:26 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KQ3006YT910RY@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 17 Sep 2009 08:53:24 +0900 (KST)
In-reply-to: <20090916072702.GH2756@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

On 9/16/2009 4:27 PM, Dmitry Torokhov wrote:
> On Wed, Sep 16, 2009 at 03:42:23PM +0900, Joonyoung Shim wrote:
>> Hi, Dmitry.
>>
>> I send the patch v5. This is the patch fixed from v4 feedback, and i
>> added a copyright in header file.
>>
> 
> Looks good, thanks. It will be included in my next pull request.
> 

Thanks.

However, i saw a commit for MCS-5000 on for-linux branch of your git 
repository, and the driver was a old thing, maybe patch v3. Please apply 
the patch v5 posted yesterday.
