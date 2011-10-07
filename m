From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] Input: psmouse - change log messages from psmouse.c to
 psmouse
Date: Fri, 07 Oct 2011 16:15:42 +0800
Message-ID: <4E8EB52E.2080005@cn.fujitsu.com>
References: <1317273295-4931-1-git-send-email-jj_ding@emc.com.tw> <4E83FF81.700@cn.fujitsu.com> <20111007063926.GA32142@core.coreip.homeip.net>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:52245 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758795Ab1JGIQo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Oct 2011 04:16:44 -0400
In-Reply-To: <20111007063926.GA32142@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

On 10/07/2011 02:39 PM, Dmitry Torokhov wrote:

> Hi JJ, Wanlong,
> 
> On Thu, Sep 29, 2011 at 01:17:53PM +0800, Wanlong Gao wrote:
>> On 09/29/2011 01:14 PM, JJ Ding wrote:
>>
>>> From: JJ Ding <dgdunix@gmail.com>
>>>
>>> psmouse.c had long been renamed to psmouse-base.c back in 2003, when we
>>> were still at Linux 2.5.xx. This change makes the log less misleading.
>>>
>>> Signed-off-by: JJ Ding <dgdunix@gmail.com>
>>
>> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>>
> 
> Actually, I (and other people) wanted to go through psmouse logging and
> make it all consistent. What do you think about the patch below?
> 
> Thanks.
> 


Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

It seems better.
I can patch to all except input/mouse/elantech.c now, maybe I need
*git pull*?

Thanks, Dmitry
-Wanlong Gao
