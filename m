Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AA3AE18D
	for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911566; cv=none; b=a3tkmtrjoEQ5rbi+gxiAYN7zxuwfS86VQQH87AEzqY+gmdmsGGV3b0lR7SwbxozneVYkJre+9Bb3ocf+nZLV8G7y/hnWTyoGb5Nae29BYn+1UVHukWtcuqpxpFDftZbTGccwtyG7zQ0dWlKqU5neAmWgQn+QPFXlSuuKbdJk4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911566; c=relaxed/simple;
	bh=MJA9JnatOxTDcya0/pH4eQEUS46aOIcCQNEXUYgPKjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7OTddSzhTsIcFY/XlcUAijKbuO5aO+lMMKS8dualMN2g+mvH2slvdVSWHQORDWX2MkV/ARSall4VGl1Mvx2yLF6qdhvT/Kwq8ufoRvRqVc7Wiulre28WATidmQjvUt/ZmggfdApN1lgx5knhNhNdXwVvqXDEJwmap1zByRQQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF/QCBq+; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF/QCBq+"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f4e729368fso866268a34.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2026 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787911564; x=1788516364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tzEZPnlnA+MHUZ+FmtBKMiae7Anw81mNQrQ7J2H6x/M=;
        b=KF/QCBq+Nc13+fhWQb0LtKGAeuTrxDP8Ue3XIhfsR9u59bFKz0b8BJxTSdTOY780Mk
         8VHnQOZoagwdsKTPfEirOcjG59ywPaW/vVxI8OuFEchRlwXTsvdwunV77qx4jfU8XCNj
         5huCrrYxbA+Mn13TBS/lkk7kjVNSdElGjpM2zGjN/ChgquMG9jQ2NXLA4tioSmoK/CeZ
         8t1xSulfHQORTyExAYGkOtarfkq8WSQczU/S6RxI6nSTbbZOVfXPodGV160LtMQLUI8d
         vZxdv/Rosh7RHrVP53QMCj3HKln1CYBcjCd+RaHTmcwGqhIW3zNsiuwwwI9php715+iX
         gFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787911564; x=1788516364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzEZPnlnA+MHUZ+FmtBKMiae7Anw81mNQrQ7J2H6x/M=;
        b=mSCGo0KOu2D+2WBK9o6RU4JNCIHFIKghR1zAJajynJy3dQtN8dwWbqJDZEsUCtW1lA
         +h5dDXzFKdWZx8A9Vkvlb2yodtJiwH8sasF1YjrF96K7kRk08ujB41yu/kRRWRxaFydQ
         /hF47Nf6OLXofOUIn/5Y9EF95YpoFMO4GMQdSJeWpESH/AbgMkwmDZZA+o5whne+c7Uo
         zG16KRXCfFYG1G5Qu7JtobFSCRgETdtWa5TbvyT/76RzeOS1ubRhG5vrqFLJR2tmy2WY
         OVlGtnVwqMHfSwnRQo65kYa+Eq7BxIvq/DU1dR99dBSKrlduJOMcndZ+YPsQ48Qswcmy
         pIkg==
X-Gm-Message-State: AFuF++msunp4x/jBy5hCqKIN/kPdtk7X7SyL8pdjnqFKTE1iVDYHLUKQ
	KcvPMbaC5iYTg4OepRDv8DZrS/SEU3MQC+JztFFt6tAZ0z3chlZu0PQn
