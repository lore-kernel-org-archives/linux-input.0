From: Tj <linux@iam.tj>
Subject: Re: HID: asus: Add T100CHI bluetooth keyboard dock touchpad support
Date: Wed, 15 Nov 2017 10:38:36 +0000
Message-ID: <33cc2b36-5f64-0894-ef15-aae741b22090@iam.tj>
References: <1ac0aab543099ef88f71b44193e1cf30@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:45168 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757302AbdKOKin (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Nov 2017 05:38:43 -0500
In-Reply-To: <1ac0aab543099ef88f71b44193e1cf30@iam.tj>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>

Hans: I replied to the l.i. mailing list yesterday regarding your July
patches for the Asus T100CHI in the 4.14 kernel but accidentally left
you off the CC list, so I'm following up now.

This is on a T300CHI - the HID report descriptor looks identical to the
T100CHI and the report descriptor fix-up enables the special function keys.

I've confirmed that even after powering off the Bluetooth Dock it
remains in multi-touch mode and therefore has no functionality when
booting with an earlier kernel where mouse mode is expected.

I did quite a few experiments and permutations powering it off and on
again including after booting into the earlier kernel and entering the GUI.

I eventually found a way to force it to reset: running hid-recorder and
turning the dock off whilst doing some multi-touch action!

This also allowed me to confirm that on the earlier kernels (pre v4.14),
in 'mouse' mode, single finger singe/double taps on the touchpad
(anywhere on it's surface) work as single/double-click mouse actions,
including the separate right-button-area tap usually used for context menu.

So it seems like there are two bugs here:

1) driver needs to put the touchpad back into mouse mode on exit

2) single-finger taps need to be handled as position-sensitive mouse
clicks (left or right button).

Let me know if you need any additional debugging/data capture.

The information in my earlier email is still pertinent:

On 14/11/17 20:09, Tj wrote:
> With kernel v4.14 on an Asus T300CHI this appears to be working up to a
> point but it causes the touchpad to FAIL to work on earlier kernels.
> 
> The touchpad seems to be in multitouch mode (two-finger scrolling is the
> only MT action I've confirmed so far) but there are some deficiencies.
> 
> For instance, single or double-tap on the touchpad, or tapping the
> left/right 'button' regions doesn't work.
> 
> This touchpad is overlaid on a physical 'click' button surface (which I
> suspect operates as the mouse). By this I mean instead of lightly
> tapping the touchpad surface it needs a very firm downward movement
> until a physical 'click' is heard. It resists quite strongly so
> double-clicks in particular are difficult. There's a separate physical
> 'click' area for the right button.
> 
> So it works with these hard physical 'click' actions but not when
> tapping the touchpad surface. To compare with the behaviour under
> previous kernels (where I seem to recall it only needed touchpad taps) I
> rebooted into an earlier kernel.
> 
> The disturbing FAILURE is that if the T300CHI is rebooted - even if from
> a poweroff - into an earlier kernel version (than v4.14) the touchpad no
> longer works.
> 
> Using hid-recorder I saw that the touchpad is still in multitouch mode
> (event descriptor id 0x5D rather than 0x06 when doing multitouches).
> 
> So far I've not been able to find a way to workaround/fix this. On the
> face of it the driver needs to put the touchpad back into 'mouse' mode
> on shutdown.
> 
