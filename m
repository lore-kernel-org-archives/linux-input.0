From: "=?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?="
	<sergey.belyashov@gmail.com>
Subject: Re: [PATCH] Autocentering support for Logitech MOMO Racing Wheel (force feedback)
Date: Tue, 19 Aug 2008 11:51:04 +0400
Message-ID: <bb829a0b0808190051o7e6bfc85y7aeffcba1ec8eb6a@mail.gmail.com>
References: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>
	 <20080818110815.ZZRA012@mailhub.coreip.homeip.net>
	 <bb829a0b0808180916l1d2ca72fj689edcf5b8c156e5@mail.gmail.com>
	 <20080818131807.ZZRA012@mailhub.coreip.homeip.net>
	 <bb829a0b0808181130r4c45403al45fffb356f321f9@mail.gmail.com>
	 <d43da00b0808181734j13b1b1ebi15f3008fd2e8662@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:52052 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYHSHvG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 03:51:06 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1406359yxm.1
        for <linux-input@vger.kernel.org>; Tue, 19 Aug 2008 00:51:05 -0700 (PDT)
In-Reply-To: <d43da00b0808181734j13b1b1ebi15f3008fd2e8662@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "D. Ragno" <homerj@icculus.org>
Cc: linux-input@vger.kernel.org

2008/8/19 D. Ragno <homerj@icculus.org>:
> Have you found anything about the MOMO with regards to sending putting
> it in native mode, so it will give you two axises for the
> throttle/brake? I've attempted to try and snoop this, but my snooping
> skills are less than stellar.

No, I have not. I grab all commands which Windows driver sends to
wheel (on any action in settings and effects tests):
0x11, 0x08, 0xXX, 0x80, 0x00, 0x00, 0x00 - used for effects (all
effects in diagnostic tool done by this command), but I do not
understand what is it and how to use.
0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 - reset to defaults (driver
use it with previous command to produce effects)
0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 - unknown
0x09, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00 - unknown
0x09, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00 - unknown
0xF3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 - disable wheel resistance
(such as autocenter disabling, but more ease to rotate wheel)
0xF5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 - same as previous
0xFE, 0x0D, 0x0X, 0x0Y, 0x80, 0x00, 0x00 - autocentering control
I try all of them by modifying kernel driver (usbtool does not work
for me properly). But wheel did not switches to native mode.
Also I try commands from G25 protocol, described in vdrift.net forum.
Reconnect commands does not work for MOMO Racing wheel.

Best regards,
Sergey Belyashov
