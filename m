From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] Input: Add direction to ff-memless
Date: Wed, 09 Dec 2009 03:15:22 +0200
Message-ID: <4B1EFA2A.6000403@iki.fi>
References: <1259931914-6228-1-git-send-email-ext-jari.vanhala@nokia.com>	 <4B1D70C4.9000603@iki.fi> <1260263284.19783.1758.camel@tema>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:51371 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967058AbZLIBPS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 20:15:18 -0500
In-Reply-To: <1260263284.19783.1758.camel@tema>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext-jari.vanhala@nokia.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Jari Vanhala wrote:
> On Mon, 2009-12-07 at 22:16 +0100, ext Anssi Hannula wrote:
>> Jari Vanhala wrote:
>>> +static unsigned int ml_calculate_direction(
>>> +	unsigned int direction, unsigned int force,
>>> +	unsigned int new_direction, unsigned int new_force)
>>> +{
>>> +	return ((u32)direction * force + new_direction * new_force) /
>>> +		(force + new_force);
>>> +}
>> What if direction is 0xf000 and new_direction is 0x1000? The correct
>> behaviour would be to use direction 0x0000 or so, but this code would
>> return 0x8000 (assuming equal forces).
> 
> I know it's not perfect, but it's simple and gives good enough result.
> And I just need to know which side of 0x8000 it is.

Ah, I assumed the motor directions (forward, reverse) were mapped to
up/down (180/0), not left/right.

Your way seems somewhat counter-intuitive, but it indeed makes
ml_calculate_direction() simpler :) And as there are no other rumble
drivers using the direction field, I guess the wrong results do not
matter, then.

I think a comment should be added in ml_calculate_direction(), anyway,
to make it clear that it only works correctly with motors with
left/right directions only.

-- 
Anssi Hannula
