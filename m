Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7543E51CC
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003230; cv=none; b=e57WblekNpiNjHernOQHBMxpVxfHjYZ+/2oRhZRZIjSvKf7+aRDEzoPakxgPID5D5EIO0AzxfpS8STgiq2I0FV8uhtcIejTSScUXFs4sKnSLc6H9+HI7j4PvT0f4eJHTaHpIpjnRJ+sgIp3Obcb90jof5hJ8dGnW4L+nHf041a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003230; c=relaxed/simple;
	bh=thsDQLnCR6SfzvS1uM0l/YNM1YyNmv++oFkd1kZC3Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fUOgK6zxUTK5ueJ62eqi3TX3QsOywscfWfzR/km1DLCHHcUCciVFTYT9alwxSsvBwGUnWoNvTZaOxfDr7LWeLgsj7F0TM8rlj4boxRAWJAF0I/d63CM6eOjlDvk8RjT2+NoErMspSuRrMCDa40tcu+KMBlz58IrXVExlhA1fjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AORNd/83; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AORNd/83"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf452def93so5262735ad.1
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2026 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786003228; x=1786608028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNkhnL9orn28bsi55S87ql+B+2Su5aGr3RVynXyjRm8=;
        b=AORNd/83KBqZ07mlAiYBVAk1ekSVcupD130GzzlLBIzp5J/oe2bOLflf/C6+8ukaZM
         F8n5Ur17oHTmwFpIvJ8C/lD/wr62HodssWF/taS2I+WkCNZG1dNIOkjj0AWu/fkX6zS1
         E+m/n2lmj2Msd/Q3iqRACqk+iHv5SLIwE400rHh072kSsoG+uERj0AtoW4S0PI08Do/2
         wy6TqLpf8WjOOLlmyI6XDZyleThu9kKzIJpu9Z7hSci/ORxwBJ1epLbLMoigrQuh/k+W
         XeQqLrMZTR1HDQTjNDSzVyGjymG0tYnHlw95fBz3D9tPLnHglu1ZhE+fNTy/qdgkZai+
         3btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786003228; x=1786608028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNkhnL9orn28bsi55S87ql+B+2Su5aGr3RVynXyjRm8=;
        b=WBjhWdp/b2VbuFljZAH8WkDk3hfKsVUUYS6LLOCf6ACvmuET0fsThYqLb/wN6ju2C+
         V4/p8Cfx/0d1ENSKetk0Zg5a6nW3HhJ0evVHtxu9B0F4XsTra0FuSNAUTMmHyoijtNHR
         zTK4EqEHaBbZrkSOmv81llz28MvQKAwVT208hyHMCa0Q5Jmkox+QZgMBQRN3kFCwGOIv
         +7jojTgGUz35gJ55dL/RkyoI7m+QPJyuPQWFBiysh/03OKQ8gNIbSuHTDt3xWjPeatuq
         dP8PrtaUDinnPjIiOOvWc30+ywlYUaHO/5iHSRqcF1sz53zYiJnCebGz2TH11VezEDNH
         Hpcg==
X-Forwarded-Encrypted: i=1; AHgh+RpUSErc+NJFNvaZBesTPaANhwB1Dts0KOCSNfnEni1fIK6M9KO4EyzvL/eeiqhNGv1XfOM2TKXe4aGjiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8M0b215yMGyeIWe6qGKKipqwSxIZy7/LB91O4EanHQtAjEYpV
	nRoxZgQS1NVsoigc08O72oQEXToYuh6kodq7Amkuf5szuT3asw258tGo
X-Gm-Gg: AR+sD12WdbzKOngyAE7M6G7y+SzTa4xou9+zFpbfmIPw1c2ke10Xk3K/bpGSNg1lvTM
	p2bexGGpJviTRs65NS96pq+nqSboZWE7bqXq4KzIFuI1Xdlo7Kjn4PystpR3RKQBpfSz3s9N5tY
	1qD2N+3aXlXlzrB3eRIi75votZ24ntr2hIwIh+F7qWAhu0snhUK/jQPBBPqouA1s1Z5e0c9MJkq
	muMV9LdsdPXUbSUSfmsZU5sT0LfudfUASsvXNZ7rxY65UrColjodGb8p/7XO2r/kKpJE4/XIxx1
	YoFylHxaWhnZLTIEaWxfga9vuJ8e8XczI65dygnbmq7abb/9JaEAQri3WSFbppKbXPA3jwblOM1
	xu71e6KIGUbcltyDaalJ4L14zlhWKOkSpHv9as0gs6N0hrk6tQ62jAAWUPh0t7zC5KTWJsOr2H4
	Xgo6Hj/X8JL49Vz/bJfqlfx27gixoeZfL0v2mClFZrCVjbDCk4GijFbOgNnVZ2lrVdcjDEY7GZD
	LMjlONQrHteLBsUQz/unlhsoA==
X-Received: by 2002:a17:903:2f0f:b0:2cf:70d2:da7c with SMTP id d9443c01a7336-2d0f1c3c54dmr67031155ad.12.1786003228440;
        Thu, 06 Aug 2026 01:00:28 -0700 (PDT)
Received: from deepanshu.. ([2401:4900:bc2b:c75c:ceb4:d41d:8705:b6d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586402e53sm35852556eec.11.2026.08.06.01.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 01:00:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
Subject: [PATCH] Input: sur40 - fix use-after-free in sur40_open()
Date: Thu,  6 Aug 2026 13:30:18 +0530
Message-Id: <20260806080018.10050-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If any of the registration steps after input_register_device() fail
(v4l2_device_register(), vb2_queue_init(), ctrl handler setup,
video_register_device()), the error path frees sur40 via
input_free_device() + kfree() without ever calling
input_unregister_device(). Since the input device was already
registered, it remains live and openable, so a racing open() (e.g.
from udevd) can dereference the freed sur40 via sur40_open().

Split the unwind so that once input_register_device() has succeeded,
the failure path properly calls input_unregister_device() before
freeing sur40 and its buffer.

Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input devices")
Reported-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=683f6c071b5abfc266c1
Tested-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..b0958422ff76 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -808,6 +808,10 @@ static int sur40_probe(struct usb_interface *interface,
 	video_unregister_device(&sur40->vdev);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
+	input_unregister_device(input);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+	return error;
 err_free_buffer:
 	kfree(sur40->bulk_in_buffer);
 err_free_input:
-- 
2.34.1

