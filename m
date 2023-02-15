Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F162DC6379F
	for <linux-input@archiver.kernel.org>; Wed, 15 Feb 2023 01:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBOBDo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Feb 2023 20:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBOBDm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Feb 2023 20:03:42 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256662CC7D;
        Tue, 14 Feb 2023 17:03:39 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676423017;
        bh=k/sV5XTW4qmlaYhNjWXMKDXd4MAkeVLNIBbRmVwCXXE=;
        h=From:Subject:Date:To:Cc:From;
        b=HQKuVo6C/NBPMiorlEhbi5K+GQ1YZbW7gdfK1K6OdGfqKbW9hOI3WjAPsVYAehNax
         sxc+6aJYKcZ4TNWqNNnaFTT77IJNkH2lROAyo/BrnrDP57kV+s6blT3nOotU4VfyGT
         kn4W9E+XLXGU3M3IX/GJ9Da2Il2+ELo0FnQZ31qE=
Subject: [PATCH 0/4] HID: explicitly include linux/leds.h
Date:   Wed, 15 Feb 2023 01:03:33 +0000
Message-Id: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGUv7GMC/x2N0QrCMAwAf2Xk2UDX4cP8FRFJ19QGSlcS5pSxf
 7f4eAfHHWCswga34QDlt5istcN4GWDJVF+MEjuDd35yfrxiW3fWp22tlS8WjoZZIqZ5JkdTij4
 k6G0gYwxKdcm9rlspXTblJJ//7P44zx/iusT0fAAAAA==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676423014; l=760;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=k/sV5XTW4qmlaYhNjWXMKDXd4MAkeVLNIBbRmVwCXXE=;
 b=rYfnx+o8KsUhC5YJ2n2W4BZV4W/n6kTslWW81zZ7rtEzwZNbCcX5JKpj7LUsX/1b1mRHa9z3B
 9a9MTjO5VUiB3cQKGFuEXX1dMozGwXUzdQmEIL4mB/HC1JcIUl4fdYp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Instead of relying on an accidental, transitive inclusion of linux/leds.h
use it directly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      HID: steelseries: explicitly include linux/leds.h
      HID: lg-g15: explicitly include linux/leds.h
      HID: asus: explicitly include linux/leds.h
      HID: apple: explicitly include linux/leds.h

 drivers/hid/hid-apple.c       | 1 +
 drivers/hid/hid-asus.c        | 1 +
 drivers/hid/hid-lg-g15.c      | 1 +
 drivers/hid/hid-steelseries.c | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
change-id: 20230215-power_supply-leds-hid-f99a0a3fd2bf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

