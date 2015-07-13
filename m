From: Robert Dolca <robert.dolca@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Mon, 13 Jul 2015 17:52:26 +0300
Message-ID: <CAFPB+YcZnzHVdztqYuD63fNGhedDZR4xEW8Nkd+zJ_H_gm+L-w@mail.gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
 <55A3CA05.5030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35673 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbbGMOwr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 10:52:47 -0400
Received: by wgjx7 with SMTP id x7so298020792wgj.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 07:52:45 -0700 (PDT)
In-Reply-To: <55A3CA05.5030302@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Jul 13, 2015 at 5:24 PM, Gregor Riepl <onitake@gmail.com> wrote:
>> The firmware has to be calibrated by the vendor for each chip-panel
>> combination. If you change the panel even if you keep the same chip it
>> is very likely to need some calibration. This might be the reason why
>> the finger ID is not working properly.
>
> Thinking about the device parameters... Wouldn't it be possible to read them
> from the Silead controller? According to comments in the firmware shipped with
> the old Android platform driver by Basewin, all the configurable parameters
> are contained in the firmware.[1]
>
> I don't have a complete data sheet, but maybe we could just read back the
> panel width and height and number of tracking points from a hardware register?
>
> That would not solve the problem of transferring the correct, platform
> specific firmware image to the device, however.

In the datasheet there is no register map. Silead gave us a partial
register map in order to implement the driver. In the map they
provided there is no register for resolution or anything that would
help with this issue. The information in [1] is incomplete and can not
be considered reliable since the vendor does not say anything about
it.

Regards,
Robert

>
>
> [1]
> https://code.google.com/p/yuandao-n90-window-dual-core-2/source/browse/drivers/input/touchscreen/gslx680_ts.h
> - the comments are in Chinese, a translation can be found here:
> https://github.com/jabjoe/sunxi-gslx680/blob/master/firmware/firmware_information.txt
