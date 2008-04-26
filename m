From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] gpio-keys debouncing support
Date: Sat, 26 Apr 2008 19:14:38 +0000 (UTC)
Message-ID: <fuvuuu$kpa$1@ger.gmane.org>
References: <20080319221323.GA2710@doriath.ww600.siemens.net>
	<20080421144019.GA6516@doriath.ww600.siemens.net>
	<20080421155516.GD6884@anvil.corenet.prv>
	<20080422011448.GA16851@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:53828 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761534AbYDZTOz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2008 15:14:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JpprE-0007iP-28
	for linux-input@vger.kernel.org; Sat, 26 Apr 2008 19:14:48 +0000
Received: from ppp78-37-170-127.pppoe.avangarddsl.ru ([78.37.170.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 26 Apr 2008 19:14:48 +0000
Received: from dbaryshkov by ppp78-37-170-127.pppoe.avangarddsl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 26 Apr 2008 19:14:48 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Dmitry Baryshkov wrote:

> Hi,
> 
> On Mon, Apr 21, 2008 at 11:55:16AM -0400, Dmitry Torokhov wrote:
>> Hi Dmitry,
>> 
>> On Mon, Apr 21, 2008 at 06:40:19PM +0400, Dmitry Baryshkov wrote:
>> > Hi,
>> > 
>> > What about this patch? I still got no comments.
>> > 
>> > 
>> I thought I CCed you form slightly different thread. I don't think that
>> this should be a separate Kconfig option, we shoudl make it permanent
>> in the driver. I also wonder if it would be better to allocate debounce
>> data once for all buttons instead of nickel-and-dime-ing memory
>> allocator with tiny requests. Timer shoudl be moved into debounce data
>> too BTW.
> 
> Please review the updated patch:
> 
> From acf6027db75bca502d1baf45e48418ddb7aadcb7 Mon Sep 17 00:00:00 2001
> From: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Date: Tue, 22 Apr 2008 05:12:07 +0400
> Subject: [PATCH] gpio-keys debouncing support
> 

So, what about this patch?

-- 
With best wishes
Dmitry


