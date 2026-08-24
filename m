Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB803DDDCB
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550630; cv=none; b=WKJAZJ7zNQzau28kSmvxC+ip/7XkCLnfa5S2LNeG4E18L+7yFjzNl2WpUf4uluqGSO9JlPi3ZROApLGOOZhI9x07Yu+9jtIocAb2xl9EOGJzgInkM6v/l/1bDyri7KtwZQ6Xg1mGkZ4dytIZyhN1cO+ofRLolKPJsbX45yp01xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550630; c=relaxed/simple;
	bh=WZE0UAjryG3LKGmJlWlrF4NVV/WeS+t9+KyPhRYEdqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOsymx50CJGGwu3AONjRHIZiKNG6f9JBWP+HxSlRCb8ULoVV0h8zWzsyyK4qpX2a21Y1WXc5dUixXjoaYo7FbUbXkTGbmAd11iuF3QTS40ROFYwV0fh1IYPGIPSgOA9N+qfCcfBJGjFKY4gUlW8RwvtmhNzpFpT4QIUCVRuzrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Yq0NfM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Yq0NfM"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso42473535ad.2
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550627; x=1788155427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=b3Yq0NfM2W2WY7nw9PUixGDdTxFA0LFPnu80kJG80gTDj/3QER/9SFE4pmwbyr+xow
         pKgoYMwOw4AcbIlVCsyhVja9KyUTKH68ZG+jreIKFpv5abtQ+b27BNy8IJnrRT/vkk50
         EYx1ePF054OKarryHm5qsxneeCWjYe2vigG0PObtBlGzZezGMztYRx6HzDaSeWvZAHYK
         /dBIv1UK9xwCkc3mPef2BNlEcmv84mO3FKkV8AkHu/8Iom/+oVLnkWuPRps1qDInLH0M
         dIOFICiRiFRp/oCUj1p2PIA9NAiLiGZdR5FcmDqrDm27k1HaQfjR2bY+p2xe+UFQJ0G4
         rFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550627; x=1788155427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=rsviYx4zj1PgQhq87ZotyLApvHbnZM9qFaRsO9plbBJSFqlrqpskO0nC1epmfr3M03
         YSeb5rZsXEkKcr7Gzqed2JK+IfaVDFm7IR5s2zHdd8SmP/IZZfPp2BB6lqtPp+trWnjv
         G9Rzjr96gVe3IjPvi5Xa36MxaJ+xBfmGbMpv4LXkosq0P5qDDMgqtD9ZvuhMXkSZbQTv
         oFxBP/9rOeUcZq1BQkH3NplZGDCMY0vCMrUdKX7QddEFZtCrA9lAPCsLJgE6r/badx7b
         RvmAFH/H3Fyh9RhfRjtkqARBTiC8QS/nh6XYDqPUEfz82VxsTsfcvyOI3nmdChWt5bvS
         azjQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3rVyrynn2/N06DrhR0Vg8eyTxNmRcjc0lMXwa3VfQJcGvPFQaPwGYcELUZL9B5HC2Z1ZJZKIjV42DTA==@vger.kernel.org
X-Gm-Message-State: AFuF++nPYnKGX/qnKpYW1z5tXXKz3nI/uEvDTKWJK/+FPdfuA0qwHbts
	qVDxK4Md5A5Ya8YKZw1J0iTJ9PnHGjdhL08K3c5TuKAaZoQu80Nqnzvb
