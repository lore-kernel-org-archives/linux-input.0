Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577289;
	b=z17jjrVejkQJ0wjqJdkhvOKipTfbzBYndzhvcblsqhiaUJmV2SQc2jQ0TgN0UAsTjW5m
	 IiBYxWN5bLSxJ6k7/x7/igZum/OARoPnEWlDQ8cFJmTj0yI/03lNMwh0k8n6G4GmYyMcy
	 mv6f17lbDL3llJRbp91xKmvDLtT7M6UC6p9RqpzbUq4hSmX0WVrklT/3UaEbNQhEro69g
	 QPrGjcdnYYDdRqsJhP+w61xekK+zXyjrBOazZzt2QDVgtO/XLuuwbFbSQb4A+F5wznErz
	 dFyu0AqDh0T0XXZki+FZjG6Tbz/eMVSsyQ5aI2NXrxKRpNWzD7+yOpfdZfKgO7Atm+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Lq5GK581V8x7ovO5oAhOTbEGADqrrK51A5iNkY/jsEw=;
	b=XGbVbdwpaqpT3Dmbc00Q7eB5jMFdpTK1Tu/VYWf7pm+orj7Rqq4fySl3SvOHXGFTRL7g
	 KSDmkh/Q1FBwDEkq0iHDDkzlF9pprWS7p8QZibSKhPPn6s1uXuAmEA/27kvwdIYguaVPG
	 NfnujeKb3CNyqBj3bW1640VcnrSlzZJYJHU00D0l33tRJwRzeoRIMqyxjFbvw12HDJZzm
	 AKJaq+KnJ9Tv/bbEWHocmnScshsCXaOIi6aNaNsnhz8iUmWmjgOtKVIOuzP/8ksfmxxk1
	 v+ik+KM2rQEwd6o08c/W8hHOgunuFwdeoK8LSz+B1CSjtAdmG7kjfEM1kiPAq/Q8ZCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAkKmFZe;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F9606A687
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 03:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F4F9606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GAkKmFZe
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a32576da88so3006202f8f.3
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577287; x=1796182087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lq5GK581V8x7ovO5oAhOTbEGADqrrK51A5iNkY/jsEw=;
        b=GAkKmFZeYJdeyxoFnkh9isZrU3i6UCbsZOVdLwfB4v2LQF1h8z+4rk+iqz59bQ64dn
         8zTxsCXgxfGgbE6Bwa6Y7qsBmv+4Dxzq8/S70qdc0R9PZ0Y2uaKHghNAaCKEOExHZJiU
         POquc91sPAnlzVRSxYnsxLtXJobZNE2Fh02SJSPUWOozFb+nfxqG1QU9tdbVbhxm5Uxw
         mLqebyiqt6urRpwsv1zLryw1YaoCw4UmB2EZVv+JOO1xupHyEOnxQ/kJpbBGb27Z31Fd
         TOHDGZpnaCOvqS3bf9g7fpTTOeuvmsjLnmLXGqVHyBSXvon0XYkCUiyGwjjRuScaP8op
         infA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577287; x=1796182087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lq5GK581V8x7ovO5oAhOTbEGADqrrK51A5iNkY/jsEw=;
        b=we3QRM0KxR9GKgBQklZA15sLim1GEFbVpBzyQiewEA2qxEMIQGW/IIvAtM5d+eieMe
         xEnNj9taGiPNIVNyZw2aiXCW2vorNuW9Uje3bSRd9Ax0gHY7PUW19pb4QfUQYRyZTXiO
         VqtxX4KOvlzSzYRu2pZWfziKCzhgtT5mWs0nmCd9Kn164mApFFDndwP2N3Ghsdg18fuT
         JJ595r6JMWTdK/A/qEJqoQPkaGzfg9OrtLagHC1hRRpYdh3XVpiBjzZ6SKiazsGYCCzf
         OUZNyollpIEj/Bz4I5bAFRZGOH3waYPAB04I/zBZC2cVu8YDndy1Y0e2nEFcZDZ7l4VG
         PcwQ==
X-Forwarded-Encrypted: i=1; AL+hErEIMA4aODp7l7uNRP9Xt0fxGxT9174vwSBcDx1StvtiD1gg6vSFudcHhIG3oUtCWlzrVYbicz0KlExUsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z++nVhtNxsKr7lVUjlQ93aAEjH/88Jz27yhJ8vCV+eOrXtjiRyf
	84pRdk0RNMwkGNjDlpP/UyPT2SeEZ1RHbhFKtWtALEGXaS/hL8JhLzoo
X-Gm-Gg: AZFdTZf6sf5tlNvnAEvpVuahFmm7DKn1uH8tSV0Od4eR2rRTTHCK19LAzLblwKc1cLQ
	s2tF9rgN9QelHM5+wftn7PLBM/dAgZ4J+VMvTgJAw8KDQqJVaV5PMT1uMXKIYtutojOWhs1lfqM
	EVCy3rbOFgekuj4uSIoNi+Ko8XQvfsHedPUF792nCQyx1JrpHRv5vGXltNsdH1zK4pejHQWHtf5
	HF9JtbE/A4tNUAaTd5iHw8PmZ1fMW1VgD7+ZoLOcjHv+ZFTgJckrGO1sjs2g/w+f6KSCITrl4Xo
	//WBF+gJX78/plfLRJ4Xf9crDfzNgYs+3dJLnSf8iDX0I1MS5DB6FZTKpGclMPIyf9fTp9EWfSk
	80izDTQnjDrVt+CH3nw7yYm/O0eLWD8YkRgsOHJ4jLQiglYL8egcYwGQWBAzIrgZGi8/4W7maw5
	TsLX/JHEaUt2oeCbYymlcx9gbIHAxUG0Leh+gqvkjZmZgCUO6iSO8bbMS0QaSQ9oRht1klXQPok
	iInjIvYKkZr3gDqBNebzOMcYEle+tW1CtzbvpDVoMzaLPGFs+U6jjSd7wqrHrk5B/l8Ah9O8NO9
	jwgX+8Yvos8Vm2/Jh++7wdc5JJ0Eamdzeg6uFmDuLZtIJ7exyZrRbu5RWjxa+JOCKJ3oVBKDNFx
	IyJbqx1d5Wtfoh3RHG65M2Ym0rIz4ahk=
X-Received: by 2002:a05:6000:26d0:b0:4a6:8012:197 with SMTP id ffacd0b85a97d-4ad5d5f9320mr30278129f8f.2.1795577287400;
        Tue, 24 Nov 2026 19:28:07 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:28:06 -0800 (PST)
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
	Abdur Rofik <rofikcoga@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/6] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Wed, 25 Nov 2026 04:27:57 +0100
Message-Id: <20261125032802.8460-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

