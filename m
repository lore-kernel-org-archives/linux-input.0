Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D474E80CF;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836134; cv=none; b=U3OkDQcG8u2btb9iBSmlhZrdPgYWgX/+n5yYtrmsIwCTgk0da1snYMP19CIiMpZyPU8bfOdtzn7phj//vs4CrIpZn8CGjNQa9OTTODeNpQ1uzxoZETxr3cKW6CzpFJezCPus9SD1GpSaJ43QpFuwSET2zp2urXMCiyYoJLU34pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836134; c=relaxed/simple;
	bh=fHfsDAJFw0fUpfUilkiUJy3oPfy3l3e6wdBptn0NSS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwadVBbdcgVRvYfQ+mwpXkoHMrt+CueCco8yv/oTykEBDLQKZZQjwQ2I+1CglQp5qIsv9oV1g+yMEdUY/GOJKfAjQ4rpthjh8yh7f2LXtsYRX9U3whXAAn5dqEtRaqKg9SAMEFDCZFmLHn7zU1H9xgK++FkCLhvzpTX2jFnFHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsXuKr+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsXuKr+q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 340E5C4AF0B;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791836134;
	bh=fHfsDAJFw0fUpfUilkiUJy3oPfy3l3e6wdBptn0NSS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fsXuKr+qgw9rYjLitq//5EXQWHjDi4K6/tYQcPDD2MWxbOM2xBuqCW5AwYoHW67B1
	 amOnvpRLDvfHY15doQf4OViHxYvKI/DMQZjUpfF1JYwusK2pfZd0AQ3Oqbtz4Q8Blx
	 CCyO5xC8bQqx8ssoYoiN6amvPeOmMl3ccC3wcQT59wgXxy1+P3POC+Gc0GYpOknpRH
	 a/R9hQpimdgDLBvyy0WqiBDYmCG21XPacWTS1g1UAcIj5UQRrPqtlIWw6X+TFZvXYs
	 IOzX9eDAmurtIkf3DBcx6sKnU2KW8W+53FQcuBLvDSbe3JFORXMDeDxk7xght4qAPi
	 w2hFJ5kvJx/Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20859CC6B04;
	Mon, 12 Oct 2026 20:15:34 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 01:45:27 +0530
Subject: [PATCH 5/5] HID: UNCTRL: only report to userspace on battery
 changes
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v1-5-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791836132; l=1478;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=3oBe0qsOm90IcaPkZIlIWjNRUTzq1vzLXSX1oUkBnqw=;
 b=X8rj9H1jZV+QhdFfR3+iy2u/uIt+iEfRbNnyyKST2xx4RCI3bIS5+JPHJjs8wHhEO9B+P3/Mn
 rj3WU9WQzfzCP400yYq+B50R2kCDNqcDbSjegZFx01lI1KYH7yI6dAh
X-Developer-Key: i=contact@bishwasaha.com; a=ed25519;
 pk=bW8B6BzX1VU4IIcYagrb5nNRxBho+rTXaQZ8fLx8CoU=
X-Endpoint-Received: by B4 Relay for contact@bishwasaha.com/20261012 with
 auth_id=1168
X-Original-From: Bishwa Bhusan Saha <contact@bishwasaha.com>
Reply-To: contact@bishwasaha.com

From: Bishwa Bhusan Saha <contact@bishwasaha.com>

This patch calls power_supply_changed() only when the reported
capacity or mode actually changes.

Signed-off-by: Bishwa Bhusan Saha <contact@bishwasaha.com>
Assisted-by: GLM:glm-5.3
---
 drivers/hid/hid-unctrl-m1.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
index ff15384c0..df283cbae 100644
--- a/drivers/hid/hid-unctrl-m1.c
+++ b/drivers/hid/hid-unctrl-m1.c
@@ -324,6 +324,8 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct unctrl_dev *dev = hid_get_drvdata(hdev);
 	struct power_supply *battery = NULL;
+	bool changed;
+	u8 old_capacity, old_mode;
 
 	if (!dev || size < 8)
 		return 0;
@@ -338,14 +340,21 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	scoped_guard(spinlock_irqsave, &dev->lock) {
 		/* the receiver reports 0% while the mouse is switched off */
+		old_capacity = dev->battery_capacity;
+		old_mode = dev->mode;
+
 		dev->battery_capacity = min_t(u8, data[4], 100);
 		dev->mode = data[5];
 		dev->online = dev->battery_capacity != 0;
+
+		changed = dev->battery_capacity != old_capacity ||
+			  dev->mode != old_mode;
+
 		battery = dev->battery;
 	}
 
 	/* only schedules a work, so this is safe from the completion path */
-	if (battery)
+	if (battery && changed)
 		power_supply_changed(battery);
 
 	return 0;

-- 
2.56.0


