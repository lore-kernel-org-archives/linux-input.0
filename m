From: Alexander Stein <alexanders83@web.de>
Subject: GPIO-muxed inputs
Date: Fri, 01 Aug 2014 13:49:44 +0200
Message-ID: <2820612.QBnQEjqS39@kongar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60308 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbaHALtv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Aug 2014 07:49:51 -0400
Received: from kongar.localnet ([77.64.221.251]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Md4xS-1Wuxhf1mAU-00IAEr for
 <linux-input@vger.kernel.org>; Fri, 01 Aug 2014 13:49:49 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have a custom board which has 2 DIP switches connected to some GPIOs. I think I could use gpio_tilt_polled to generate proper input events. But the twist here is, that those switches uses the same GPIOs but are muxed by an additional GPIO. I'm wondering how this can be solved. An idea would be to add i2c-mux like "bus" where each input device is connected to. I think this way you can block "users" of the muxing GPIO before they can switch that.
Is this a proper way to go? How should (optional feature) should be integrated? Any other ideas?

Best regards,
Alexander

