Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE503264D4
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145570; cv=none; b=KRBB07xc4dWzsUS0oMOH/MgSMDSj7pQe18xmQ7MBtN+a9NkzAvFIODV3CWe9969kqZU935Mk0nREyru2awtqf6B79yOz0S3TkjoBQIbQ2JZ6URbG5uBXFfQAsIYdHFiXLvBFNZelgHip/D9ELPgBIHUrV+TkG7Lxsj9PFLZHqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145570; c=relaxed/simple;
	bh=SR47e5VLRjptkH7hoXhuOEzDVgkJjAgGQHeZ6l3/JIA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UbKbHizvK1d9viiJLERK+FDp2bEHtwKsgn6XwmpvSDOgTnWCCk8+WF5zeM/osRVsJmDg83gECv/oETmUFNn3f4FD3l9OJZmvXBx6N14vgorC9x9JKXXWo0rlySqWcS8V6HE+v9A/00l2NJubhg+8StkAo8mdlLmwzO1VppJXFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgblwmvI; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgblwmvI"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39deda201bcso937671a91.2
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 23:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790145565; x=1790750365; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fYXiK1IIs224YYvsOKYTsSB/R9PTPIaZUM4TNW3LiQ=;
        b=bgblwmvI2yMv+uyKXE+VRlWRoQxlbpZZAih5kNRxF3FlZwvMZTRZCa2LTSMco/uM+h
         rBmkIcygKMppxC+5FLvF9Z1yzH3d/SKHtCUuo0sTHTHP+DlZRuJwQKbyzBzX5wCli61j
         h1o/wQVOb/QgmUTxVsbSDHalM/dDoxOP91A8iFPSr0N96qzXnc3sGlD9G1dU8WhxS9Kp
         TLGCuiV0ytxmF69+dcDK7gpSdNS71UAXqMf/ev0DJFxbQ3u2SDswmJiwrZKHgUJMFRYU
         d7rIW5LtjT1Qo9y3S7EgY8FHWjhiT3ijQNwah6nFwGTmgPGrJ5d22B/jAxgy8pZwjieq
         8Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145565; x=1790750365;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fYXiK1IIs224YYvsOKYTsSB/R9PTPIaZUM4TNW3LiQ=;
        b=Givb+67qJsrr5keAiV1vgbZDedkcAgWP4soApT9u4ERzcSygoNkmR8pb9A1cJ3Zbha
         RUFptd96ueuXvingkq9GVd88ZIX/qOn6i63wc/7KMR63C4d4Si32aLU1tweDTnbnOpBd
         5MkuhhGIAl1OrXrIkS1HJJcy4YaeputUNJR32vNq18Su8o60xQe5KJljjHapRw7OoQL9
         Wkb6DRapt5JyrY5fvf/tVG0iat0Jj9uY8cnJsnijgBUhDT0qZVyvhf5Y+eowRYjuqb7s
         48IFVAeQo1HUVDg/QmB1KrxLYy7cpVdzpI3nTEv0udGAEVw7DfmY+QvPQc301SJYj3Sm
         lvvw==
X-Forwarded-Encrypted: i=1; AKwUvBzbc3ixoTjXV8PS/sW7oEqHZIm5j4G+jmuAag3ZegH5qZLWrlmGgz7Yo3Zqdprfpm4kdVlexKZuD8zqFw==@vger.kernel.org
X-Gm-Message-State: AFuF++kxRkV6jlH3dFhE8TFUWGGFGTdxzOLEpItF4RAiZ3uGyKPdTbzF
	NqaUQcyBFgkiH0gDGqOlN2gXGVpCRK86N1anrMNxdsFM/PomoZVoozrN5j/sKAYJfvdRfWEUGf4
	N
X-Received: from pgei9.prod.google.com ([2002:a05:6a02:5269:b0:cc7:52a8:e3b6])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fcc:b0:3a0:6b20:678e
 with SMTP id 98e67ed59e1d1-3a07e516c46mr1787372a91.13.1790145564662; Tue, 22
 Sep 2026 23:39:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 06:39:22 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923063922.2693049-1-morbo@google.com>
Subject: [PATCH] HID: core: add __counted_by_ptr to struct hid_parser
From: Bill Wendling <morbo@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

In 'struct hid_parser', the 'collection_stack' pointer field is used
to store a dynamically-allocated array of collection indices. The
size of this allocated array is tracked by 'collection_stack_size'.

Annotate 'collection_stack' with the '__counted_by_ptr' attribute
referencing 'collection_stack_size'. This allows compiler hardening
features (such as KASAN and UBSAN bounds-checking) to detect potential
out-of-bounds accesses to 'collection_stack'.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/hid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8d17b741638c..403da4cef890 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -790,7 +790,7 @@ struct hid_parser {
 	struct hid_global     global_stack[HID_GLOBAL_STACK_SIZE];
 	unsigned int          global_stack_ptr;
 	struct hid_local      local;
-	unsigned int         *collection_stack;
+	unsigned int         *collection_stack __counted_by_ptr(collection_stack_size);
 	unsigned int          collection_stack_ptr;
 	unsigned int          collection_stack_size;
 	struct hid_device    *device;
-- 
2.55.0.1082.g2b9226bbc0-goog

