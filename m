Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20514AF9D4
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227584; cv=none; b=YuhGfmoNK+/wN16wHc17svhOOxCOQJrZsqdt1jaV6InHi56HHfCnRhngjInZgS7wG7d7ZjrQK5XQs3ZaoyyC13j7zQtZ4BXFUc8n7ri5aTPHLzEU/WmqVf+nnnNTspQ4W8JGNrjCFn/d8vUtnzUa83c+q7hY+5FkTGwvuuQPlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227584; c=relaxed/simple;
	bh=BGMwkFjT+LLKb/t9OZ6A8jAn04l+gtGoLYbfaDbzehU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXQX7o5Be7IgJR360VNAGV9uIz9iagB9IhC7qDXlAoBDr3P6rVJxXQSIiLpu7UQX+GG4KKl7lyciJxe5cSQs8u89QWrT7RspqKW76+3xc7w3g2bbw81CKlUn9EbHFbtOKFOvJbBotToDp4/r469SPlgEmk3Izpzwkbutu1WGWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyspmF7v; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyspmF7v"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6f8525bfbso1401712a91.0
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2026 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227582; x=1791832382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ5MRPC4I9fA9ZFAcaPBErsj9RjadP4yXm5H6MNvFrM=;
        b=XyspmF7vdzieI6ZinGGYx1IR5UHbzCvxoApu9tBDSvmfP4eubugj0WIZYCyNW/gkgI
         VIFLejKMTm1TChpbysUFB6J3a5p84/i48QKMUOizOHqB10dduIq0Ty9MxEDnlkLe1hBh
         wj73fG6nPk9A9HHX1/3Tk1RL5aNc+vhZ0gZ3VIzaim/bCLL1LQzBUcy25rc2vGUqHdeW
         AXDhvzSDpw8PLS6s7GLlc5NG0JaQoZxfYTU89GmsxJufiBDC+mGsP4FRYX4H+0Vzj/mz
         KIOwUBKRyum5I8L4VZKEc6vysOl3QV3ahfcwXI3gGjH6vDxCqZ7I3scn5v32Izf/3V7B
         hkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227582; x=1791832382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ5MRPC4I9fA9ZFAcaPBErsj9RjadP4yXm5H6MNvFrM=;
        b=Jbs+DKe7J+Y/KSnAyguTGUEEjaESE0ML7/PVOdwSI3MZAatjKOncj2IdLtWt4I8oDH
         F3a+7PlH6092OYL7mTZj6o7Zhb1bAL0Ay6txy+gGL+8BU3n9sMEkkPakm7h4IGbHWhQ6
         ZzSzlD441pBJGFELDINA1EKPY4RSB8jxWeZ0sVzA9xwB5Yd6GIuMTEQvsvPEspeX1K4m
         YUGyHaD/rde3YGWa8FAVXmjDETw5z2L0Re96KDu+vY3f5ZkRJxgCKX7i1mFINlvcZLkB
         Fm4Bh6soaS4qR+grf15S1QB/Jqi9OWhCHuo2xWCPYMRjenM9ZpO2KYHnBVy8T3azz0jR
         xBWw==
X-Gm-Message-State: AFq9FYJZZxAGFQFigToPKysliksLSH394vbqy3bozYbT8QJ//a5juCz6
	lC6REpHjGLQ5Y+JN/de2v99Xc04VLj3hYFe8EDi+bO4nLXnHnGhBXyrqlJX4dtjVQ/g=
