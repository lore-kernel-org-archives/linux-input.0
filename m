From: simon@mungewell.org
Subject: Re: BUG: Joydev - Broken line compensation does not work for small
 range inputs
Date: Wed, 23 Jan 2013 12:06:42 -0500
Message-ID: <65291f9461742ff807017cf8acec5dca.squirrel@mungewell.org>
References: <dd635eb75d3c9621e698d5458b16811a.squirrel@www.mungewell.org>
    <04d6d378f8654bc2923cd22e11fd6569.squirrel@www.mungewell.org>
    <b778032fe6aef2b537b734c6a248c219.squirrel@www.mungewell.org>
    <4466640c-69ae-4232-8136-871955ae6ee6@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:41808 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab3AWRGo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2013 12:06:44 -0500
In-Reply-To: <4466640c-69ae-4232-8136-871955ae6ee6@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org


>>The problem is that the 'broken line' calibration can not properly
>>represent/process a value with a small range - I guess this does not
>>matter when there is a large input range.
>>
>>In my system I have a dial (RZ) with 4 positions (0..3):
>>      expect to see -32768, -10922, +10922, +32768
> Hi Simon,
>
> I think you should simply use evdev, joydev is legacy interface useful for
> real joysticks.

If the use of joydev is truely depricated then a "won't fix" is fine I
guess, but a lot of applications seem to use this...

As I noted you can disable the calibration with something like 'jscal -s
8,0,0,0,0,0...' in order to get 'raw' values via '/dev/input/js0'
interface - this might be sufficient for a user to make use of the
dial/etc.

Thanks,
Simon.

PS. The irony is that although SDL2.0 use the evdev interface, they show a
similar problem due to integer math in their calibration code/coefs... ho
hum off to patch I guess :-)


