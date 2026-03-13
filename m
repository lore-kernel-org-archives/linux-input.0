Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C633F5A9;
	Fri, 13 Mar 2026 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773387653; cv=none; b=PP9+FBXbe0azYsSjsKY1ScnXHTK+10qmqRRkdzQb39zuzD2vIPvDqc1fC3cEey26pIS01QV/Okg4H3TZmvrZB08Nc3DSzbiW5gk7dYsYCrs5+vH2zHYdj77uzEKigVCrCyVX5hOm2rs2tyuNFNDaYQCv+C3D1Luy0Jo7Jy9RIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773387653; c=relaxed/simple;
	bh=Thj684RK4cIwq/IRarl5yywXidXSKskpD/hdLathcwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HH85GWFJfrOmMqXwuWfZg6szugH+0uFfFZT5V4utuVhXVCUnUoC0W6mJBzBB5JL8pEynJtlN3rbNtlV3CkQYAfFL8z7sAqHUpB0Xvnlv+48B1WGeGn8OYlGRvYfZ/ZPEJnQ/l4lhTXhdg0IzlpRfgt+8WpCEnUVvVEzAnoRCLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHUgawgl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHUgawgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E6C2BC86;
	Fri, 13 Mar 2026 07:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773387652;
	bh=Thj684RK4cIwq/IRarl5yywXidXSKskpD/hdLathcwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LHUgawglK4HqNko+QOpRamHHZcyI/nEpaoBBnm/JUCSe5G46Cf8NJKyu1sVwhbQVq
	 WkQ1hGULbqB5S0pUeW/bEPrjIQMAgF9LmcMPMlCZHzBXW97DjfZBIvwVT/SHBoHAXQ
	 kWUXaq5CbQ05iIcUurfhTLv6ZhtVXhamfgF9Kp0K7ze2sEkNt32gGlDWIRy4p5nV+T
	 zaxIOjPp5HpEu+kGihr+POR7W5iSyAse1jj8HpUHozRIRPcs42DshSKsBzj1spdt0H
	 SetZo+LeihjYhH26UiW69G+9bE9B+hhUGAFN5XU9BlDa7l8xIMSfU1EooXdsjM6Yfi
	 4cRUkk6qvFnEA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 13 Mar 2026 08:40:27 +0100
Subject: [PATCH 4/4] HID: do not bypass HID-BPF when setting LEDs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wip-bpf-fixes-v1-4-74b860315060@kernel.org>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
In-Reply-To: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773387643; l=989;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Thj684RK4cIwq/IRarl5yywXidXSKskpD/hdLathcwA=;
 b=QbbIk87/vU1g9TmFIwh+vIF+/yo/qn6ojDdjwidiZr9WQ5U/7TLhExdHPa4qDSofjxSrBTpX0
 HeeqorxKOwsBvsnHPFcAaGS5NT1gG+hxxhbW1sx3n1ALBhzE7cwSqzk
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Right now LED workers are using the special .request() which is
asynchronous but bypasses entirely HID-BPF. This means we can not tweak
a HID keyboard.

Drop the asynchronous (only used by usbhid), and rely on the common
implementation.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-input.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index eb84f63c51b8..f0a77a4b2a42 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1853,11 +1853,6 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	report = field->report;
 
-	/* use custom SET_REPORT request if possible (asynchronous) */
-	if (hid->ll_driver->request)
-		return hid->ll_driver->request(hid, report, HID_REQ_SET_REPORT);
-
-	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)

-- 
2.52.0

