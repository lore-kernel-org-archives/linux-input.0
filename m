Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596872;
	b=2E3QjmfSpj+fwzUUCy4xntg+NOzpFfiTrFVxW/64rdrC6HT+PJSmqUzJ4r7P4ZJbFetA
	 btxceVO16WIvHVgFZw1dP5QvLVmvGkRX5LTYRH43bLX+Guus6UMB/YkcbQea5YQ/v2j8l
	 Ge/hhXbuNBPQT++s411WoptPSrB2MfTki4Hdl5r80s3FAaFPZAN88BeI2qLQFUCKW5E1Q
	 txRmfEwhaaaT3kLzcOXvIs02USGCMKYpDhQDejalGy46XnDcahJ3YJ/o3Trhz6AC4nPLI
	 /7C6He7SPxEBkyijcWUxm2WJpHXjXkaI3XqeVH34H1swDgiGHuEMbhcbFfS6gXhJ1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
	b=JLiabH9XXKHGe3C0TeFM82gWOynOgZ21UxXWD22S2X5Yh3gD0Fx2Ai3RvnHqWJZCfcwp
	 wAzbDrkISm6b3rCt08dGgfH25+3lmnwcoAaDduUCQOPApOC0Ee3oe74dUd5B3wDyKv83E
	 KU2rVrDM0LvtIthfycfK9h0DuKmwRgtRFdyNmCZqRZZSr307Wwg7PZIHbtBhttAboi4P2
	 KldjZ619yB9PDzLGXzb1XQfV2NL2eNpViVfhBtJGXV/Ue+NIf43WsTpPEAfShs5FdDLTM
	 gNh+Dcu3frMdbdNwiM8LfgtuDK1P9GsXyVXfg444K1WERE0AqseFrmZ5r36FNaywuLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC9606A886
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 19:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFC9606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3208020a12.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596870; x=1795201670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=HePccj35FvhTjvXwtdVBJgEGNVeh2KrOUDPZqigubVdBbr/KLsuRN5y64YNXHBWId4
         m5z0PK1xgJg2mvVjc5PNTWLFyq96goUIFhvhIPhZLDaMHVwkfH1EPNEemnp6vzvRPKLg
         Yuy1HRPofIJAEzZc6kSFJD1IKjUzSort9TdQEdO9ff62aiFdDCjMk7tpoNy2qzHJ8s96
         YMdgBD2K4ZYcf0zITt9tCnTJE3UbVZJCXEo3J7dmh0cYnycfUhsDbPWzieA+Tru3tD+O
         CE6bH2un439G7EPfZMZmwydwevOgw046xvR0kNIjHzWfD+tp7t1hWAKcpujb0Shia4NI
         mV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596870; x=1795201670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=l9psW/H2nPoQhl2YcsWORhW+7pYFWL52iobfLDfFQV0GAjFz2kJC0jF1YF+TFDIifx
         B9GSiu4DFR3xpKA93kvW8EydyKPETunVW8H3JFvieOpxKQs1FuJfyWAcyJbVRigf3G5+
         PcOrdlhhQmjUXFtc8y5OwJdPZYpzmFZ6yCVwxakAyzdHz7KoWMSycyIla5eRVJ8YYSPS
         cfARzVEcaSXNq975KedmNnM/n5+8VMenUvBsRVYZzdZf5Dd25LwpXl2gE74MLsasNhwh
         ytlr8+odJHxhf4OOdRuNukbZa6tk8NCdYvw49EI79bbAcyfp90RJvUgUR1fLUhu71rWM
         6g0A==
X-Forwarded-Encrypted: i=1; AL+hErEL6yAfysFQCmsFKBpHId3Fa21xb4jPQVhf05xejKEUMhUWzLiq4EVnUohILmAyrphoMDGK5w+rWLipKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nMNkx3YoYuHfcsynZE+HIBlaB7YHaPPNI2LuN8o/ThYiksRBy
	TXOaKn1pQXuBhw/+nxndyXfzisL7qpHZ2OuKUt0oBjzlDOgmEWYcGEKU
X-Gm-Gg: AYBFou2quO5ETm1lseEhushTJRpwGXc9/4654B2y2l2bpxw2yHgLdIZCD2RKBxDncXm
	539TWC6n/WyxgRBmcN/LI19/4Fpev7NJZ5OuqrT6duEAjrPHQva3PKUP3GvBs78z86mRnMk05eK
	GobOn90JYD7g+3kx8lpqhRAU/Ctm2E2ys+qlWJVVGmqkBtVlXIFdxYGtXbb+k4dopyPhXq7fXeP
	tGDDufnrq6Rc9D+30jodMtBtXz/5Txbq0cz2ZnE49ocKP44FIcP2V+1AbXj3vPxfJ2Ol8nVBSqj
	PdkPlbgfqs8MRAaF6Ildp+eKlrmh09fY4a9PvzpZZMmfh6xkg/zAqxUjl+4boKpgXap+Nqr+CxR
	5pYYvfY1OMAz5477D/sOEV1NLU5jNg0fdvqYo37K7egDIoKzqEhzNm3wVEz8SP7MJrFvfqjEM2R
	WNNCEhMu6Nn34Rl3bSfDpCdHbdmA95LZHhVReqosRlS2ZeYLFydA1jyrCK0vj6kAET0HZ/akwKI
	m9ZqmJ9xG8ZXmjV66NFv3ZOFuoeEdpNxpTUN9Y7xiWmwOR0WH9PsHKrukRzrRiabXJeBztlhe+R
	wcVVzFgSr3JwmCjsTHXr3TVdXgO6WU5kzeUSx27mL8ba2uM0w97+sP5b7r3xd5To
X-Received: by 2002:a17:907:3f02:b0:c50:5186:6dc2 with SMTP id a640c23a62f3a-c509636b5f5mr389984566b.24.1794596870123;
        Fri, 13 Nov 2026 11:07:50 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:49 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:59 +0300
Subject: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
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
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the watchdog of the MediaTek MT6895
(Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
known yet.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 8e8991ac95ea..d0a73b9c81d6 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6895-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
           - mediatek,mt8163-wdt

-- 
2.56.0

