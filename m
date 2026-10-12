Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6427A47F
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791785566; cv=none; b=kVG1vc7qByO5XAfd4ivj8bbhZkHkwgKP3is/sidmdoAbEN8ponr0drVsiEhNGItG9PknCrsAxhcgIT6v0HXGT8rhOVU7TK1xklc87hTF802LKECy7Cg3R68LwjRESMlSAEkZAYB8Vfayc42w/XnJ3PruYsGWcF1H96xBPG2fwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791785566; c=relaxed/simple;
	bh=X0rSsrNnOjjGYUh8UDAFaoAJukwKXknvLN8GJyYXvGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WroSBX1EgEltyYuOHZFilcXQdgvcQNpYxHrIv0EhtXhrum/G6NSsiLzuNn82j/qS308OnrKOMcIinK5acm2vwaXCSVHXgrJxGdpXw8ZbtSvuYN+uu8K/7vFTAncsoaFJqTDIRHKLVEZpWbIkdB4opKemTXBAn6b2AkeDrQXytiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iurKQw5F; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iurKQw5F"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so3082950c88.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 23:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791785564; x=1792390364; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEQGWV8V7BfjtX2JgvHQ1LpUH2O138OrGdI660UjUjA=;
        b=iurKQw5FnTizzHcSHNiQhz7Ch2LRXP7OWURc3YWGvVFSmRxSFXgOO0dzLls735MhWu
         vHmxxGmuWUfgq8oYsCK7Qo8HFcOaVz5SJYdly4RM7TK83GVumB0kqZQFGkke0FWtiu5C
         dWZH04gdVw5KauVIjwVZ1xff5tVY/zPygLn6pQ8biC9GKw10qsj8PEucP8p0tmRoamVJ
         RemTecPvdrujB/PLBfCrmxuE77uXDtRJFEOJUEhY8j1MFOJTZBhU7hinLxcNSYWwji+6
         ZL8zlxgX3BWv/XUgAp3X6cYtMfD2iZqJO6Zr/SOh0sOwQWBJwWFC/qnmEj2Gyow7s381
         WgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791785564; x=1792390364;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEQGWV8V7BfjtX2JgvHQ1LpUH2O138OrGdI660UjUjA=;
        b=2N2fiQe6DFserxvgNIbRZ1P+u+R2U1O5XEOF6fBvdSJecO6l4cKvN2+VyL4eoY1xnz
         LVYvclo+Y7p5qhmMfeUI0mI4kxf3KJG9TR2MbVcJ+mEQiJOOfv4a8EGHfPM+okbHkyt4
         3FK+b41EuPcuCXN2xQ4qRJmtFK7d0k4Mom5ZQMRVF9tn32JNK6lXpInubfKK2aLxNmSS
         ZRPdjnWgWgUkm7zR4e38TeULWC/EOVHm9HTsoV4NSl0/B3gJiS+IgdqFA75kje3Iey1H
         zpDqkyKmOslWPVNoIthM0us+l5PH91p+5586/GIu68yEPoZjQsp1qIVqMU8IbeEfArJM
         Tu2w==
X-Gm-Message-State: AFq9FYIe+GcOODkPKp0oQgb6wYBvI4lqyMbpKwIwllstupZBZrQAgyGb
	TxkLEfCOe2ag2n16aXZ52k+w8cfpLp9cc+qV/y4HGcEA/vOsabURnes+9Vnuk81L
X-Gm-Gg: AYBFou12ir3AQ4tEWvbiLHRh0xAEupcJpYmy2hWqK7g2q7R1zctQZlZTcwhp1yTTE9Y
	jWMheGuTjW/A0um+ZlWhvFhzgsNYQyrzYMlqSi/1LDYgX0V340va6P1GWF7nozGTT/jC9wDulXi
	YktYxq2bbe3Vu4nDlETIBxoyyhtpJ0bIxqEqZUgIWPrpY5opPmo0qUmg3rBDmCRHIdhHKdp5kJ3
	IcOrZUR48k+DMkIrO/OW/ryHXWAfj0c+YMNWZ45tJdS9VhUKll1/RCYAyBtxSzJH/unSFVVnONf
	IHXsfLhL55OnXWCZJhFSJkFwaHywasUDNEvnX16cZORJYrxmWfXeCmRC+xEg7s41Iec2tcVP3Oc
	d/Ww63IErYrvqnIOjzOQax2+kbxmdwQqw+G1Y4u9g6EIHcRWcYTxEWHXgwlKT1NmD1T6okoUwJ+
	DTqyjE0qSVstmUPREr/sA06qUtcCqpXrJyJHEYZ9sLZBlV8tC1uhlixpl8Ts7BhpiqBXHcSnkRO
	VHYsU1Ct+8xeL1Lhe7TILfo+4n8+wZdnTpvlkvh
X-Received: by 2002:a05:701b:270e:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-16a5c5f20f0mr14463358c88.13.1791785564234;
        Sun, 11 Oct 2026 23:12:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8999:e631:ed58:366a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm27719200c88.14.2026.10.11.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:12:43 -0700 (PDT)
Date: Sun, 11 Oct 2026 23:12:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Karlos Abel <kabel@voidship.net>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] Input: always accept EV_SYN in input_event()
Message-ID: <asx50uz6iafsyAd5@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 0cd587735205 ("Input: preallocate memory to hold event values")
moved allocation of dev->vals into input_allocate_device(), which caused
input core to accumulate events reported while seeding initial device
state before input_register_device().

However, because EV_SYN is only set in dev->evbit during
input_register_device() (and some drivers also overwrite dev->evbit
directly before registration), any EV_SYN/SYN_REPORT events sent before
registration were dropped by is_event_supported(), leaving those seeded
events stuck in dev->vals until the next SYN_REPORT after registration.

Always accept EV_SYN in input_event() and input_inject_event() without
checking dev->evbit so input_sync() flushes dev->vals as intended.

Reported-by: Karlos Abel <kabel@voidship.net>, 
Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 76ed9ff40584..fae508d280db 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -452,7 +452,7 @@ void input_handle_event(struct input_dev *dev,
 void input_event(struct input_dev *dev,
 		 unsigned int type, unsigned int code, int value)
 {
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 		guard(spinlock_irqsave)(&dev->event_lock);
 		input_handle_event(dev, type, code, value);
 	}
@@ -476,7 +476,7 @@ void input_inject_event(struct input_handle *handle,
 	struct input_dev *dev = handle->dev;
 	struct input_handle *grab;
 
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 		guard(spinlock_irqsave)(&dev->event_lock);
 		guard(rcu)();
 
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
