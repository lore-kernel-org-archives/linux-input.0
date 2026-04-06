Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F633120C;
	Mon,  6 Apr 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484254; cv=none; b=AVYK7udW8mhu6UbIJaCrVw2dJUPa2D7GSDOz3+E07Y1CqpT6OgJIJiDt2h+roUewkpWvhZG0H+6FCD+scV8xDSwY5qyvP93Wb3IOrc1A/ENZZzJjVlX1/Ill+VoyaFljBqywDeGuXsRew5yAElaAEkLBtlzgVvloFFTfd1sBqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484254; c=relaxed/simple;
	bh=StVaAU5WDJR4wwnqHgcwI2Ek4SQNKX4MRUU6DxCm/Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8fP5CvjYHm42PXrHDth/X79RsjP8xQ710WZNp1VmaFMTAYEFhe6DSMU8c22Ciwu51Gv7rE9V9p4Apo8IdMmuN4EZ/5iCC9qf7q7UHTkJvtWS/tTJMCRwk02FdStdxgQIW921I2Z5AqgBUyhA7msCBuN60OloKJvCpKTPnfIel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z3/eBoFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z3/eBoFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45387C4CEF7;
	Mon,  6 Apr 2026 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775484253;
	bh=StVaAU5WDJR4wwnqHgcwI2Ek4SQNKX4MRUU6DxCm/Ho=;
	h=From:To:Cc:Subject:Date:From;
	b=Z3/eBoFA6kSlJk0lo7lYxGNjNX07fo7aOXCGaU3xjZiYy+Fw6gO4KaXEmsPLi+HKv
	 BPNiPE2B9yeEBcfOc46obmW72/x+S4aMQthQQfQU31RNhZvJR+bvPCYUIMtcvh7OZb
	 ANnJdXnc1e8YVnJHwWa9uKAjzfqcAv4IEpGJaR8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH] HID: core: clamp report_size in s32ton() to avoid undefined shift
Date: Mon,  6 Apr 2026 16:04:10 +0200
Message-ID: <2026040609-equation-ascent-2b3d@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1437; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=StVaAU5WDJR4wwnqHgcwI2Ek4SQNKX4MRUU6DxCm/Ho=; b=owGbwMvMwCRo6H6F97bub03G02pJDJmX90Z+/em9qG8Kd31oamJm7WPptRcjF4RdkJrz0fZms HByeIBERywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzE24phwcoVN1jeu1upv9e2 8XMSqFA/sm+SJ8OC5vTGPw+Nk4Km2ZU77PzUq/d/a4wrAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

s32ton() shifts by n-1 where n is the field's report_size, a value that
comes directly from a HID device.  The HID parser bounds report_size
only to <= 256, so a broken HID device can supply a report descriptor
with a wide field that triggers shift exponents up to 256 on a 32-bit
type when an output report is built via hid_output_field() or
hid_set_field().

Commit ec61b41918587 ("HID: core: fix shift-out-of-bounds in
hid_report_raw_event") added the same n > 32 clamp to the function
snto32(), but s32ton() was never given the same fix as I guess syzbot
hadn't figured out how to fuzz a device the same way.

Fix this up by just clamping the max value of n, just like snto32()
does.

Cc: stable <stable@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 833df14ef68f..868c65684aa8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -71,6 +71,9 @@ static u32 s32ton(__s32 value, unsigned int n)
 	if (!value || !n)
 		return 0;
 
+	if (n > 32)
+		n = 32;
+
 	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
-- 
2.53.0

