Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748A3101B9;
	Tue, 17 Mar 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764673; cv=none; b=CJ2MZQX9ZRjyBckL9/lBMcKUhkkHTsXhrpmBDV8PXCn2E43Q3zm7YAmDQ9YFwfuxVQ3DTIwICMhCInLuRCfHYPCoRlG94iXHzOIvLA7dM67Dq7D6+01qD0MYguaiVUyoIpjCWPyd2IOGdqa1nwrr51SaVnuEZJJDRWviZ+dUdWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764673; c=relaxed/simple;
	bh=ZOgthNmR8TVqRvQ+Zt5VVruQTCZ1mA0BbFRAYdXfCI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t6buCChFEJmSK2gJziRa4ct1yjK30cI6fih/+aWAbifVonPpLParevpkjbdEN3SgI2LjQ4/9WpREbd6gbOvFBiqI9wv/FenR9OK6iUKsZOc6eo2Uoffa7zex2O+U625QAiRSMdTTtd1aOhCBlNbBowy4X9OLs/Pms1r9Vxx98V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7Tq1g1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7Tq1g1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B642C4CEF7;
	Tue, 17 Mar 2026 16:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764672;
	bh=ZOgthNmR8TVqRvQ+Zt5VVruQTCZ1mA0BbFRAYdXfCI0=;
	h=From:To:Subject:Date:From;
	b=r7Tq1g1Oo6iHZxnOkxQnU3CBVcnTkHMmiOkm/r4kPJTCVX1dPB7SVny0Sgh5qC21R
	 gthhXOVC3cM9OdtPJkEGs8m4P3vIWfS11zKtJpLM/WfrA1iNWs9vQGNv+Lrof7SAYT
	 BUinksqCP9yUlCaFOz134PK9j8VVJ3Xu0MfVf0roQiT36FkExH7OeI6tsKBjiCqZN6
	 +Xk+Bz7bN3PRVBFGipk9sAZj4k+ikypDxKTBpvvAXupi2FqFbB+Om6hR4C7qsyL60q
	 A1mMGoZrz/xclgaJsyoj2sEohNgqhFdrRaU7gnzuVChSl4c48vFUOS3kN2A5bpfN5D
	 K1kB20BmMQO7g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write
Date: Tue, 17 Mar 2026 16:24:25 +0000
Message-ID: <20260317162426.1533573-1-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

logi_dj_recv_send_report() assumes that all incoming REPORT_ID_DJ_SHORT
reports are 14 Bytes (DJREPORT_SHORT_LENGTH - 1) long.  It uses that
assumption to load the associated field's 'value' array with 14 Bytes of
data.  However, if a malicious user only sends say 1 Byte of data,
'report_count' will be 1 and only 1 Byte of memory will be allocated to
the 'value' Byte array.  When we come to populate 'value[1-13]' we will
experience an OOB write.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-logitech-dj.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 44b716697510..885b986c7a12 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1282,6 +1282,12 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
 		return -ENODEV;
 	}
 
+	if (report->maxfield < 1 || report->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
+		hid_err(hdev, "Expected size of dj report is %d, but got %d",
+			DJREPORT_SHORT_LENGTH - 1, report->field[0]->report_count);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < DJREPORT_SHORT_LENGTH - 1; i++)
 		report->field[0]->value[i] = data[i];
 
-- 
2.53.0.851.ga537e3e6e9-goog

