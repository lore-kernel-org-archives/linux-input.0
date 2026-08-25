Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE063B2FCD
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638237; cv=none; b=I7+uWJuooi/tugyUv4ifAf0NieHVw1Sh/0X3XsOyRrWsNs1miGJ/8ip/Ud6c48CT5QW6UzTia6JSYIc7q5sYhZjqqcUmUOzM8OVKUe7Lkyj3TbYC2inxwGv34N/cMOb+++LStnUK30Z7jV8rdfE7f4GQldeC02kGzsfGOtwEyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638237; c=relaxed/simple;
	bh=u3K+pqwlQxfkUG5TAz57N41CJMhsQtXMuS2/ucfBYcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiAfN9G4/HADNmE9rj0qFKW9yqNTs6pao38foktaKK7cebQg3PTXJG5nOiigWieCyBS5ilX3+wfaRUbyrqgJudlv3Cfy0Az+17G6GhiW2OcYUe6bUiViBMTlNBG26CsXPgTcnVDxod/OF+1WYdxCRRe3RYZh7R/yyKsbnAI/k5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aup/bh8X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aup/bh8X"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso48105445ad.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638236; x=1788243036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND0GiXjyOiahUAdjcPXqRI8sK+8IdeZXOpNWsXBTPXI=;
        b=Aup/bh8XpSUl4f1JT4G4KXRHwna+vUgxKcbIQ7/ty0SkVH/YuarvS/QcjmqPLSE0XB
         8EDQWHQ7qEAuS7iISk1zWfT71/32bPGL7o0zJy05QoghjVb4IzZnRGCWv1AQ76INe9Dv
         BoILzsmOh8L/97Gq5PsilW5aumqhjkuO+Phhu+XAakyFYky11a3p/8Z5c57+6OiT973S
         haqMowk/Bwd027n/2xy451PZ8LALU1P5zPakr4OWIRGmWX2HpMNrPt2AZqpog5VMMVeN
         kOt2qNVGBn8ej8h2pHJp4TNIKxyUT3MHiqv4wGG0kSbwLE38K8fjW7kz7pfTuyAz7oEg
         4T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638236; x=1788243036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND0GiXjyOiahUAdjcPXqRI8sK+8IdeZXOpNWsXBTPXI=;
        b=cam8tBmbkv6iu+dfeQsT4btDHNEPLt5nZ/c4dQKmGrPIqk9fTihOC1vTiQ42Ss5z84
         zpJoCdR+P9QEJUd2HNSs4hsaKFevVvDlBVHpi4E9rijKImQ5PWUxl3loQ5lhDjRs9vE3
         hHMPYnpjiDhyEDT4BRTf+XajfGMlIbMYfRm3ufGuAuf5U7Y6oZfDEAQFdAuq86Ca/jEC
         sJWeK1ZEgX3rImvzNHTQMpy6XhYNL9QTj9RKwDCAQLHCSV0/xBdPGLCh1H9CwM1uxaag
         Dp6JolYjO5JzWYWVSUIPozZW8sXzV21KB2c7afEJIccryck9QBN7kmEL0LVW4VHMS5+X
         GTAw==
X-Forwarded-Encrypted: i=1; AHgh+RqZs90kC9NcLQhTfRMhMkpqGWZbMSdpotXAUP7N80Fa+uEyvGtljpReRHL3pzofK9i4ZU7AqqnY2b3fXw==@vger.kernel.org
X-Gm-Message-State: AFuF++muXFxLtFMDygAXmivp/4WgdHtuId86H6/kKLh/mXjHYOyDvNu2
	1PI41HlwpRUM++1gtKDQSAF9ySskc8PsW8pa9YihH1USn26vewfhDol0
X-Gm-Gg: AR+sD12WD/iobS+8bfOMqmktbCOXSO4g1Cyee9qDKApGxxv6R0F9D5PZGQfRF3weOvE
	5UwSXvorp0TWSRGfswXCg/Z+rwULNTDS13A6/ifPTXF98cbJeHY67TTH5smVOj5ZlSRPRhnAxDu
	bcy/RJR9kHrE/0jBHn4wHGis4+bvsdX+EQnyQA/DbcIre790RR84/pGSgmr8cNuApSnb6HR2PWL
	Ji0u28mPIpS6IU1P0S1Z0mlVNKEW7H2w5sFvmajhf1D2o/TiEU5ibt4gY4x9im5bcbtTU3EfHTC
	0+nxYcd8rQbCORnsQ09i+ubrGnaz1thsvPYhHsIHmuPXeuLUSnuCxCaOVFCHpEjOK4MjMgN9Nv0
	JRMo3QU1lSmzKACWJDrA4ffYCQXpXs/uVNkjKoP1LbUs8OxHjxD9ItVU5Y5CT8a3J4dm3b7xdUi
	gVQhn9Sr0l0ZuqcElTLVdEclEtR3ggIMnlpzSia5Z1u+1gb2PtYbaWcEASWCsYYY6nwH4vUyGFQ
	T3SB/OfPgYOnB0YRF84uLwTm4bIEgsCm02FfnYcTUnm6H4TQ6xUUQ2PBlmaDb/s0jmBwkTSSjee
	Dds3IMQ76AS3KtIT8PIdPSXA
X-Received: by 2002:a17:902:fc4f:b0:2d5:e9d5:8ae with SMTP id d9443c01a7336-2d64adf7719mr543533055ad.5.1787638235784;
        Mon, 24 Aug 2026 23:10:35 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676408147sm23954825ad.0.2026.08.24.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:10:34 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Tue, 25 Aug 2026 14:10:26 +0800
Message-ID: <20260825061027.105062-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-1-98lawweijie@gmail.com>
References: <20260825061027.105062-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

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

