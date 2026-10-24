Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803113;
	b=Wa1jjYuNZOt4tsyHGh1XGYYev6uoT7HrsXnQUEP0VwFzMAnfZ++rZzY4P8kDOZu0oEAa
	 /TAAm0WPxZAglFJR5wJLJWEhE7Wn+dgtbeXU9zJ56i0+nM7aakEpS+H6dK7a8JppzrfDq
	 2WRozGq+l0T8lGL2pEeWEcNofmQVBKXSSRXES1IW9XBhvQhlcPu1E47pzArRd41RZw6Bh
	 Bi3k3lNt8aMsHKMn/PJ1cwU+xOCfLvnaUpjWPhuHhfy9t6GR9O/Z5lZ+QPnGRgXnBpGrl
	 M0ifyqw53XIaeO4KlZv9Zda+IIKlk8CQdiwGnvvi91xhvAMhgsJB42QVHuUHlgXBBiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
	b=Z6hE+F/dZ27E54ZEzId2mQIbUtAIwKNJa95tkHA9awe0+tibgPKFKM0rsiyqh0JL2ipC
	 5LOWFm33gkmk4oOLRGvdcPXJTn68GaeSVI6NCpOwz1cmGW4RZ+tCsts3/qiWn5p4p7vkl
	 qhahJ70l1YTmHYh0i9FnNO3HCmQ3n+1/j7C397+uY/kNRfjn9ha/83yB7m9/bne2yxTXo
	 +WyqDBurHlE6r9XURD8z8TWvFCuctD+d54aEibM9FV4F1dsutNsoFmBC3lrVkWkNdWi1y
	 dxSup1TsFPN9MCZXqYdwDPRrPnf8NBERRaH3DMNTYPpwPexBVJfYYki7Dic8m9JvTFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y1cZa65q;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680D606A325
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0680D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y1cZa65q
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1097601a91.3
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803112; x=1793407912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
        b=Y1cZa65qKf3rNeVmoPQnEIKAF6xrQhj1+SuXNOEflQZczWW776jP9jQfcFQR6OfJV3
         yqF6PfKNfijIBpSnQqCst/hTuWflEY7lqwUKFO8OO5VZ5DjzBE+b3dFU9PwoJxIoU5yx
         wkHl06/LmYFBuagl6SSUwI0oJW4wcEXUQyUOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803112; x=1793407912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+y0vpLA6rDnZkZJGvTpFSS8QdG6zDUiFg4vlqbK0zls=;
        b=z1herzZL66gpIaCZohFQ6wOZZlpqJFSBGB6W95YnGaKRYs8q01P1cnVMhjBDwST3Yi
         dJIys3kLWyQpBju5Bm4C5NXfOOS5M4D1AX4EDHobP6mZ4CFViprj84bxWBaAAB5IEzfb
         RYorSAhMRIlAQExQ2S3zQDw3MEKOv8b2SCm6hCh0+5JtRZjIGhoGmXz8dVzREWfiWuEt
         pw6Yb28RIEH6OnKThuwc4wt0plP2Gl6jb3pjPV9KQUiqiK4Ue+NQ+VCjE/9ZK+4QXJd6
         o5NhFT9HMPF/CHUOil0ZHZnHREr3NZMz23ZMEiDv/0Vij60TRkD1oloXiKV//CcGWr7w
         aZ8Q==
X-Gm-Message-State: AFq9FYKszbBk6+q4v5qQEUL0WKZtl5GZZAlw1WEBE8S05kvMgGrG+j09
	S3umAuE0yKTMe4kAajFi3UG1lUoWU4rDMjj+pG5tDbh6CTprwUuRCOvEOsXEV+YTPbsV+Y8Do4K
	xi2E=
X-Gm-Gg: AYBFou2Jkjd2vXkK238wlP4tX3s8huqqQPj2dy2Iy8aUAxrlIgTNB25V7IY75IdN2o9
	lIaQvYe47GgL9ffH/hnooC8RBy54iVWkbwnBfcmGkFU5dbuCEzY9kgsW8EWOeli5i7A3IrsfFmy
	kIId7YCgvNmhE3iNnYH1g7wgHeS4mBmplUgqNS0usqLdtNPGff2ZtEvWfl4Vu5sf45pAAEYGZ0i
	IjOeP3/mafxbxI+5KBws0IRVenZomqiAH5Wwtoo6Lx+Qr5Uo8l8FrBN5oFo/AnP/fzLcadiOZ1m
	42/ZhkG1FDhqg8FaXuGvA2IEV9zVsvcXFko3t2xC3sTpaozdFETIojcWTT1X/MrD4pR//lXnBSP
	VzxfH+JKhFfjZPgN+ll6IvVaVGWHlOzrGgWYVwWBe+7lUJhbrffu0Ts/ccbbtuiwCn/WXbm0GyM
	sX9Hb3UdH3M6YADovPeXe7x2iou46vBvYQ2qxFlSuYsGbu+cebpQh6HhiVxgV+qdudJfNtuZEq6
	vl94XGadOQf4z2n2f8sTnK5WcBz06LUBrWhwBKC+1EFO/ctRtnmWmFZ/EYrd3Nzw7Qy+JsUyR8R
	gWZzqoWnhH46m9xddKAiIEVJiEshgGoqf3tHOVIXuw1aH5sijvvZOvDShVvJe6o=
X-Received: by 2002:a17:90b:33c7:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3adeae78223mr710221a91.50.1792803112460;
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:35 +0000
Subject: [PATCH v7 01/11] Documentation: Correction in HID output_report
 callback description.
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-send-upstream-v7-1-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=IwRF58jgSTKP3fdajEFSeRD6vCiZwxLFM3sXfjl8RPQ=;
 b=sqNkuLc95RysONWlhkLkd5q3xh/LjwcP5ptF4HGTo5fIv2IBDuCMHn321hsAylqkyHBNqNSSl
 je7LcVE/CrEDf3mcpNveHsUUJQfwXAnE0sFD4Emc7TLquH4W7kkL6F0
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.56.0.257.gf7497c7d27-goog

