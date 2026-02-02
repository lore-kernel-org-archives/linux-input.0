Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED723183F
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069751; cv=none; b=hRGLI90czrm2LLCwEk3cBzoubCgEHJMSVtWi2WZ1x6YqSqgC9Mq7HEh3ecL1rbK9cnjly8lZkXNXLfGSBV+scnMy9oVZXt+RHy9y6czpRJEb1kctbeDcHl+cZWxruB0sNu3qS20pmITZOGBy12Yo4YqpcaKbDheCJqCmeNd5AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069751; c=relaxed/simple;
	bh=M1h6oiDlaxrkqzOOKY7/+kSWhTgWeNiRMhUv+LJSN/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIImgjFYf1p2HAzbPl3s/kNg1bBU3g3VN+f7ZQxAoQFJTxk3yiFuYfIqLp9V7+s2PdcPif7iHjVqmtwn3v7+2B7YuVUBIv6wznfVdskIYkC3HZEtuq4vVAaHsSz5ooDBsma2aTJgveZ4UulqmEyBp3F+m+Nq2bYL456t3M2v2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=rmVP9nqw; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="rmVP9nqw"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f18e8f2f5so3322357b6e.3
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770069748; x=1770674548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SYQe/eEo0kQQumf8hsyNZeV4cvUpi1AJXZkoNU8kt8=;
        b=rmVP9nqwhvHBWj4MoJZc7nGZZCefCGx+gfNyLlt5r16IzS4NfZlF4VaEzdsBie7TP6
         nq7xQEPlDGxa1x3Hc0O1jyhxpfeT88pPA2s/QX5u5TQZsquDw2XoLMsbyztsGHguzt3u
         FsJjyC0WfPgJfx9vCHCMMe85OcRHi0CJEtE6ONS8X8Ux0B5mCLdlSDkYYsW9VaqQPbTu
         C6SqvBkiPVuwrHBZjoWeskPRgWuB6ezrYzIEbTybYcmPO7CvFTU23BvERA4fZLWui97D
         m++euP8Lc2yBwf75QZjXvQQ2i+4tTyTmigOxx7xamFqyJQJvPzjo5ipSTkcvkAd9pv/R
         aelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770069748; x=1770674548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SYQe/eEo0kQQumf8hsyNZeV4cvUpi1AJXZkoNU8kt8=;
        b=VBiSdiNN+/sQQVa5vUM2AkxHnKcYXw0OrqJeSEg55iAYDMt7iosDzaFQiB9VxB8XKw
         Fok474eEGreNNah6Ecj9k9PZWCeNe1wpjdvVkp69ZNXt8DJgb3VWA7MpjQc5Qyj7ojaN
         GeLqmaCjErG+mz85JHlQ/cgc/0al9BViot1BvXcwveFuwT7fJJ5GZq3FZ+n0Y4I2tDqi
         1xPC06LURvo55eYUufkydv6Li16FWppkFMk2EtlXFrOm65tcJCGiLOEBlrbvgF2ls9Ck
         V42gGZn5dwDg/kc59eCO4zpXyq1xeB5JxF8mQhOMeeFyhf43jwXYytakbz0zv93JHjHO
         NMgA==
X-Gm-Message-State: AOJu0YwHGi874vwQlMFrYuSydOcD/mNwCyoh+78tq12yrsN5DCLkDcl0
	bb8cEjL0asJUogsMKhUt7RuUKK7O4k4yvEg2qTzeG1aLye8Jt6kt2LwomyFTQTmQRhs=
