From: Brendan McGrath <redmcg@redmandi.dyndns.org>
Subject: [PATCHv3] HID: i2c-hid: Add sleep between POWER ON and RESET
Date: Sat,  7 Jan 2017 08:01:38 +1100
Message-ID: <1483736498-7805-1-git-send-email-redmcg@redmandi.dyndns.org>
References: <20170106081144.GE15702@mail.corp.redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:13633 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751018AbdAFVIG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Jan 2017 16:08:06 -0500
In-Reply-To: <20170106081144.GE15702@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>, Brendan McGrath <redmcg@redmandi.dyndns.org>

Support for the Asus Touchpad was recently added. It turns out this
device can fail initialisation (and become unusable) when the RESET
command is sent too soon after the POWER ON command.

Unfortunately the i2c-hid specification does not specify the need for
a delay between these two commands. But it was discovered the Windows
driver has a 1ms delay.

As a result, this patch modifies the i2c-hid module to add a sleep
inbetween the POWER ON and RESET commands which lasts between 1ms and 5ms.

See https://github.com/vlasenko/hid-asus-dkms/issues/24 for further
details.

Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
---
Changes since v2:
  - added comments to explain the reason for the sleep

 drivers/hid/i2c-hid/i2c-hid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 844662c..d5288f3 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -426,6 +426,15 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * The HID over I2C specification states that if a DEVICE needs time
+	 * after the PWR_ON request, it should utilise CLOCK stretching.
+	 * However, it has been observered that the Windows driver provides a
+	 * 1ms sleep between the PWR_ON and RESET requests and that some devices
+	 * rely on this.
+	 */
+	usleep_range(1000, 5000);
+
 	i2c_hid_dbg(ihid, "resetting...\n");
 
 	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
-- 
2.7.4

