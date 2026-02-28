Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51643DA38
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290000; cv=none; b=jNLPYAp+GcLGrnVsHQMdzrijxLt0EYGXoBoRKax8nKJMVV9q9lJIMS+RS8udNYkVVCHxQ9s8sGwBqRkU5oU+DvW4H5XNYd+uWUkcR73jXgsRE4D/xTc3BOPH3r8i1v/kWJo3cINrQqRLzMk+8MF/TlpO6yoti9dh2Ik0TkBAj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290000; c=relaxed/simple;
	bh=RLfUS5tra/gyyd3lDFT3Jo+sr3I3Gar7nGUgIP4tNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK8CXpZbWj1OwO8lTcv3mZww6RDRka8GCizOyJmlUJ6EGN9qaGM8Mxm7hV0NBMAa/oLxyz9x/tgWrFa/Y4eocryiIhUfzesamjwECOfKbvjHsmisod8cRoQRteExCv0R9ZqtAGJNrNW1Ilah9vJFZpv+fB4dU7p+9j09xJpQq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zq8UnDVU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zq8UnDVU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772289995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/JjveZr9Jn4MeDPTXiAb+xofPvVBJSGHbnUYefB24Q=;
	b=Zq8UnDVUZL8QHqk0ADiv2zMgtjWxyM9uORb1l9uMbFWpFmNdfaV24YX8SbRTSNPZHjx0IU
	UgkmYxEU6F4a1xAOojbrFDxweg9Aq07dZT3+4GTwBqtM8l0sKLKki8G7ukdlvg6BC+HDXf
	V1ecYxw3AMklXdYwEURn5l94QeiRaOM=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>
Subject: [PATCH 4/7] HID: asus: make asus_resume adhere to linux kernel coding standards
Date: Sat, 28 Feb 2026 15:46:23 +0100
Message-ID: <20260228144626.1661530-5-denis.benato@linux.dev>
In-Reply-To: <20260228144626.1661530-1-denis.benato@linux.dev>
References: <20260228144626.1661530-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Linux kernel coding standars requires functions opening brackets to be in
a newline: move the opening bracket of asus_resume in its own line.

Fixes: 546edbd26cff ("HID: hid-asus: reset the backlight brightness level on resume")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2b4411399571..48731b48523d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1171,7 +1171,8 @@ static int asus_start_multitouch(struct hid_device *hdev)
 	return 0;
 }
 
-static int __maybe_unused asus_resume(struct hid_device *hdev) {
+static int __maybe_unused asus_resume(struct hid_device *hdev)
+{
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
 	int ret = 0;
 
-- 
2.53.0

