Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107267;
	b=J8qJctd7JY0VEmLLHJU7/wGyqaYc81RZlsU3n6bvuslJONDQAOHVNCXWP0sW/oHTrVFv
	 oalZEPQv5baybJOm+TkhdPecwdmYH7bYYqEdbjxrfvapn0eWVq0hoWwO3QPKi/A+YABAh
	 MTReQpFWxXo7bolXVtGHoD3PRMRPNstJHWcqPvm1DX+cVQ2K4YuFU662MtXHpiA/sXqY+
	 blbdDETkcKn6ur4k+nUuNxBplGuITCBJyvynAX6mEu/032hEgLF/9nUf3UXBb9FanYH0W
	 WjsLQH2kwxoND+styeQosTzjEVVzdR0SDbKOr01rhQ0Vn4o44mQuyWvdM9urGeFT5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
	b=ukGG5q3MqPQGNU/YUmSq22Ajn+RZtGac3lYdO8PU8CfXYESuj2Z2Ktk1ApAq6x0+P7gy
	 lfWeteZIKNop94/MU4hv0Qn54YqJhBK8tA4D1q12+OmiqWKy2Bh7tIcVN8bDBw7mFGVaj
	 bAf/cRVd7y0WSY833l90phda0n4CBVqhyQwzq3j+ik7o6wO5V22M7QmNPHbwopwVXIa2m
	 6qgSJkXbJqfCSxbzuTdh5IgdqQNg0LrpxotC4dklWieoy1oStUOH/HpShD4gE6CtOcciU
	 994JSYvxUVTI6xlK5eMTvxKgRcy37rZha3BfcZzEnWRScXDbzfaPeFUW+cwaLzbxmwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMU5F7pE;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35848606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35848606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yMU5F7pE
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dee593f18so2512443f8f.3
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107265; x=1795712065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=yMU5F7pEic3WVSBK24VbKUxHb+6uvJTAIVgjWdxbMw4XrPOaSJE7r91tNCsliqQHaC
         qUZ5AZm1wcdjhg5SrKK/Ip3xFQeC4WH3EWfuhKGt2XT4qXNdxGvhP4n4JZToUqxlS8Ow
         I92yF98dqmRTf/ArtA4sBnN+AainR8sDe9FkRY0ZduALSURpwPh14khnTslQ5LzzN2NT
         wgcHnaSFPMaj8w83bxuyS0gTYRA9qb9F8740IOKVqC2JpoJaV55hh+Ddm3gPRJLYGvse
         aP2oDAyuagJ3p7ACBi+M3SSu54fU1v7T73M9/axItnrn/NlR3Y8jwyws5kkRF8YkbAgk
         QDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107265; x=1795712065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=Aghg++JUTuQll4o9I7aEZKJkT52AT8z1oVphgGBppl+ZUS4SOzrrLyys/y0ICAtPIb
         SKSzG9fh2KmH41GVOjFCTo0oG/X0WAEbR7pXZ73Oq5SaExtX6wXi141uKg+ePmryrGZC
         mH/W2AGrcI+3EfDTKMEHSGob76Y9zS2d3EqyM+ofIRTv0MdbIUoX5DYW+G87lepYyNaG
         1wgxQsNTdTJs+ppIS/UkSr6FOE+pXml7QhJ8pcfKeNvi2K59l0gXPMbfFzuuHzewKLUg
         QltGWmvWmXSP3rVNgCvhOcth8unftQiWbBwW/bWOf03pWeg/TifvUTrImTyWpvPhWOtR
         tQ9w==
X-Forwarded-Encrypted: i=1; AL+hErFCvSt3i39ZuzhpHcntHyAQVG1fTWlI8Jevxn4XOf74f0e8XZGXpUUkPNIfFnW2oe+MCT3Z5h9hFDjtxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/yQBsIP1UW+eenVJeWlCg/eCeJM5HB/IM8HzzZUsp+xxLjJ5DD
	rPCH2HPuCvgMJWOZ/Khonh10Pjd88X4hf8/dTE/jnjOVmAlA5t+JF94M
X-Gm-Gg: AYBFou3iEgOfaNtMmsKv+7Tu4WzZExvmb9oxk5ZWx/4gqJlCWJnew2fvPnEAV4DUgxt
	WnnrGczKKsFUXcnXMi46fCbtk1pkFYgDE92t1kCAUZQFhxvncuCMDHJX5iwmjwzq7HHKG1pAZkM
	h9xxpfohrD5U/+y6dSxCI1WMrkFepGgYgjsd6BrKfPbJ7nMqwEK62z7cMxb9hq9ehBwo8Hw22JP
	JtxIrpkFk1IRzWOk2QRWQ21MG6mas1B7QaPgPvXOfE6BVr/d45oHO7ihpz/3b3u5MjK6jPgpAVk
	fcELhZLuA13djkBjaOX1ehlUjjZJ5Ay/5CTArdDVkOKdd30OazD/WTW0Wu1jD2CX5Q4pXRG09iA
	uaqFFuCt8O0MA0xnaujmk+mRQyBwFUmIUiI9cow+qQ7CK1tEWWbwEXru77yQK9nJzHjX3HdCdAq
	M+86Pz/9JBjEC5nB0+GLs5wheI0zHMhLZFNXT50zCObHB48ZWEibfsaUDmi4TYPGb2KRtup3cOi
	NMaid7TvPVkwS/G5MvD2CnZF6ZivJ0kS39mjIpcxoYMbNJWp7hJPu3OEbmHgZvjZe0O3Y3vNdxV
	RcHnMM7+n4ZqsCA++8KTIRag7RHfkwjoceXI9Cy3Ykk8Se7Uli+CkyFdsmIKh9EDDycfjRTr6/c
	=
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4bb8881a294mr1876395e9.25.1795107264467;
        Thu, 19 Nov 2026 08:54:24 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:24 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Thu, 19 Nov 2026 17:54:11 +0100
Message-Id: <20261119165420.24466-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the LG V60 ThinQ 5G (timelm), based on
the Qualcomm SM8250 platform.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1ef..85635a871e7f3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1139,6 +1139,7 @@ properties:
 
       - items:
           - enum:
+              - lg,timelm
               - qcom,qrb5165-rb5
               - qcom,sm8250-hdk
               - qcom,sm8250-mtp
-- 
2.39.5

