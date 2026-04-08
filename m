Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840C3D091A
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657992; cv=none; b=rjPi0Hv3/YYbGmLZRY5SOHPgAmtvhfmL5i0WhwGNQ+jzUzMcLCgHY5D9t0/8BUG7B6eCIXT22DFKnW66jUaAgIzst50X5PhteciNo1jDVBrGQgTbRAN19D3LntohCvw37j1mDH8s1iTP1ckBtiI/g/AbPos/szj5lQpysNxhV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657992; c=relaxed/simple;
	bh=/RQPtUAL2UmqJa95AwJGh3fSalm3PSqkznyBvQeuVNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fd33d0HCnS3iCixOTXKszCEYAly141Mk98iBFqehbyN9yVjYBV1IjTxqKaJZEmpsFEIrC20pbvCnv78sHA6mvzic0XH9LyGA3MUtpjgQc/s/5+FfGlYhQ5FRevHtzlFc0+mQAAorUIEptF2QQxdBlsnXvZu+KJ7ga8piH7elunA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uYR0e/W2; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uYR0e/W2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775657978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xqhcz0s899DFFE92Y1TSvGkuk/W1D4YwpjJ1vQJtGog=;
	b=uYR0e/W2AJbMrcXrs6CKF/1Ks0thxqqJzlBpro8qh/QMM8U0HMTOyhoVHsgon4krj02rnu
	k2qLcZzlZdda3G98vlMS2Pz71vxbsnAICyYk6EdabnVoXz+kikFhRi/pwQfqV3tkgVqz4D
	NAH8rDbyL8ZWjZFjk6100y1XTKI34v8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: qt1050 - inline i2c_check_functionality check
Date: Wed,  8 Apr 2026 16:19:25 +0200
Message-ID: <20260408141926.1181389-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878; i=thorsten.blum@linux.dev; h=from:subject; bh=/RQPtUAL2UmqJa95AwJGh3fSalm3PSqkznyBvQeuVNQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXkt/di1r3ZNImnqdlvDw+yjpFMmtWs287qpTJ8fT5i j3bnguc7yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJ5P5mZJg3jZ9R2D5/02c/ ru7Jet95Lt7dYrp1/rtShW0cBl4bvXcwMmzeHioxf+LXqTGTDHSWTrtXdl28bFqzG2vmEi9lLde Da9kB
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Inline the i2c_check_functionality() check, since the function returns a
boolean status rather than an error code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/input/keyboard/qt1050.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index bce8157d1871..f9f480c91032 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -435,8 +435,7 @@ static int qt1050_probe(struct i2c_client *client)
 	int err;
 
 	/* Check basic functionality */
-	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
-	if (!err) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
 		dev_err(&client->dev, "%s adapter not supported\n",
 			dev_driver_string(&client->adapter->dev));
 		return -ENODEV;
