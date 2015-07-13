From: Robert Dolca <robert.dolca@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Mon, 13 Jul 2015 12:59:47 +0300
Message-ID: <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
References: <55A18959.7050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36279 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbGMKAI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 06:00:08 -0400
Received: by wgxm20 with SMTP id m20so108617202wgx.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 03:00:07 -0700 (PDT)
In-Reply-To: <55A18959.7050502@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, Jul 12, 2015 at 12:23 AM, Gregor Riepl <onitake@gmail.com> wrote:
> Hello.
>
> You beat me to it - I noticed the lack of a generic Silead driver that works
> with Baytrail tablets (and ACPI) and started writing one myself, adapting the
> code by Joe Burmeister (https://github.com/jabjoe/sunxi-gslx680). You can find
> my endeavors (so far) here: https://github.com/onitake/gslx680-acpi
>
> While writing the driver, I noticed that my controller or the firmware (which
> I got from the Windows 8 driver for the tablet) does not seem to support
> finger tracking. If I look at the data packets, almost all of them carry 0 as
> the finger ID, while some carry 4. Lifting a finger simply removes the record,
> without providing a way to correlate it with the next data set.
>
> The code I worked with seems to support some kind of finger tracking, but it
> still uses the ID field of each touch record as finger ID. And that does not
> work with my touchscreen.
>
> In the meantime, I just implemented type A multitouch support, leaving the
> finger tracking out.
>
> Can you help me look into the problem?

The firmware has to be calibrated by the vendor for each chip-panel
combination. If you change the panel even if you keep the same chip it
is very likely to need some calibration. This might be the reason why
the finger ID is not working properly.
