Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003639;
	b=X0dY95NBfDe/rkScprr3SFBt21G5OOc9aDZoqrJTV2K26SWIeo1akCLJmd9VkL6EE/28
	 V2RN1WB5xbiNYojnuHb/JrAgIHCTlCYlojQHmbCExxLm5vFhYrEjpsb528rzhx6kNtNdx
	 TqBpBUx42P4g6S+tsgQ362UQpYE+AzKB3hdqlqpg7tfetFb+13ShjxXhMYIf71WvVbVAd
	 mJE2YTdEHR7Mw6W2nj90YhoijjhyNj4pL7fFo8v8QjESYlFbELpADkjXMUzC9HycyrdqL
	 JSZIQuSgQWCLuKoMEXZOBbt1b8NNNDHgWO9zX47uOSM3ahXdpobO4ObZUpiuEbRrgww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
	b=nxCixVC2wavcZQH3CwEfEZBlstKwJdDYHCaLYn604vqfIfnM8M2x6f5aXTBc1c1Z6Pb6
	 MxYhfdVKglpKPSp8kkgtGbIsfQy9mIDuLseiKpM1Jb7dc2eCu0cpRaJqdS18B4DkUFwjM
	 dsLKel4K11JxdZfLw/4/pt/2dgaJBdISL8CA7bg70uqj7FlPm0SomL16oIgBXxHtDztXw
	 zSjz5kz0VzlBfxty7a0ktIS2kgKsqTO16gPC875ih6eNzW/aT0oSHx0AHdUoNZiNmnXjj
	 Mh7bDOl/iMBn0qwBC8eGJok8D/cYe5HM+9/VdeIZzGoDDqNXnpkQofSjlkaZVu17GoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMquM6pt;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764E606A33A
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1764E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMquM6pt
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so725432f8f.3
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 04:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795003637; x=1795608437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=rMquM6ptDsutIaiNx2Yw5NPovGela4gqxe32OKyBmkc9+Gr7c1LXKVFsiz0LwoHMGi
         580ZTI/Av7s/ToqUw3YGWhaZdKj7L+hk4AC7B7/p3oUSV2yaMvuL4fouNWcm5dvtEiAe
         E6O3Oo9LdLfW/a+SEPyGwjfbvyak/8GurZcJQhewbWGcsuzxAN0B9s/B0EsgD/osUoyt
         c0GJIVMyfi/frV5jVG6gZdURV0zzIO+LR1T6rddoFztdIlwcozOBUT/HzGNxP/7c5zQ6
         vFlHINj3hmsNKKhkennDdAzLsee+13zqdezn44hmvFj2mypUMX0AKnSBH9DuMy1DG1jC
         gVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003637; x=1795608437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=kPEJJeM7VVGcJQV1oBLt5BLVe/oTAiXCmCUvENnbKyj3CP+sihvdHsPkoesJTzRa1/
         HEDBo2Inoqg4ivfzVx51TMxQ0YM691KXcNCC6gfWRAvTZm9msw3b+IRoyN5xd+Hitr0M
         RUXuHaa7FjlkxvzVBH8hWNi+cpbzTSpCpxYb8wMoifhdDsGB5YEc58eoF32iOr3s0SNL
         S9Yr51RYQqqwDjM9TxsljjLvAwSASY9YuFvxvPK6rWHLayAdrpx+YX9j2tYZkBDhjS5c
         WliUo/IkeYayxqfCVlrvBUUVl+OtDQJrPNTF28EmRJkFhsZEAtOx13DY86hcOt2cGc4m
         GFyg==
X-Forwarded-Encrypted: i=1; AL+hErEGzOJw+iUS9Yoo+ZOSzkddCExBLOxY6NTUycrZ2zxYhDg9QcnoWXVb/xj17+3r+Tn7qEX4Zth33gXo3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/LDW5DqSBakVBhNy3B+8DQ6A7UiERQAifyKqNA1y6b6pAuAWaZ
	g4rtbEBPSH/zyHaG9UwjlEWiDjYmVEx92FUxOsnZhmqrvHEoSGo+Yeap
X-Gm-Gg: AZFdTZcgGThxvIoqZHPIe/qp27b1CQrIs/JLgZKwglf2DvKWnhCmbeiP/dyj2TcVtF2
	pQ8R5urzwmMITEObJTdRqOUMXK98Ao0Ab8Js/UnPHkorjsEJ0REGXvh2tRbNjHjl9d51UBOJA82
	bABuT++nB2Cq7MT8K6FDm+ORDhLIAadU15zuVBQFCd2L1afx0cRP0PaJ0tH1OLN6IZIMRGd5EgR
	QGJQGE8YvySKf2dXyViqv+lAUpGXeR/WVmbaD5iW7FGDDDtXTssCO+Scs0KH6vqSevwJE6VTPMt
	KN83STi2z8YLBv+GjSmLYy5bewTkc6020JtRctz1AlWdgyx7UHen/BZMuaZE66wYsipvmWMCwcW
	cEUUzpnjUEmj8qfF2lGJZBtWwWpH5i0A9p8zLxN1YgZaUfuZgy0om4/YT+ul/AuujGjRjTOoiIP
	4iU8MvWvoeDrWDag4l7v5OGKmVxJYgJrJWos7d1Q7nN2yF77aeNkYKcm5DhFhYJDOLlCtaItyP7
	TY2H3UgnHQiIQxVwMZhXwdcjrHq0UCG3kuctW7VcvT4zt6k03lPaiWVuLiykgtNQh72ASDPesOl
	q+qd1yf/hHramfClgudXDftgxQ7zAL8vsf79AEnHrdQIGknn38dScDrpwQtEB8lzIUFw9ZrjvQB
	TNJALsx7Fzr/t0RFKzzou
X-Received: by 2002:a05:6000:41c9:b0:48f:bf3c:1631 with SMTP id ffacd0b85a97d-4a638eb6cf5mr4646275f8f.21.1795003637378;
        Wed, 18 Nov 2026 04:07:17 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:07:17 -0800 (PST)
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
Subject: [PATCH v2 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Wed, 18 Nov 2026 13:07:05 +0100
Message-Id: <20261118120714.31505-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
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

