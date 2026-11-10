Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794277973;
	b=Js5QKaOmmSpAs/RbVqAyFXxvMUZlX1II6EnqQ/HH3By+Ocn0NyFWXtxMHDtaeTcaifZ1
	 UcoCMBT3Gp5WVlVbAlZQ7TGOnj1YcGEWqszeZiACoxERxJQcCom4jmbdAxjH8rg3LzIIK
	 zra5N5eVvSyaJvIRglUTBNo3ti+qEFYjwb6TFKGaExBkZfECU2lou/YQAQoL1UNu9oUyk
	 40OLV6DltMyNZ5yHzLYIkwdBAKE5XTxkI3H4SqenlNWEHV0Eagm1UWKxDtliXS975xWRy
	 cjinOGuuDeBK4e+gh+p82ScTnDIBroJ8aonDSqnnxTQ+B+RW5NeknXNSCDa+8BeFwPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
	b=RNZa4JsNPQpoIJFfPQEnOUI1c6AG+NBegHrLA+3SEDAOYg4SsxMdY8CJ87pWIXfFZmln
	 sdQmx9SWr2AZG6Dmky7ZiFW5nimi9r1+B+qP1VXGVnIJ34xIEzeSCTshLZJdCJyI1KOVV
	 gxOrnLr8NO+Kj+83fRlb2E2yTagSu75EeoWg2tPOiH8I/ZF85bvmvqJc3Sk5Lk7G6ungf
	 nDScPvU1DRRdea+eZ5cafl/DgC4RlKmujeTtdDbb3TWPxOajtWqZ18LhQVjP/x1WJpcld
	 5crMfHL1lLhr9rJMn72mu50t0VING18Bidy9XQwPhNTBIJm9mUu4MsbjcmG8kKSmqhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6B606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53C6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kN8usH9I
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so2012775a12.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794277972; cv=none;
        d=google.com; s=arc-20260327;
        b=qqxviLd2efBtqWUU6UTr6V3aDYur3ouJQBcguwGDYjdYS+qNvuU9LMQHkfLPuq9Qds
         HGF8DlFdU7pvbDnwRB/rqBwjT+Yma0ipcQz+RYTRA5fxLqEGPxm5H6zpdqlTUqs0cqo8
         Z7ZMF1+4k2VXJneg43WlX2CM4BimIDjXShtTtyNVxTsANwAfNsVHIgfwY7MxQsvySH7g
         CGUfpoMtSmapnRpg+6+2tTlk4srnDm+bbNB6Qwcs1vLKFoAUp53Q8qOCUJ2jZu9dUoJm
         XK1a2eh2f/04Ckft9oerSzXjBdguhR+YlsLH1yW+sZs4iDotTd4ROxS68y/PVImDyYJJ
         YctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        fh=hQS1xU6lO8uC26t180K4E859wxipZZ5x+ddCY9jXcMM=;
        b=PEPW9CVsXovvyOO7WxEwvxXMwdNSjTFwXCQjK+oykeb/5dURqj+M9v4L51LUdcy23v
         ZyjDuRxfdt3vmoSacLVyj23ncIC9Do87z1XfWkNZsV1YW35/nky9LoqjHss4w48dbekL
         g9ALacjKKjvYsa0k0CnbQey+myFvH3uddZ2MznHeaIlro5onvTuZOGhD02XrA/cPVM0b
         pf5OJREUVVqZaT2WOIli+DzEMND93Xhn3W9lXRUgOaxB7r78AG+HDXLGsc0u3zIwDaXR
         DCH/yfLbyDEEZ0gu3c2i1pTRnCJhIiCJ8hMzxD9ObJl4cq80AxYJsR3VhwbG6vhcPksm
         EC0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794277972; x=1794882772; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=kN8usH9IU49ojTSFWxPbJVZ+ZPL9HfmyxBuwCulgrTZp/vIkQ2G69w6Y2yovNv946E
         bJzgBQHvSOFygF+KiU2KfzjtI0OAeGZi9VL3lKD+AvhAVGOQmot95xbnAbg2A4CaqsCf
         eTZ8KFJ96l3FwkAU/lwTHaXnrTtHfa2PYj99p6cQOQJSjiD4KSRMNhMDCcuyLBKNz9Os
         tSQbuty+GYOY4ZQ2vek1GcljQVgKSwQkRuubGXyLCTQolhUdTNTRmgmjxNwLUn2vfeXd
         12WP15h/MMthSPTaba6ldVBkatiFdKp89KUiyAAfiQLjEErfYKq0VKNkyG5HIpvzN859
         aeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794277972; x=1794882772;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+UEXnv8sO59biXTVUGJWsxHSY+X/qyvekpO21DXG97s=;
        b=ezgtIK6JCIhPuxVyUqX6B4kGQpTRS5C2YhI1hRo8cytBh3VwBY3t3se3Ddfw8U3ZBh
         rRWN8Ks6EFlQOSP11Ddf93LClwjiHg9LhdbVfQ10Caenyz2kG4YVrIgsX+ZRp2A4AvEI
         s9HbaFkOOT9Y20lMkZeQ9Gz3Sa2UtJ9xgN4P6/H8U1l1FFn8xnl2Ha2rbCNrd5UC+Prp
         W73Ua3OGC0UKwmMyHPr/AHHf6HJAFCvzoJzMYAM6GdSNOy3B90VUeGDHxme3Umy1nUdx
         uH5xI8WG+83SZrDEzOux3f4TTeztuiHzluWRtVmILLzA9b22Mb0U1AxlwQ798SSfV5rr
         k/rg==
