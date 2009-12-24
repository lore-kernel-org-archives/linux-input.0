From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC] ff-memless instant starting
Date: Fri, 25 Dec 2009 01:52:42 +0200
Message-ID: <4B33FECA.1050407@iki.fi>
References: <1261575074.24604.31.camel@tema> <20091223193805.GB4525@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:33347 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZLXXwo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 18:52:44 -0500
In-Reply-To: <20091223193805.GB4525@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jari Vanhala <ext-jari.vanhala@nokia.com>, Linux Input <linux-input@vger.kernel.org>

On 23.12.2009 21:38, Dmitry Torokhov wrote:
> On Wed, Dec 23, 2009 at 03:31:14PM +0200, Jari Vanhala wrote:
>> Hi,
>>
>> Looks like starting effect with low HZ machine takes considerably time
>> due need to wait for system timer. Simplest way to make things faster is
>> to do calculation for effect always instantly, like in stopping, but
>> this makes starting multiple effects more costly.
>>
>> Other solution would be making it a module parameter, so behavior could
>> be controlled per machine. Optimize possible cost or speed. I attached
>> small patch which will do that.
>>
>> If starting priority of individual effect is needed to controlled, you
>> probably need to add flag for that to effect itself... I don't know
>> which way FF-api is developing, so this could be either good or bad
>> thing.
>>
>> Any opinions or suggestions? Other than rising HZ. =)
>>
> 
> I think we should just start playing the effect immediately, without any
> additional module parameters. I'll queue such patch unless I hear
> otherwise from Anssi.

Indeed that is ok, no need for a module parameter.

-- 
Anssi Hannula
