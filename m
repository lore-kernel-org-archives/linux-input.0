From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: udraw-ps3: accel_limits is local to the driver
Date: Tue, 15 Nov 2016 14:26:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151425170.29400@cbobk.fhfr.pm>
References: <20161115120205.3364-1-hadess@hadess.net> <alpine.LNX.2.00.1611151422371.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48629 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbcKON0I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 08:26:08 -0500
In-Reply-To: <alpine.LNX.2.00.1611151422371.29400@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

And as such should be marked static to avoid global namespace pollution.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

I've just applied this on top of hid.git#for-4.10/udraw-ps3

 drivers/hid/hid-udraw-ps3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-udraw-ps3.c b/drivers/hid/hid-udraw-ps3.c
index 1f68b0b..88ea390 100644
--- a/drivers/hid/hid-udraw-ps3.c
+++ b/drivers/hid/hid-udraw-ps3.c
@@ -54,7 +54,7 @@ enum {
  * Accelerometer min/max values
  * in order, X, Y and Z
  */
-struct {
+static struct {
 	int min;
 	int max;
 } accel_limits[] = {

-- 
Jiri Kosina
SUSE Labs

