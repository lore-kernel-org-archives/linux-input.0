Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D9204C36
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168260; cv=none; b=nr+mpy9FXQTLr/18y7dIAv6ZOfPaqwO5UmDqTbhpPY5ZhONvWGVRCbc/gf7ODoZzW6rD5rEt79GAyoPTh3fqwuWLhTCRNRpKR7ZkeYzKMVEaQi24BlvKynl05zsGC5lP5QC63TRUPhRwGOBff13NvrmGFZB8AfbyvdQNVlbkwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168260; c=relaxed/simple;
	bh=Gh/vEJU0EGlJkxcWfGReC2v+Rr4CHg9KxV1K21dLdvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gCX2N4x2wYz4Qo6KDz7VBwr2KcKi3U78UupQMn3KytDI0nQbi7/PuZGoUz2nltRisy0X/IbI1jVVXdD3z45LQINcOUNlwZbW5i1iFiTYWnGEBJnjVdwjsTUrnnlL8rLyGqo2ZfxkC3TDdRii6g0BfViKtMyoCcX6xeoMOmXAOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDE2h4op; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDE2h4op"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so10720915e9.0
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168257; x=1775773057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZvfE5Xh6joR2Ps2HxBC4h/f1h6TIhRJYVGLkpiemiQI=;
        b=jDE2h4opXDIq+xmxiTtl5AORWOMoBfNl06v185XXs0hEwWe1ouaYC8Jk0/XECSesha
         d6waRQlDlQndm3OUDRNoiPYRMWnDKrR0XvNzuI1WpA7OHky/uFQak25TNYvLrcvOKvHp
         WHzNnKoKV7C+Fahr05KrpDX251hDzZccmaenkqa5En8h6uV5eSH7a3h/HjnEjpVOOQ4L
         j9he9aHsXq0H/YJPOkHcxgSgwKtiCU61uRtajkAoVrmOwT2Uv+Hhu0nGtKlTKa5lNogG
         4uiOKPeLD2ZrNtv/QEEGj7F7X9WJW+Zt43ri/rejxOqJnULGnaHRLzP7sFiF7GdmzGKu
         vsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168257; x=1775773057;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvfE5Xh6joR2Ps2HxBC4h/f1h6TIhRJYVGLkpiemiQI=;
        b=dxHpvpwATp/YTqSJeUTiqZQ+LbLOPuHVKrxRipUzN7XWdHXkhV8O0VgjIqknj9NDxA
         CsbNZjKLzuSQRaUDbmxcOWe8wYBB17B93TBx/yDI9FECgI6Ypr6dKMJfFqZRtTCN5bJJ
         qvdSKsk5l2EDdyRDortAXOyG478K34GnaALheDg/POoTAUJiGVeaKfwNeb4ibHsKd8Es
         tPu67xsi4pnKbh7HzJi6CFwFrOC1xHlDI6S/bVNo447/aGqI08Ijjq9qU9nD77DHl44z
         Ux29oK3Pz5aM3aEKHr8j1WlFnB01aC8YUhJopVlnvk/gvCfHtGvn2YXiXwuwIZ5ar80g
         6QIQ==
X-Gm-Message-State: AOJu0Yw/72LAdFMb1TOfd7193VN2GlOAyE9DrdbsLlP+gIvUF19SCUbO
	bsjWgwZ+RFjRuP4etUmhoqvaRHVOdz8nWVpIY1hLNLfFX/3E8KZk1ANe
X-Gm-Gg: ATEYQzxh7kWbh0MrhvvvFY3g6NnQsm+XDhHqCGDO5JMDt6ot0aWqcNXgBwIgxG1P1qG
	RvOWrZXdpzap7eYKDfLWFPqLFhPtXu0d5y3uTWTwz8ZPdWhA0rZ5vmoaMY+hvezLKTz8zw+6xQQ
	jrgP6D1Xh/jXx5JBE119l8zyr/Hjzpp6rGfv5fHwdeVzsjtcCrT/P46CWTFkC1I95PYlGoP4/L7
	PNbsc8rmb7HPV7VEmapE70HawwppdkHjGIDmc3WZqlykLzoawyHn0L+eZ/M8e4zMf/5nJkyXK7T
	wxCtZnw+qoo4cM7+YiprQPwOho3Me/spMSRx5L2odtGrSrQiZ1oBUyQZJu9bOluzZ2BbbV+B9z8
	vjNaWLFJYvoFsSTNnYzAPbKA600pKD1Pb1H3LzAqpW6/SrCyiovxKp1sSNhvdbGNn6QNaW593Ft
	N/e/Bbz/ZQRIYfZR98i45KtH98NlPw5gQZBx+Bs4AeXRtbfbhAo2h3iCb2qfN3b0uvGKUeyZ+X0
	nEFu3lNmU2O/D/+XpFsVCQ1xtH3Hd4A6OcrSwBAR4Mwx94t7yU0/7qFHEqfcv2HSA==
X-Received: by 2002:a05:600c:4743:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-488996ff833mr10662365e9.10.1775168257032;
        Thu, 02 Apr 2026 15:17:37 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm363895755e9.2.2026.04.02.15.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:17:36 -0700 (PDT)
Message-ID: <cf519463-775a-4d43-be38-20742fdad407@gmail.com>
Date: Fri, 3 Apr 2026 00:17:35 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] input: pc110pad: change PCI check to get rid of orphaned
 no_pci_devices
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Language: en-US
In-Reply-To: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As a prerequisite for removing no_pci_devices(), replace its usage here
with an equivalent check for presence of a PCI bus.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/input/mouse/pc110pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
index efa58049f..c7a6df210 100644
--- a/drivers/input/mouse/pc110pad.c
+++ b/drivers/input/mouse/pc110pad.c
@@ -91,7 +91,7 @@ static int __init pc110pad_init(void)
 {
 	int err;
 
-	if (!no_pci_devices())
+	if (pci_find_next_bus(NULL))
 		return -ENODEV;
 
 	if (!request_region(pc110pad_io, 4, "pc110pad")) {
-- 
2.53.0


