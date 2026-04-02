Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B13BD25E
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168139; cv=none; b=W7LudZq1JMgoX0AC4098TiCebs2G5jT4+xL/2W1aUKX5ZFDww6Zfw8OqYkDvkzozUutvYv2Qxy7EygRsBacH3ADMtHkncRe/gWO1TeQwOqIiEMAbCQ62+pgMXfBeXXd66vZ1Tj8jJrpWV0RWUkTEBOYxRviLShuZ1TzAyUGYR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168139; c=relaxed/simple;
	bh=y/cvq7De8Xbj0KCivfEiUiK/1VFgA0tgg6/tAffifwU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=eoZ+h1dJiuUmtRPVG1VXRhzipShzV3H/+9lBPvJ0nMJIkqgrtxxfgWqjqRO0DVbNgs5wK5KB0s+THIt5YNUpW0NHohlDiz5qlPogrDnXa/rPnYc9I/JfrInwf0skVBDVsy6bGViL1vC1Pgwso41JEHUFUwoCY/EStwb1f1DLL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZL/yWcW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZL/yWcW"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf5fbacc9so749583f8f.1
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775168136; x=1775772936; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNqja1PvIcdsWjrfuwMT/5/0BCuTChHmcznmKRTrjr4=;
        b=BZL/yWcW7GD7YJS4Hl7imJCr27bDuDa/RNNJn0pJp40OSON3AqlNt/fuyumkT7qkA4
         FO+ckwsZa+ZANvk2wWqJ7tiZRx5MsOttTHHvuUeEHfHfp0jdXgMTZa9ujGubsL+zCnOc
         nmhzTtGhLSwgMoOEqfRGxphHQ3CP2JMkuHa9/w1ZCX9M04PH6fL02PXJT682KjohVJkM
         TFGccxPHvq14+IT6bkKYYXMoKt8Z+pY0IIB5Mfn8ZBgihB2ecjwTb4KkL9BtrDHsYAin
         BnIJBxAYcbQQkKkP4/r3GffOqrF8+tL5Uv7ZRDh3tQ2Z3YfLLK+OjKY2JNdrxFx1veJ0
         Fs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168136; x=1775772936;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNqja1PvIcdsWjrfuwMT/5/0BCuTChHmcznmKRTrjr4=;
        b=h5VfVm+KofeFgcESVKohm7xMHZEhlYD/MAS5OTjTXikT4M8Ozn+vu0zVXEDm/K2VPw
         EZS31qnylhE8CyVyHU5JLTSDcOWFN0SgUXW3AlAq9IftfhdYWNUy+rTuDuP0aTz4Ofw5
         InPhvpOod1qxVTjKVjOtDE+dN9/Ztma5kv7VvjOI17zloKZ4dJo524lkat7FV/JCowIE
         SOitXhH4DsFS1XmIB4p/ylBB20lzHGnYkskjHUIThtXCWIyaSsmEyBXYmz61PKxOLkfV
         H7YspPNaGR8pEFKQXfqkJ0d4D0WQmTwp6l+DlXXlyI1y7gR2ZX/1Ms1dZq7zmbAs+kXn
         svFw==
X-Gm-Message-State: AOJu0Yw8LJq0YaNuB1d8LIbSQutVwTXZdrt90T/7VL3wZV12x+c4r3e8
	D6eXeWG8UZ8lOH4SJKvutjbTPiIG4riQnp+XdicIR+JBKE8tf0sgi5TN
X-Gm-Gg: AeBDievyxnInqw7xsJEAhWGqPNkXygFKhGgssy5nqizn3k7z4+IoCN1vgUWC0VnntFY
	W7N0PqfFbhIa7m2yS/9qF5mchykyMZEK/PZkOlW7q57b+hQclFyGqdLjia514iJ7fiiNa9DRlOX
	YFV/GRYhXHYzhwDAvXP/vda0bG7erOiK7llge2gtVb9W1Tk/P341FnLAAHGN8TnvKoA4Ajm8t5A
	TjEYsMpKl/RwrTMcm//084wNmNHGjlV8SaKHzobu7IHRQc62j5vtFLnhfo/A/KHAuViqoNygpbK
	fL+GLvSRJcw3Nn6ScMD7ciiJhGIhci+4w9+EYbeiw0Iu3XBT/5N6BEoLC2o5qDqC3Bm+nEOT/Cz
	1S5SnPDPVAa1WnBakubzF+jVtA1x9bxxiV7aYxF+UbpWXRbY5GtjpEo0GdZgfu7eLFoPF0iofn2
	gJoQ6om2p7tyja75JAF+m1bLjhVSdfoW62jHiIB/tvbiZygPus4cEmXRA6+6yXaFfC0ZPXwhPgu
	YZ9TdzNLc2+zcyd6c4oGH0VtceEaOmmioueT0YOqtTJOGF6NakQM4OeLu0MK3GFJA==
X-Received: by 2002:a05:6000:288b:b0:43d:1df7:e3af with SMTP id ffacd0b85a97d-43d290f71ccmr1472473f8f.22.1775168136279;
        Thu, 02 Apr 2026 15:15:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f19:9500:c168:ad27:2fdd:9334? (p200300ea8f199500c168ad272fdd9334.dip0.t-ipconnect.de. [2003:ea:8f19:9500:c168:ad27:2fdd:9334])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm9662990f8f.26.2026.04.02.15.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 15:15:35 -0700 (PDT)
Message-ID: <dd9ea7c1-44f5-4364-a3d5-885b1c99159f@gmail.com>
Date: Fri, 3 Apr 2026 00:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] PCI: Remove no_pci_devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove the last user of no_pci_devices(), and then the function itself.

Heiner Kallweit (2):
  input: pc110pad: change PCI check to get rid of orphaned
    no_pci_devices
  PCI: Remove no_pci_devices

 drivers/input/mouse/pc110pad.c |  2 +-
 drivers/pci/probe.c            | 17 -----------------
 include/linux/pci.h            |  3 ---
 3 files changed, 1 insertion(+), 21 deletions(-)

-- 
2.53.0

