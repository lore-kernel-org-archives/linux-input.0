Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30602EB84E
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854211; cv=none; b=PvDl2/YJ2tc9L5UWWplhxU/ZpB32kWEH42HZlc0KjVa2HDjembKkjc06Ed9nmAX5YfhNOFDNEDTcoeWI0Gj2ubXrAl6/HmDupwsXFtZhd4MU3tBbnflqO35JwloYZN4pbovOlefcR4IxPpvX6NxBGx2UbGaKfu9ZXWXIb91j+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854211; c=relaxed/simple;
	bh=En+FSzjm9b3yZ7RTDdGPtQq3dmB2SMEVaIrfb8fKjrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHjzJEo+slTTgnPfNQPQVe9idOfl1KjsnIHtIX2VlL2n3M8ztwzl+rHeTKxg9mu8jNjac6+tWgKIpnWJqWOOunAAOo8DRUx78x2L0d11JGZOR1GKyx5URbmBuyHXwXvbMZquEVLbLToHGyKVRkDYMmYp6GPuc0stJH11YxmJsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmW9v62h; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmW9v62h"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35990245493so3926632a91.2
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 19:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772854210; x=1773459010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUfuF25BN8uUpJXhc6fQg9RcsbS0Xj7nnWqfeLrQ/Xc=;
        b=mmW9v62hsRnt3QJRlMY4Yha7OWE/d7Q3x75zo1Dsw/OeCWFcNPPet7n0nldJaHWRcV
         T/4vKOLqRtk9hsMXvMUTqGke3IFjLQ42oq43F8WE5UwXit4zLoBv0/VxpQNL0sQK79qs
         eoOqv/rT1G1TuZtsNChswA4OxAOJjJlkVeLCmCa+ixtZJU9Li1eyPnbW39bAL71Nl35B
         6ieazO+yrZC9UseWQ5Kya7lLpKb0d/frvElwvz761nr4bE8zvNZw37ZAI79h95oM0XFt
         o36QH2AbirI2Bkd7qA5sYeZWRQfngei943C81IWGUAfADNF+ONI+ljIynvMcmTJtLMHn
         jRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854210; x=1773459010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUfuF25BN8uUpJXhc6fQg9RcsbS0Xj7nnWqfeLrQ/Xc=;
        b=kzoiTiFbYd43qKrra/0J8Y119RIwf357JGgA/CxaZqjRI8xeZkrjh/4W1QNzVdhQGF
         4CrS1P3bkmDm/rcWl/C+Fi6OYllAEEKZOuLRRFkJ2Kph5VwmhgMdBjliwUmBTYip9D50
         JngxSR5uiDZiMp8tVI6AOikXAZFD+jZ7VFlK9fbZfBp46DOhXWy4JxYRE+FHtiPoD9r9
         Agzc3fmcK+O8gpmirp7vPFd0Jbw6G4YPpfuoXGO9xZ+7MUZGZLYmUuRsLBC2GHjQq5uz
         1J1ZsDSNayZfhxThuBsMpGlWyaZ3wLoNdpYBPbDgBsdSQCWTRZULY44IbuL1Sj15Dg8h
         fgUQ==
X-Gm-Message-State: AOJu0Yxt44u/GCf8hT3yGqSFz03/dpmCqL0hZfRo5ClxqwoMOwz34j1D
	aNjzPoin4BdcUL8NvYQkjfYm7BsxFc6K+tIK5GOvJJOpWzPPCdhF8JQMOiYR9my5NFM=
X-Gm-Gg: ATEYQzwz/zgHb+ML8ddoeUC3JQohZ+r+DegPCS3/nDJsvw1izDbKUFt3gd0gabEYNrd
	ZojErwAQl56cXkzR+xFIrwSJFyhEZFDD6AsmldP0T8ADFUctOLLScvJ/HNEu8TJzkWwRfzpr2FQ
	crRlxDUdQqQ1M+sdAacxYmx6ObafFJ55rnOvKZXuRTAvMoe7svs3mt23TTkA+aMiV0/zP946Esj
	R7sDvR3O3NMsPHHHjq4c/ZZiEardUunwbggUyXqzhgh8TtSIcdkmK2XU5RM4F7RkVPEqfRCmHzC
	su8kGSScxqV5IskLmaF2ObOneE0mrs+f4pAImWkekXxoYtnvk3OGZ0Qm1ehNwWJIY40xadqREDJ
	J0JbctS/B7ED6flPTA5WP84737wZODEjYxYbeKiOqO81Ele4GZvBOD6fytD77DwqS6ClOu37NGd
	cU3/MdIfx1llB+hl3remNRkeADUtX8BM3EY+p0bM6INvF8mAp10QkmY4U=
X-Received: by 2002:a17:90b:388a:b0:359:87ff:f34f with SMTP id 98e67ed59e1d1-359be2331d6mr4219798a91.3.1772854209474;
        Fri, 06 Mar 2026 19:30:09 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c003c51bsm3548732a91.1.2026.03.06.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:30:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: core: use flex array allocation
Date: Fri,  6 Mar 2026 19:29:52 -0800
Message-ID: <20260307032952.642014-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of embedding a pointer in the struct, use a flexible array
member to avoid the + 1 trick to point to allocation after the struct.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/hid/hid-core.c | 6 ++----
 include/linux/hid.h    | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 840a60113868..6bd6cbf26c6d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -127,15 +127,13 @@ static struct hid_field *hid_register_field(struct hid_report *report, unsigned
 		return NULL;
 	}
 
-	field = kvzalloc((sizeof(struct hid_field) +
-			  usages * sizeof(struct hid_usage) +
-			  3 * usages * sizeof(unsigned int)), GFP_KERNEL);
+	field = kvzalloc(struct_size(field, usage, usages) +
+			  3 * usages * sizeof(unsigned int), GFP_KERNEL);
 	if (!field)
 		return NULL;
 
 	field->index = report->maxfield++;
 	report->field[field->index] = field;
-	field->usage = (struct hid_usage *)(field + 1);
 	field->value = (s32 *)(field->usage + usages);
 	field->new_value = (s32 *)(field->value + usages);
 	field->usages_priorities = (s32 *)(field->new_value + usages);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 2990b9f94cb5..e2c3e2528582 100644
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
+	struct hid_usage usage[];	/* usage table for this function */
 };
 
 #define HID_MAX_FIELDS 256
-- 
2.53.0

