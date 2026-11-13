Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596866;
	b=a6gXKQU+zuLALl6RiZBFu8glpOMmO6ieSnTULYU7+hHFayYLPZBcav79KDzzD0dw0ooh
	 OF6AtNQFppOnGS+QLkDp42DG2psl9K5JnzQCkjyoj9XjjUQFAEiae1CRM5/bkaGNgHpvK
	 6+624CMdypvauqrhMLRK2Ho6nYaGgKC+rtMPmkgQP169BQqXelVsj7ZwW0wf1oypr2Vk1
	 bbpM4Zwzc6ahVW0WScBJEBGfIEguWWwGfXbXtkC8Prb+Eoxk7pOoxXoDSwNRvLFU6+OAs
	 0lPlhN3DOKatGt9vmCTTKxzrBCy1sijpM0PGbfTSKiNeGoBHGrSqfi0u8dswsEW5oqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
	b=tlUP0PvthPCjcEHbOOuK+JdB2sfWss5aAanJtjZatQImXnsyNyINe0c8NGKlgeC8Da/X
	 ZuvkabIvpJwdZYLV4SMWcNhMZz3f9aEgRNbVBS2k5ue2Z8iBTze6LIYxt9FIHSSOzvICZ
	 LC0JmcKQoJFYUQA8e4jHHGZwA6CFTHmO+8rhc81yrUOSm45nWegoFIFV1RmRXvceRdxqX
	 va6Ioo3sRp3Ra+eFm/PsZkr5RBMWe2YyLqDkVKw9sXYHps+ZDbCHK8hgkdLTDNdphZuRP
	 gWhvf6n+ZSKIxyLNQvWDZ3dzbVI8Jrc4EbgAU2PPJlrPAFWSKawqmpXmXyXTIWpuV4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D4606A896
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B60D4606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vm6v1RTE
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso226811966b.3
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596864; x=1795201664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=Vm6v1RTEA4FWJq25ASY1lb5MR5BgXMe4qoAyAKawSq9cDnRLqH/msUZtMegpu8mO31
         3alveRSeEqOlea3xa03rZSdDRmVsFWBqx0LvtXUYw2yHjLyfgd/DRtnPA2Kv33PBvdzq
         6/D04/Ychb3xeD7h2lFwdXVW9kehjlwqs6tQqZ6ir45YeFHjeC9p+tqjQCCzhCBM80Gc
         dDUSPmVKWoIld4xsa0FObxQKQoUQqEjgaxbgyLvcnnwHmjG7pd8skw7SxHTHjtYmY7Vu
         m8wlHEZ/BrlQKb0qUoRYpWhitGlL0IDd03p5YchHAQXI015wKWpYldCg/LZsRoMg6eGb
         Q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596864; x=1795201664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0kISij2dA5dG+ZLDMffjTugHXeo/ScalkLGjjtZzlg=;
        b=qGc1KwzI1fDBIJKy2Ls5CUC5SLdizSJwbj//At54XQeTJxdrMe2lzHaeYB+LEg989F
         CEpfrQidkq1rf5yF4GS9zp9XI8435ayg8EPdhyrqNaYwtuOyiWTlXGNTuDilgIpMOM/X
         ncTISMof4pubAgoUILHiYWyOsawR5sIOTqtA/sjRqp1qpUzHu1CyHJcV9vbEdBYb3G6E
         qYb32ieXanWsE94Xihy8J/cxwbpqQtNPLb7BfuAKEZT//2WEa/zBLb9dm2QFNE2aeII+
         V/vtY2KriUrGaI8OvpBa0oc7BzpS6fuohRuhSmszhTmQEfdU5HEv6v8491ZnbRA6wVtT
         8J/g==
X-Forwarded-Encrypted: i=1; AL+hErGYv6s8Tncr0PGz9AmqZd0h1gCsEkQ+fc1rb/WCglbv5JP57e4Bynf4yqTOQSkh9AB7NSYnKm4q070sxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nF/RaZmfUe3eJxSl3xv1Pupgw2qidEYMUmvnyD9FRK7VQg7hD
	w7Uc1xhhMwWHb/cGhwvYga6FtrYZOejW3CdRlHpPlxbmhvJCGYVqmGv3
X-Gm-Gg: AYBFou30EA5VqSL7fdw2cmh6lRTEGoo1Q+Cvofz583NRHwvaFlvFWj/jbGksz3b6QpV
	Qw42TFsC2i+XWHtPyUDnVqRkMLeCMdRAnHfPLGjQ/wppfkZd8N8/+95TeuactH0Qq9jthkcGQll
	EDm6boZ24Oai6oLPgqxYwa0S8LH+LyuS9uGnZmEzGksHV6zlUHo/GIDqEYPz7oOU1Fnthj7zQpi
	YkfdJIL9HG+Up5QkKfPLGedC1LltfIRFFCdlBbXJjktbhz5SYpXMgXHFYmqilPnyBR/I+7GkznH
	qDXjmyB7SI/uyCmAGOS6K7CrrqwGudGy5GuJyJWyR2pKgD0skGVyWl3c407HRJdBmHkiIHKmELI
	bjg3GU3qVocoZ9XZnIlQNYZBWeMNz46DK6Ir3bBgeFEzanmiM4MuJv5svOPJauiWrQtvsgRhgsW
	pLPlPk9Ltq3mUi/YBt26VZCruPwWP9hEpQqcKCEMIfbpN6Yue6JYSPRfhWQUddUVPA719e+MOQ+
	hPAQiu6OgY1IokWplCk4zfOL3pnqYJKTZawlZ8JYJ+kMWEZ6cKiKAd/A8MSY3M29+1DyBUjBuEU
	wb6EmTZZlF4kmyjb5XEAWeove62aTC7wpeayhDP657EZm9fo5imCxAZa3lu07nKv
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c50963d50e5mr310340266b.16.1794596864130;
        Fri, 13 Nov 2026 11:07:44 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:43 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:57 +0300
Subject: [PATCH v2 1/9] dt-bindings: arm: mediatek: Add MT6895 and Xiaomi
 Poco X4 GT
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
Message-Id: <20261113-initial-mt6895-v2-1-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
along with the Xiaomi xaga board based on it, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e7..28180ed0e815 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,xaga
+          - const: mediatek,mt6895
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
2.56.0

