From: Tj <linux@iam.tj>
Subject: Re: HID: asus: Add T100CHI bluetooth keyboard dock touchpad support
Date: Tue, 14 Nov 2017 20:09:00 +0000
Message-ID: <1ac0aab543099ef88f71b44193e1cf30@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:43876 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752151AbdKNUPH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 15:15:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

With kernel v4.14 on an Asus T300CHI this appears to be working up to a
point but it causes the touchpad to FAIL to work on earlier kernels.

The touchpad seems to be in multitouch mode (two-finger scrolling is 
the
only MT action I've confirmed so far) but there are some deficiencies.

For instance, single or double-tap on the touchpad, or tapping the
left/right 'button' regions doesn't work.

This touchpad is overlaid on a physical 'click' button surface (which I
suspect operates as the mouse). By this I mean instead of lightly
tapping the touchpad surface it needs a very firm downward movement
until a physical 'click' is heard. It resists quite strongly so
double-clicks in particular are difficult. There's a separate physical 
'click' area for the right button.

So it works with these hard physical 'click' actions but not when
tapping the touchpad surface. To compare with the behaviour under 
previous kernels (where I seem to recall it only needed touchpad taps) I 
rebooted into an earlier kernel.

The disturbing FAILURE is that if the T300CHI is rebooted - even if 
from a poweroff - into an earlier kernel version (than v4.14) the 
touchpad no longer works.

Using hid-recorder I saw that the touchpad is still in multitouch mode 
(event descriptor id 0x5D rather than 0x06 when doing multitouches).

So far I've not been able to find a way to workaround/fix this. On the 
face of it the driver needs to put the touchpad back into 'mouse' mode 
on shutdown.

