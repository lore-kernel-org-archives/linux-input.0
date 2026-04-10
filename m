Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E22226D02;
	Fri, 10 Apr 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850856; cv=none; b=qCc7ZIxF5dKOYS4DXoGy2jqw31na1o7B9+iivJ6MPrhLiKPBKeN6MFOKuRZIw4pmNZIdE4//t1koCqeWyKX9a0a64d6IY0xZcU4ey72ztj32nPOFVyFcgAS1yd6ZOqH+p+q3G3YC5G5+yYpdpaSncJ/Rj8TK/yDxJpMDiRaSDKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850856; c=relaxed/simple;
	bh=H6C8vVmGFftLEtGxIDXKYC0hmDJTW+6oV5DREqE198Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfnDoa1SHnZqzVihh455d10HrbItOrnXfOE7OQb0UutS+aLiBqSavEZJu5JCO6K797rCgkHaMtRY242ej/+WIB319GoOvwUiQJqhP3kh6ZXG1j0wW/lfN8H6cMNkvYFD9XFV9GxfdvxUxkhajVWyu7ELHM4RyRs59IhNx4kXp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dRRze6fx; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DSj1az7h; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dRRze6fx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DSj1az7h"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fsnYw61WGz9sv4;
	Fri, 10 Apr 2026 21:54:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775850852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AjcYcPhfQ56qIZe36GKHceVJqb2a38fdKS7WFcUfCJU=;
	b=dRRze6fxi0spUHB50hKjfsgOMzm8a9TH5EziHPe93zVqlch0ehLCIlxhvqRok6wmuWiF46
	tda0PtbpLk/9JEE3BqJqGF5XnE4KsDtF6k9seLTU7KyvOksDFcnHFuLURVebu1XwmNqgFD
	YvVUTnERRn36PY8pLFsfSgTWTq5PLNIhUJDc6OZnw2Gn4g0mlPK70ouInYs79JUjRtfajs
	WlZ8E/NJ90Y7pBpGsLDqBSSIP841JP9HRl3xPh2a85yU9FyE24+GaOv8GRlOXVzYkkdRjH
	Wrl1BiQBa4hwo1NlkFeHPFHhfwoH0lZVaeQNsONC49I6xq7KMClmNXaxdbUksQ==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775850851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AjcYcPhfQ56qIZe36GKHceVJqb2a38fdKS7WFcUfCJU=;
	b=DSj1az7hwUh/t6OfMOefEfHuGO/65iUErGTA2KhWNM//B7MdkMhVw2LZ0ZwaJMXAr+dqnQ
	vIgClC8gTWjr+gBpimerlJOmtB3iv/M+1KPDZysaKKryCnUuRQIYdlhAG2vByB+1wkVec4
	CAkCaR6WqUViA6pQo6QO78X1DkQ/SsZ/vTqXTVkR57uHH/npWzXdEWfE62owL6kV+XEiT2
	dLfqzAK/CQHFxGdlULn93DGyrJbvr5hhAmPgdGjz5pMOjviniJNFf/cc614R61dt6+Z8co
	/6iEXgWGyKzkr5ebRq8gTyi2L2F4BsBOCJVPMtA8pousNFlKvJwV5ZPbBMJNhQ==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: fix incorrect force-feedback check in sony_suspend()
Date: Fri, 10 Apr 2026 21:53:54 +0200
Message-ID: <20260410195353.4321-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fb66f5ccda41e4596b9
X-MBO-RS-META: pdr5s5a1j7cka9jqjm1ys3m7yzy7h7nm

This commit fixes the incorrect force-feedback check in sony_suspend(),
without this the check will always be true due to checking a constant
define that is never 0.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/hid-sony.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 83e82a0a3327..9cfea6f40ec2 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2456,11 +2456,10 @@ static void sony_remove(struct hid_device *hdev)
 static int sony_suspend(struct hid_device *hdev, pm_message_t message)
 {
 #ifdef CONFIG_SONY_FF
+	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	/* On suspend stop any running force-feedback events */
-	if (SONY_FF_SUPPORT) {
-		struct sony_sc *sc = hid_get_drvdata(hdev);
-
+	if (sc->quirks & SONY_FF_SUPPORT) {
 		sc->left = sc->right = 0;
 		sony_send_output_report(sc);
 	}
-- 
2.53.0

