From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: BUG: Joydev - Broken line compensation does not work for small range inputs
Date: Tue, 22 Jan 2013 21:39:57 -0800
Message-ID: <4466640c-69ae-4232-8136-871955ae6ee6@email.android.com>
References: <dd635eb75d3c9621e698d5458b16811a.squirrel@www.mungewell.org> <04d6d378f8654bc2923cd22e11fd6569.squirrel@www.mungewell.org> <b778032fe6aef2b537b734c6a248c219.squirrel@www.mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46469 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3AWFkC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 00:40:02 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so4513330pad.13
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2013 21:40:02 -0800 (PST)
In-Reply-To: <b778032fe6aef2b537b734c6a248c219.squirrel@www.mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, linux-input@vger.kernel.org

simon@mungewell.org wrote:

>> With a little more digging on this I think the issue is down to the
>> default calibration values.
>
>I have further confirmation that this is due to the calibration used
>when
>the dial is presented via the joystick interface. The values in the
>event
>interface are correct.
>
>See 'joydev_correct()' from 'driver/input/joydev.c'
>
>The problem is that the 'broken line' calibration can not properly
>represent/process a value with a small range - I guess this does not
>matter when there is a large input range.
>
>In my system I have a dial (RZ) with 4 positions (0..3):
>      expect to see -32768, -10922, +10922, +32768
Hi Simon,

I think you should simply use evdev, joydev is legacy interface useful for real joysticks.

Thanks.

-- 
Dmitry
