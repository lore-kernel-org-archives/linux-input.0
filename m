Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340050;
	b=KqPbYnHvxXEaRG8cfDJlhpzX4aTJsxWSW0LytM0YQ5cCmhg9WL7QdgVh5lSf8PHU+jCg
	 6oCAruzf5tOFSQRhUZ0+P46C/NkcXSKeIjZLT38dKkLdkAjbjBm8MZqwahYTF/3AOOmeH
	 8S+yxeoPL1186dRAQaAFjw8urGmua96f2evacrgPOLu//+1sDLVBeOkRgVDUKy+8R2h4t
	 DUJjhUMuBqZ8t5pVnMT36GCZSXRL6zZrNs4sEYcn/2z4I+FFC+ufj8mHeavy1QTIOifKH
	 iieg+4BZY57pkr4mUFRalQd7CKCnPVeSHpI1NCA6+KyddLyerWgWWEr5awFJGTkD9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EMGZeiHC1km9rdIIguTSZBczlbZkEbh605v5+C7/h1o=;
	b=sb9nePUA6ldbkgTXqYr1prByRdjbiynZzQnFbBgxjKuDW9rSgK2lI6QOQ6Dsqo4D+orn
	 z5DfRzkf5n1E0u/NsghQj4a8r7L4VMYF7kXokBohc5Ot7RmgfYVDkz6pws+tVBOdqOXxQ
	 JvlE8kbXWeAdQGgt4/VHzVAfP3/POTiUa+yzobohzSe6jC8CWna6YBDUkJn8qHoHbHTlv
	 8x8zaVODtlyMhm7UW4sy493MyqbLx5PFRwmnhgUmftNt2awZMVRJhKm3xBa8ecoW4tpUF
	 JxQDCasrzSHnOQusB4euwtvzIQH3VGRiDPCpAUKfTNxrw/xJ6lz+e89bsr+Z3oT74QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B6fhYufr;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD850606A330
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 09:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD850606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B6fhYufr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so2167189f8f.3
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 01:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795340048; x=1795944848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMGZeiHC1km9rdIIguTSZBczlbZkEbh605v5+C7/h1o=;
        b=B6fhYufr40VSF2/kzijMbnYxB648vZ8pjssxb+JPNuhijzjwKFnrcuFJ4CIBls+tKz
         PnrMNTTLa/ddouxB5hpm+9a99T37Yz3QKh3u6vu2fjlPDuTW7cOEJndzgi9a61czhR8V
         TxFinq+72O3dRH7BxXu5cT9TU2WiK9Tbpc0wLcqFf7gEttly1dO80Fn/IONv5Z7/HXBy
         v8zAc0ZguLpPv8mwf78oKzbOudYOO2dA7iSGfdxmk5elfFEVMwdXTeSyowJNf0571g/4
         RrmeG4UICtXTfnWk5nojO3ADd6hMV7aGk6xfHmWStRN37y/V6aBeTT1dRxfMZSOW0iFZ
         41Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795340048; x=1795944848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMGZeiHC1km9rdIIguTSZBczlbZkEbh605v5+C7/h1o=;
        b=wK8HVj6cIKchxu3ngjUj5V9Vi7kmpp1qE0UloxXgbAG8Wty/Y5RUnPPvplW45MO6+K
         PvBU8MgeE7Ik3hTu/Zj9orurIYh48HV74ZqUiadgF3N8Ir7rZ+w5kPVMFYjgeqTaLCf4
         BTVWZU0BHqNqNl7r1GWPBnLY4Ztd2DZFXVUDVM++75tKDvj13dM6Zln9cT3GAKL0NG51
         1hwoHhdHdgrFJRRdu1hMIFfA6qyhV1KSs4L3SczFQx+Grequ66kQssXR2roWXjKqy7ZX
         oQ7SyMoR1/dxL06eKQZUJcyWWIdK1Otllo0Vkyffl9O4IvPoDToYD7Sq2yYmQJQHB2PQ
         DwBA==
