Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9E4F55DF;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839642; cv=none; b=RbUCpqigRndMZ22B8AySz7CroC6QCyNI2G49aQD4brzTJHlT4jcrbMC2qjdai1DDT0rlExdVrMRSvKEtoRHDpNXEY0UKMlWh71OBUw4nTMHV6nHWgSXnQ4upI6hYM8iZEIVOWJh11va/BX8lZzoxDc9hqdbmyPvO43UmoAr0LK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839642; c=relaxed/simple;
	bh=QUeNb7LJAj8/YvbAcxes+Uk5xB9eByk4c6fQy/FlkXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCg4P//3aMeUjcGxKqaTt+dyVIyZGcqURb2jdfmdDktL/buHJWmt7NnyLyCp116JldwqbPx8UHJb+dYr7JL2mihISI11F6Fq9C9i74ROx0/0W3+bbtQCxhsmha9FR1i8iiPXkAyQny0rNCJeVb490xrRk853lu/hZ/8uYMBOGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tazCNZNJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tazCNZNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74B6DC4AF0C;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791839642;
	bh=QUeNb7LJAj8/YvbAcxes+Uk5xB9eByk4c6fQy/FlkXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tazCNZNJRTnN0EWs4keUEFziIXLa2bgjkD2W8wV2BBKIXVwi7E1Ada0lYn/Xg6u8w
	 eT8ErV23CmJfYAqy0c9fDgRaqMiBFdbe/ESLNJmfx8fPTJ/gsAytfh7y6xwF+/K1it
	 0uNTHs9b/TGUEiNkP8YCFfSZ/Ctd15AUgpVCQtFY6xjQ3dt+QKlELFtlqX3/Wc4fUF
	 se2SPnGb0WjaPr8K97a5uwtV176OWi3CgeCwwNuvTDZSqOenAiC0z3dN9MyGsg/q1i
	 Z4xgetjn7g2T0mPw3yurN/TSsAr3joPv7RGuELLJnQTM+EB7SIQ2TPvVvf20OV2BOA
	 ReicbtGInOZXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60632CC6B03;
	Mon, 12 Oct 2026 21:14:02 +0000 (UTC)
From: Bishwa Bhusan Saha via B4 Relay <devnull+contact.bishwasaha.com@kernel.org>
Date: Tue, 13 Oct 2026 02:44:00 +0530
Subject: [PATCH v2 5/5] HID: UNCTRL: only report to userspace on battery
 changes
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-unctrl-m1-battery-v2-5-bd6752021753@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
In-Reply-To: <20261013-b4-unctrl-m1-battery-v2-0-bd6752021753@bishwasaha.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bishwa Bhusan Saha <contact@bishwasaha.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791839640; l=1613;
 i=contact@bishwasaha.com; s=20261012; h=from:subject:message-id;
 bh=KdqmriOtFavceiEYR5a85IDrZtx1u4sC3/DG/YTiFJ0=;
 b=yP3y4kypAkgi3nBghxXa8QO28nISgCfqrC5G61vi8namA1rGRyA2UWBTkNl1y0qS6O6n0xpqX
 F47X4ZTE85lCtbJm5VQEWnJ6DEhAl8uqYIYOFC/EdKxo9k/PdYHxnp2
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
index 624ac1365..c44d1cd5b 100644
--- a/drivers/hid/hid-unctrl-m1.c
+++ b/drivers/hid/hid-unctrl-m1.c
@@ -331,6 +331,8 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct unctrl_dev *dev = hid_get_drvdata(hdev);
 	struct power_supply *battery = NULL;
+	bool changed;
+	u8 old_capacity, old_mode;
 
 	if (!dev || size < 8)
 		return 0;
@@ -345,16 +347,23 @@ static int unctrl_raw_event(struct hid_device *hdev, struct hid_report *report,
 
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
 		/*
 		 * Only schedules a work, so safe from the completion path that
 		 * raw_event runs in. Under the lock so that the unregistering side
 		 * is either done or still blocked when we touch the pointer.
 		 */
-		if (battery)
+		if (battery && changed)
 			power_supply_changed(battery);
 	}
 

-- 
2.56.0


