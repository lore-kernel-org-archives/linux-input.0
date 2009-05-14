From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux 2.6] new mouse driver looking for review and
	integration (fwd)
Date: Wed, 13 May 2009 20:40:13 -0700
Message-ID: <20090514034004.GE12778@dtor-d630.eng.vmware.com>
References: <0810211135259.24686@cnaqrzbavhz.fragryvp.pbz> <20081030184450.GA18874@anvil.corenet.prv> <0905081258371.25111@cnaqrzbavhz.fragryvp.pbz> <200905082017.34300.dmitry.torokhov@gmail.com> <090513175501E.28934@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:28020 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbZENDkW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:40:22 -0400
Received: by wf-out-1314.google.com with SMTP id 26so656115wfd.4
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:40:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <090513175501E.28934@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

On Wed, May 13, 2009 at 05:56:39PM +0800, Tai-hwa Liang wrote:
> On Fri, 8 May 2009, Dmitry Torokhov wrote:
>> Hi Tai-hwa,
>>
>> On Thursday 07 May 2009 22:30:52 Tai-hwa Liang wrote:
>> > Hi, Dmitry,
>> >
>> >    I'm wondering about the status of the patch you submitted to git.  Will
>> > it being merged into 2.6.31?
>> >
>>
>> I really need to get back to it. The weekend is coming up, I should 
>> have time to go over it, I shall respond by Monday.
>
>   Thanks.  Where is the git repository I can use to retrieve the code you've
> submitted?  I have a few changes for your patched code.
>

I have created "sentelic" branch here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

I fetched the latest version of the driver off the sourceforge page and
used it as the baseline.

The idea is to implement full absolute packet support and not rely on
relative packets because users will expect Synaptics X driver work with
this device as it works with all other touchpads (Synaptics, ALPS,
Elantec, BCM, appletouch).

BTW, I have a few questions regarding protocol:

What is 'arc', x1_g, x2_g, y1_g, y2_g in the absolute packet data?

Thanks!

-- 
Dmitry
