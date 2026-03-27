Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039843C13E7
	for <linux-input@vger.kernel.org>; Fri, 27 Mar 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594631; cv=none; b=AsMka1NYXRqdAaxxhUW1saQrQ5ebqPZTvDwHa6omoQJBTYLXkj0/cWwt9E75Ql6VbcZNOhcI8XTM2mIwGO9HqpWs4rOrRnwW3Qc9XbkxUjo9gKedUZ5pgzT+9ENBff1TZDhKt3VAdgWRuB9JZrBsryC0d/c3CKNVUAvVr1OJvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594631; c=relaxed/simple;
	bh=ZrFd0sfvBE9j8afhdaRZNneXsFQ16WbR6X1/fiuBTXw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=InugwEOaB4fpWode3J+oz4d8FOIPjzD4alVCApLK0An/VDktIdOrOoZuEtchvjVQcxTr/X1FnYgZzd6/em3+i+rdwJ266cGB95Fx+pDSFPHqbqObIpvjGsjksaFmaM4IhskiLdSkOAacy9uETYOKB5aE/h4nJBjTpfP6+IJdRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--akshaim.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbrh8lT2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--akshaim.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbrh8lT2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c73781252edso3696353a12.0
        for <linux-input@vger.kernel.org>; Thu, 26 Mar 2026 23:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774594620; x=1775199420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n5f6sBEuaGs8mBZpYq78kqP0id3KfwuBa8ncuJ2QP/c=;
        b=gbrh8lT2VXjeGuK22+0UGC20wOhTWsy2bkKslZ/2HumYYVrqsag6STImA+hUruKomR
         mfCDmkobIdp/bk6opMj5/G318rb6zhoRnTkLGCh4NUsopO8p/B58PP7HK/AG/k8HrK3O
         dva3GkWoyrAG9jFYrabt9zywLOlzqoUi2nw7v5LHiCFb+uOpsDO7dfLm3WotbG3HErYG
         lvRoDo46qNMMNvep+cuOeHR2Yf79je65Jgh3hkpUXreZXQugRwDUqNWv+NCDfxsGY/md
         COViL9xQzC6RIB+6NSZo5A/jnNp0EhQ+lj++W5zV3l2YeZUEyGMODVM6spnE0nnPs9KR
         ucFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774594620; x=1775199420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5f6sBEuaGs8mBZpYq78kqP0id3KfwuBa8ncuJ2QP/c=;
        b=E4jzblfhQivd4RlEKfy4hwXWKsgdQcv9B3kckiTgsR9RfoSd+JvTQmZaMU6RzC6MqR
         ti97Vm7GQeathLrlw3BNix5uXc7tZemZqS3bBMF9uKEk+o4EFuhwD3FJ8U0MXR3FzQ1H
         jZ9X/+TyinSc7Dodx44SSKn1Ly4P2n0NmHuHSofYvMib4EUWADHygG6ueveeHk4A9gJW
         390RVPLPr/sZrQJ/ujOfiMTbDPS89C0sXnM1Jog0uqeXPYqib2MT46yIViqAOJR4pgvc
         S7Y2ETMwUozX9imGPxVLZy6mDnA0Mg6yEdT7xhrUmSKqK1mUg4BYLD0S5wU+BMB75pMx
         9XIw==
X-Forwarded-Encrypted: i=1; AJvYcCUwUM8Q/8NtifaTkhxc+Re1FNcvGQsxSjczPDfc8peshpAEnd1jv5ZJn4TM7J61360kCvf7HrJyVUOKLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuI1qc2DpDcS0nc98GCX9uRGCrifHkyZQIZC2Q1xBT/5/sTXO
	mdZJVPvXtF4QaAUErwGPsDAlgWO/HbfKFCScCeodWTsCYrimFcnsNtIv9HcHvmced+tr4euNN1U
	ib0URIGPs5g==
