From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v4] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Thu, 15 Jul 2010 10:50:16 +0900
Message-ID: <4C3E6958.6090708@samsung.com>
References: <1278488423-2727-1-git-send-email-jy0922.shim@samsung.com>
 <20100713165152.GC26529@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47194 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125Ab0GOBuZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 21:50:25 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L5K00ISUT3SMWA0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 15 Jul 2010 10:50:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L5K0037YT3SDK@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 15 Jul 2010 10:50:16 +0900 (KST)
In-reply-to: <20100713165152.GC26529@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, rydberg@euromail.se, khali@linux-fr.org

Hello.

On 7/14/2010 1:51 AM, Dmitry Torokhov wrote:
> On Wed, Jul 07, 2010 at 04:40:23PM +0900, Joonyoung Shim wrote:
>> This chip full name is AT42QT602240 or ATMXT224. This is the capacitive
>> touchscreen supporting 10 multitouch and uses I2C interface.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> Henrik, Jean,
> 
> Have your concerns with this patch been addressed? If I get your
> acked-by I am ready to apply it.
> 
> Thanks.
> 

Sorry Dmitry, i will post patch v5. The patch v5 change is a few code 
cleanup mostly. If possible, please apply patch v5.