X-Gm-Gg: AZuq6aIkrFoDb4QT5vdKawdkHI0Pjwkp4vQR0XO5BTL75tGScmCKeYhXa41kq9T/Okj
	5n8+EuYhP+S5x62zMi7BazkYx7mm9qqvdsYCVovgbJTXLHY3OPjXE7g/9oyDjZpTqVYhPb+NCSZ
	W32rBkWoJtV9L5OljlK/eDe3OcDD53a32V0BEQulZOhwU0Fl2EEx1il67N6HsVjrElWfyJRRV87
	1X9DTWYuvNroovvv98VGIfMPfIM0I5wHXcHfz1bqrZMfYcVkAtMm9hvtZ7G0hgBFAJcSj5XG18t
	pQajJr9RXg5ovvSZKu8euUE7cDhCsY3aEEHIL1186hsxh4KFmSCIbl+IFPnbJMK7tscwKP7wmkr
	rD1GIdtfQPFVHIA+YFBkyJaKCRnEtxM2II3pLIEoLrrHIG4BTEpAlEFRSXxvgAcMLfhsOqoh5VT
	W3Lk5h2Efs1vyVGrwxpFy04AmeF+DBzaIrXzoEiLInFc/XRC09x7aXoyYgEm+6rK2Nby7m+7aJK
	y/mxeyreLt5sDlpY7G++tcmFs+oVJc=
X-Received: by 2002:a05:6808:c413:b0:45e:a76d:966d with SMTP id 5614622812f47-45f34d178fdmr8095640b6e.45.1770069747944;
        Mon, 02 Feb 2026 14:02:27 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409575f6551sm12422161fac.22.2026.02.02.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:02:27 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] Input: cyapa - fix missing input->mutex when calling input_device_enabled()
Date: Mon,  2 Feb 2026 22:02:23 +0000
Message-Id: <20260202220223.2471730-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cyapa_enable_irq_for_cmd()/cyapa_disable_irq_for_cmd() and
cyapa_reinitialize call input_device_enabled() without holding
input->mutex. However, input_device_enabled() has
lockdep_assert_held(&dev->mutex).

Add mutex_lock()/mutex_unlock() around the input_device_enabled()
call to properly protect access to the input device state.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/input/mouse/cyapa.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 00c87c0532a6..e5fe3b8b6548 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -525,8 +525,15 @@ static int cyapa_create_input_dev(struct cyapa *cyapa)
 static void cyapa_enable_irq_for_cmd(struct cyapa *cyapa)
 {
 	struct input_dev *input = cyapa->input;
+	bool input_enabled = false;
 
-	if (!input || !input_device_enabled(input)) {
+	if (input) {
+		mutex_lock(&input->mutex);
+		input_enabled = input_device_enabled(input);
+		mutex_unlock(&input->mutex);
+	}
+
+	if (!input || !input_enabled) {
 		/*
 		 * When input is NULL, TP must be in deep sleep mode.
 		 * In this mode, later non-power I2C command will always failed
@@ -545,8 +552,15 @@ static void cyapa_enable_irq_for_cmd(struct cyapa *cyapa)
 static void cyapa_disable_irq_for_cmd(struct cyapa *cyapa)
 {
 	struct input_dev *input = cyapa->input;
+	bool input_enabled = false;
+
+	if (input) {
+		mutex_lock(&input->mutex);
+		input_enabled = input_device_enabled(input);
+		mutex_unlock(&input->mutex);
+	}
 
-	if (!input || !input_device_enabled(input)) {
+	if (!input || !input_enabled) {
 		if (cyapa->gen >= CYAPA_GEN5)
 			disable_irq(cyapa->client->irq);
 		if (!input || cyapa->operational)
@@ -628,6 +642,7 @@ static int cyapa_reinitialize(struct cyapa *cyapa)
 {
 	struct device *dev = &cyapa->client->dev;
 	struct input_dev *input = cyapa->input;
+	bool input_enabled = false;
 	int error;
 
 	if (pm_runtime_enabled(dev))
@@ -652,7 +667,13 @@ static int cyapa_reinitialize(struct cyapa *cyapa)
 	}
 
 out:
-	if (!input || !input_device_enabled(input)) {
+	if (input) {
+		mutex_lock(&input->mutex);
+		input_enabled = input_device_enabled(input);
+		mutex_unlock(&input->mutex);
+	}
+
+	if (!input || !input_enabled) {
 		/* Reset to power OFF state to save power when no user open. */
 		if (cyapa->operational)
 			cyapa->ops->set_power_mode(cyapa,
-- 
2.34.1

