Return-Path: <SRS0=3uwQ=6E=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F1C3815B
	for <linux-input@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58582082E
	for <linux-input@archiver.kernel.org>; Mon, 20 Apr 2020 16:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgDTQpq (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDTQpq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Apr 2020 12:45:46 -0400
X-Greylist: delayed 508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 09:45:46 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37181C061A0C
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2020 09:45:46 -0700 (PDT)
Received: from kevinolos (unknown [IPv6:2001:470:b:5c3:2c1c:9654:4aed:d8a1])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 1CAED1849C5E;
        Mon, 20 Apr 2020 16:37:17 +0000 (UTC)
Received: by kevinolos (Postfix, from userid 1000)
        id 0E0651303663; Mon, 20 Apr 2020 10:37:15 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] Input: i8042 - add ThinkPad S230u to i8042 nomux list
Date:   Mon, 20 Apr 2020 10:37:15 -0600
Message-Id: <feb8a8339a67025dab3850e6377eb6f3a0e782ba.1587400635.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On the Lenovo ThinkPad Twist S230u (3347-4HU) with BIOS version
"GDETC1WW (1.81 ) 06/27/2019", whether booted in UEFI or Legacy/CSM mode
the keyboard, Synaptics TouchPad, and TrackPoint either do not function
or stop functioning a few minutes after boot.  This problem has been
noted before, perhaps only occurring on BIOS 1.57 and
later.[1][2][3][4][5]

This model does not have an external PS/2 port, so mux does not appear
to be useful.

Odds of a BIOS fix appear to be low: 1.57 was released over 6 years ago
and although the [BIOS changelog] notes "Fixed an issue of UEFI
touchpad/trackpoint/keyboard/touchscreen" in 1.58, it appears to be
insufficient.

Adding 33474HU to the nomux list avoids the issue on my system.

[1]: https://bugs.launchpad.net/bugs/1210748
[2]: https://bbs.archlinux.org/viewtopic.php?pid=1360425
[3]: https://forums.linuxmint.com/viewtopic.php?f=46&t=41200
[4]: https://forums.linuxmint.com/viewtopic.php?f=49&t=157115
[5]: https://forums.lenovo.com/topic/findpost/27/1337119
[BIOS changelog]: https://download.lenovo.com/pccbbs/mobiles/gduj33uc.txt

Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
Cc: stable@vger.kernel.org
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 08e919dbeb5d..5bbc9152731d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -541,6 +541,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
 		},
 	},
+	{
+		/* Lenovo ThinkPad Twist S230u */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
+		},
+	},
 	{ }
 };
 
-- 
2.26.1

