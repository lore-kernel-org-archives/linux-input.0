From: Brendan McGrath <redmcg@redmandi.dyndns.org>
Subject: [PATCHv2] HID: i2c-hid: Add sleep between POWER ON and RESET
Date: Fri,  6 Jan 2017 09:53:10 +1100
Message-ID: <1483656790-27977-1-git-send-email-redmcg@redmandi.dyndns.org>
References: <20170105112319.GA17928@mail.corp.redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:36654 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968928AbdAFABo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 19:01:44 -0500
In-Reply-To: <20170105112319.GA17928@mail.corp.redhat.com>
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
Patch has been changed to use option a)

I upped the minimum sleep to 1ms to match Microsoft. I figure this is a
safer value.

 drivers/hid/i2c-hid/i2c-hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 844662c..61ff6a6 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -426,6 +426,7 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	if (ret)
 		goto out_unlock;
 
+	usleep_range(1000, 5000);
 	i2c_hid_dbg(ihid, "resetting...\n");
 
 	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
-- 
2.7.4

