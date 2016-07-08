From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v2 0/2] Input: synaptics-rmi4 - F34 device reflash support
Date: Fri,  8 Jul 2016 12:54:18 +0100
Message-ID: <1467978860-24909-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:2845 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754616AbcGHLyb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 07:54:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Older <jon.older@itdev.co.uk>, nick.dyer@itdev.co.uk

Hi Dmitry/Andrew-

Please find attached patches to add F34 firmware update to the RMI4 driver.

Git tree here:
https://github.com/ndyer/linux/commits/synaptics-fw-update-v2-2016-07-08

Changes in v2:
- Resolved reliability issues with locking and teardown/re-probe
- Add #ifdefs for CONFIG_RMI4_F34 in rmi_driver.c
- Slightly improve debug
- Tested by Chris Healy

cheers

Nick

