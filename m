From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] synaptics: add support for Relative mode
Date: Wed, 26 Oct 2011 22:45:49 -0700
Message-ID: <20111027054549.GD15725@core.coreip.homeip.net>
References: <20111026092552.D47439D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46579 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1J0Fpy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 01:45:54 -0400
Received: by ywm3 with SMTP id 3so2303977ywm.19
        for <linux-input@vger.kernel.org>; Wed, 26 Oct 2011 22:45:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111026092552.D47439D401E@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, djkurtz@google.com, pgf@laptop.org

Hi Daniel,

On Wed, Oct 26, 2011 at 10:25:52AM +0100, Daniel Drake wrote:
> Currently, the synaptics driver puts the device into Absolute mode.
> As explained in the synaptics documentation section 3.2, in this mode,
> the device sends a continuous stream of packets at the maximum rate
> to the host when the user's fingers are near or on the pad or
> pressing buttons, and continues streaming for 1 second afterwards.
> These packets are even sent when there is no new information to report,
> even when they are duplicates of the previous packet.
> 
> For embedded systems this is a bit much - it results in a huge
> and uninterrupted stream of interrupts at high rate.
> 
> This patch adds support for Relative mode, which can be selected through
> a sysfs attribute. In this mode, the device does not send duplicate
> packets and acts like a standard PS/2 mouse. However, synaptics-specific
> functionality is still available, such as the ability to set the packet
> rate, and rather than disabling gestures and taps at the hardware level
> unconditionally, a 'synaptics_disable_gesture' sysfs attribute has
> been added to allow control of this functionality.
> 
> This solves a long standing OLPC issue: synaptics hardware enables
> tap to click by default (even in the default relative mode), but we
> have found this to be inappropriate for young children and first
> time computer users. Enabling the synaptics driver disables tap-to-click,
> but we have previously been unable to use this because it also enables
> Absolute mode, which is too "spammy" for our desires and actually
> overloads our EC with its continuous stream of packets. Now we can enable
> the synaptics driver, disabling tap to click while retaining the less
> noisy Relative mode.

Can we make it a separate protocol type so there is clear distinction
between them? Then you could employ the standard protocol switch code
instead of rolling your own.

Thanks.

-- 
Dmitry
