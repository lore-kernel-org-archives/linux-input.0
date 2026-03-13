Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EC3D6673
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424657; cv=none; b=kPob4UA/E6H9hsfOkNXFHl/zaWl7AQ5VBEJbd2IlzZQO1HfXID2IRj9VB3WVriH1DNe39vUfKImSngIvbSKyMx/N43I9uiIFRL/LbJjTCuz21dhu8OW1JisXTttdG7soQBN0PQdXoNnNi3ULdnrMJ/SmbDBG2ochtCsQvOcZSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424657; c=relaxed/simple;
	bh=q2kaaDEu1j+d5wDddrGcmzxFn2iMtkGM/0OPERtTVOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Xjl90AKzB6hvTwJ+93TGjwdTGgY5Lo1geulLBo5rTjkyxktHVvMjm6IY2PRpLhGdZIMjBW/QEbaYHZyYYQTBM5h30H8dMXjBYjQt3RIcfRszdIJ92nUjNHXNcSpg7Oyl8nji40otVhCdhqmysAADqExTOVEW9g4D537T6ojUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=XIKXuePY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="XIKXuePY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a07738118so1481335b3a.0
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773424650; x=1774029450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU9uyCO90CsHf0DRRmxxN4oXS1AlNcFHOsvk1fwkujE=;
        b=XIKXuePYLLTXxRzDTi3DAHUvFjG4P37xUYdZvc8zm2u3LzutG9VWFgnX9uGET3hsR0
         7S4w/mxhRrilnEWO9UlmNtoqOt//MXTdTIN4jkQ/a/xel9cwEfOMAX9bffXs0pmG9hhd
         +178BiTVaE6bjWqu4y0pdcDmqsZ1PHBD2xvhVcyU1RYOJq555zwCAFvK0YH3zGrxoaI/
         TIRVlI4cN+987dqGfN3p7wQZU5W/Hr+GkUfY6tz4szQ1C99rf1Fom9wdpuY+45k8wdXL
         QSVmS2eR/PnFOrj08WDbypduBKXNixT4H5PqxAmMSR+pvTrisXi4uR0PpvEijRoONTF6
         QbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424650; x=1774029450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qU9uyCO90CsHf0DRRmxxN4oXS1AlNcFHOsvk1fwkujE=;
        b=RHpF8OVKlR7wgWk6rmhvxFwhWXEwKbNgn6P2xAW4FAw89zhONe/eTUnZK21EMjncN+
         xaVizYV84+1LEuc2mLNOEfIiftxKxaGGSEDimIXnX7yZuDxNdENXd5+LCNz2sRBB+h8v
         x4tqxHU2pPEHsEBcQeBRVjCtNWwm8jJvRJz1oOtyB6yA4METIBpwPU97yCwge0JBqxje
         2F4X/Ge73spJYypnagQiMolzaPBCI5ItrjnDj8tiqoxGZVVyrw85ywCBkqJDfnR6zxit
         2CtalSBcUekinMSa6md+jpQsUHOUCZ5x9UayviHVDGWyktGY12aM12i+NkTY0TBvS0OH
         Hl2w==
X-Gm-Message-State: AOJu0Yw63NninI1Zp4mORe+HL58gCGp6D3dkDNXMR7h42jMUzKLg28P5
	Y5XEtkyVSdB082R49NsEhETiV0D5CschqNgSIavHoQgwJi/7+esnG7ks/7+qzBQGZTs3l4jDtqn
	Mb9g2
X-Gm-Gg: ATEYQzwkiRsN+LVEjL5qUTLnfLYrkVHpMtgF6eqw3kGuaoYwbk/v7NMVZ2IGqiG9jYA
	JLzVu9SrmbVTgOgQ/wk6bGsYYzZBzwWIhbSJRp7zPEr+0UsV1uf6ec+tRahpQxSu0jF0SD8Oypb
	44PExqkFPG0y8ptN3r1SJr5DvDfpsAFEzq3WjE4uI9kk0FDfRm8LRhgGHPMTvTq5qh47caIayxE
	7G1kySnTfLrcOLZbTD/xHHJdlvsHn2XNIDXWgkIxEkzYmRrOLTmcUCk3e4YFsTnaaxjEd57ccBl
	eZ9f+trExmHSQkuoWvaUOY5gHMj6gh86m3xtbWwGM8QvhX53m3qXItslSfFRvPp3++iooWAbwSz
	c4HiuAB5NMOhnBkQhcNM3vzqjcLW7JrpXerzVDVlAhrVB/DoaCZLmpstXNt3+mXUswYxRsUvdYQ
	YCOwhKXFwZNeZsR54JklzSbFki/Z2GyKd4Y2kkiXZlpYsevv8vkGUu2/Lu9n02SknKllZfZHG3n
	cwTXT0E2eb+ntedB9+KEiWVeVPQhtvSBozd4gRWsnBu7vs40rOclDzwyDTQnplPfA3INvrqmyZ5
X-Received: by 2002:a05:6a21:6186:b0:398:b95c:51ed with SMTP id adf61e73a8af0-398ecce4e09mr3767583637.35.1773424649902;
        Fri, 13 Mar 2026 10:57:29 -0700 (PDT)
Received: from nixos.home (2001-b011-0001-3a55-372a-4d8b-a513-4837.dynamic-ip6.hinet.net. [2001:b011:1:3a55:372a:4d8b:a513:4837])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm6265488b3a.8.2026.03.13.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:57:29 -0700 (PDT)
From: Daniel Schaefer <dhs@frame.work>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux@frame.work
Subject: [PATCH 1/4] HID: i2c-hid: Use wVersionID for device version
Date: Sat, 14 Mar 2026 01:56:56 +0800
Message-ID: <20260313175659.268094-2-dhs@frame.work>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313175659.268094-1-dhs@frame.work>
References: <20260313175659.268094-1-dhs@frame.work>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use wVersionID instead of bcdVersion for hid->version. Per the HID
over I2C Protocol Specification (Rev 1.0, Section 4.2), the HID
descriptor contains two version fields with distinct purposes:

  - bcdVersion: HID specification version (always 0x0100 for HID 1.0)
  - wVersionID: Device-specific version number

The current code incorrectly uses bcdVersion, which always reports
the HID spec version rather than the actual device/firmware version.
This change aligns I2C HID behavior with USB HID, which correctly
uses bcdDevice (the device version) for hid->version.

Currently wVersionID is not exposed to userspace at all. It is useful
because some firmwares use this as their firmware version. It's not
possible to check those device's firmware version on Linux, only
Windows.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux@frame.work
Signed-off-by: Daniel Schaefer <dhs@frame.work>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 5a183af3d5c6..41327e32f359 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1056,7 +1056,7 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 		return ret;
 	}
 
-	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
+	hid->version = le16_to_cpu(ihid->hdesc.wVersionID);
 	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
 	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
 
-- 
2.52.0

