Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9F3242AC;
	Thu,  9 Apr 2026 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776569; cv=none; b=SqM0621hC0Ns+4aN45kJDm3NqHaZXN1bh2dX+BKLJS9Muw1/7z/m4zd8FwVSaXMjTTmK1qO5O171tWJGsjbbnMo/hKsDDFTkmrCHXL3LR0ywDo1NA3hp2fzyhgBJIfT2yzewoOXabIu+/OQtTOqFTqdLhkRXlGv+g98p3aZr1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776569; c=relaxed/simple;
	bh=zXPpOHMW9upMaQxO81NIuHEfVi6SiNKISz3S94pB7KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jO7lAQ+3EUnA+MA1p3HKRr90lJMbQrikhJvB3ou+EhbNvHsmWSrEtuBrc+SvAFqFPkfUehg1W843nqgFoRQBJC28g9fvHQdrBzQb7oB+ow/y0dyt9Nf4w91U2iDxV+C94gtWIxv2/TQcyA6T4lppSmeoG776fmERcwmyiL0SYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqz0FAAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqz0FAAW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C306C4CEF7;
	Thu,  9 Apr 2026 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775776569;
	bh=zXPpOHMW9upMaQxO81NIuHEfVi6SiNKISz3S94pB7KY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Nqz0FAAW4hEe14JuHdR7NdzV/zw2cjlMLOr8N3m6rhaX5Aix8kY5Bld92O45rel3g
	 PLet0EA0i9iIUMVum1NEWyD01ECfj82wLrx16ocy4bsES7URcSwnW28hOTMI1EHlhw
	 bXmrLwLvPgWFoy1OTr0KC/Wgjc3sg804IUe4moS3bPw+k94JbMRp2AVck7MThiuPZG
	 nHepWofkqxkK9s4rQk5uaBn6QxHji32cLFCUP5/CFzqX2rAwgWXMK0rmg+c++85Ed6
	 KFd0Ah/p7zQ7Facuy4YVNTdJuJVvfi+fnbAwPcCXDKwMx0gJn71+KAw8M9SdWBz0JG
	 NG387k3xcV9kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17866F36B95;
	Thu,  9 Apr 2026 23:16:09 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 09 Apr 2026 18:16:08 -0500
Subject: [PATCH] Input: edt-ft5x06 - Support label device property for
 input name
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ft5x06-label-v1-1-21e8a9ae9a60@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3bQS0woDM92cxKTUHF0Lc4uUVINU0zQLk2QloJaCotS0zAqwcdG
 xtbUAztxzQ14AAAA=
X-Change-ID: 20260409-ft5x06-label-878de0e5f84c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775776568; l=1205;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=KTxgBMVlEg3nom+rhZXznr0aORzvFvN9pOpo7KbEjOA=;
 b=1vVpMCrRkRGnRugfIpLGE0lKz4nHo57TCv6oi7mWcYS3Fxf9eVfmsXdDLaQvDdJ8aDtC82oLx
 fpewtU+DfmEAY5ykrgzg8YussbdTycqfRwUgnrSAS4KpWn9VVFhmKuA
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The AYN Thor uses a ft5426 and a ft5452 for each screen respectively and
these currently get the same input name, making them indistinguishable
from userspace. Support setting a label in kernel dt to make these
report uniquely.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ba8ff65f7ea671..c36497571b1aa1 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1285,7 +1285,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 		"Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
 		tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
 
-	input->name = tsdata->name;
+	if (device_property_read_string(&client->dev, "label", &input->name))
+		input->name = tsdata->name;
+
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 

---
base-commit: 3fa7d958829eb9bc3b469ed07f11de3d2804ef71
change-id: 20260409-ft5x06-label-878de0e5f84c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


