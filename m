Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190095;
	b=LRrJeTgd/5vin+Z3CpYEOwMFsG46rHRYJc5iaVfFVmJdKxnEUbTTChOTfJZfoPGRPfGM
	 9lxcXahgK/jDUUjtX7ChLJZEgN+r5filTr4K2+ckDHSjPI/hkVMF/W6fG/VWf52LnKkvR
	 1Ajjw3fUtLxzxntHx7LXc53AhoPP7lgdONj/JMmIjqN7CBBe/8NDTUXrqmkga5hMR5jMs
	 7dKsGD1JWd5Z8o5hxrEOx2eQenv13rLr8KM9owRsemU/ni3KGgQSDDEn41PogVRkx6UDg
	 vq9siqG7h79uq4E4ukxz5gANSAjRJ0XXeJ3LoJEnJ1Ic/f8EMuBIGbzrvHmqv2uOqwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
	b=tm0xktPt8+pXZ/b/CewskWRj4Mgc7R8iJR75qEcy0hpl9mfrh/S7x7Q2NHBws2q2U1pC
	 cdgojjGYxd1uCLMpGlMpq1x/3hSvKcaL5aqzHBntx1vMg3tcyoXbmq2vmmpJnbE6YaH+g
	 xUDM2wNKI/CYUAboqmOSKjm6JahBAA5g9ZqFub3GP7Iro0n1Le+DSgvhwwrO6qMZ01Z9n
	 vAGtj+LtigrSMQYPAArYMUg0t471eDDC/nYMa0Prl24HlYvMrS2Mikfzd+K+TBBlI2Kx+
	 /uC9EzyfcCZGikbM7e4SzL2VJkfnWYc00nqFJVp48NYv4oWW0R0VWg23ohVF3gW1FXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9ymzV1n;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A1606A33C
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64A1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9ymzV1n
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso9856175e9.3
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190093; x=1795794893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=C9ymzV1nmJJShkya7UcSKR6iPDN+n6RuxSd56u4zS4owB/0cvJp3RDW67ws+Gmp9Oy
         JxkSDl1mw5dfJV7cYJf1CnuPNq33/dywYRPcs51Z/1PqES9VB53htY2kCtrGZZHijOLx
         teyhPFNnnKYqEPMEQZo5lIg+/YPMVhfYBIqmI3bq4n9ha6d4mIcSse0j+8r3/ZHFpyFr
         WeiAvffXOcPc1haHpB4IMFkmCXmC9Y4WOziIjRLOEMZil0DiqeOpJQF98Br5cMKFdLjB
         bP67IuLd2gKNBPlgGiD1S+FbgLuFU+Bup66zVZR6ib61yBQMSNyG+iFQHkMB8KJy6+j4
         eDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190093; x=1795794893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcT3yZc29jCRS7MnDgeTGGcWUyCQ1FNb6W/JHHtK0hQ=;
        b=C8OOKm13/94Qs2xwQV4Qt3F5yH60xVu2kE+LVUyF7QtPzvA/1/I1TxNtRhKvOhTbEw
         rQ4yFC2+h2ExyQ5Q2ieySdyJTOMB8Z3+0KLcGmEAZR07eef26YC3b8NglkGmzr0yD/Ax
         YKCrUO93kdX3PW8WHqjMHOt2PX4StOLdGFxlxNSKj5fozhTwT/3awNt7f5IzE5TkU/Wv
         gCt98rIE6wlYuevd06fQzkT6oEowRhtvwFKTCDSb22cZjm9LhrVc4YP5+1862HQwC2lz
         1izYC04lR9j0oQvD5uuAqC6P220QITN3FNfvO8LxOprbuMz51jSiHpITBei+TrxZewlH
         IINg==
X-Forwarded-Encrypted: i=1; AL+hErFp1HaXFI+bli1C4FjVlaX/HmCLqn/acV7fR4YrFpAcvFF/TAI7FzZ7idW9v0iUKvf2It207gLBM41mTw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NuCfPraOXdpvIcDfWoEHgLibPSEhTYUZ3WS9tRP4neuNFr2/B
	0N90hNW4dSr+RCl+3gIFmS86JxiYaDJ/CSz9DMs5YPasTE2yDKSz8tN9
X-Gm-Gg: AYBFou3G5/NlFq9AmTlX6bpuDTEG2zDKRqNezWyHnIbFru8bI3z/34m5tDUHZWUbSoQ
	3tmIHaU+EIRHVSQUE99yQqfaw5i3uZ4z1XPRc8oIRMby9r71uIbWg7itJBSMrA8QIUsiWjgjBC3
	JzFyfzQdnsj9nOSK83r8USpRzmHU1ZwIg+21v90XWq8/8KzBINkDOZ6oxZf1unG2wixeOkfyi4H
	5a4TQz/TRaoFUzRFAuWJEtFz6uPWbTI6sNNuV+su0ma7QSrkl52JYJYA6wgx0FCkEjjcISNPiRZ
	3uNAjTT3+Zs9k7fi4ecp2GwpOB7tnC1cxQLHBvxrOQOnMY5sPe+ez/rHHV1uuf9IbdZp18S3JOt
	MvuNmhwGKsLV7QZ0n8OEmHOYpVIOPT3jPlXAHXLshQuT3kJZDEe4GQ3sKDip/u6n8QjEQM1FhJR
	AAiDs2UNaeYejk7511rlA16CQOnBCuFbozoTWfTWum/jjTZYzMrBKgGfoYiYcy5g+OPAv6qsVQS
	s0Ulw1om98Hms/0BJwzi1wxjiX5VSDU0+YKx9i8iVecuResMnaCwB3aOfCAtfaAKRegf0I5piHH
	wnN7WKOonpHTUBDd8UvwWxJY6liNDHVFl95yPBx7MKjsz0FcanWWHKaqHdMrBtaThpsVbQUb/Fk
	=
X-Received: by 2002:a05:600c:3547:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4bb88809795mr76390745e9.16.1795190093061;
        Fri, 20 Nov 2026 07:54:53 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:52 -0800 (PST)
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
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v5 01/10] dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
Date: Fri, 20 Nov 2026 16:54:40 +0100
Message-Id: <20261120155450.7719-2-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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