X-Received: from pfib1.prod.google.com ([2002:aa7:8101:0:b0:829:72ec:561c])
 (user=akshaim job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94c7:b0:82c:68f6:a18
 with SMTP id d2e1a72fcca58-82c95ed8eb1mr1555337b3a.34.1774594619526; Thu, 26
 Mar 2026 23:56:59 -0700 (PDT)
Date: Fri, 27 Mar 2026 06:54:45 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327065446.3467352-1-akshaim@google.com>
Subject: [PATCH] Input: add keycodes for contextual AI usages (HUTRR119)
From: Akshai Murari <akshaim@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Akshai Murari <akshaim@google.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

HUTRR119 introduces new usages for keys intended to invoke AI agents
based on the current context. These are useful with the increasing
number of operating systems with integrated Large Language Models

Add new key definitions for KEY_ACTION_ON_SELECTION,
KEY_CONTEXTUAL_INSERT and KEY_CONTEXTUAL_QUERY

Signed-off-by: Akshai Murari <akshaim@google.com>
---
 drivers/hid/hid-debug.c                | 6 ++++++
 drivers/hid/hid-input.c                | 3 +++
 include/uapi/linux/input-event-codes.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f20dc46fd8eb..f44e6e708404 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -990,6 +990,9 @@ static const struct hid_usage_entry hid_usage_table[] = {
 		{ 0x0c, 0x01c9, "ALContactSync" },
 		{ 0x0c, 0x01ca, "ALNavigation" },
 		{ 0x0c, 0x01cb, "ALContextawareDesktopAssistant" },
+		{ 0x0c, 0x01cc, "ALActionOnSelection" },
+		{ 0x0c, 0x01cd, "ALContextualInsertion" },
+		{ 0x0c, 0x01ce, "ALContextualQuery" },
 		{ 0x0c, 0x0200, "GenericGUIApplicationControls" },
 		{ 0x0c, 0x0201, "ACNew" },
 		{ 0x0c, 0x0202, "ACOpen" },
@@ -3375,6 +3378,9 @@ static const char *keys[KEY_MAX + 1] = {
 	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
 	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
 	[KEY_BRIGHTNESS_AUTO] = "BrightnessAuto",
+	[KEY_ACTION_ON_SELECTION] = "ActionOnSelection",
+	[KEY_CONTEXTUAL_INSERT] = "ContextualInsert",
+	[KEY_CONTEXTUAL_QUERY] = "ContextualQuery",
 	[KEY_KBDINPUTASSIST_PREV] = "KbdInputAssistPrev",
 	[KEY_KBDINPUTASSIST_NEXT] = "KbdInputAssistNext",
 	[KEY_KBDINPUTASSIST_PREVGROUP] = "KbdInputAssistPrevGroup",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9475b7e9da43..e824c793f669 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1227,6 +1227,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
 		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
+		case 0x1cc: map_key_clear(KEY_ACTION_ON_SELECTION);	break;
+		case 0x1cd: map_key_clear(KEY_CONTEXTUAL_INSERT);	break;
+		case 0x1ce: map_key_clear(KEY_CONTEXTUAL_QUERY);	break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
 		case 0x202: map_key_clear(KEY_OPEN);		break;
 		case 0x203: map_key_clear(KEY_CLOSE);		break;
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 4bdb6a165987..3528168f7c6d 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -643,6 +643,10 @@
 #define KEY_EPRIVACY_SCREEN_ON		0x252
 #define KEY_EPRIVACY_SCREEN_OFF		0x253
 
+#define KEY_ACTION_ON_SELECTION		0x254	/* AL Action on Selection (HUTRR119) */
+#define KEY_CONTEXTUAL_INSERT		0x255	/* AL Contextual Insertion (HUTRR119) */
+#define KEY_CONTEXTUAL_QUERY		0x256	/* AL Contextual Query (HUTRR119) */
+
 #define KEY_KBDINPUTASSIST_PREV		0x260
 #define KEY_KBDINPUTASSIST_NEXT		0x261
 #define KEY_KBDINPUTASSIST_PREVGROUP		0x262
-- 
2.53.0.1018.g2bb0e51243-goog

