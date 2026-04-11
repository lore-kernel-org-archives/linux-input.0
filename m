Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784573A8757;
	Sat, 11 Apr 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775922877; cv=none; b=crtfVToJqNuUCCwnR0DoImHal4VorORvKH2yGoPnevvAciBNoqSBAEaMRH+hheB6yZgbR4C5FYVeM7plm5gGSAgrtlCd+DOSTyBvS0Cq/Z1VYq+B6Sv8TZN64piiFjHvn7vj1mgPFtuJmqpvJwypVGA29kdzYmyJ4Oc/VxCHE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775922877; c=relaxed/simple;
	bh=7dJCGyizmlrYX5fPHkYZ8OCSIfEjywKWcd9102XxNQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GavQVBCqT+Bh1Jbw0xbHChNUGGHv9yUqpKMyC8jmXS6BNyginAEdkDcWA2u7pGURYdnkVYI/U0jtWgee6XsXfhpByk7khSXkGaMcmpGQNJBtouwKsRX+WcZr6GfJgkQ4n0fO7zJ9/T3SAMWV9mUJzgrk19hCiuuFh0hZdz3yyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fkB7MHhD; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WwF4YcPX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fkB7MHhD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WwF4YcPX"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ftJBx2GPNz9vDH;
	Sat, 11 Apr 2026 17:54:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775922873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGxO1OHkr7HmXsC1DenYXWO5mnWlBN6zG7Y71PnBPIU=;
	b=fkB7MHhDhyNAWKjQ7YDCJuxSwfuJBswRB6ZqLeW+VRjmKsyos18kTLd1aP3LbejT3ZqVrD
	UyVNqnH7pRDL8lc31CkUGcHZTzMVLzIcUE5IgQT7KJaHglIZrQcY9ES+4RxxFwMuPfrQiE
	Nw2X5FsAResCe8idv+KuuOVd4IusvMoh7bjJcRVdXo/52CUsFEYkgm4j0OEadgkZvzTlMc
	nQGbmgXCHB5U4fYHwWje6K1dDX8Pj028ejOEIZSXUAjZco1+yzSfi7YNfI7+29DgJ6M1as
	BBj121NSsT1ICtitETkv9lzs4nteGx/ZPllVgV6x8MlzOVo9RGB2BnAorK5HNQ==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775922871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mGxO1OHkr7HmXsC1DenYXWO5mnWlBN6zG7Y71PnBPIU=;
	b=WwF4YcPXXvtR/dGoMKXEj8J7JxEOwv3GvPZdNLT7gtnYwMw7z4pB3mN9CoZaL2005qM1d/
	LcHrsebzL6sZ+cb4cOhnWdL7qtEuahLNQtsOpBRgcZR/Xd/IhtHdGtrRicF+NBcilyk0c5
	q9O5rFCTdU0OViN5lisvAQ9aWlMaXq1GTJhWRP6KQGR4hcTUOMoXca0iPCT+xGn0fvdOzF
	Ljnd0+RxKeJ4BGN6rEeuFddlXScBHwqNgTv2eUPJsfkLYBEeXZrMOIK2608n7gs2s+dNpM
	gAQxI1FcBiLYwUxvLms35dcbLRijd9EKtRotZwJI0jLtha3s+MtuJt2p4OOQVw==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: use input_dev from sc struct in sony_init_ff()
Date: Sat, 11 Apr 2026 17:53:47 +0200
Message-ID: <20260411155347.101760-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: abaaeaf1599582f348b
X-MBO-RS-META: r1shwpqrtg6ko1em8qoj4joknmf6yc4d

This commit makes sony_init_ff() use the input_dev from the sc struct,
this simplifies the sony_init_ff() function.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 6a860b9ef677..ad394ac57fa5 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1853,18 +1853,8 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 
 static int sony_init_ff(struct sony_sc *sc)
 {
-	struct hid_input *hidinput;
-	struct input_dev *input_dev;
-
-	if (list_empty(&sc->hdev->inputs)) {
-		hid_err(sc->hdev, "no inputs found\n");
-		return -ENODEV;
-	}
-	hidinput = list_entry(sc->hdev->inputs.next, struct hid_input, list);
-	input_dev = hidinput->input;
-
-	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
-	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
+	input_set_capability(sc->input_dev, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(sc->input_dev, NULL, sony_play_effect);
 }
 
 #else
@@ -2151,6 +2141,8 @@ static int sony_input_configured(struct hid_device *hdev,
 	int append_dev_id;
 	int ret;
 
+	sc->input_dev = hidinput->input;
+
 	ret = sony_set_device_id(sc);
 	if (ret < 0) {
 		hid_err(hdev, "failed to allocate the device id\n");
@@ -2311,7 +2303,6 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_close;
 	}
 
-	sc->input_dev = hidinput->input;
 	return 0;
 err_close:
 	hid_hw_close(hdev);
-- 
2.53.0