X-Gm-Gg: AYBFou2VbMfwnN8h236/AJ2BJbyUDMBb3jonFmsshZNl3JdXUTszfBV1kSKNnpAY5o6
	zN21i/YkzH7VOrGISdP/ORosLP7jAo7QWptvlzFX95g0Oga8TlKB5crpYfM4PQOMziUPiydY+JP
	Hgv+8jLlgWkGdIQpPpxM4m+6nEyAWvXfRYjacsWxQegHCyIuQ3XZluvCCGqBJTFVE+XASUDfRIv
	leHHFU2j9os5Jq5U2KLmIDNPayuqUqODmZFe4Pjgcy/lbXqpltyyJpEjG08NcfjeVL4m7h/9KZU
	t2/SxX9543XxKRhTebOxGgczGlkG5koR63L268lUju+et/kUSVMCtIOe9YVE1q92IJz/zGLJf/6
	4zyuV2wfEAUajGEc3WAW3NDeXzB6VhZIlhVM1vkZ043BxECMvtGWQ1D1AM/dSN1DdXSdJqzKRZF
	jSNzBTs+uqcXh0T0AMipL4GFAqa6rmhT50AOQ5a7TqauM7GM9kv4jHBzq/YochyRp8mSqjD7b9y
	JJzkXCf8SNhYU/vgeQL6HPcEmTxHCz6IFfGMc5lsattbr76sQIukoduZjCBBUEbTy2R4coZEjqG
	IzjuiR49uC3cM5W0gHbHSuStZ4nuX/95mw+qlsHJS72gyEqo
X-Received: by 2002:a17:90b:1fc7:b0:3a7:9afb:78c5 with SMTP id 98e67ed59e1d1-3a79afb87cemr3208892a91.30.1791227582073;
        Mon, 05 Oct 2026 12:13:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543bf138sm801736a91.15.2026.10.05.12.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:13:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v2] HID: core: use flex array allocation
Date: Mon,  5 Oct 2026 12:13:00 -0700
Message-ID: <20261005191300.80818-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of embedding a pointer in the struct, use a flexible array
member to avoid the + 1 trick to point to allocation after the struct.
This also shrinks struct hid_field by one pointer.

Annotate the array with __counted_by(maxusage) so that FORTIFY_SOURCE
and UBSAN_BOUNDS can check accesses at runtime. maxusage already
holds the number of allocated usages, but it was only set after the
usage table was populated, so move the assignment into
hid_register_field() right after allocation.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use __counted_by
 drivers/hid/hid-core.c | 8 +++-----
 include/linux/hid.h    | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ec7c2860c93e..76bf4da89d2c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -130,15 +130,14 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 		return NULL;
 	}
 
-	field = kvzalloc((sizeof(struct hid_field) +
-			  usages * sizeof(struct hid_usage) +
-			  3 * usages * sizeof(unsigned int)), GFP_KERNEL);
+	field = kvzalloc(struct_size(field, usage, usages) +
+			  3 * usages * sizeof(unsigned int), GFP_KERNEL);
 	if (!field)
 		return NULL;
 
+	field->maxusage = usages;
 	field->index = report->maxfield++;
 	report->field[field->index] = field;
-	field->usage = (struct hid_usage *)(field + 1);
 	field->value = (s32 *)(field->usage + usages);
 	field->new_value = (s32 *)(field->value + usages);
 	field->usages_priorities = (s32 *)(field->new_value + usages);
@@ -357,7 +356,6 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 		field->usage[i].resolution_multiplier = 1;
 	}
 
-	field->maxusage = usages;
 	field->flags = flags;
 	field->report_offset = offset;
 	field->report_type = report_type;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..16e8f19d42c5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -524,7 +524,6 @@ struct hid_field {
 	unsigned  physical;		/* physical usage for this field */
 	unsigned  logical;		/* logical usage for this field */
 	unsigned  application;		/* application usage for this field */
-	struct hid_usage *usage;	/* usage table for this function */
 	unsigned  maxusage;		/* maximum usage index */
 	unsigned  flags;		/* main-item flags (i.e. volatile,array,constant) */
 	unsigned  report_offset;	/* bit offset in the report */
@@ -549,6 +548,7 @@ struct hid_field {
 	struct hid_input *hidinput;	/* associated input structure */
 	__u16 dpad;			/* dpad input code */
 	unsigned int slot_idx;		/* slot index in a report */
+	struct hid_usage usage[] __counted_by(maxusage);	/* usage table for this function */
 };
 
 #define HID_MAX_FIELDS 256
-- 
2.56.0