X-Gm-Gg: AR+sD10ckqPT0hSSui9M8kbOX+WvW9Kx2KqB1M7Qhf2VCJGmR0ks2e3AuU0aDYdiMbf
	pZlW1oc1rgBYZxY54jmHH4ZUIEpifnVOH6Ng+Ufcak7PdR0GYUMAIX9wKwRCoQC4ZmSjtUxYGDj
	TmbtMSQM9EthPQIutOjSZeNJPqKL7W8MNrTsM8TXgw9b/acGL0/+xmRzE2sJ5WLU1pwWt6eFXap
	SdQZWGoCYKudw8xHMEi0uDuFDeoDSZbXSK5G88KWyXfzwg7LKyx9hDA1sf9naEKEAggPxTzOjUm
	4XkJvDzSxLSs726FujBYE2C1MV6zDA9x9YfGFtuAFxF0M182uBI3slUpbqCmUgUS73bJuaDIz1Z
	hpjo6MJO6Wh+gJU9CWHSQITI5Y4hqe2Q5Rcdca8ZDBQRvDRw0N+V9gX6DZr1U7Phd/dN4bIkiig
	INPg2a452KD9XyeWZkKgM2Ap07dW0AkoPXokwMQLdGLYXMmLzfMNDWHEfbPVomAXkxTcuPFKmKt
	Ujk
X-Received: by 2002:a4a:dd1a:0:b0:6b0:5bd1:4722 with SMTP id 006d021491bc7-6b1c668e741mr4292347eaf.13.1787911563533;
        Fri, 28 Aug 2026 03:06:03 -0700 (PDT)
Received: from Default ([2409:40f4:1018:6686:df4d:699c:e13c:43d2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm1910157c88.11.2026.08.28.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 03:06:03 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: [PATCH v2] Input: atkbd - fix UAF in atkbd_set_repeat_rate() on disconnect
Date: Fri, 28 Aug 2026 15:35:47 +0530
Message-ID: <20260828100547.120553-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect")
moved cancel_delayed_work_sync() after input_unregister_device() on
the premise that events may arrive until input_unregister_device returns.

However, this created a UAF as work that may have passed the
atkbd->enabled check in atkbd_event_work() may attempt to dereference dev
which is freed in input_unregister_device(). Reverting the commit also
does not solve the issue as events may still come through and pass the
enabled check as atkbd_disable() and event_work() guard with different
locks. Fix this by closing the hardware first using serio_close()
and then unregistering to prevent work from executing after
input_unregister_device(). serio_close() closes the device preventing
work from arriving. Additionally add a check for atkbd->enabled in
atkbd_event() to prevent userspace from queuing new events after
atkbd_disable() sets atkbd->enabled to false.

Reported-by: syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e2ef9bcb29af666b2e6
Fixes: 0ef7a26af127 ("Input: atkbd - fix canceling event_work in disconnect")
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
 - Changes in v2:
     Added a check for atkbd->enabled so userspace cannot queue events after
   atkbd_disable.
Link to v1: https://lore.kernel.org/all/20260828080839.116065-1-jeffinphilip14@gmail.com/T/#u
---
 drivers/input/keyboard/atkbd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5736f4bc5a50..79e4cd9ee1db 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -672,6 +672,9 @@ static int atkbd_event(struct input_dev *dev,
 	if (!atkbd->write)
 		return -1;
 
+	if (!atkbd->enabled)
+		return -1;
+
 	switch (type) {
 	case EV_LED:
 		atkbd_schedule_event_work(atkbd, ATKBD_LED_EVENT_BIT);
@@ -963,17 +966,18 @@ static void atkbd_disconnect(struct serio *serio)
 
 	atkbd_disable(atkbd);
 
-	input_unregister_device(atkbd->dev);
-
 	/*
-	 * Make sure we don't have a command in flight.
-	 * Note that since atkbd->enabled is false event work will keep
-	 * rescheduling itself until it gets canceled and will not try
-	 * accessing freed input device or serio port.
+	 * close serio first so device will not get any data, which prevents
+	 * atkbd_event_work from being rescheduled after cancel_delayed_work_sync
+	 * returns. This ensures no work can dereference atkbd->dev after it has
+	 * been freed.
 	 */
-	cancel_delayed_work_sync(&atkbd->event_work);
 
 	serio_close(serio);
+	cancel_delayed_work_sync(&atkbd->event_work);
+
+	input_unregister_device(atkbd->dev);
+
 	serio_set_drvdata(serio, NULL);
 	kfree(atkbd);
 }
-- 
2.55.0

