Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63532C957
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 05:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426439; cv=none; b=GhG+WETyd4GL/svLv/CF8QyDFm0cVlITqBY2fIJknWHINRXZjQs874oIf/IjtyIHPYtndeuB0ek+qi7jX6JD70HnGt2I0A/glzJIAjCBHwyReZUkarzllapyT3o/vSEtfRYIdWfYGMo4PWMS2zu42wyv1NOgLfh03+XALMFcVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426439; c=relaxed/simple;
	bh=b4ruh6ckcqyqTEbMsQ9Z/bHfP5z5BnAV2NXb1OQT7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJ5lCMbbFAGyukHZPmpZa7jBetDv8IVFw32fS4B6i/gwSCWQ/X2Idpch8awdgFaVRqBtoDNSxICRmfYqKgEM7xUglJv9y+eVDzTWsUrJpa5AOhX6P24AT002TAZ9VTjDioWsqc6XcpN64wtFUdYr39HRmw1kYg1ccskdmp7+mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3664df32e91so7538478a91.3
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 22:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779426438; x=1780031238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xF8szAxR2rfuGWXV2Cx/VDqoAjq/XwuZo4QBEhRw0U=;
        b=ACVTX9BnsUz8LpEkcm1YLNR1RQkEbpDo8LZnXIdXlQs5H65oJucfa3QRgh28hyemwc
         EbacDlxqEVWeHUMPupm8mzFHDs49HbUVZL895OXtbA+XTRJwwp/H7jbPeC28ee2qkAGk
         m/GY/hGjd+GexKyChaF0ABD9dSXbJ682I7SlvnOTw2w+pn9jRl4e0Lr4CnvxEjFxw2ga
         PpRdsgoShXpHLw/g01SkFDZ7kYKEe9Vpyk+xRa0XYkgR3bNZ8A98e8iuFcVYfVD44ElO
         kmsdl0k+nRmaVw8OoixJJF3+OE5aCW3yVdx8rwT9wBS4BykMY6LF99eNKTtv9RkDsdGh
         DEKw==
X-Forwarded-Encrypted: i=1; AFNElJ8BDDa7SYJFkJ7s9bhdwL5DmJLKZskOXQ+T2xDk1rg9Vvwop0YB50uvK0Wzq32W3VTZGaWNQ600s5KTjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6LtYB0I++t4wBQan7EqjLN0XR3Xm9w0VF2+zWgVAYVZVtYfb
	VnHYc6Ahqnj5RaPSx5QAN1OhYe6/ziNkshkK9J3opmuGeLSFHOFm5CXk
X-Gm-Gg: Acq92OH8kvpP0r89A6/Ux7s0mACpefvoV0Vu3GZW21XrXXryTEB8cU6XwUAMV0rMJr/
	HP2Urpw8od20AsVybDqVYDLvYs+xGwWaE7MvRxJeUjli1pvlysaXVsSxlYaLi6cwqa9DeAo+LIK
	kZUdS69oNQVp31pBN9EH4ZC/r4Wfi1m0ZbS603knoQ1g21d2Ix+0j63JsLeqUzbk+jzhWBfo34+
	2KzAPh9eufB3fx1/EbpjXK3g24oEZIwX88RdhAX1XYS4UAWg6Bs/ORTgbQx/uxNvTcU7NHOpm1u
	CUunot2i19wgsI3vQAeUA+dmD2BrXRvXIwHrMdJWA+epRb4/ux+klP2cDxLQcV/PyJ0JKC27sRM
	dT/QbxmIZDtBePdybyeyx5picS+6wtD1oYN2YChWW0m7uaMAegG25GjImauXbv0T1LMuw2rzNyZ
	qIUns86qQDyt3sPUO+7EQLaQ1AfTjJVBrTWPG/tLhBCMigpRb9RYgkIkMK
X-Received: by 2002:a17:90b:224e:b0:368:b917:79b9 with SMTP id 98e67ed59e1d1-36a67658122mr2222697a91.25.1779426437790;
        Thu, 21 May 2026 22:07:17 -0700 (PDT)
Received: from fedora.lenovo.com (zz20234032476F6CA7C5.userreverse.dion.ne.jp. [111.108.167.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205855dasm367615a12.31.2026.05.21.22.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:07:17 -0700 (PDT)
From: Vishnu Sankar vishnuocv@gmail.com
To: jikos@kernel.org,
	bentiss@kernel.org,
	derekjohn.clark@gmail.com,
	mpearson-lenovo@squebb.ca
Cc: vsankar@lenovo.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishnu Sankar <vishnuocv@gmail.com>
Subject: [PATCH 2/2] HID: lenovo: Use KEY_PERFORMANCE capability for ThinkPad X12 Tab Gen 2
Date: Fri, 22 May 2026 14:06:32 +0900
Message-ID: <20260522050632.8079-2-vishnuocv@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522050632.8079-1-vishnuocv@gmail.com>
References: <20260522050632.8079-1-vishnuocv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vishnu Sankar <vishnuocv@gmail.com>

The X12 Tab Gen 2 emits KEY_PERFORMANCE via Fn+F8 through the raw
event handler but never declared the capability via
input_set_capability(). This prevents userspace tools from
discovering the key through evdev capability bits.

Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
---
 drivers/hid/hid-lenovo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 35b00619f045..3492ba8d0fb0 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -1525,6 +1525,7 @@ static int lenovo_input_configured(struct hid_device *hdev,
 						hi->input->propbit);
 			}
 			break;
+		case USB_DEVICE_ID_LENOVO_X12_TAB2:
 		case USB_DEVICE_ID_LENOVO_X13_TAB:
 			input_set_capability(hi->input, EV_KEY, KEY_PERFORMANCE);
 			break;
-- 
2.54.0

