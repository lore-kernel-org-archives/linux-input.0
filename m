From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/2] input: add MAX8997-haptic driver
Date: Mon, 12 Mar 2012 17:31:24 +0900
Message-ID: <4F5DB45C.4050101@samsung.com>
References: <4F571629.8010203@samsung.com>
 <20120307082900.GA20493@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:21076 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2CLIbb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 04:31:31 -0400
In-reply-to: <20120307082900.GA20493@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

Hi Dmitry,

On 03/07/2012 05:29 PM, Dmitry Torokhov wrote:
> Hi Chanwoo,
> 
> 
> On Wed, Mar 07, 2012 at 05:02:49PM +0900, Chanwoo Choi wrote:
>> MAX8997 has several features in a single chip,
>> This patchset supports unimplemented haptic driver of MAX8997.
>>
>> v2
>> - code clean and remove unnecessary code according to comment of Dmitry
>> Torokhov
> 
> Could you please tell me if the version of the patch I sent to you
> worked or not?

It isn't worked because it use the mutex lock in irq handler stack.
so, I resend v3 patch of max8997-haptic driver after modifying it.

Best Regards,
Chanwoo Choi

