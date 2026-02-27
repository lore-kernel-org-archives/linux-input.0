Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC21A9F83;
	Fri, 27 Feb 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209849; cv=none; b=aMpYIibb8TYLvc0NdUwBlZJCX6/OzL7YPSAqfaix4h26D6vsXF4Pcn+a7ANOrSGaISgjzNDYPbYHyl8NmYQWJmkMAuQKJlOt6CaUsGgwy5VW2Az7kO0r28hvHcnq2c4QGNVOJf+hRxyLZq1PXD+lmyqXcMPBg2HJX6gdt6kjFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209849; c=relaxed/simple;
	bh=BlsTu0VOG9/qAj3jabhz/qcOBusWfTy4d8sl/RuWakA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG0xK5BO2ewFZWWABZVD6OavBqvOjtFpz2fkcW1F1ey/2QtSMmvIkweEqBR8vk4ZcStaBloH/XXqEIW9Vflxdw9YrbIx/jdV0zkG6x79QcuODNbMUYzAtRmlYRIarTxAhQ0AqFzG+OscEilIho/Qk3BkJ8idppwgv4xPCppoKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2A4cF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2A4cF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954A8C19422;
	Fri, 27 Feb 2026 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772209848;
	bh=BlsTu0VOG9/qAj3jabhz/qcOBusWfTy4d8sl/RuWakA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PM2A4cF22CKoG8+LR1MSZ6JPGilaCqyllq7HkkBaR0qwHWNmoaez4FeCGyQFBx9/Z
	 BQ1sYK/AppHVr4zjAhhxXL8Md7KsElyTHO6FReX5lRqvIeDSD8VoF9kxXVZMqdrNXO
	 VMtR0KDkZEWvPj6mDYpiQwYu+g9hnpfgEIwXwMdzSAg+Ir5VckX4RisIAK3fS31v6w
	 RZPYoNdgZs8mFLtl99OJywaWW9dm1cWQxbvPxFpdAX/2tjBEeLWViLExVU6v7oo9WP
	 Ypl5iFjXroaIFGZLJI/an9kPxiHmRKpfOwFz9dsexEK/YrLz+03rNvFPQRe3ZJvAaO
	 UO5FUw+1fXX8g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: multitouch: Check to ensure report responses match the request
Date: Fri, 27 Feb 2026 16:30:25 +0000
Message-ID: <20260227163031.1166560-2-lee@kernel.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260227163031.1166560-1-lee@kernel.org>
References: <20260227163031.1166560-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a malicious (or clumsy) device to respond to a
specific report's feature request using a completely different report
ID.  This can cause confusion in the HID core resulting in nasty
side-effects such as OOB writes.

Add a check to ensure that the report ID in the response, matches the
one that was requested.  If it doesn't, omit reporting the raw event and
return early.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-multitouch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b1c3ef129058..834c1a334887 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -499,12 +499,19 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
 			 report->id);
 	} else {
+		/* The report ID in the request and the response should match */
+		if (report->id != buf[0]) {
+			hid_err(hdev, "Returned feature report did not match the request\n");
+			goto free;
+		}
+
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
 					   size, 0);
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
 
+free:
 	kfree(buf);
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

