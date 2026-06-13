Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589A1F94F;
	Sat, 13 Jun 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781331155; cv=none; b=YnGkVswpSMQAE8QE10PwdcAuqa/nE3EfRpcyPOBjtDSjd7BxYepZ4ZgpwKbB13POIQqcu0ucSDABXpC3Uo/3+tBSH5WAT5Zy3DvyXb1UVYIZGBxngyla4/XsfPTRSDKwWkowE3XjwWHSv2s64VXbhOClGFjQqFhjK1FXXca5T2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781331155; c=relaxed/simple;
	bh=R62Hmd5ErigMaIbjojyjZgiPiDDXNa/YZIGZmf8mWWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkJmg95r17DXWYz9/gE/ZMkxzdX87TbBqEz5NOVyjqHvpC3nycoiTTN684o5TB13VTNoBpU6prf0ifgqEEwoyAvxNwUZ/SBDMwwtkiaOoy24+1x9cwbJsP+WmJnMybvPQg8iNOWI9bYn68Ysl0XlgzJBWrK/E0LzeNoiUjXz4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OThCpCvn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OThCpCvn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 721F1C19425;
	Sat, 13 Jun 2026 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781331154;
	bh=R62Hmd5ErigMaIbjojyjZgiPiDDXNa/YZIGZmf8mWWE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OThCpCvndH1TNKDPVqIPNh3tc9ZU0eNC+L5wMgjqEQ4zTMeSoi+gETf+p1fDTJ4SW
	 qEXIDRvHHN+XdD9mraxExVQKVkPlq66kxMhZXIGqkPj2gY9pV0eml8Dt/3pz+w/mOl
	 YQKcd0YRCJ5u6SK2OKvpnoVpDPCqJbf2XlXf0maKl6Y2hD7hKBk1Rf/w2EWqaIn5/z
	 B/v+OsF51rdY8XhQxJV/a/iYPp1UfNgq8IHv4cKVJhkEGbSjJzjtJXuMIg/tQ3MZkZ
	 7yxkxvceRP9lxjakPkXRVxzWIWyIlN4PdlSKnNUpu+L7vgu1CEYfpnLrwWGkPL7pzi
	 9fINqbCPYzzAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5FCCD98CF;
	Sat, 13 Jun 2026 06:12:34 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 13 Jun 2026 01:12:34 -0500
Subject: [PATCH] Input: cyapa - bound the SMBus block reads to the caller
 buffer
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-b4-disp-8e550272-v1-1-9658cf8292c2@proton.me>
X-B4-Tracking: v=1; b=H4sIANH0LGoC/x3MQQqAIBBA0avErBtQ06yuEi3MppqNhUIE4t2Tl
 m/xf4ZEkSnB1GSI9HDiK1TItgF/unAQ8lYNSqhe9LLDVePG6caBjBHKKnTSaW290WIYoWZ3pJ3
 ffzkvpXxVRhvSYgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dudley Du <dudl@cypress.com>, Benson Leung <bleung@chromium.org>, 
 linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781331153; l=3371;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=GV3OIu9GRRKjdqcaWZ4II7ZaN9d38honFN8iwiNx23I=;
 b=3CZ2VsGndrYewICriNIQ9fnVkJilLdoqSN4+F9OMOHEaFaDrPxldIzWCYCZS1s4Raaf8L3R8Z
 RCmFL4lyw8BB4T8yp0vOuvt6y0ggRCSXzrit/hF4vLovmqPGiaXTBTQ
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

cyapa_smbus_read_block() takes the expected length of the result but
never uses it to bound the destination:

	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
		goto out;
	}
	...
		buf = values + I2C_SMBUS_BLOCK_MAX * index;
		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);

i2c_smbus_read_block_data() has no destination-size argument; it copies
the block count reported by the device (the first SMBus byte, up to
I2C_SMBUS_BLOCK_MAX = 32) into the buffer. Several callers pass buffers
smaller than 32 bytes - cyapa_detect() reads CYAPA_CMD_BL_STATUS into an
on-stack u8 status[BL_STATUS_SIZE] (3 bytes), and the group-query path
reads into u8 query_data[QUERY_DATA_SIZE] (27 bytes) - so a
malfunctioning, malicious or counterfeit trackpad (or an attacker
tampering with the SMBus) that reports a larger block count overflows
the caller's stack buffer by up to 32 - 3 = 29 bytes, clobbering the
stack canary, saved registers and the return address.

Read each block into a local I2C_SMBUS_BLOCK_MAX-sized buffer and copy
back only the expected number of bytes, in both the group-block branch
and the multi-block loop, so the device can never write past the
caller's buffer.

Fixes: 6ddaf744c9f6 ("Input: cyapa - add support for smbus protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/input/mouse/cyapa_gen3.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..832775bb7182 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -247,27 +247,37 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 	ssize_t ret;
 	u8 index;
 	u8 smbus_cmd;
-	u8 *buf;
+	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	struct i2c_client *client = cyapa->client;
 
 	if (!(SMBUS_BYTE_BLOCK_CMD_MASK & cmd))
 		return -EINVAL;
 
+	/*
+	 * i2c_smbus_read_block_data() copies the device-reported block count
+	 * (up to I2C_SMBUS_BLOCK_MAX) into its buffer and has no way to know
+	 * its size, so read into a local buffer and copy back at most the
+	 * expected number of bytes - never past the caller's buffer.
+	 */
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		if (ret > 0)
+			memcpy(values, buf, min_t(size_t, ret, len));
 		goto out;
 	}
 
 	ret = 0;
 	for (index = 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
+		size_t offset = index * I2C_SMBUS_BLOCK_MAX;
+
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
-		buf = values + I2C_SMBUS_BLOCK_MAX * index;
 		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
 		if (ret < 0)
 			goto out;
+		memcpy(values + offset, buf, min_t(size_t, ret, len - offset));
 	}
 
 out:

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260613-b4-disp-8e550272-a1a447c54089

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


