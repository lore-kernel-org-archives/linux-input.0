Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911819;
	b=Qm01BNQfZoXPA8VTmjt+mtv4N7qXP/yEHqIhFBDvpXyumwQb0KdfOU1x4egk3W/XXSDq
	 YJrQYWVvhgpFqkK+wqbPeKSMqDkHvVZ9wAeP1U6lTWVciekrGIavDjvNL6ltrHHanmkBv
	 EyDmOsghsdfbL7HxpZxU0ZnCoFZ8uAWEqPLH4MMI9xnz3FYURutE/eVJZs+QX7axyZnFc
	 iNaiVtN0/sTpKA0l5o2KIUltTjk5kDN9D0Tp7gu6suLlrmt+XPsi7MU9FLJl7sHS6cM6P
	 cdMrZClvKZ62q8Vu49aR3D9I5FS22KKVUBDnSj5LLgTt2jugE7elFLJQTVSA2a18BOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911819;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=iTnrAs7uLFcz1KJZktolxPVjQbg895xPmxpLJwZwM2I=;
	b=djXaPbrfIZxwaAKS+g63Wy64x5RYS3luXFptoyvjKzluW+J1ZFD8zkysgYi2hWCigDBk
	 WBLd1Ty0eOjren7yWN5poGz//uvmwXSP9Wjnuy2Vw2/PrbYHd5PC4z9idpnn2BLk93k6T
	 6bz6ihVLyqF/gmBV/vk+2QKleo5F688uZ3bBoxs5x0M/ZfUqUAmiM1X2+W2BlRDbWtVjM
	 04Z/0oZKl5vq8jGbBa3QyrfXySiZ7g8SXV9Fr8rFO6d7RABD9Bd+9HUA/pEdaYVjYIDlG
	 w2N59MmRH96Q5vfmUB1CbbTxf2CStP++TTCaV5pezZHuw/e9hQKpANrvVv5WcqBW0wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eIx1ZbVm;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82E606A31B;
	Thu,  5 Nov 2026 20:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF82E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eIx1ZbVm
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jLDw64RNDzKn9r;
	Thu, 05 Nov 2026 21:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793911814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iTnrAs7uLFcz1KJZktolxPVjQbg895xPmxpLJwZwM2I=;
	b=eIx1ZbVmLLRujDapJD5UYMpy0azXIytr12lFictJcy862c+v4Ri6dmrow41/4F/0mlquaX
	tIGR78E/jyR4MmM0j6sM9aAYnzqGX1J0V5Ijns5djOiZ92ypbqx5PcUh33qDtE8D6R5QnO
	hmkMaStCFLg/5fkKVEel7ksM3Q/jGoF5RcZwv0PvKXBSat2E4le95gXniemXpkLIGunXdS
	bUjb+sHd8+1YccIq+NWIz5lgxNN7Mrji2nD5EQJgp5cEN2PwSCBUGL5hOc5O3XRNutlPDd
	15yBsC23jpIft/kwYt9hyzykzbp0yD1WKQxUHsLuVEDIIPeiAePpduBIIpEoeA==
From: Markus Rathgeb <maggu2810@mailbox.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffery Miller <jefferymiller@google.com>,
	Markus Rathgeb <maggu2810@mailbox.org>
Subject: [PATCH] Input: rmi_smbus - retry reading the SMBus version on -ENXIO
Date: Thu,  5 Nov 2026 21:49:53 +0100
Message-ID: <20261105204953.69572-1-maggu2810@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f5d073e60f8487ea940
X-MBO-RS-META: pezxg7i4bnhf9ynz85ssi3pd9wae97k3

On a Dell Precision M3800 (Synaptics touchpad, PNP DLL060d, InterTouch on
i801 SMBus) the touchpad intermittently stays dead after resume from S3:

  rmi4_smbus 8-002c: failed to get SMBus version number!
  rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read current IRQ mask.
  rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -6.
  rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
  rmi4_physical rmi4-00: Failed to suspend functions: -6
  rmi4_smbus 8-002c: Failed to resume device: -6

This is not a recent regression. The system journal of this machine
(available since May 2024) shows it on every kernel series from v6.9 up to
v7.2, in about 18 of 377 S3 resumes (~5 %).

The resume ordering is correct: the PS/2 port is resumed first due to the
device link added by commit 7b1f781f2d24 ("Input: psmouse - set up
dependency between PS/2 and SMBus companions"), psmouse_deactivate()
succeeds, and rmi_smb_enable_smbus_mode() waits the 30 ms reset delay
added by commit 5030b2fe6aab ("Input: synaptics-rmi4 - handle reset delay
when using SMBus trsnsport"). Still, the device sometimes does not ACK the
version read yet. The error is not retried and rmi_smb_resume() ignores
it, so the touchpad remains unusable until the driver is re-bound.

Re-binding the driver (unbind/bind of the I2C client, no PS/2 command
involved) succeeds, and reading register 0xfd with i2cget before the
re-bind already returns a valid version. So the device does switch to
SMBus mode on its own, it just sometimes needs more than 30 ms.

Instead of increasing the fixed delay for all devices, retry the version
read on -ENXIO up to 10 times with 20 ms in between.

With this change, in 56 S3 cycles one resume needed a single retry (the
device answered after 30-50 ms) and none failed.

Link: https://lore.kernel.org/all/20230726025256.81174-1-jefferymiller@google.com/
Signed-off-by: Markus Rathgeb <maggu2810@mailbox.org>
---
 drivers/input/rmi4/rmi_smbus.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c2382297..93ecd6e14dee 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -22,6 +22,15 @@
 #define RMI_SMB2_MAP_SIZE		8 /* 8 entry of 4 bytes each */
 #define RMI_SMB2_MAP_FLAGS_WE		0x01
 
+/*
+ * After the PS/2 side (psmouse) has switched the device into SMBus mode it
+ * may take a while until the device ACKs on SMBus. On some devices (e.g. Dell
+ * Precision M3800) this sometimes takes longer than the reset delay after
+ * resume from S3, so retry the first access for a bounded amount of time.
+ */
+#define RMI_SMB_VERSION_RETRIES		10
+#define RMI_SMB_VERSION_RETRY_MS	20
+
 struct mapping_table_entry {
 	__le16 rmiaddr;
 	u8 readcount;
@@ -43,14 +52,27 @@ static int rmi_smb_get_version(struct rmi_smb_xport *rmi_smb)
 {
 	struct i2c_client *client = rmi_smb->client;
 	int retval;
+	int i;
 
 	/* Check if for SMBus new version device by reading version byte. */
-	retval = i2c_smbus_read_byte_data(client, SMB_PROTOCOL_VERSION_ADDRESS);
+	for (i = 0; ; i++) {
+		retval = i2c_smbus_read_byte_data(client,
+						  SMB_PROTOCOL_VERSION_ADDRESS);
+		if (retval != -ENXIO || i == RMI_SMB_VERSION_RETRIES)
+			break;
+		msleep(RMI_SMB_VERSION_RETRY_MS);
+	}
+
 	if (retval < 0) {
 		dev_err(&client->dev, "failed to get SMBus version number!\n");
 		return retval;
 	}
 
+	if (i)
+		dev_info(&client->dev,
+			 "got SMBus version after %d retries (%d ms)\n",
+			 i, i * RMI_SMB_VERSION_RETRY_MS);
+
 	return retval + 1;
 }
 
-- 
2.56.0

