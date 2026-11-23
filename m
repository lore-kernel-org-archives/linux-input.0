Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432751;
	b=cZ8GzuzgXRxdGUqr9L08xEA/vsLsw8eT6mzTBjhauTXhPX8e3r2eJMNdv7tKB4ZKFEmV
	 0nNLkL8xXF+USepBv+38VV4J2/hnVvYF4aIJcHUdqZKr6nne1a1Oa1ro3GFjMy6OzHbTg
	 MyGEhis10vsUvvM9xs59mjCyCT+MOI/+/dg+fZCjJWRvbXN6JnAVK9xNDYrJ+Eb84HFTB
	 S7uGcZSE+xdziRJK9qJjHKB4BTDglR91O47r7/G034DF1Hsr2K8/fEmX6lfAaFO5aCsos
	 NeS7TrjFYCNLuGg5b+dbJdIvGdrkW5e13Ce4hCMiia3C3IFcwoWZpMwnk5ZxjLoK0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
	b=XFI93wgFfuXKp9YjibL59iI5VrP90nVnQdQqSpm4yonohlv3UjxbRYzBsAqojQPiUmBp
	 P35b4VjCp8ua/jkOV66QjExabmCuH+hqL/Rlzqfh4HyFwBw1f6U7FMpzu+47oFlFOwkYm
	 JB8EA8esuTghdn4c3WsgCkJ+zUHSqMf9uTyMWAro6D8ii4Om7iMHKvdDTpqhts/6GEugj
	 82PeT1ma928pcDUNFoYzEUhrxpJgW2YErz1f2QplkXurb3X0iaiI9zPd18r52Mt/z6zEX
	 5dHDXDW2cvMjFgTDow6QUCJDlIulHiZkqZaC0sjiG3JjDO6KuuSLTQPmw9Al+nuhlDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcoKie5q;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08482606A6B0
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 11:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08482606A6B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcoKie5q
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a574bffso169800366b.3
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432749; x=1796037549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
        b=JcoKie5qcPIy9VJGNJOeooy8iE89M63mPT4Tj1eTTLSnqtXq2b1lwRilTuF8Wo+w30
         2mxiL2i3Kgv1GdMK5qHeDH7IacTvYGU6YHektDgrSNsjjnCE7wnipEghpMjLc55Zi4Hj
         kgzPLiOhYpRTUT4KP2wf0Oo6kIWuFOkV8cF6MluV+qhv6OhNdw5ZYUmNc1PDQCzxjgcM
         CV+RTr5c85OgIHVnYYn4g2IuTNj8mjnugocu6PNncbEOYSkWeudE4IVx9G5+bwbOTt7i
         HgpA9vdDoDQCptPRtZwyqsw4GEVjsXpuOQPBTB/cDi2VXoVWy684JhnOA2J1Ipoh5CfY
         548g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432749; x=1796037549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
        b=LaTRiG3GiPqkJ9aVDTfWbc1sv/wT5j1Sew8cMZctwY95mN9PCJZTTOInpxRVbuOeZo
         Ml2mdfc7IMtz/qm9Bwseb+8LbnuBUTXZjUsbAetnPLF/qHR97RxU4nRlWq4uZW7YZPwI
         0yKD3bYAM9JVdnSMtawpodcGmjYd7DB5wC3MtKuqzUDtHePgrSo53joPeLkl7pPLwf1Y
         D3PyJq2ewFf8R6iTHjZ34P4ajY+nxcAabJltPpmYetDHCOmS3I/8Uf/LFmoZG8WI/7DS
         t/Fua6AX5lfibkE7UB8wQnI6X1PXjt5Jdg1e6o7d5usGUWQZf8gKn4d8pNTf24LUgVqf
         kg8Q==
X-Forwarded-Encrypted: i=1; AL+hErH4HJfXO4LymiN3tMub0M+nTBaKGo+R2x/U1l0ntLUr/3ZdWL1R5MTJL7YQ/YTfNgOWNg6QKeP1uO3xaA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9/Nv64YvC227zgBchLeLO0QfwTVH5CWizXi8+Fqmye6iHWMawb
	USRwYX5UurUZPazmri288UEowZzsWLUAWFSXv1h6R45dtsvB9Injxeio
X-Gm-Gg: AZFdTZd3vomKq5Ce9fboAZLDaJKJwob2cdiadb4ptngOco9TyPts9bAlFlIWsKQNTp2
	U1NwwJKnU+Ze2N+KGfZQoB5zi7nq4eexWvuLiMh0KHhSO1YlLigvnzNh/XUoikYUBzt/jcZFx/m
	4oj0+AhWyqkaysnzaoJSUFTndxlprw2NeUjoBSiHLEjsSdw95Ey2xrq3isCrp1mq3kf2bbMlqXb
	NrfqSJwJKoertj2R/CmWixe7kx87ExVvSLnWP+C6sO19Vv2H/hM+71CE6+apfkrEeQ+ZqZVbkUW
	xTgyS4e7piT7kVncisnU7a06QU0yVIYtX2nZg3OF7SBAfjvacW049lIgManwh+bZ+u3vA8y4N1w
	TeQrM5geQae6PTc9ln26yMm83sT0yQxwVnqiQuo0Rv5fF5QmTlbDWfTu3pMTS4Som6levEyptV/
	bXicuNU9B7EA3yE38YNK6IOuN9clC3xIqC2108slkIKFcTDfeiYEkO4sy4SqN9YKGtAOlt+WXc2
	dRvMxhMxFEO9RlRGVW6IoKMj6NNkLWFmCiiHhjNmMqoH86/e7TZ5PbJNf4N/cMCHuN+x+VGWRLZ
	zJf2x+gQT0ZZGEnFa/pVZewmzQDuVqpCNqT2E/KatoGPg8TWgveHNdgALMtnslNk+Q==
X-Received: by 2002:a17:907:84c:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c513acb5be4mr952960766b.48.1795432749405;
        Mon, 23 Nov 2026 03:19:09 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:09 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:37 +0300
Subject: [PATCH v3 4/7] dt-bindings: input: mediatek,mt6779-keypad: Add
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
Message-Id: <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its registers are the same as on MT6779, so it works
with the existing driver through the mediatek,mt6779-keypad fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 9f0da1240187..9a1369c9ff4c 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -29,6 +29,7 @@ properties:
               - mediatek,mt6572-keypad
               - mediatek,mt6595-keypad
               - mediatek,mt6873-keypad
+              - mediatek,mt6895-keypad
               - mediatek,mt8173-keypad
               - mediatek,mt8183-keypad
               - mediatek,mt8365-keypad

-- 
2.56.0

