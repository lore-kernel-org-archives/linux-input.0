From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] Fix sentelic multi-touch driver
Date: Thu, 28 Jun 2012 17:17:50 +0800 (CST)
Message-ID: <12062817144218.19930@cnaqrzbavhz.fragryvp.pbz>
References: <1340829375-4995-1-git-send-email-ogoffart@woboq.com>
 <1206281559091.19930@cnaqrzbavhz.fragryvp.pbz> <1624632.HRAD290WOc@gargamel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:38407 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756628Ab2F1JRz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 05:17:55 -0400
In-Reply-To: <1624632.HRAD290WOc@gargamel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Goffart <olivier@woboq.com>
Cc: linux-input@vger.kernel.org

On Thu, 28 Jun 2012, Olivier Goffart wrote:
> On Thursday 28 June 2012 16:02:15 Tai-hwa Liang wrote:
[...]
>>    I have a similar patch to address this issue. Would you please try to
>> see if https://bugzilla.kernel.org/attachment.cgi?id=73991 works for you?
>
> Hi,
>
> That patch also fixes the issue here.  (It fixes scrolling and two finger tap)
> But the case in which you put two finger into the touchpad then release one
> finger is not handled properly. (I took care of that issue)

   Would you please be more specific about the steps to reproduce this?
I've tested both of these two patches but failed to see the difference in
this case.

Thanks,

Tai-hwa Liang
