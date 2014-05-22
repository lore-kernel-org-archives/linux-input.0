From: Ferruh Yigit <fery@cypress.com>
Subject: Re: ABS_MT_TOUCH_MAJOR metric
Date: Thu, 22 May 2014 22:29:43 +0300
Message-ID: <537E5027.9010705@cypress.com>
References: <537DD98C.5090800@cypress.com> <20140522172353.GA1984@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56526 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaEVT3u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 15:29:50 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so2900437pbb.8
        for <linux-input@vger.kernel.org>; Thu, 22 May 2014 12:29:50 -0700 (PDT)
In-Reply-To: <20140522172353.GA1984@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On 05/22/2014 08:23 PM, Dmitry Torokhov wrote:
> Hi Ferruh,
>
> On Thu, May 22, 2014 at 02:03:40PM +0300, Ferruh Yigit wrote:
>> Hi,
>>
>> What is the metric of ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR events?
>>
>> The Linux documentation
>> <https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt> says:
>> "The length of the major axis of the contact. The length should be given
>> in surface units. ..."
>>
>> What does "surface units" means, is it millimeter or pixels?
> It is whatever unit the device reports, similarly to ABS_MT_POSITION_X
> and ABS_MT_POSITION_Y. Userspace can use EVIOCGABS to map device units
> onto common units.
>
> From include/uapi/linux/input.h (struct input_absinfo):
>
>  * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
>  * units per millimeter (units/mm), resolution for rotational axes
>  * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.
>
> Hope this helps.
>
Hi Dmitry,

I understand this works for Dmitry ABS_X, ABS_Y,
touchscreen reports between 0..A, screen resolution is 0..B, a mapping
can be done 0..A -> 0..B

But for ABS_MT_TOUCH_MAJOR how this scaling can be done,
touchscreen reports between 0..A, do we know the min/max values for
application side?

-- 

Thanks,
ferruh

