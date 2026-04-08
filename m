Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A63CEB81
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657986; cv=none; b=CKli0cjnBEkJLJbiUrkbRyGYJcdyfwFNcrxFK2nGmV0YFwEnsaBUGHnsqRj5BZsQ+hKID0XHRSkh/az+G5MBXLhplklYXL/xok2ay1Oo2iTIQlP4hCiofLei1WDvFuGMeVkRizmZ4n6upNPGmwlzdAMZ9AB49uEqlp/mFW2Lpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657986; c=relaxed/simple;
	bh=nkadNPCuUPlHyboyvm9ZCXTTSq+qsVF4wZlSOsNL6l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjVwjF2aPmFNCfKxQBU/F4m4heAz6mBUaAgd3sF6nnC9VHcVWpZuypWa1mrniOSKQIikVk9S+pD7WkXvuPvaCoEK7fqXxjksG/kzXOqboo3Imd7b6AUB7JGtybJlzrqu2CgSBpQZ5aMEUpCm6V3AJSNWuJ3IGJtGzn51P1cwYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jWDZEFyK; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWDZEFyK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775657981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC/eNzNnkUto7QYorP+3oUe70mQudQAsQexA9jHTTLY=;
	b=jWDZEFyK1hKbtCmUMJ5bxpGA70o5J+AvIReBXG97GfhA55U+IJSDsg2Dp1lhDUsfQjl1B2
	TRv/ASlbtgZZpg3QM35hl7wHKWD5bJvttHHmThKELsU3YNbtCwjQNm4+vQvjW8I035hoMN
	4pFoxQEc0M8jkts4M6k5IlKaDIf6pX8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: qt1070 - inline i2c_check_functionality check
Date: Wed,  8 Apr 2026 16:19:26 +0200
Message-ID: <20260408141926.1181389-4-thorsten.blum@linux.dev>
In-Reply-To: <20260408141926.1181389-3-thorsten.blum@linux.dev>
References: <20260408141926.1181389-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=thorsten.blum@linux.dev; h=from:subject; bh=nkadNPCuUPlHyboyvm9ZCXTTSq+qsVF4wZlSOsNL6l0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXkj+EXvbZ5/fsosDRFIbv+7cqbdd+IzaFOfXbykKeV xP7MuKtO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiH9Yy/LOPaWPnTl/meilr im5jgFLFtxU8iw/zpIocW7nHO4jlsRPDH77sf1ccK7NcLhiqLfrx37Dy1qXFxmfzMotNBROjw0z amAE=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Inline the i2c_check_functionality() check, since the function returns a
boolean status rather than an error code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/input/keyboard/qt1070.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index b3db2c7d0957..b255b997e279 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -133,8 +133,7 @@ static int qt1070_probe(struct i2c_client *client)
 	int i;
 	int err;
 
-	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
-	if (!err) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
 		dev_err(&client->dev, "%s adapter not supported\n",
 			dev_driver_string(&client->adapter->dev));
 		return -ENODEV;
