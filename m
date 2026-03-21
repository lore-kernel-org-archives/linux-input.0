Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176DE36C9C2
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124783; cv=none; b=uG9ClxqHpeC2hmnkGCJqxv53Hi6+7XuL+Inv1/Za0fI/s+VEWR/761kSl3nxCE4bBfpe44vILLj51G7veC5MLG6vP1+FWCrt2LSKDL3JrQko70TzY1fwwC9KizBKJEHVi9Y9F+WS3+2OmHu2pj6oo75VqGvz/CMR+xjZAKgcF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124783; c=relaxed/simple;
	bh=1ZJ4UW9VNpIfmKRylDWx30ZOWztqjUmTC5cFRStSjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU9Ngz6KJf9/dTR8Za+EDoPyMw9bnZ9Y9TdPX4I//NSwA/wrLU/+Wva3HCOKyDn2Rmh81AzVrR/1Bvp3cKvKBqAvSfvltcaPcx3icGiwPrc+BQ00OE5KIJ0t3xNf3TvftSPxw9181DbBl85QDna3uIdG0CvLldyofrgz1AOOeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUeOylC1; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUeOylC1"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94de88e52e5so1712466241.0
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 13:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774124781; x=1774729581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezBRmG+B1qFanDOxUrd5DeB6YRPxeO5OjVC/69MyO+U=;
        b=LUeOylC1J4LjzEefRcqOjokeZJ4N4T5f6dvFIcm9EjIR2BMnc/aLpY9e6ubvdWFlTq
         Ppr44hFn+nOVdZURtlwkL7lYpNKOxMNXTnq8n7PG6SS1ZmvXpDffLSfNyN1J2HCDSBBl
         P12B7hDwLc8TSlEx7JoeKOs8rCbToG++NQAXkDk796z2MQWqb8q9bjO/DwoA37Hk/Nbf
         YVKVJl8VbM0rlziwKhDEWPLSjLxtjI3ebz9dQj8zG+drBc7l7gmoMyLFrRmDLWhaV72D
         vj88ZPC8Pf4K5IHUS4ZZTSt24Iq73/G2LYMNsHCH9FnXdsVNJj1WdHgm/TivP0knb92T
         fgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774124781; x=1774729581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezBRmG+B1qFanDOxUrd5DeB6YRPxeO5OjVC/69MyO+U=;
        b=PhBqjDcis1aXJrvvFKo+N2tGDQ6lmwCochHHKdUL4Ck3wPLim/qFPFm+oi9hORwoIN
         4MHDWlNqUgkjEQaQsbkDZC7wfhbEImB/TDgTdRu6FGBdSociUmf2Oqd/vND0CUq4bxEK
         4kE+BrBArbz0qlqRFCXlrtYg7X3ktQ7CA3ycW2DlAUpbIAHjWAwl9+vqQU5lYCLZcAsv
         zOVEdbuXCkBn1dw06/CbDF83i/g7KNvgdKzTAgH0skPSunl/dzX8IWWbDN3RowlA0/FK
         UyVo/7+U5g6OlwY95QhKJcEIaqoZn2H8vwTJ4GLU/89+HTixIxWQ1grEcIm7TwuZKi4j
         SZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCXu6m4LEgK8/Mf3CTPUBW/D68QzV4kl1IY96aUFeZlM9kcT1qFRYs6q+2dT7SfotmENN9OOLbMVaFxhAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkoHQvVmUwkXsAwGaxx6wPaGtb2rNTGNIUT57DRp/Em+JcwGi
	I/JCgtiXjOHm4ZDVEK4VKTVCu7Ciot9AsdpyESkGa4h34V+YZ4EA2G6z
X-Gm-Gg: ATEYQzym6ZVTDlVqGk7I3vEI7HWadXiDdOs5ogBBi150rT49jRpBmXZEdwBkf4LUyW7
	ujOAc626fJSfPmH9KfTmp35QQPw/A2J++zvwxS8chFdMQK7N/00lEC4QNwEwYt7VC3ZfDyKwPnG
	+74+/EQ3Kn/mRnW/9NkvlsQj7RHOzgYlmmeLbGtnaGQmWIETrNSt6BEJ/MMSrZseqpvtGfZYany
	2QzT/oT2DrP9qbCpXPzn7Gi4usLEwwTMLUhKFbtmAqiYT7ZMLN/kW1odKxeNJRtKLEtDRgrx16a
	9Y4dBlVtMnLo9QPFSOjn95jMeanxBFGaWcrjZSZmQV0tdItz+X+7QcldP96dh+mi+ArnZr+gH1p
	7glg2jRQ9g5NVhBz9TEgxPA9dScH0lNIYV9h2+CtWU0Ofs4xte2D1rgJgCvBeEUHm99mdrdyooY
	rN7LGn7e9JOrMUEIoJRcV2+OaP6i1YZGxX6Q==
X-Received: by 2002:a05:6102:4194:b0:5fe:12c9:6e5a with SMTP id ada2fe7eead31-602aeb0234emr3859545137.12.1774124781101;
        Sat, 21 Mar 2026 13:26:21 -0700 (PDT)
Received: from charlesdias.. ([191.22.16.211])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de53d9sm4144378241.8.2026.03.21.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 13:26:19 -0700 (PDT)
From: charles.embedded@gmail.com
To: Anshul Dalal <anshulusr@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charles Dias <charlesdias.cd@outlook.com>
Subject: [PATCH 3/3] dt-bindings: input: adafruit-seesaw-gamepad: fix interrupt polarity
Date: Sat, 21 Mar 2026 17:24:46 -0300
Message-ID: <20260321202446.724277-4-charles.embedded@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321202446.724277-1-charles.embedded@gmail.com>
References: <20260321202446.724277-1-charles.embedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Dias <charlesdias.cd@outlook.com>

The INT line is open-drain and asserts low on button GPIO changes, so
the binding should describe a falling-edge trigger rather than rising
edge. Also update the example to use IRQ_TYPE_EDGE_FALLING and add
interrupt-parent, and clarify that the driver can fall back to polling
when no IRQ is wired.

Signed-off-by: Charles Dias <charlesdias.cd@outlook.com>
---
 .../bindings/input/adafruit,seesaw-gamepad.yaml      | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
index 5e86f6de6978..f0ebb326bf74 100644
--- a/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
+++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
@@ -25,6 +25,11 @@ description: |
   SE -> Select
   X, A, B, Y -> Digital action buttons
 
+  The gamepad exposes button events through the seesaw GPIO block and joystick
+  axes through the seesaw ADC block. If the optional IRQ pin is wired, button
+  presses can be interrupt-driven while joystick axes remain polled. Without an
+  IRQ, the driver falls back to fully polled operation.
+
   Datasheet: https://cdn-learn.adafruit.com/downloads/pdf/gamepad-qt.pdf
   Product page: https://www.adafruit.com/product/5743
   Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw
@@ -39,7 +44,9 @@ properties:
   interrupts:
     maxItems: 1
     description:
-      The gamepad's IRQ pin triggers a rising edge if interrupts are enabled.
+      Optional interrupt from the gamepad's open-drain INT pin. The device
+      asserts INT low on button GPIO changes when interrupts are enabled in the
+      seesaw firmware, so the host should typically use a falling-edge trigger.
 
 required:
   - compatible
@@ -57,7 +64,8 @@ examples:
 
         joystick@50 {
             compatible = "adafruit,seesaw-gamepad";
-            interrupts = <18 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
             reg = <0x50>;
         };
     };
