Received: from mail-vs2-f11.google.com (mail-vs2-f11.google.com [74.125.227.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D5345EAB
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790990328; cv=none; b=i6njks7vFeNTblLMn5aGUx9aEnKmmr1fJ3ltc5R+cgSA3QkTD2Rb1l9NfgFZajCznfy4Ci9QWt7Fnzcep56nFvdvyHSZkTMxh39Z0Tkzh6ASdO17bM5iIR6D0l+5077K8pnHipiyuh1oXdQEuyA9dUkwpvQYdAHas4iQhWgyk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790990328; c=relaxed/simple;
	bh=C1eYKJ5to7jp23Qb3KieYha41ikL6UcD0SPWNaLSb1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2dlN1jhpQdTDDKyEu8gfrNPUdUV+ZG9nMmUrAo38xyWHycPuf1aRPtkU2TQ6jib6UyqCNiEps9UD+Da6ULL6Jc618P9Zzt2en22DXP89TKGSghDBV95Z1OVzdhnRIrKtIdIMi5SyvjnO27BlEPVfijp3OewT1cLvVNaHxtnlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6e23d2p; arc=none smtp.client-ip=74.125.227.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6e23d2p"
Received: by mail-vs2-f11.google.com with SMTP id ada2fe7eead31-7c0dbb2176aso18856137.1
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 18:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790990309; x=1791595109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AEmSwYlG0qis3rm6ApjRG5M/pOaXn1ND3xSYcCNbo4Y=;
        b=f6e23d2pjY6bfM7FIxB0gtbqeS0FXeWvOyEeaqunBLS44UXVW+Nn7asU+/m8+Jqx6S
         aRlApDd2Vm2whui4AeAQQb/DwlV7VTegwaZHJ6OHhlEOKu0JTW1nlbnq5aKYQx2KSlyx
         6n6LyWcXhJsPA+UNGBMS/0kVuvlWmXuMjjuwl8c4dC19c0eB6rh6GttikneqwQ2tREPS
         fDyGOPJBz7BBQELsfdvZyvdcyce3zGKeb0aOf4eplBLuGdlzAnKIqfz9STmXeUuHkGxt
         845ZxZBJ7v2GoNfC0hLDwrv7yYPDUUkzWmHpO6aJMHr25yIOoLnLCZ+PDM4nMGSHElhW
         G3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790990309; x=1791595109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AEmSwYlG0qis3rm6ApjRG5M/pOaXn1ND3xSYcCNbo4Y=;
        b=fgkjNLzkuEtOVENW7inTX3aTkjpxqFPmOB05sf0rtNa/MNVJkgobXCxBGGnp8Nivh0
         4DkzIiogTTt2eEdSEZpdNmUAp1x+df1/jpCJqQAJ8oJq2lzbwE1ob6Fp+PSMQlFqfLyL
         01yHXokBwMt5DS9Yu9bAVzzTsa5DDoTfEPCTDCwJozcrcudFd/pxcAMa1E7m1W7aDaVF
         ABHaFPbNoXNQCvz2YLq/7XrJmotkpDPNamhloLYglRD/MmOsms5cnwFhs6VKN+b3VfSH
         CyUakpvn39XiYLF8QrA6T4Le+dT8N6aEJF7qYT30ZkT2PpbSQBhNT8SH6fM0lu4qPO9w
         N1Jw==
X-Gm-Message-State: AFq9FYJfCuTV6AzuXuT1E6H6T8ddC6vgRU/3m5VTRwfXwmW1HL1XESYf
	+NOUNPmNzMU56fQBPJ/bvFJ/qXY+f+uhiyAZz4JZnSOdlScYpgzelS/q
X-Gm-Gg: AYBFou0yKM5UqnNYpfzuLivrbiYF/1PJCbTCGM3eO6d/lOoFv2A6H2YpVIhedGgZpO8
	/E9k4YqcxG5l5wBPgVfMwfC6wRou1EoVtzlWwK/wDrTEndTQkeHHG3xPzYBmWaeIbTt7bA1ZbUE
	EyvpSD2aNWicm82Tdk8gWOGchXLW3Sjzy5Rp7NjaCzdtzHMC8IOTk/oqPTvBM1oov2knKlPpRAr
	EKr0r5yuIn4J0ayaV1vLEnxA0OfApYZ7xBfOLyXXFD3EIeUNByvjJipMSMBqZhH0tC0/Yv92VL3
	thjlQMIs2JI3TK2uVFnHXdfSadTrTiIkgTc5UqCfIo9oq2iBGSmdgbef1XmqXT+LpIHIDQKBcR4
	5YvIZpdA/KHH21Arrp/bc2jQBBNdG5NRzTe4/U6G/eDiAd5RFV8ubQGNg1GHwhqag5ikcvBuqq8
	hhVjzELcdVTfF32aSwZ+T9ewqLHneWWGoabcTHur+r9XReQNlD7qYpPBZ2pEOICFE3071Q1tgkK
	HBUh8HD
X-Received: by 2002:a05:6102:162c:b0:7c0:30f3:cae4 with SMTP id ada2fe7eead31-7c0f468dcccmr1264666137.18.1790990309084;
        Fri, 02 Oct 2026 18:18:29 -0700 (PDT)
Received: from linuxmint.. ([2802:8010:9a20:9901:f66:d985:53fd:94be])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0fdc62625sm4148177137.1.2026.10.02.18.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:18:28 -0700 (PDT)
From: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>,
	syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
Subject: [PATCH] HID: magicmouse: fix null pointer dereference in magicmouse_event()
Date: Fri,  2 Oct 2026 22:18:20 -0300
Message-ID: <20261003011820.1295672-1-nehuenlian.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a guard clause to check if 'msc' is NULL before attempting
to access its fields, preventing a general protection fault.

Fixes: b8d56ef91cc3 ("HID: magicmouse: Apple Magic Mouse 2 USB-C support")
Reported-by: syzbot+5ad4fc9c8360b68e353f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5ad4fc9c8360b68e353f
Signed-off-by: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
---
 drivers/hid/hid-magicmouse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index d637c0477379..85454250355f 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -553,6 +553,10 @@ static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	if (!msc)
+		return 0;
+
 	if ((msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
 	     msc->input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE2_USBC) &&
 	    field->report->id == MOUSE2_REPORT_ID) {
-- 
2.43.0

