From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
 series SoCs
Date: Mon, 07 Sep 2009 16:31:53 +0900
Message-ID: <4AA4B6E9.2070603@samsung.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
 <4AA49C53.3030400@samsung.com> <20090907063341.GT3962@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40019 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZIGHbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 03:31:52 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPL00EE1BL5EQ@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 16:31:53 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPL00AJFBL5BJ@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Sep 2009 16:31:53 +0900 (KST)
In-reply-to: <20090907063341.GT3962@prithivi.gnumonks.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?UTF-8?B?Iuq5gOqyveydvA==?= =?UTF-8?B?L0FQ6rCc67Cc7YyAKFNZUy5MU0kpL0UzKOyCrOybkCkv7IK87ISx7KCE7J6QIg==?= <ki0351.kim@samsung.com>, =?UTF-8?B?IifquYDqta3sp4QvQVDqsJzrsJztjIAoU1lT?= =?UTF-8?B?LkxTSSkvRTUo7LGF7J6EKS/sgrzshLHsoITsnpAnIg==?= <kgene.kim@samsung.com>, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On 9/7/2009 3:33 PM, Harald Welte wrote:
> On Mon, Sep 07, 2009 at 02:38:27PM +0900, Joonyoung Shim wrote:
>> We already implemented and tested the keypad driver for s5pc100 &
>> s5pc110 and maybe it will operate on s3c64xx. We use the samsung prefix
>> to support three cpu. Because there is no the arch for s5pc100 and
>> s5pc110, this driver doesn't compile yet on upstream kernel.
> 
> The schedule of System LSI (the department that makes the SoC and provides the
> BSP) is to first complete the 6410 support in the mainline kernel, and then
> incrementally submit the core architecture code for 6440, c100 and c110,
> followed by driver additions.
> 
> So the events (ordered by time) have to be in the following order
> 
> 1) the s3c-keypad driver with 6400/6410 support needs to be submitted and
>    submitted mainline.  This is what Jinsun was starting, and which he
>    will continue until it is included mainline.
> 

The keypad of s3c64xx and s5pc1xx is same almost, so we need to submit
the well-defined driver from the first.

> 2) the c100 / c110 or other SoC core architecture support needs to be
>    submitted mainline.  Nobody at System LSI is working on this yet,
>    but they already have a tree based on 2.6.31-rcX for this.  I suppose
>    the real work on submitting this will only be started after most of the
>    pending 6410 stuff has been submitted.
> 
> 3) Samsung (either system LSI or DMC) can then send an incremental patch
>    for adding 6440/c100/c110 support to the s3c-keypad driver.
> 
> Regards,

