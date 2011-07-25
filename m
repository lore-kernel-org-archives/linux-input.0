From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] drivers:input:set driver data to NULL for pcap_keys
Date: Mon, 25 Jul 2011 17:14:11 +0800
Message-ID: <4E2D33E3.9090408@cn.fujitsu.com>
References: <1311176068-9934-1-git-send-email-wanlong.gao@gmail.com> <20110725083048.GD22937@core.coreip.homeip.net>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:63559 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GYJPM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 05:15:12 -0400
In-Reply-To: <20110725083048.GD22937@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wanlong Gao <wanlong.gao@gmail.com>, linux-input@vger.kernel.org, gregkh@suse.de

On 07/25/2011 04:30 PM, Dmitry Torokhov wrote:
> On Wed, Jul 20, 2011 at 11:34:28PM +0800, Wanlong Gao wrote:
>> It's better to set the device's driver data to NULL
>> when remove it.
>>
>
> I'd rather have platform devices core clean up this pointer, then we
> could stop caring about it in all drivers...
But the platform devices core just call the method of each own.
And don't care about the details like pdata, etc.

Meanwhile, I think the platform core need not care about these details.

and Greg, what do you think about this?

-- 
Thanks
Best Regards
Wanlong Gao
