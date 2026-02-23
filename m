Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75B3EBF37
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805009; cv=none; b=RMgiuTDe8//tkWIrnMSD11IieYTKWl8v0Gzef7b+pmUElzbTkOa+0A+nZ+sETftjNXwVi8aB3HC7dSWgz+0h4wThDKzbQi4uRU9pIvlD1LzHe0W/qQQs056kToDKtWZEXKK5ru/hFjx9IsFFMBvbsaxmUYXPwTcdF82sCwkaozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805009; c=relaxed/simple;
	bh=2HDKZUKuSNHMnL/oPVsvvmjnVgL8OxaBMVrbwzxk2cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWvati3XyEZaZdzBLqRHen2AoPdZGpd2RDvjUwEnjEGoC79meox3MDLLdIWrjm+zEZnXuh7RBf7RuGfqmkVqULwBj2XXXpeicITFgpK7fdR7qcipN/3Fdbt7bj0qOlc30SRr7HYCGI0cE1Kiqwqp8djmMa2BSLGXq526k4rCaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVBQpcrL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVBQpcrL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771805005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LaxSw3JpmJCqFhjEFoDoUaH373FRBXwbHxCiV8Jk4Lg=;
	b=cVBQpcrLNu2MMT2iayXHSQCLsH5BCUWrC/AhKkEdYTzsuKd5bNyDPXzj/JKXMQmOjbQkHY
	S15V0YeW1c7LOoq1DLYhP7z1r22u3JdDNOWzOie1YzOhXvO9TWIAJBWQoMs4Rq+V9eaS68
	ll2lj2urGOdCapW0ylJXlELVGEap32U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: adxl34x - Drop redundant error variable in adxl34x_i2c_probe
Date: Mon, 23 Feb 2026 01:03:04 +0100
Message-ID: <20260223000308.319335-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Inline i2c_check_functionality(), which really returns a bool and not an
error code, and remove the local variable.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/input/misc/adxl34x-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
index c05d898898e8..5ea0ce42a507 100644
--- a/drivers/input/misc/adxl34x-i2c.c
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -77,11 +77,8 @@ static const struct adxl34x_bus_ops adxl34x_i2c_bops = {
 static int adxl34x_i2c_probe(struct i2c_client *client)
 {
 	struct adxl34x *ac;
-	int error;
 
-	error = i2c_check_functionality(client->adapter,
-			I2C_FUNC_SMBUS_BYTE_DATA);
-	if (!error) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
 		return -EIO;
 	}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

