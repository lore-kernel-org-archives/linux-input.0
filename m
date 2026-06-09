Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3737AA82
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980087; cv=none; b=qQFQ1CJ6zHdLBjHLBHBuvJEZEVBF+/rW67Danr1/iAHTzbRr6hkG4XaLzQEdELGF6kOVGOf1naofL4xFQvDDCTs4PlpAlc7Q/yPVaGpHhWXnkdrQKDORO5vL2HPG2oqRQNS0KwzYmAfzHEI7mhJXL4v3xrwjqIq/gNvgZLTfvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980087; c=relaxed/simple;
	bh=JA2M7AiLUuSc6veCi/kbJrYplg8DlHt3oDIafgdkMi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jz4JgOh4LD+qvd+1u4H0PkFBAhv27ZCt30jZQ62E3H7ejZjXa3mqzQQ/TOP4pJeGk8Esjv8x7X6Go1JJW7i5C+mxQgm3T6cGfRGD/65EZL8riCrRC6bryNV+s9kSut2yCpx082N6rW35Rv8DNsqGS6YQN3fnpFYyL7mLFxt0Nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FtNIrr5b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtNIrr5b"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf1f074a12so52560045ad.0
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980086; x=1781584886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA0puiI12gkUUrChccEFoedZkqg321TG7vWV3+7W2Ns=;
        b=FtNIrr5bpJw5cCz9yjGqXFQxfbfSh3Ro21BPtakPw+eYYgW1GCRW2n+jFCcGA9ohoR
         7mjyGbCQrtBVq8BhEqKd9fqKyN5DBV7ka7zdhHI+gQ6j/3y+ZCrW85jrmjax2BCqvTXN
         vmWpQll0TOTG36Wgs1criDWj9c8+lDH/r17S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980086; x=1781584886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eA0puiI12gkUUrChccEFoedZkqg321TG7vWV3+7W2Ns=;
        b=sZiXCY5EvnXVYf+KZ9QoZYnr9Yef8kmHomlHAK+/EE+Tgy4zh8DvjnpRKD9UZvPYlg
         c7pggHZVc08DhiE9EjibZkrJlJZrp9K4UngLg+bRt0zK0zR5Zd1OFRTXPOuEvaDyFwg9
         MQ9LwFgZkIXHsxQ23dPM9O+80Wa+Bcp8aEyy2neoWGWfsgymECGTp8k/Bq1XAGNptNld
         L9ZZjfNT3LZ634lY8PKiicszTPfnYDvAb+FSkeJDSFRTnTGbk0JBDgSm/4JgWrjE+PvC
         8k/Aic7xI4ouZuHgih6B7QEsusoai35V38yal5wfw+yx5k//l8znKkN8ddDILm0nvYUL
         HIGg==
X-Gm-Message-State: AOJu0Yx6ZQYsgl5m2zXVCFg3K9dld4MKefwtYcmD8DfljZxncUhhJ5I6
	dD9OkTkf8k4eBpiCnVoFnKdii3Cjb9qK/TM5JybuH+aWlI6khpZHCw0BSg/idACXag==
X-Gm-Gg: Acq92OHu06KFEQ7Xivb6Vh9wyBqTlv7Yat/NM/XzuKjWt0Kj5H2LEKt9xahoPiceSJf
	vxDQW6VyHF+gcVDj44P0iAB+67XRDBgPacF6jb2qlVwQ3US64fgCeU7ZguCRpbkKPjNP7eSB5e7
	NGQ/5+P8elNSwmduyirB68Ypo4xAT/s2p4NE8DcpQgjobkDbACZBBS6IE2H3Rm5m24fCKnyHEGP
	QL6QnN+XdeIzr+BhsFctiXQpc9dZmRdaV2udbEus3iBKD70eC42QVHXlPOAycQaqDyvm28JZL5w
	hlb99lvW1pxsiw3RepeJlYw3bbuTx1Fq0kAwgudVih0j6PY01EtR8F266uYruM7PAzvRQSR2O6i
	pm7H0V4kZCmvL3CatLQAjwnY1sDVyk3o0PUgqmgZ90NFnBg8wE5QCXrgJGnD5AljRcD0MKRjcJ8
	CP3/tQgQm6OniQB7p1IGjeRK7YpxCa4tFFUPOPV2f5bbS7/fE0bB1ZFqgVRrCbs2kf2ZZWNTFRi
	7DSu0lPnUVfDk6EwXTkV1WTLCyVIi7tDQAPICUA+uQ/
X-Received: by 2002:a17:903:41d1:b0:2c0:af09:f3c7 with SMTP id d9443c01a7336-2c1e85c0cbamr219282855ad.30.1780980085929;
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 09 Jun 2026 04:40:52 +0000
Subject: [PATCH v4 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-send-upstream-v4-1-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=1213;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=WgXF5HKmPVI1MEtrLNcqmUizKiLvnC1/DeVVEsJVV4k=;
 b=MRn8ThmipL8aQeFe4El0wwHcRed1esJP/XYC9aYnkuywJVUaIVxu3P8Moai80Jt3iW7OzC0El
 WxYiULYHaqZCIsSH0OhJG6kcJ1FO8J7LYW+q6zH+Xa0pPw0DZ8OiK0e
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
2.54.0.1064.gd145956f57-goog

