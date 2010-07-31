From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Sun, 01 Aug 2010 01:00:15 +0200
Message-ID: <4C54AAFF.7000206@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD454.4050807@tudelft.nl> <20100721033655.GA9070@core.coreip.homeip.net> <4C532009.4020103@tudelft.nl> <4C533DC3.9070001@euromail.se> <4C53471A.9080001@tudelft.nl> <4C53ECB4.2080700@euromail.se> <20100731093312.GA3461@core.coreip.homeip.net> <4C541BC3.9000100@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:56294 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab0GaXAM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 19:00:12 -0400
In-Reply-To: <4C541BC3.9000100@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Op 31-07-10 14:49, Henrik Rydberg schreef:
> On 07/31/2010 11:33 AM, Dmitry Torokhov wrote:
> [...]
> 
>>> This sounds like a misunderstanding. To rephrase: the suggestion is to always
>>> send the last known one-finger touch point, and to update that point only when
>>> there is a single finger on the pad.
>>>
>>
>> This would break two-finger scrolling mode of synaptics X driver.
> 
> 
> I envision synaptics being MT-aware at some point, but alright, the idea is too
> radical at this stage.
> 
> Back to the original problem. When adding the second finger, the first finger
> will actually be in one of the four corners of the detected rectangle, correct?
> So how about keeping as a state what corner of the rectangle represents the
> original touch, and continue to report that corner as ABS_X/Y during a
> two-finger touch?
That could work, but in general the policy is to not do finger tracking
in the kernel. And still, if you leave this first finger before the
second finger, you'll necessarily see this "jump" as well.

Eric
