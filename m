From: Ladislav Michl <ladis@linux-mips.org>
Subject: [RFC 0/2] Input: gpio-beeper: drive output by hrtimer
Date: Wed, 29 Nov 2017 12:06:27 +0100
Message-ID: <20171129110627.GA24064@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:55266 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbdK2LGa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 06:06:30 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990439AbdK2LG2xmavI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 12:06:28 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I have board here, where beeper cannot by driven by PWM as its pin
cannot be muxed there. This is an unfortunate result of evolution
and fixing thousands boards in hardware would be too expensive.

So here we are. I'm not pushing for inclusion to mainline, but
parhaps this could be usefull for others. You decide.

In case you'll find it usefull, I'm ready to solve any objections
and comments.

Ladislav Michl (2):
  Input: gpio-beeper: use helper variable to access device info
  Input: gpio-beeper: drive beeper pin by hrtimer

 Documentation/devicetree/bindings/input/gpio-beeper.txt |    5 
 drivers/input/misc/gpio-beeper.c                        |   99 +++++++++++++---
 2 files changed, 91 insertions(+), 13 deletions(-)
