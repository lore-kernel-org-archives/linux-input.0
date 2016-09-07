From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH 0/4] Input updates for Jornada720
Date: Wed, 7 Sep 2016 10:50:29 +0100
Message-ID: <20160907095029.GL1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52457 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbcIGJuh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2016 05:50:37 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Dmitry,

Please apply this tested series of patches for Jornada 720 input support.

Thanks.

 arch/arm/mach-sa1100/jornada720.c         | 16 +++++++++++
 drivers/input/keyboard/jornada720_kbd.c   | 48 ++++++++++---------------------
 drivers/input/touchscreen/jornada720_ts.c | 21 +++++++++-----
 3 files changed, 45 insertions(+), 40 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
