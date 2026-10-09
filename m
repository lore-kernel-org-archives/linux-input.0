Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3E453A45
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584801; cv=none; b=ENcQgnez/p77+duTmBgvTLb9K9jsXJb7doQxfgK9qd4OkPa+bMf4BQgmSOJl9dzUAbCY70a79uKbgPLPkLEm/mXJF9Ep1oWRelQDqSiAa2DwyRAzgUrB56/wMpbUVGseTOSfnkFNdY56XNyHg6lBYQI91pr7vsM8hyU01RXERH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584801; c=relaxed/simple;
	bh=To/N6sKAD/JUTbP1/yzbIz3c5H7WcyV26UjvmgEl9WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uT1zuM0RRhGMcXY0Ioi1TzSStG83+2Lixx28++89GhIPGxRFcrCf1/xjGWsGKoRgce3gSAQlyriqyzvAytZbhIfVRoQbnEM77GukTrz+3kJYraFPwTwK/2zNNststiSjpD30tNWHA8jsZogZBXb5ManiNxesOTRx1s487XInguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F3FJbA61; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F3FJbA61"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e618db81c0so1527455ad.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584799; x=1792189599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvdzzoNUmS3cRm++6obW+ZK5PMthoIQu11Q/B6OTMpM=;
        b=F3FJbA611llD7M5Fym+v/csGgtk7YlyMS/perdq81TDF9QXpxd9JiENLHDCgy9rpSK
         wUObdWpray+nzTtfVS3ryzlusHagFRnIQuc7I+KLyLdZMpu3JC1OV9blRo/CSmpyF1di
         gV1d2mhI7rlto7/ZYhCkw+JYU/wQBcBB3hnXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584799; x=1792189599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvdzzoNUmS3cRm++6obW+ZK5PMthoIQu11Q/B6OTMpM=;
        b=qSyUVfEvZLp6V7n+a4RHy1LxOAFmk7O619P1vH8fy4k85URuXhHxp3+HcydiNgFfUm
         ShjSzQzWv2wkOCKmGp1aUwO4CvNjF8Ps1EJGJ+s9LJ3kSPO3Rihm1IszbwcEEdLAxmo7
         RlFE0qZaTcz0tlSYv/DJTp/Vjk6TV4EZRUCGd0ssuJXDhJ8lTyoEMRiH2yCobaYLvOzB
         1vLF/W8oSk9lY6LRaAqumNDKHQ8ylWPiCw7iYVVlMWS6Y18hZrb2+TgWiBD8zw08iI2D
         7rq3Etq1JX0Zpq24o4yTa0H1lek2LwOiZsg2+k2HrSVHAWuOHnbbjShqtq/5d7xjremm
         kt5A==
X-Gm-Message-State: AFq9FYIX4swVc+mhIajzDxezUmjuLmpwCuKoYJtoWtWSz8+7Gupka7t7
	61uP8cL6gE00lfjtjjXq5Jq/4e9ASNVKy5lZWuSpQgWRaliE9isBI/IAdEzD6qN7Cg==
X-Gm-Gg: AYBFou1ufRt6N3zexeWiKx3+Sulc10mv0s1vGvOr7WKvErpJVDuxu4eMTudbI/reNhz
	UXCRAR6i5WEhq0LfVOeO4eZOHKhzGsD7Bxv/kQOOzeUpOW6lsTus5ROebV2fVQsH68Ra0K9pvfs
	ZU6V5HkXr91mziou/sWj2HK2OyNcuiZqj6ceQKs36aRwl7g+DGJ34+MjBKKq+fXrP+uUea7VhbL
	258eKT643xyJuBlh83NDbsmnCxkUAAPjOnGCWVh5iKlSWAMACVFYBq6Qp2XR9zLCACILI5g6XL1
	SwkTjnSrl1bggbQ/7dJXKA6EqSKA5P6GylLra/8qofl8+yTi0Fh2XgMYSLEhDi9B1QEQVyGIY7P
	uY10Pza/ujXpPmgAxN3JMGgxahJJ/qtWPvkvToVfBX3ldvhdbmmdUI3yLTNSPPMT8Zm4yz+4IOq
	t3IM3kA452vqaGeymVhPXCb7W1d4eJYVG/7rmAPq1MOnHagkYdYrs39VCUiIVOyUVoNANYCssm+
	JeogZNfvKQBqrwHOuB9F1Zcisqr3IWhyJPbV0GGavQq8CjUICLzwr2QJbSfV5KbA71bN0YNMdoK
X-Received: by 2002:a17:902:c943:b0:2dd:c100:3133 with SMTP id d9443c01a7336-2e842f30fa7mr27271395ad.47.1791584799011;
        Fri, 09 Oct 2026 15:26:39 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:38 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:26 +0000
Subject: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-1-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=1256;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=aFkj0W7tNOjBci2pknGWJKhsT02OsUboxe/LcEHUTNI=;
 b=IbSutf0zd2qYpnyGDgn4KNESCycWkwDCX7TOGkSC6MXTFypJDD9VDtz+YmrNGl729DbFEHvvo
 LcNPMDv4SPaA4aOAuHecBFRmpXSqIJ+au1itt9MXiiW/Nq5XKf3Fj5g
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
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
2.56.0.385.gd3acb90ef8-goog

