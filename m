From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] input: adxl34x: Add OF match support
Date: Thu, 18 Dec 2014 14:03:18 +0100
Message-ID: <CAMuHMdXcfe0JQhZzGSAoqjKR346-QJrvyi=afHF7cAaHKa56pw@mail.gmail.com>
References: <1418868923-13411-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20141218082151.GA1038@katana>
	<1492007.8cQN1myWLD@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:42215 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaLRNDU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Dec 2014 08:03:20 -0500
In-Reply-To: <1492007.8cQN1myWLD@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

On Thu, Dec 18, 2014 at 1:49 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> There are three compatible strings defined for the ADXL345 and ADXL346 in
> Documentation/devicetree/bindings/i2c/trivial-devices.txt: "adi,adxl345",
> "adi,adxl346", "adi,adxl34x". Given that the last one is a fallback for the
> first two I don't see a need to add the specific compatible strings to the
> driver for now. If a new totally incompatible chip named ADXL347 comes out we
> will need a new driver which won't be allowed to use the "adi,adxl34x"
> compatible string.

FWIW, I'm the evil person who added the adxl entries to that file...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
