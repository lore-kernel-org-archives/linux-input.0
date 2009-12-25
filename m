From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Fri, 25 Dec 2009 02:17:59 +0200
Message-ID: <4B3404B7.3050702@iki.fi>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com> <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz> <fce72f9b0912101237x5f38300bxcd0fbb815ad5ea9c@mail.gmail.com> <alpine.LNX.2.00.0912151451060.3755@pobox.suse.cz> <20091219085353.GA2782@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sirokuusama.dnainternet.net ([83.102.40.133]:54434 "EHLO
	sirokuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755AbZLYASB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Dec 2009 19:18:01 -0500
In-Reply-To: <20091219085353.GA2782@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Gary Stein <lordcnidarian@gmail.com>, linux-input@vger.kernel.org, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

On 19.12.2009 10:53, Dmitry Torokhov wrote:
> On Tue, Dec 15, 2009 at 02:53:26PM +0100, Jiri Kosina wrote:
>> On Thu, 10 Dec 2009, Gary Stein wrote:
>>> However, also in this code is the (int) cast fix that I send before to 
>>> linux-kernel in ff-memless.  Without this, my driver or the normal 
>>> logitech driver for other sticks seems to work for me.
>>
>> Dmitry, will you pick that one up for your tree? 
>>
> 
> Yes, but not quite like that - I think there may be more issues with
> 'gain' being unsigned int. How about below instead?
> 
> [Some more people added to CC.]

Seems to work.

Acked-by: Anssi Hannula <anssi.hannula@iki.fi>

-- 
Anssi Hannula
