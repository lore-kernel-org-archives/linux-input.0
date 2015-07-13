From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Mon, 13 Jul 2015 16:24:05 +0200
Message-ID: <55A3CA05.5030302@gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35598 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbGMOZA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 10:25:00 -0400
Received: by wiga1 with SMTP id a1so71139222wig.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 07:24:59 -0700 (PDT)
In-Reply-To: <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@gmail.com>
Cc: linux-input@vger.kernel.org

> The firmware has to be calibrated by the vendor for each chip-panel
> combination. If you change the panel even if you keep the same chip it
> is very likely to need some calibration. This might be the reason why
> the finger ID is not working properly.

Thinking about the device parameters... Wouldn't it be possible to read them
from the Silead controller? According to comments in the firmware shipped with
the old Android platform driver by Basewin, all the configurable parameters
are contained in the firmware.[1]

I don't have a complete data sheet, but maybe we could just read back the
panel width and height and number of tracking points from a hardware register?

That would not solve the problem of transferring the correct, platform
specific firmware image to the device, however.


[1]
https://code.google.com/p/yuandao-n90-window-dual-core-2/source/browse/drivers/input/touchscreen/gslx680_ts.h
- the comments are in Chinese, a translation can be found here:
https://github.com/jabjoe/sunxi-gslx680/blob/master/firmware/firmware_information.txt
