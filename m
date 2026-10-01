Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E02253A1
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813238; cv=none; b=vEL5CCECXruXFHZudfytdEKRzvfxN7kCuyVFj85mxh/lVcdh1nrEgd+0xwX2SGDc6to60DbrMsKF2W2JOHYBjEi8Xmj3qzw8bNSdozzQbKRU/htGIqXx7hMXJDYpJss9/h+yDPQXWu60RrgLQa3nAMpMfNVg5y+ISNcGR8oBL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813238; c=relaxed/simple;
	bh=ctsGS6lnk6rXTrY98UOT3o5M2C6j2dr/NzLtFhmBWk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JQV7w1mSFzSlTwQk9mKGdOfo2xKqf6vhWO3OdW5ektJeYBm0A4wmEcTGkMOypHEURaXHDiWpGEIuiwe1nXNmxez1OeyVQQIufq0tUrzTWkvuO5FzfPu+Bx07Y93LvQOK716hp2LJ6GaGD6LpUgw+kyMjKszoTYkXpzEmsSbnBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ycstuff.net; spf=pass smtp.mailfrom=ycstuff.net; dkim=pass (2048-bit key) header.d=ycstuff.net header.i=@ycstuff.net header.b=gR8p01yF; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ycstuff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycstuff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ycstuff.net header.i=@ycstuff.net header.b="gR8p01yF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ycstuff.net;
	s=protonmail; t=1790813231; x=1791072431;
	bh=mhSs+RMwZjtjzvmPxkz7O9bb+hocQqnfw9nObx+ARVE=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gR8p01yFRttj9kUVtzYJh2Id94HPeMs598ywSa1rT/LZ1y9N3EHqTuxvjTC3AUTw5
	 hdEbsfwAwmsdgsSMLJg2e170GYuZ6J9xgXqM9PsADrAy6qRE2NjTCu5/kxHBFjOpMK
	 PJehYS11uL6XjteC26jxt+a3ctjlSUfpwsbG9rDAaVLD3tu+1pe2ZwTRPJb1Ev0aBO
	 cXJzguvZlx3aB8DNATovlaFLoc2+jH/KCtSBgTzNNn+6pGvnB5TrTQAEty3AALZp60
	 bZGhxdTyGg9XRg/AdM9z1wbncGpYBH7oNz9/fAfvuU1eAShph6nxEIPN/sJ/9z1OmP
	 dILS6fqJlACBQ==
X-Pm-Submission-Id: 4hwBzx4QZcz2ScMv
From: Yicong Hui <yicong@ycstuff.net>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yiconghui@gmail.com,
	Yicong Hui <yicong@ycstuff.net>
Subject: [PATCH] HID: magicmouse: add pressurepad property to Apple Magic Trackpad 2
Date: Thu,  1 Oct 2026 02:06:59 +0200
Message-ID: <20261001000659.21747-1-yicong@ycstuff.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace programs like libinput will take the pressure value reported
by trackpads, and use it as a proxy for contact size unless the
INPUT_PROP_PRESSUREPAD property is set, causing libinput to freeze the
touch input when pressing too hard.

Set the INPUT_PROP_PRESSUREPAD property for the Apple Magic Trackpad
2 indicating that it is a pressurepad reporting pressure measured
as a real force, as specified in commit ae8966b7b5bd ("Input: rename
INPUT_PROP_HAPTIC_TOUCHPAD to INPUT_PROP_PRESSUREPAD"), and set the
INPUT_MT_TOTAL_FORCE bit to allow reporting of the total force across
all contacts.

Signed-off-by: Yicong Hui <yicong@ycstuff.net>
---
 drivers/hid/hid-magicmouse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d637c0477379..017e3805557f 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -620,10 +620,11 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__clear_bit(BTN_MIDDLE, input->keybit);
 		__set_bit(BTN_MOUSE, input->keybit);
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+		__set_bit(INPUT_PROP_PRESSUREPAD, input->propbit);
 		__set_bit(BTN_TOOL_FINGER, input->keybit);
 
 		mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
-				INPUT_MT_TRACK;
+				INPUT_MT_TRACK | INPUT_MT_TOTAL_FORCE;
 	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
 		/* input->keybit is initialized with incorrect button info
 		 * for Magic Trackpad. There really is only one physical
-- 
2.55.0

