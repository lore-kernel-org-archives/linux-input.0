From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 5/7] elantech: report position also with 3 fingers
Date: Fri, 30 Jul 2010 20:37:03 +0200
Message-ID: <4C531BCF.50409@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl> <4C1FD48C.3040506@tudelft.nl> <20100721033821.GB9070@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:39693 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab0G3TDB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 15:03:01 -0400
In-Reply-To: <20100721033821.GB9070@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On 21-07-10 05:38, Dmitry Torokhov wrote:
:
>> +	case 3:
>> +		/*
>> +		 * Same as one finger, except report of more than 3 fingers:
>> +		 * byte 3:  n4  .   w1  w0   .   .   .   .
>> +		 */
>> +		if (packet[3]&  0x80)
>> +			fingers = 4;
>> +		/* pass through... */
>
> Are we certain it is 4-finger and not equivalent of "palm detect" flag?
> I could not locate the equivalent in Ubutu sources, where did you get
> this data?
Hi,

I've just tried it on my hardware, when putting the palm, only one 
finger is actually reported, with a large width. This flag is definitely 
only when 4 (or more fingers) are reported.

It's one of the small things not found in the ubuntu/dell driver, but 
that I just found out by observing the output.

Eric
