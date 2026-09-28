Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE73D8914
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615615; cv=none; b=eIAzttPtapSRDgeBlnZENOpDOOu2nPi8I5lepXSbhNxEEvMOJf/kSnX2o4nVRs9wPWtQ62vR6K3Ukppb/S32y9eRdMRE3lZXFG/VRIo7qECaulZ46Ez0c5tTmNv7WArQGD/171pDtDjswRTt+tlDPoWmTt3eS0YbPXbQL8Ywz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615615; c=relaxed/simple;
	bh=XHxU/KK74RPc0kjSTKlbcrcV9V1wAktMhhVZ1zefMa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aY4cJmIC4F4n4SkN6Wb4KsZRds7GiqV3ny34z5GsZR3pG9EvVFvmfujRdY+U+saRCAa9Tfh7xW/USxtnZY5cP2oIDzTiNPqGAiEvSykfhaGIaYyQ9R2qwUiJjcc5EZQ/gWjSQ9OmuPfotvDYOpMMzZC4kaNewkImmQxo8IiKdQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdEAZ+5l; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdEAZ+5l"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso24530475e9.2
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 10:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615612; x=1791220412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7b9T1NGzSIvXERiQY1++9mhso0lw76tkEZqq9P3l/A=;
        b=QdEAZ+5l/R0BgZZ2voaG/n8050hTzTqV3tdGs5bvAjsYOHz3+X+cRJYjpfRzDbUixh
         7Z/cl3L7B9d6J8FzVTLP1a/rV6YX2UDRJU75UFdCypzpD7hMdgytir63dFx9vuVBTZtA
         hNOu+jWDBYNlug0YSGDV+uyZFkvbzkK9j/ZZ/d0Lx4M5eAK4VuVFUPQLHHAZ9bdEWldt
         idBQ3PzSYfy+XflWP/6V7N5fRiJsrhx0Y3LEkqcC23L3noveF9ASr1sHjoQp+X6GAqeJ
         UpdooAeD5G9Obww5ZHtfV+jU5zmw9VhP1o68C+u0OqSYVyo4IZVnniuWrETHLT6JjwNl
         VGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615612; x=1791220412;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P7b9T1NGzSIvXERiQY1++9mhso0lw76tkEZqq9P3l/A=;
        b=Yt2aQByUn5lYZtpoavRDCzQTx2ljwdmyam2d6QvG75gMJeIEgKYxmx9zTDNFH0Tv5z
         BjjUz2gpjJaNQo76LeglthnEXQCbT0QbewVeF8lib+MkiCNzjm99iFneOoGbXsHpLUhn
         uPD66SHQ0+TtRiwGsmlqPpL34VBOnGkIokkk7/AZSNAWbG37HU7sYzwSdLXfBH+onmNe
         FrSbroh9IProlCl5+Vn1Cd4jGbul9y8lD555fNZYgiRt+U1Jbzu8eRSrxqUHOUHODRPA
         KeB0KrFatmrhUBZnbYdlisjlpodZ1KRIZJWuhV7cJGPHcOkNiiDIgd0ZEbLUop4VI/sr
         VrdQ==
X-Gm-Message-State: AFuF++k6V7G5Zq+rbSeknhAHGa4Y609tc0vCrqA9O77kRp8gPXlnq9cy
	y1+4cRl8F/6ona+2aDw1CcQDiqwkhHxfjMwgLXaQD+nkKLA62GkMqHX9ZuHra5E=
X-Gm-Gg: AYBFou0ufLPV1484FrZGdA2wpw4ouOKm3LrHjxbpuC1IwbAm8AWAy+/h9QsCCx15KIZ
	olvD5Nrg0hAWMhbqFGC9GbHQxDC6KkwgjyoNVvXi68ZWXCJnGgLfYw2pYjdcjTe30Dy/nUp2h7V
	E1aTgXlcM3dGXbzHU0KYAuawzVYkfFyMwYjIUM0qqG5gMeYUs1AmlfXDyWnyBzZ3bEkPqKv6x/V
	vKcY+RG/Vq9xndvmfFgyDnEVGB/kNeZ31IJvcv0Ge4m/r3Fg5R/EWIE1UIw5vvqzTmlPFcC5J9/
	ZeGCcM+QdPINJg7oHYpvmtVZubMR6yNYRGe2XbxTfjFs8DIWlQ3LRCPSwyEYGFFguFigEiL/+k3
	fKwur8BVQ5AAv8uidMac9P0RvOX1iquv3L22lwxWtiPO6NIw2BF6zteHYC8KzOgE9ol/OHSxjiA
	N82sAtupPA8GcagPwrR0FlDAZT43STfRnAPcNcFdoJdAzAtORL+lmijPv0QiwZg21r5ZAMUKebm
	lvlBK82r8oqE1sAfLJnNRjVzAOx7QbYpltB5qTiNQ7WBqbh
X-Received: by 2002:a05:600c:34d4:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-49fe66d1279mr209796045e9.10.1790615612284;
        Mon, 28 Sep 2026 10:13:32 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfe0ea4sm6947525e9.3.2026.09.28.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:13:31 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com,
	=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
Subject: [PATCH v2] Input: fix potential use-after-free in input_devices_seq_show
Date: Mon, 28 Sep 2026 20:11:08 +0300
Message-ID: <20260928171306.59206-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The input_devices_seq_show() function accesses the input_dev structure
while holding input_mutex. However, the device can still be freed
concurrently, leading to a use-after-free.

Fix this by taking a reference to the input device in
input_devices_seq_start() and dropping it in input_devices_seq_stop().

Reported-by: syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc6b37960b1d13f68f9f
Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
---
Changes in v2:
- Added Reported-by and Closes tags for the Syzbot report.
- No functional changes.

 drivers/input/input.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index cf6fecea7..14a95e816 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1051,6 +1051,7 @@ static __poll_t input_proc_devices_poll(struct file *file, poll_table *wait)
 static void *input_devices_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct input_seq_state *state = seq->private;
+	void *v;
 	int error;
 
 	error = mutex_lock_interruptible(&input_mutex);
@@ -1061,7 +1062,11 @@ static void *input_devices_seq_start(struct seq_file *seq, loff_t *pos)
 
 	state->mutex_acquired = true;
 
-	return seq_list_start(&input_dev_list, *pos);
+	v = seq_list_start(&input_dev_list, *pos);
+	if (v)
+		input_get_device(container_of(v, struct input_dev, node));
+
+	return v;
 }
 
 static void *input_devices_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1077,6 +1082,17 @@ static void input_seq_stop(struct seq_file *seq, void *v)
 		mutex_unlock(&input_mutex);
 }
 
+static void input_devices_seq_stop(struct seq_file *seq, void *v)
+{
+	struct input_seq_state *state = seq->private;
+
+	if (v)
+		input_put_device(container_of(v, struct input_dev, node));
+
+	if (state->mutex_acquired)
+		mutex_unlock(&input_mutex);
+}
+
 static void input_seq_print_bitmap(struct seq_file *seq, const char *name,
 				   unsigned long *bitmap, int max)
 {
@@ -1151,7 +1167,7 @@ static int input_devices_seq_show(struct seq_file *seq, void *v)
 static const struct seq_operations input_devices_seq_ops = {
 	.start	= input_devices_seq_start,
 	.next	= input_devices_seq_next,
-	.stop	= input_seq_stop,
+	.stop	= input_devices_seq_stop,
 	.show	= input_devices_seq_show,
 };
 
-- 
2.47.3

