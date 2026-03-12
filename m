Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A73CBE8E
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327971; cv=none; b=k3mmHiiyGelO9brE50c0s6UipX3nXVBXfCqvFJAzxCAh6+t0C46zeFJliwEIeWEWkeb5FnZnyCHfcZ8ofPgefYyzZBGjgLVabSI27bY6xScEkly+k+iwtlQw37/bEjuZ8f9TslyAnndizDWr8g5zulddH0n3zBH9bidObJtEwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327971; c=relaxed/simple;
	bh=F1US9094z0fvYx9vK05QZF2pya5heKfNhqy2rm6xyK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLBRHCqbmTWY7/X+EIWJ3nQJ1uKcgzHYKLWe8P/NPpJ/caYLTUf1BAQ7/0jZJiSnpSePom8nwuQCVtcLGWIvg6VlEWy9bnQ8EFPCK5pEsEIZngwzxg5bc7SENumEhx/Od6wqYfhMtUTa954X+dOSxSSoY1vyhAd++jMaanxta/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=oK1AYdGs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="oK1AYdGs"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1010630a34.2
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327969; x=1773932769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W9gh7QrUGTnp1xN3w+c7Mh9hTc3a8AN2H8zLSFP7JY=;
        b=oK1AYdGs0URRj1PhuBKpF0pD+b5FSA1t6sLHj66zF/nlL8E9GWsB7yy6EdCxrWNn0v
         qtWAY5t6LBmkDVaSsxjuDredsQcU9g2xJBnRFnSAiSONL9jQIM4oWWFjocObvWecThP5
         wS48+EPQHBpgqrosknourzSV10vo/99JZMeAeaKGogXAM42wVPuBrwu+g6AuTEfra6PT
         i3VtbxANDjn0JX54z6YiJ8IGwrUTN9Oz3f+VuNVlV8tcdMpDrmMHUbij6C9ysEkXgz8n
         DJGxY6pOKJfaq9oJE6HElSrxsuRcRlNe0KmYFMMyqwFa/in37vMnu15AXZG9pak0jDDb
         aSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327969; x=1773932769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/W9gh7QrUGTnp1xN3w+c7Mh9hTc3a8AN2H8zLSFP7JY=;
        b=YxeGLnUzE+AY13QGAyjPo+UeB5ZNTCkDVzsYji4E77amox3PvJLaJQol5tLTLQmgK8
         kgUi1ujXb9p+XBXokQvHi2BgW/q56DQqViNVaYhkFO/ohne+QS+UTMHy6lHvou9p+kjb
         ZYKb3UkhHufUHACuyoAmXHeiaMYQ9ar0/XHkPAaKiRfqsDK+t2cm/5t+YM8zbaGHDYI5
         br4d4vGKCwCTQ9+E+a4pBGEKKVlx8t7YcNIm/diyALN+8VmXHwPr+Y6mRd3Lv/WQii/M
         qXXXZ9KX2mTNI5BxocCLU/V3pNwRkjGiuv4MnYlyhzJva1I1xctldHIXKVSp8XYYL95y
         ViMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdG/1ojlVVW51Il1eXTr7nAX0TYXrbDyiDJdOMg/OHClY7ab2AoWYtVAkOv+Egx9nz36UMhS+dyNqChQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7zIxc03ziF+0UmPHXyMwt6R56faGgst0Fhc1bS8VrU5iRitX
	SF4bwDNMWbrVacNrOA2zSnbbBmP++M3w+DvQ/gDAwgI3YLmKLEfQb3FPGGfFSSrQraI=
X-Gm-Gg: ATEYQzwOEurToxX99ZUCt6ukRdAL1IHcmc2/S5E6OZLVG+lEFHkfN7kX8TK8WzbQrh4
	QInT39N58hO1BOCnAx3Flz7i8Cv1tcS4B74elIvpJCK9Ewi92bSGNbjbOoOdP9ofggYz6TnWU8N
	SLP+2gS7hgnygGpJmbZKTJm7Xb3TQesJWgBbJinyq6bQDphhzLNKXNJiKjR26eSLicNTLFVVRfr
	S5t6xrXfL3as1sBA2kstWMkscOSzb6rTj+3VAsLi4D9+lOZjR2iCQP+jUXP4SXQrpv8twrsAfnb
	cG/aEyNW8Yu4M5ykqpfvCBBUnS2aDe+q46DJJRj4ZrZP1O6Q0ZWGacFXxg1NiAClhRJaln4uX/Y
	kx/AhF+mnvo8exyNbS4pJW4eBqUcreUUqK/VSoaMxbop5Y0nTDA4m4sSIEya1ZoogI3qrtEGjM5
	cPFaPGH6TlPN9xQ5K+yeI6rsB6qC9vX2XoJEZoK0tyCE13L+bC/h5YeMLet7YPjfEfsw==
X-Received: by 2002:a05:6830:380c:b0:7cf:d784:5d9 with SMTP id 46e09a7af769-7d76a621267mr4279238a34.16.1773327968610;
        Thu, 12 Mar 2026 08:06:08 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:08 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 11/15] HID: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:06 -0400
Message-ID: <20260312150523.2054552-12-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ed3405c05e73c..01334a6599971 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -110,7 +110,7 @@ void ish_event_tracer(struct ishtp_device *dev, const char *format, ...)
 		vsnprintf(tmp_buf, sizeof(tmp_buf), format, args);
 		va_end(args);
 
-		trace_ishtp_dump(tmp_buf);
+		trace_invoke_ishtp_dump(tmp_buf);
 	}
 }
 
-- 
2.53.0

