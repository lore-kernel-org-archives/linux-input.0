From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: uinput oopses and bugs
Date: Fri, 28 Mar 2008 20:46:59 +0200
Message-ID: <47ED3D23.5050605@gmail.com>
References: <beee72200803260141y59b96c56n9fccfda6c72d1783@mail.gmail.com>	 <20080326132844.GC25854@cathedrallabs.org>	 <beee72200803260709p7239ae8etb4e00b608bbfb6bc@mail.gmail.com>	 <20080326182314.GF25854@cathedrallabs.org>	 <beee72200803270115v72eb1cd3s38ae90a4efd6acd1@mail.gmail.com>	 <20080327202245.GK25854@cathedrallabs.org> <beee72200803271755u468f5d0djd10d282593644a7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:35485 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbYC1SrH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Mar 2008 14:47:07 -0400
In-Reply-To: <beee72200803271755u468f5d0djd10d282593644a7d@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: davor emard <davoremard@gmail.com>
Cc: Aristeu Rozanski <aris@cathedrallabs.org>, linux-input@vger.kernel.org

davor emard wrote:
>>> There is also a still issue with segfault and unkillable driver.
>>> I upload custom FF effect, driver segfaults but doesn't exit
>>> and becomes zombie
>> please test the attached patch
> 
> The patch now avoids the zombie lockup coming from segmentation
> fault.  Thanks a lot, that is great step forward!
> 
> However it's still not clear to me why do I get this segmentation
> fault when I try to upload a block of FF_CUSTOM sample data.
> I made my code mainly from looking at the kernel source without
> having any example - anyone on the list can point link to some small
> code example?
> 
> in uinput-zombie, I've prepared the data in application, ioctl'ed them
> to uinput event device and the uinput driver segfaults when
> it tries to read the portion of  FF_CUSTOM data.

I think uinput needs special handling for FF_CUSTOM to deliver the ff
data to userspace. AFAIK the segfault occurs because the uinput driver
tries to read the data pointer, while the data is only in kernel and not
copied to userspace.

I haven't seen any driver yet, uinput or in-kernel, that supports
FF_CUSTOM, so this could've been overlooked quite easily. It is in my
TODO to implement it for PID devices, but I do not have time anytime soon.

-- 
Anssi Hannula
