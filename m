From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH v6 0/8] hid: new driver for PicoLCD device
Date: Tue, 30 Mar 2010 22:32:24 +0200
Message-ID: <20100330223224.18fe4f3e@neptune.home>
References: <20100324233707.7243b04d@neptune.home>
	<20100324234022.0361bd80@neptune.home>
	<20100326065656.GC26602@core.coreip.homeip.net>
	<20100326102951.3b9ecda1@neptune.home>
	<alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
	<20100327012245.0ace6a09@neptune.home>
	<alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
	<20100329121611.0c22dcaf@pluto.restena.lu>
	<alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:42513 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab0C3UqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 16:46:24 -0400
In-Reply-To: <alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Tue, 30 March 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> so please either remove the parts that depend on power management for
> now, or I'll wait on your respin of the generic HID-PM patch.

Here I respin the whole series, with PM moved to patch n=C2=B08 and
patch n=C2=B07 being my original generic HID-PM.
Without the PM part there is one compiler warning about defined but
unused function (picolcd_resume_backlight), I hope this is not an issue=
=2E
If it is that function can move over to the PM patch (with it's stub
for !CONFIG_BACKLIGHT_CLASS_DEVICE case)

So for now you can skip the last two patches during merge.

Do you have any suggestions regarding generic HID-PM as to how much
and how it should be visible to the HID driver?

Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
