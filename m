Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC12E5B29
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639468; cv=none; b=h1Uz9Dy4ZXmYHdPHXIubGvbZfeh29g5RgNCevQQ77wyfXZqWam7WYHTZ/4SCwMTTcpDguhbzawmues4WOuyL+YBX+Ges+16/P2Kv/aQAVhWq3RA0H0vTMp8CD2v0/3z2rvSvYUmFiTBO/avubdqJr7tMruJTYZVHfXfBbyP0fRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639468; c=relaxed/simple;
	bh=KUxc5s+Ozy/mh8LcygImhFbcgR+t8ibAmyTyILx/d9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt8DVm35HKZUg9wzgJ/zc0OVYnhym9HwZYZQ/u58joEh9N9/jiOqeApYb8d4E5QZPaYiLmWDY6OXeAAe4c1aQYqllJoyYevnvAHGnoxwtk3juE6hdnSbXpTpMYTiDQYmn7IQyd9weR0dBf8M4ZqMCCWYg8lphaCrmyZs5mkDPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX4F6utV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX4F6utV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4938d60c035so7857335e9.0
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639466; x=1783244266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FQzT0Pfxjs6kdPKaUfr6F0wexDd7Xo9qWKJhKghTGM=;
        b=lX4F6utViTkAkMfBZWiugZaSidMyROeH2ORe4flDMRrXPEq03BFE8YqO48noC7ORgJ
         KS/Djl5Jtzy17C+BWenVMkQwLcEAdm6418RhwTzY9JsmVeMuBOnsDohcHeIA23w3tSBb
         VvkY2Xr5wY7GYNc32dBJR2JH8rTWWPAFcyxV5SkxAQJ5IS1qvcuUAkAkvU8iIklv9lFG
         oNIlNlBuFfiuf3Hk0XLfITZwaEc61CZWlV4IlF643fFK3tV+NiMwOiH8f7VZh75NtFFc
         KDvfnY925GCE7N7wR1+lSRsv68SwpjNL+ltfc273yfoYlHR33HLbDj9MDiNLyt/Dag0s
         gYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639466; x=1783244266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FQzT0Pfxjs6kdPKaUfr6F0wexDd7Xo9qWKJhKghTGM=;
        b=NUJdQ/K8OlzszHp+d3iTO2Dm68QrPtcuWP+vX3UC9Ec6tZpSH4J2gwdQfWZsXdwVA+
         ztK3X7Ow+Oj2BWKbs9oALCwrhYf8vaxfGt2xrNzldtLWkOne4hK6xFAN5PVqV4jwYB2C
         Y6t7dNBhqc7nrF6AOj7nwMcMSL2+tTvT9HHXW48Z5VFa/8Io4jST/WMoltkbeH2I2Jzh
         14HblSxhUZfDTvVc9JNhYB4wni4orpTE0PjqqcuA3zlLiJR3gXkE1gPd6IPWoy3XIqJb
         Sbo7LYzCJbW6ntifjcGCaCt1SZP/28kQdO3/P5oDzrLzzL6uNdzEH68IgdbKwRyBon0e
         glYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mLlZTrV2PXaiRawaJbR9cZAp3jv8uILzWb8/G+pilezR0a0js8uDqVIYEdaPH7kMTYUTr9xFtRkZpWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeMb10Msu2eX0BmK4cZRX+4lUh6AhDrU+YzLdGOZXBY2cmqR6
	4V7ysLONw3BlSFRhZlAD+hON3kACAeRQ3POc+lH6/SNibulH6tSjmkm2
X-Gm-Gg: AfdE7cnbtHRWI2pu6JijEgP3VRj6/SLbNtWWdLoguU/nI9z7BFjk+YDtm/N6tVp+Ltd
	ZHNegisTv96ibN7qU6h8In7GIuO/RfUNShY0gv6OV4TyQh8miI+5kGeGKSwlZVT5F6DfxhGbS56
	q79I/ReNGzPHXl/Ac1VeADX/3AnL08orOkAotqzJPrJKep8xF3qo18YUuLM3T23LIV+m3DvK0Xn
	u80GGpACaUh0mRKudzu/TZf4zMPBnZvUA3PQVPxgo8vZbDb/3cLWjfZUEBKG16Evwz6T65gdZPa
	ETRLkZlnROAdJ9bvxPNvdaKVhnyid5+rYBvgUamY0E5WrenrWHq9LTHcj5Ydl9b3gWnl67i+M0y
	L90DeQtNbIpJqqG0YFq7RvAZwmjY+fb0y7gRtvYwcMhK9UzTebvNn8JAUdWDeEbrvbyf84Mg14I
	VBo6XTcSy0yz+Ko3ep8oMFgFaFzg==
X-Received: by 2002:a05:600c:1c17:b0:492:7019:caca with SMTP id 5b1f17b1804b1-4927019cb17mr131689195e9.26.1782639465516;
        Sun, 28 Jun 2026 02:37:45 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm246657585e9.14.2026.06.28.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:37:45 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Rishi Gupta <gupt21@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: mcp2221: reject short input reports
Date: Sun, 28 Jun 2026 11:36:58 +0200
Message-ID: <20260628093658.43445-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCP2221 raw-event callback reads fixed offsets from the 64-byte input
report, including data[50] and a variable payload beginning at data[4].
Raw-event callbacks run before HID core extends short reports to their
declared size, so a malformed USB device can make these accesses run past
the received buffer.

Reject reports whose size does not match the protocol and complete the
pending command with -EMSGSIZE so its caller does not wait for a timeout.

Fixes: 67a95c21463d ("HID: mcp2221: add usb to i2c-smbus host bridge")
Reported-by: syzbot+1018672fe70298606e5f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1018672fe70298606e5f
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-mcp2221.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e4ddd8e9293b..311b51c17b4e 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -861,6 +861,12 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 	u8 *buf;
 	struct mcp2221 *mcp = hid_get_drvdata(hdev);
 
+	if (size != sizeof(mcp->txbuf)) {
+		mcp->status = -EMSGSIZE;
+		complete(&mcp->wait_in_report);
+		return 1;
+	}
+
 	switch (data[0]) {
 
 	case MCP2221_I2C_WR_DATA:
-- 
2.54.0

