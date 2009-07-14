From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
 controller
Date: Tue, 14 Jul 2009 16:26:00 +0900
Message-ID: <4A5C3308.7000404@samsung.com>
References: <4A56A304.3050009@samsung.com>
 <20090714060403.GE2822@dtor-d630.eng.vmware.com>
 <001901ca044f$0314e930$093ebb90$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9127 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZGNH0C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 03:26:02 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KMR001NBGNC44@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 14 Jul 2009 16:26:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KMR005WZGNCSV@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 14 Jul 2009 16:26:00 +0900 (KST)
In-reply-to: <001901ca044f$0314e930$093ebb90$%szyprowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com, Tomasz Fujak <t.fujak@samsung.com>

On 7/14/2009 3:47 PM, Marek Szyprowski wrote:
> Hello,
> 
> On Tuesday, July 14, 2009 8:04 AM, Dmitry Torokhov wrote:
> 
>> Hi Joonyoung,
>>
>> On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
>>> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
>>> controller can see at the following website:
>>>
>>> http://www.melfas.com/product/product01.asp?k_r=eng_
>>>
>>> This driver is tested on s3c6410 NCP board and supports only the i2c
>>> interface.
>>>
>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>> ---
>>> Dear Dmitry,
>>>
>>> I sent the patch v2, but couldn't get any response.
>>> This patch v3 is updated a little bit from v2.
>>>
>> While I was sittign on the patch mainline acquired threaded IRQ support
>> which fits the bill here and simplifies logic quite a bit, could you
>> please try the patch below and tell me if the touchscreen still works?
> 
> I have no idea what I do wrong, but this patch also does not apply here:
> 
> $ git apply touchscreen-update.diff
> error: patch failed: drivers/input/touchscreen/mcs5000_ts.c:259
> error: drivers/input/touchscreen/mcs5000_ts.c: patch does not apply
> 
> $ patch -p1 < touchscreen-update.diff
> patching file drivers/input/touchscreen/mcs5000_ts.c
> Hunk #6 FAILED at 196.
> 1 out of 7 hunks FAILED -- saving rejects to file drivers/input/touchscreen/mcs5000_ts.c.rej

Hmm, I've tried '$ patch -p1' also, but i have no problem.

Marek,
This patch of Dmitry needs the latest kernel source, but our source 
doesn't seem latest, so i cannot compile.  Can you update to the latest
kernel?

> 
> I've tried it on clean 'v3' patch posted in '[PATCH v3] Input: add
> touchscreen driver for MELFAS MCS-5000 controller' mail on Friday 
> 2009-07-10 04:10.
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 
> 
> 

