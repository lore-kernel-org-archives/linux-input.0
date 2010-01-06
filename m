From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: Questions about Multi-touch Protocal
Date: Wed, 06 Jan 2010 09:49:58 +0900
Message-ID: <4B43DE36.6000907@samsung.com>
References: <4B42D998.4050303@samsung.com> <4B432BDB.3000103@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60699 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab0AFAuA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2010 19:50:00 -0500
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KVS009UWVNANT@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 06 Jan 2010 09:49:59 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KVS007S8VNAYT@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 06 Jan 2010 09:49:58 +0900 (KST)
In-reply-to: <4B432BDB.3000103@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz

On 1/5/2010 9:08 PM, Henrik Rydberg wrote:
> Hi Joonyoung,
> 
>> I have some questions about Multi-touch(MT) Protocal.
> 
> Let me start by answering your last question:
> 
>> Finally, what is difference of ABS_MT_TOUCH_MAJOR and
>> ABS_MT_WIDTH_MAJOR?
> 
> The TOUCH and WIDTH parameters have a geometrical interpretation; imagine
> looking through a window at someone gently holding a finger against the glass.
> You will see two regions, one inner region consisting of the part of the finger
> actually touching the glass, and one outer region formed by the perimeter of the
> finger. The diameter of the inner region is the ABS_MT_TOUCH_MAJOR, the diameter
> of the outer region is ABS_MT_WIDTH_MAJOR. Now imagine the person pressing the
> finger harder against the glass. The inner region will increase, and in general,
> the ratio ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR, which is always smaller than
> unity, is related to the finger pressure.
> 

Aha, i understand :)

> In addition to the MAJOR parameters, the oval shape of the finger can be
> described by adding the MINOR parameters, such that MAJOR and MINOR are the
> major and minor axis of an ellipse. Finally, the orientation of the oval shape
> can be describe with the ORIENTATION parameter.
> 
>> First, what is the purpose of ABS_MT_TOUCH_MAJOR event? I wonder how
>> it is used at userspace side.
> 
> In a graphical program it can of course be used as is, but in the specific
> application of creating gesture events, the TOUCH and WIDTH parameters can be
> used to, e.g., approximate finger pressure or distinguish between index finger
> and thumb. With the addition of the MINOR parameters, one can also distinguish
> between a sweeping finger and a pointing finger, and with ORIENTATION, one can
> detect twisting of fingers.
> 
>> Should the ABS_MT_TOUCH_MAJOR be the mininum set of events for multi
>> touch? I'm not sure whether this question is valid because of first
>> question.
> 
> Each finger packet should have an ABS_MT_TOUCH_MAJOR value. In can be computed
> from various types of sensory input, e.g., the size of the contact area or a
> pressure sensor.
> 

Hmm, I think ABS_MT_TOUCH_MAJOR is similar to ABS_PRESSURE, of course it
can be used other purposes. If the device doesn't support the pressure,
the driver doesn't report ABS_PRESSURE, so if the device cannot get a
touching size of the finger, how can the driver report it?

The ABS_MT_TOUCH_MAJOR needs for several things as you explain, but i
think it isn't essential event for multi-touch such ABS_PRESSURE.
If we can get only the coodinates of each fingers, is it full enough for
minimum supporting of multi-touch?

Thanks for explanation.
