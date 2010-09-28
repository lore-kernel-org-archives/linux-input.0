From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 28 Sep 2010 21:32:07 +0200
Message-ID: <4CA242B7.7020609@euromail.se>
References: <1284476919.3732.10.camel@PhEeeTab>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:34164 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754192Ab0I1TeA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:34:00 -0400
In-Reply-To: <1284476919.3732.10.camel@PhEeeTab>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Philipp Merkel <mail@philmerk.de>
Cc: chatty@enac.fr, linux-input@vger.kernel.org

On 09/14/2010 05:08 PM, Philipp Merkel wrote:

> This patch fixes three problems with the eGalax/DWAV multi-touch
> screen found in the Eee PC T101MT:
> 
> 1) While there is a dedicated multitouch driver for the screen
>    (hid-egalax.c), the MULTI_INPUT quirk is also applied, preventing
>    the hid-egalax driver from working. This patch removes the quirk
>    so the hid-egalax driver can handle the device correctly.
> 2) The x and y coordinates sent by the screen in multi-touch mode are
>    shifted by three bits from the events sent in single-touch mode, thus
>    the coordinates are out of range, leading to the pointer being stuck
>    in the bottom-right corner if no additional calibration is applied
>    (e.g. in the X evdev driver). This patch shifts the coordinates back.
>    This does not decrease accuracy as the last three bits of the "wrong"
>    coordinates are always 0.
> 3) Only multi-touch pressure events are sent, single touch emulation is
>    missing pressure information. This patch adds single-touch
>    ABS_PRESSURE events. 
> 
> Signed-off-by: Philipp Merkel <mail@philmerk.de>
> 


This is a late reply to the whole thread.

I have looked at the joojoo (0eef:720c), and constructed a driver for it using
MT slots. If would be great if it could be merged with the 0eef:480d in the
hid-egalax driver, but there are some things to work out before that can happen.
Here are some observations from the joojoo:

1) The HID report says the x/y coordinates are in the 4096 range, but in
actuality, they are 32kx32k it seems.

2) Reports fingers serially using slots, and there is *no* message indicating a
frame. As Stephane pointed out earlier.

3) Reports x, y and pressure (emulated most likely, since the device is capacitive).

4) Very fast - below 5 ms between completions from preliminary measurements.

5) Only two fingers, but of good quality.

Because of 2), the MT slots protocol is not only suitable, but required unless
additional complicating logic is introduced.

Philipp, Stephane, if you are interested in testing out the driver on the
0eff:480d, please let me know (off list), and we should hopefully be able to
find a merge.

Cheers,
Henrik
