Received: from mail.raman.v1.sg (mail.raman.v1.sg [5.223.73.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441640F8F4;
	Wed, 10 Jun 2026 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.223.73.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099834; cv=none; b=FjnpJtsGwwfWCUIl3mYBDP1t2R7lVuiDcbaF/OSw0lqD8nWWAuFUppO1Nb523ALTkHla4Ip9/XWK8p+i3ope7nsj1youvhtGJ8JF4Aqco8R8W1jTa/SCDSqjhClLdPaF84pH5a+UNM/RICEY88sfqMKC5VHvmY+rzzhPIA+s5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099834; c=relaxed/simple;
	bh=Tdzmnm3tx1iIpVyuRuBj15XzFCd7cK120KOQzL50Ye0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f785qiNltR6vRM9M3k1+3NZtUsZ5r2mJVVwMQRLKjRz0hrwT3xQWUN745ELL99nScK8Pfl2YgoDuRWt8P9vRRbU77dNR1kAlYK35N9L2+wT7VLVybDFBeIfpNbfpLZWnyBfyeA0fjEqPXvGlKW63WdoFWROy5LO7YAariNirpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raman.v1.sg; spf=pass smtp.mailfrom=raman.v1.sg; dkim=pass (2048-bit key) header.d=raman.v1.sg header.i=@raman.v1.sg header.b=Y/GIU++H; arc=none smtp.client-ip=5.223.73.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raman.v1.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raman.v1.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raman.v1.sg header.i=@raman.v1.sg header.b="Y/GIU++H"
DKIM-Signature: a=rsa-sha256; bh=Aw+Ssz8MRmoH55NHfIySuTnpiVbECDx/KzYBd910ALo=;
 c=relaxed/relaxed; d=raman.v1.sg;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@raman.v1.sg; s=default; t=1781098906; v=1; x=1781530906;
 b=Y/GIU++HrwBbm3uwYJBImGYL8/EHA2ftdZTE7OnfeMzpjwD+2d0pMrf+r+T8Otg30vVPJGdK
 Hkm+2D6lcd/tgmRPXQc6avaBo0FzxOPZysf7ClJeexRIGgPG0BBXq7GtetMvh0dYvg/UBr2EBiw
 xdO/UaV2n1n4E5IvJ42KC+zeXGnuUBMmMBm4ttun8BEfJPBheCNTO1pn/Tag+JchNoHXvmHzdir
 aF8CAQm6XlxaUorrKKaMQzxc0mWaCeKRafUqfJ/493wDKq1oZYwFLMHpJfhBsk0gzJEAkwiKU0y
 dMPHL1xk1f/HS6uoTe/cuxDiCw1spP80ff6Jqas/pZO+g==
Received: from cyberarch.tail8ae6a2.ts.net (localhost [127.0.0.1]) by
 mail.raman.v1.sg (envelope-sender
 <kernel-linux-20260610-80b7ab08@raman.v1.sg>) with ESMTP id 68bad46c; Wed,
 10 Jun 2026 13:41:46 +0000
From: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
To: michael.zaidman@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Subject: [PATCH] HID: ft260: fix SMBus block read protocol handling
Date: Wed, 10 Jun 2026 21:41:19 +0800
Message-ID: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
data->block[0] + 1 as the read length. But on a block read the byte
count is supplied by the slave as the first byte of the response;
data->block[0] is not initialized by the caller, so the transfer
length was taken from stale buffer contents, and the count byte the
slave did return was stored without any validation.

Implement the SMBus 2.0 block read protocol properly: read the count
byte first with a repeated START and no STOP, validate it against
I2C_SMBUS_BLOCK_MAX (resetting the bus and returning -EPROTO on a
bogus count), then read exactly that many data bytes and finish the
transaction with STOP. This keeps the whole sequence within a single
I2C transaction:

  S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P

To support issuing the two reads as one transaction, teach
ft260_i2c_read() to honor the caller's flags instead of always
forcing a START and unconditionally appending STOP to the last
chunk: START is only emitted if requested, and STOP is appended to
the final chunk only when the caller asked for it.

Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
---
 drivers/hid/hid-ft260.c | 45 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 70e2eedb4..946ed0c6f 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -502,15 +502,23 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
 	u8 bus_busy = 0;
+	/*
+	 * STOP terminates the last chunk; clear means hold the bus so a
+	 * follow-up call continues the same I2C transaction.
+	 */
+	bool want_stop = !!(flag & FT260_FLAG_STOP);
 
 	if ((flag & FT260_FLAG_START_REPEATED) == FT260_FLAG_START_REPEATED)
 		flag = FT260_FLAG_START_REPEATED;
-	else
+	else if (flag & FT260_FLAG_START)
 		flag = FT260_FLAG_START;
+	else
+		flag = 0;	/* no fresh START - continue current transaction */
 	do {
 		if (len <= rd_data_max) {
 			rd_len = len;
-			flag |= FT260_FLAG_STOP;
+			if (want_stop)
+				flag |= FT260_FLAG_STOP;
 		} else {
 			rd_len = rd_data_max;
 		}
@@ -708,14 +716,41 @@ static int ft260_smbus_xfer(struct i2c_adapter *adapter, u16 addr, u16 flags,
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_write == I2C_SMBUS_READ) {
+			u8 count = 0;
+
+			/*
+			 * SMBus 2.0 section 6.5.7 block read in one I2C
+			 * transaction:
+			 *
+			 *   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P
+			 *
+			 * The count is read separately and validated
+			 * before sizing the data read so a misbehaving
+			 * slave cannot drive a write past data->block[].
+			 */
 			ret = ft260_smbus_write(dev, addr, cmd, NULL, 0,
 						FT260_FLAG_START);
 			if (ret)
 				goto smbus_exit;
 
-			ret = ft260_i2c_read(dev, addr, data->block,
-					     data->block[0] + 1,
-					     FT260_FLAG_START_STOP_REPEATED);
+			ret = ft260_i2c_read(dev, addr, &count, 1,
+					     FT260_FLAG_START_REPEATED);
+			if (ret)
+				goto smbus_exit;
+
+			if (count == 0 || count > I2C_SMBUS_BLOCK_MAX) {
+				hid_warn(hdev,
+					 "smbus block read: invalid count %u from slave 0x%02x\n",
+					 count, addr);
+				ft260_i2c_reset(hdev);
+				ret = -EPROTO;
+				goto smbus_exit;
+			}
+
+			data->block[0] = count;
+
+			ret = ft260_i2c_read(dev, addr, data->block + 1,
+					     count, FT260_FLAG_STOP);
 		} else {
 			ret = ft260_smbus_write(dev, addr, cmd, data->block,
 						data->block[0] + 1,

base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.54.0

