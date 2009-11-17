From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: A question about touchscreen absmax value
Date: Tue, 17 Nov 2009 15:18:31 +0900
Message-ID: <4B024037.2000807@samsung.com>
References: <4B00B08E.2030905@samsung.com>
 <20091116171202.GC24026@core.coreip.homeip.net> <4B0211B8.4020508@samsung.com>
 <20091117054822.GA6451@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:58588 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZKQGS0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2009 01:18:26 -0500
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KT800KS3PIU8G@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 17 Nov 2009 15:18:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KT8007RUPIUTY@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 17 Nov 2009 15:18:30 +0900 (KST)
In-reply-to: <20091117054822.GA6451@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 11/17/2009 2:48 PM, Dmitry Torokhov wrote:
> On Tue, Nov 17, 2009 at 12:00:08PM +0900, Joonyoung Shim wrote:
>> On 11/17/2009 2:12 AM, Dmitry Torokhov wrote:
>>> Hi Joonyoung,
>>>
>>> On Mon, Nov 16, 2009 at 10:53:18AM +0900, Joonyoung Shim wrote:
>>>> Hi, all.
>>>>
>>>> I have a question about touchscreen resolution. My touchscreen device
>>>> can report the position from 0 to 1023 of x and y coordinates, so i
>>>> setted the absmax of input device to 1023. BTW, i only can get from 0 to 
>>>> 479 x position and to 799 y position because the LCD resolution of the
>>>> target is 480 x 800. I wonder which value is setted to the absmax - 479
>>>> and 799 or 1023.
>>> I believe driver should, by default, set absmin and absmax to match the
>>> limits of the hardware/protocol. In your case it would be 1023. The
>>> driver may choose to accept additional infromation from platform data, if
>>> present, you can also adjust absmin/absmax etc via ioctl durng the
>>> bootup sequence.
>> Hmm, i get the resolution information from platform data, so i can 
>> set absmax values from platform data. Is it ok?
>>
> 
> Sure, if there is only one possible configuration for the device on a
> given platform - yes.
> 

OK, it is helpful me.

Thanks.