X-Gm-Message-State: APuU4Z+2uAM9GFVIuif70/SwWWnfiE6x942HOC9YJSMlTII6HLir1Ig/
	JDGpFSi/TwfWWgWRwICfOLDO7t8PwSxhxZP9qnAgjucvjDIVTshV60Eva2JlIOL3s+o=
X-Gm-Gg: AZFdTZd68wV7pEE5U9QD//jn56YPVNOdXxLKSgf7gkKghFk/mOXn8DlnrLwNa7Tzs85
	OVlJz8ztHxBPDpQ4RxaVIL3Zv0krsejKSjrxDU6WoQzqOiQ6Qsl7gEe7iyKjIGRsHNVke3vJc7T
	Dl526J7f2Aa7rkYsLr0nGwlmCc+pYYAPssR2Ew9/H0xlFl48UK7et+hIFJfPHzw3Fqm+mvwp8Gh
	Om9mLcXQLBAuuEtMmqQXsG/1qIJLl7zBxThL0hW59ZbHvi/KctQ9VRoONY7Sw0EcV+aAKsluxbS
	BjS8Z9gsKZM9Q+6kViAxGL02ZYiZh3yTS4fN1tYuouwwd+IyBXFizJChgfAKFb1AisGJpIg6M/8
	uDtPRqCQZ6tQ1VisC0pbpfIK/CN+hCeQEROAjs8eVyLkNEu4g34Z2Dh4dyQyGknvKlIO7dIL2OM
	xgJzUnRbf5zx5X8Y0bGR9x2qBI2GqBcKvOzTmM5lVKm1dTehC/RfGn8ftHgg1tNDiiJJh9DUmvA
	9ogGowVdW1jOKFBpNpGUSzsPHRb8wlJFyLATNNpJsHLL3gOlh3s3VNVYn3yUWzrJO0z1p93EDE4
	xtZNG2Sh+h+fvmGjCRVcxfiTi1dYRP2y5yH8VMDELVETGZpaQXa8WVT1csDbuvYp8fDr74y4Nai
	Gmjj9LnS1N38=
X-Received: by 2002:a05:6000:299c:10b0:4a7:9630:7b5a with SMTP id ffacd0b85a97d-4abb47b2043mr11673178f8f.47.1795340048064;
        Sun, 22 Nov 2026 01:34:08 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm1552848f8f.43.2026.11.22.01.34.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 01:34:07 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: input: touchscreen: hynitron,cst816x: Reference touchscreen.yaml
Date: Sun, 22 Nov 2026 10:34:04 +0100
Message-ID: <20261122093405.70406-2-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122093405.70406-1-gerard@teslabs.com>
References: <20261122093405.70406-1-gerard@teslabs.com>
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

The controller reports positions in the coordinate range of the panel
it is fitted to, and how the panel is mounted varies from one board to
another. Reference the common touchscreen schema, so that boards can
describe them with the common properties (touchscreen-size-x/y,
touchscreen-inverted-x/y, touchscreen-swapped-x-y, ...), as other
touchscreen controller bindings do.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---

Notes:
    Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.

 .../bindings/input/touchscreen/hynitron,cst816x.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
index 72d4da636881..df52431b1d49 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
@@ -13,6 +13,9 @@ description: |
   Bindings for CST816x high performance self-capacitance touch chip series
   with single point gesture and real two-point operation.
 
+allOf:
+  - $ref: touchscreen.yaml#
+
 properties:
   compatible:
     enum:
@@ -41,7 +44,7 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -57,6 +60,8 @@ examples:
             interrupt-parent = <&gpio0>;
             interrupts = <4 IRQ_TYPE_EDGE_RISING>;
             reset-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
+            touchscreen-size-x = <240>;
+            touchscreen-size-y = <240>;
             linux,keycodes = <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RIGHT>,
                              <BTN_TOOL_TRIPLETAP>;
         };
-- 
2.45.2

