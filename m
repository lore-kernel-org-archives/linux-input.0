Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BE2192F9
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653893; cv=none; b=QTcn1nv+h9Qmy2uLn8+Ez20udQ/RcduO13nsOQGsc/QRUCX1g+OgnX+NexbcATiVFpyJBNjqN5jRhHT8Yv+KmtubP5uZ0Ruv8Wy+F3zV7e4jeIpIGEyvlGFRHadGOjKNh/Bopsyf6n7HaHdfGx3gb1z3qZt8XbPgA/a+0D14OJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653893; c=relaxed/simple;
	bh=nwJF8hkMevEUdXZN81gBgVbQ4KN3f7jxnXKdwBGkXhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o00e9vBJdEODWhkNRlZrCf50l46QyeLKq03z3VqJjYZacqIASh8p/XLUY1kGT7IPzH58y2IIJlqyXwZpth5rj35ExZ4j/OsbEzS+ixH0v0sAEojZXTknHQAwe/o3hgtgOipS+FqLPpGXCY8GxSv4ZHZXqCYbExUP9WjAFnGWfNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSSYYwjD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSSYYwjD"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2784252a12.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653891; x=1788258691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+eJlGm04XkGO4oIFm6Hc5DTMF8bceRHtuCJpJJ7D9Q=;
        b=XSSYYwjDgR7th5xtppIbXB5F2ZvylxEblmzi/bDfpMFGayfnojUwv/N1hew/r6pk7h
         ZwEtcwZhSSUoyibEdxlDclJ//pkwt8sC/iOiVHTzsqIpgxmoHc3l0ODQF4LHiHp45lrd
         KAczJ1OgBVbln3+x68BVKtiKxiJiOvfcWD6+oCiiX8sVZlwtLI/d6PC8Xgk7FBWahLyM
         pnXJRO9ErTB0N+2h4r19Cr4pxcLVCJXh0RPNAhtK+x7bXaOYeQJvLa/Fqhxo1+RHmaD2
         LYEdTvYqyFBulAShcHmlUubGpbRr/8hUyW7HXKx+Qq8Avnwn9r3KAl+pMm86F9MFDDlp
         pO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653891; x=1788258691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+eJlGm04XkGO4oIFm6Hc5DTMF8bceRHtuCJpJJ7D9Q=;
        b=Sz87x1Ck+R3jxsJZgo3GTyRQyoUWWdn1OMufmp4I4Q33pqgtbAMAgotshzTXFWjDWA
         ClZ3cRUXPt+CUJaOKjgVQR3GbOEOwBfoFr1SKp95EWOsE9yxIjv/4sVkcl6O4cDBbAaT
         S7YwQJwAS03JWmCPaiym38RisrPGvdYG1ZpWz9Nx1iLYMBZl6umySnRfMC+X13PIdC5Y
         sSXN6glyJkuQ7ob/bzg0L7DKQJem9r6lDSv5bNG1mOqCOgtGupuekY829XGkg6V+38+n
         o0SYH5SQ/z437vYT64N0x09O1k8CGvnzRmJkJ7rZoBDlofGYHwrlEPYXS4SxiBzJYlX2
         hDPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1Sq/cmtBLrzYlEmgztNrMstLwNtkrcZFsw6AyF0pkIYNZ2xld0qliprAw6IITu0LgHjxymlf6Wi1Rhg==@vger.kernel.org
X-Gm-Message-State: AFuF++nBZCtKxKXNc2RtkqfwxtenIfOWtHCANrNlygRNvLP8ebRXxiOg
	dKp/qp2BkK9m1RgAOeLXWRGfgNTDA2MrQq5xzvwEJE+T1HQPG/StC5jb
X-Gm-Gg: AR+sD13gWQ43cGtWeh5XCZM35qdyzRUesGmkP8asKLG/QcQjxpHgP8wPjNEDaSWFfJb
	anyo38JK+h/8xvsBXpf5c39FordSCq+2FlFM7k0KWMDUb/wdOvhIQIODMNM6JLKWZeaTq2t6bSR
	JnGFCLZ2p5K78+2QBr0vOPxrNRj9jU3X18IDRT5K/6V089kYwqpVMZE/muDPr0jufHt+PnmcbYp
	ORAW+OV/SLLXHX/YFzPm9TUgHvTec0ux9MpnYbE72mkUynBHuwRAerd5esGaWJjQMPuJu9P7bBX
	u5EckF08YK3NSHkb2oPLCYSOSfp1vvMoM7hSsUIOg5fHjs2JiZVD14PsNjshzv3RiyBrO1l2up9
	FgcJDJiv95yIkrZQ7BXDcS2B2hO/sHN/4S7YJq6gFJZoTZOq1RIgdoudTOcYxnjLyVFD2WRQcWq
	0Uuq5KZUsWlpHpVhauJ+/0uHpRJ5PKieYZJGIBBYu7RmsfQdkcY72APLt+44pvvBKV2RSvtDgQ3
	BR8lfFqDUzvKZmmsbkH5KfzCrD/b/cd9pDjbH7MIhYN7LEquDBqazZELlqXnPR+Fu9+Jxu5hmSk
	JzOAQf1CUyWyNFIEL4FDU04xqxZX804ys0U=
X-Received: by 2002:a17:90b:184f:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-3964603084fmr11994838a91.0.1787653891187;
        Tue, 25 Aug 2026 03:31:31 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm3244968a91.9.2026.08.25.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:30 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Tue, 25 Aug 2026 18:31:22 +0800
Message-ID: <20260825103123.12216-2-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825103123.12216-1-98lawweijie@gmail.com>
References: <20260825103123.12216-1-98lawweijie@gmail.com>
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
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v4:
 - No code change: adds the Assisted-by tags required by
   Documentation/process/coding-assistants.rst.  The diff has been
   unchanged since v1.

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

