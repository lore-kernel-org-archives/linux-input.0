Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547D3EDACD;
	Fri,  4 Sep 2026 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526396; cv=none; b=QaMgVLf4yOUKS0LMBjdlEA7C1gEKFFxu2YDvTrRZzzWN1y5qZaZLgS+/TX4iINbBQA0CdNd9tvu3LjircEeatUH5R6dnpxwR6hfaWkkvJTXthS8DndbvyRlroSyBKhL+RSuR6vUgiRMxqQ2aqobSXLoDuET9sahOMYBLSKHbOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526396; c=relaxed/simple;
	bh=wUwPUKo0jf4PK8RHKD8/IPzBd9Q7ihhOyso3SZvS5qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SELhvXr423xKBgPCzceqt7fUSuqmn0d7hA0N/5R0FQsZNrC5TUfKhLpbrg7jEqD0vpsreWG3zW0VHT5yJwq7th9jhTrh+XFwLFvy6hga+rNnQ6K1gBZi4kzTwlmgpPbtxNXrimwoONEEATPbdqyLB1YJRnk39FB8ObZiTSFF+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwg36NlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwg36NlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E2D1F00A3D;
	Fri,  4 Sep 2026 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526395;
	bh=HuyUkb9QsgfNFHqyR5g942koc/YUlOHj8jX0auIKN/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uwg36NlG7O/JKqjKd1HAXPiJpW7Kf7t8qJtkY8cNBRrHIv5lNy6R1L3uurIDuVuTS
	 kkRbDn0kYUr4OAgDlVpu7jw9ZM/ItIVlQPat9ahtVyGEbXblSjKRqtmV1spUMLEOfI
	 SNt9/N8rRJz8Ftgbm8A/7MTzQEdmzAqCJebZ+G+cURubeqt8uFDeklmRau6OmV/zJK
	 MA0O4DsuNMUqPjx/ZQAp0yLTk2YromIgdX7diFujUGmEKpJmfVXOYlR2tOO737ZttY
	 a1vCxQNbOdYCRIvpv6H7aW5ayg9b2EiFkcSmhaLTMMfjTtnZenQm7JzzUDJB79fYCe
	 5OOYCqpDkrslA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 04 Sep 2026 14:53:00 +0200
Subject: [PATCH 2/3] HID: bpf: fix __hid_bpf_hw_check_params report length
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wip-bpf-check_report-v1-2-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
In-Reply-To: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788526390; l=2503;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wUwPUKo0jf4PK8RHKD8/IPzBd9Q7ihhOyso3SZvS5qU=;
 b=k/WKkJAdMWqjWJUD84OovAXPDp+7ZSra2FteNQmA+Fro5PKJPnC4lcbVBmBGbPbd11uoQetIR
 5wOeVy4iETGDfxRJxkiWyQZ0mxR9JLlVkULilEU6m7sofB7pf9h6ocE
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Turns out that USB, I2C and other transport drivers (except uhid which
just passes the data) still need to have the report ID in the first
byte.

Because they expect the first byte to be the report ID or 0, when the
report ID is 0, they strip that first byte before forwarding to the
device. This means that the transport layer forwards a buffer of size
N-1 to the device, which gets rejected.

Fixes: 5599f8019661 ("HID: bpf: export hid_hw_output_report as a BPF kfunc")
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 536f6d01fd14..b1de1dd0f21d 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -359,7 +359,7 @@ hid_bpf_release_context(struct hid_bpf_ctx *ctx)
 
 static int
 __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
-			  enum hid_report_type rtype)
+			  enum hid_report_type rtype, bool hw_request)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
@@ -388,6 +388,10 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
 
 	report_len = hid_report_len(report);
 
+	/* unnumbered reports need to have a report ID reserved in the first byte */
+	if (hw_request && report_enum->numbered == 0)
+		report_len += 1;
+
 	if (*buf__sz > report_len)
 		*buf__sz = report_len;
 
@@ -420,7 +424,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 		return -EDEADLOCK;
 
 	/* check arguments */
-	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype);
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
 	if (ret)
 		return ret;
 
@@ -480,7 +484,7 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 		return -EDEADLOCK;
 
 	/* check arguments */
-	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT);
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, HID_OUTPUT_REPORT, true);
 	if (ret)
 		return ret;
 
@@ -506,7 +510,7 @@ __hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *b
 		return -EDEADLOCK;
 
 	/* check arguments */
-	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type, false);
 	if (ret)
 		return ret;
 

-- 
2.55.0