X-Gm-Gg: AR+sD1178NL0TDzR4k1f2dbOFf3uc9AezYDfdqxIQiGcvHb7jUu05xQ80YZcG7QNAW6
	qYXHDktb3qYl2wFkwkVPAbIXmAItFZ/csHor6jfgS8NRYqWqAHo8Y00IN9k93WUlN5K8m44z0nx
	qTcXfbmVsnYbENXnN43e01/iORzggoSQPwp11HQXdUPBJD2O0e1sn6UzhusizCNzYBPCDsKyH/M
	btufhV9WC7Fqrk6OgkkoMB5Dgh6PcKoBSvcSirViq5/V+N4wvfWEral7+gZt0u57oI/Mx18oz4B
	m6VUhwqdfMoQtAR4Ly8IiWV9Tc+UToWqUVMpyrZ1lbNc/eVD42TvMuVUCKCfIk7c6VOIHGNdoj8
	ipDlUCsgJQzlFy05QEJhJQIJiin9xfFJQgx5RcIqhSNexNh59Gr0nZwwtn/PetpX4QGvcqJqIZC
	d/GmkD392/3tWHuUqF7TXMQ9y+y4swBZiGVw4rYEheHpttLdjOiP9hDH1TJOWtWwmkscB29/h0h
	qIWzq+fTLpyWAdjHzXCiBJzMfxP1uufydkViTlBTXfmgrQAm+AwtKPGuUR1SOouh1YwROc9fUUd
	t2Tn+bnaoL6BU4ZBscgKcZps
X-Received: by 2002:a17:903:354b:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d64ada70cemr430814115ad.1.1787550627273;
        Sun, 23 Aug 2026 22:50:27 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768c9876sm13955655ad.68.2026.08.23.22.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:50:26 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Mon, 24 Aug 2026 13:50:11 +0800
Message-ID: <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787549234.git.98lawweijie@gmail.com>
References: <cover.1787549234.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_read_pdt_entry() takes the interrupt source count straight out of the
Page Description Table entry the device supplies:

	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;

RMI_PDT_INT_SOURCE_COUNT_MASK is 0x07, so the value can be 7, and
rmi_create_function() copies it verbatim into fn->num_of_irqs.  But
struct rmi_function declares

	int irq[RMI_FN_MAX_IRQS];

with RMI_FN_MAX_IRQS == 6, and both rmi_create_function_irq() and
rmi_unregister_function() index that array up to fn->num_of_irqs.  A
device declaring 7 interrupt sources for a function that has a handler --
F01 always does -- makes the driver write irq[6], which is the storage of
the following member, unsigned int irq_pos.  The function's position in
the interrupt bitmap then holds a Linux virq number, and that value feeds
set_bit(fn->irq_pos, ...) in rmi_f11_probe()/rmi_f12_probe() and the
irq_dispose_mapping() loop on teardown.

UBSAN reports every store in the loop body and the read on the unregister
path:

  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:183:10
  index 6 is out of range for type 'int [6]'
  Workqueue: events uhid_device_add_worker
   dump_stack_lvl+0x64/0x80
   __ubsan_handle_out_of_bounds+0xc8/0x100
   rmi_function_probe+0x1c1/0x210 [rmi_core]
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:186:28
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:187:35
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:189:32
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:191:54
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:282:30

Size the array to match the three bit field that feeds it.  Clamping
num_of_irqs instead would silently drop an interrupt source a device is
allowed to declare, and would desynchronise irq_pos for every function
created after it.

Reproduced with an emulated RMI4 device that publishes a single F01 PDT
entry with interrupt_source_count = 7, driven over /dev/uhid and again
over dummy_hcd plus raw-gadget, on v6.12.69 and v6.12.105 with
CONFIG_UBSAN_BOUNDS=y.  No reports after this change, and the same device
now probes normally.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_bus.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 90122df21f74..faf2ebb00d52 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -12,10 +12,13 @@
 struct rmi_device;
 
 /*
- * The interrupt source count in the function descriptor can represent up to
- * 6 interrupt sources in the normal manner.
+ * The interrupt source count in the function descriptor is a three bit field
+ * (RMI_PDT_INT_SOURCE_COUNT_MASK), so a device can legitimately declare up to
+ * 7 interrupt sources for a single function.  irq[] must be able to hold all
+ * of them: rmi_create_function_irq() and rmi_unregister_function() both walk
+ * it up to fn->num_of_irqs.
  */
-#define RMI_FN_MAX_IRQS	6
+#define RMI_FN_MAX_IRQS	7
 
 /**
  * struct rmi_function - represents the implementation of an RMI4
-- 
2.43.0

