From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 16:08:14 -0600
Message-ID: <AANLkTinfvSxQSeGCWm3yJLcTTBX-8xxRHm=AkFgFgBzR@mail.gmail.com>
References: <4CEE6D2A.9040408@euromail.se>
	<4CEE6EE8.4060805@gmail.com>
	<AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
	<4CF0BC13.2010800@gmail.com>
	<20101127083229.GA28745@core.coreip.homeip.net>
	<4CF0C69D.9080904@gmail.com>
	<20101127091533.GA27213@core.coreip.homeip.net>
	<4CF0D35B.4030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35070 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab0K0WIP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 17:08:15 -0500
Received: by yxt3 with SMTP id 3so933857yxt.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 14:08:14 -0800 (PST)
In-Reply-To: <4CF0D35B.4030807@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 3:46 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> On 11/27/2010 12:15 PM, Dmitry Torokhov wrote:
>>
>> 2000LPI == about 79 l/mm. How is it not useable?
>
> TBH, I didn't make any real calculations.
> The introduced error isn't very high, indeed. The vertical size of 4x3 inch
> tablet becomes 75 mm instead of 76 mm. So maybe it's alright.

The wacom's I'm inteterested in have lots of different resolutions
(0.5k to 5k) and different sizes.  I've only calculated a few to see
error but seems no more then a few mm in the ones I chose as well.

It works for me... that is to use units/mm for now and if that ever
shows to be an issue we can move to new units in future.

Thanks all for feedback,
Chris