X-Forwarded-Encrypted: i=1; AL+hErG6mwUuNRdKoi17S2oqgPrlCpuBdGmRji62ft4zxgsIHA8QQG3ighdITAsB951T4ihjzqDdtG8/iAFU1Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8aBLS0SCkax0c72RCvjKpxwee7DCazzq6LGvpVjun5zaE7MQ0/
	tItJROO/Sa21ky7oCbJxnSYdtet2l2rb4mKtjXoOHF7021ye4jsQKUwPhin7q3lM4aTnvUy1Mxq
	ghYMrwMSn5aaN6msuOG5BgEu02Nfu9g==
X-Gm-Gg: AYBFou0Dp+qyeU2XcmgOrFfH72WfcUjnyb3EKltFBqMtxlDYAkGzeV9r8m0+sYd7jJ8
	4Twteq+eMKAKk7zwNpN1xRJhWLJHd6o8P0MRr1waclL2rDn6ajAwPu39j9JkqPBIrKkYx3K6bXv
	MBzqPsmY3Q+8CM77zvguQUNfa8tlhV0m6Ojdao8fmIFROOJ8Wea1K4nVLyyxN8gJq8QH3EKXNMK
	ckQPFW34jKFAWR1gpttmoa5Akjg2Z7h4X/gwPhEH8i5GXQZJYYSPIJlHIio4OiVM6pYVuPpuVWm
	91WpMWJCGkomdUsO18zGKYYw7BncBTBhBXIor1rFtTQ4JShNDn04fT4N0QwRKzLFj8bsV8rAF89
	QRtJxrvkXKtp7Lfc0Jun4vgGm79HnJsIPA7yQTikbAY4aL3XzAqWWP1FRXLV3ypIrv5Nr9OJS7A
	1sl0EeR+DLIOeujuHHgWccBX+dkdyAHBbIzw8WUhXEid03
X-Received: by 2002:a05:6402:a507:10b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b7568dc1e7mr684976a12.22.1794277971764; Mon, 09 Nov 2026
 18:32:51 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 10 Nov 2026 02:32:49 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 10 Nov 2026 02:32:49 +0000
X-Gm-Features: AclHuK8AIkgNRXamUPSojUGsIPAwgEr26dHrd-qWTZA7kFbE804fLktH5iFVef4
Message-ID: <CAGEsz8Gb=4JS4OAFKppe=LW6JYa2ssJ8APdJJX2Ou_BhzEvZxg@mail.gmail.com>
Subject: [PATCH v2 0/2] mfd: wm831x: Fix IRQ mapping and cleanup
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Ijae Kim <ae878000@gmail.com>, 
	patches@opensource.cirrus.com, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lee and Dmitry,

This series fixes WM831x IRQ resource mismatches and follows Dmitry's
request for managed onkey IRQ/work cleanup and MFD-provided mapped IRQs.
The provider and consumers are converted together to keep their IRQ
resources consistent.

Changes since v1:
- Use managed IRQ/work cleanup instead of storing the onkey IRQ.
- Move IRQ mapping into MFD and update all platform consumers.
- Reject failed mappings and unwind consumers before removing the domain.
- Retain polling for release detection; the chip only interrupts on assertion.
- Drop the previous Reviewed-by tag because the implementation changed
  substantially.

Compile-tested with LLVM, W=1 (arm64), for all 11 changed C objects.
No hardware testing.

Previous discussion:
https://lore.kernel.org/r/atJycIEnUZKVdTjW@google.com

Thanks,
Myeonghun
