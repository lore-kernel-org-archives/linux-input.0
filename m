Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585919;
	b=DvtFpjB0N0qAU8WkfEF8a/QsK6sU3bZzRjrQ4HnGnO8TEFrx0KTrFIQXXbgg8z7YsqhF
	 HFPe7oF3tB+LWCL0g7uyjLBz3hM4VrGnRXCaEUwjjhwr6gMA/gxR1zDG5SQwx0AA7BMwh
	 kaFg/fncKY/Ch2mEzLJN7WyA+u4PLrio2PB/BkDasKaJDz4mfKT/D5e3GHgXsC/3EMWw5
	 QmRciUKwOpaZvCNY8UA6d/O+7laPhg1t1jVu/pEF3w7xTOW52HsyWZKCVtiBzWITTrx8E
	 73Q/P1hXp8GTlG4vjeRBoORYPkGCfIvx7cbpcw/Wp5sELHyt+4nhiKzd79tv/97MDCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
	b=SQyX8poAuum0+CQcHcKKQkjNug7tue/SRsAp4f3AAINfzgBgG/OM2Ce44Pu2Yp7quYBH
	 y7849eokd9cl8g279a59F/+a4kLVqOKa3QljKHKgLaBqIwokQQ1bOhk684MzLEzx822Ur
	 +v0lxSGIF6J9csQniaLY0VkpvZcGjWO/qKrT4HCTP+3Ykp3POy3aMner/tFR9z6aFfvgJ
	 PUnDYSBTIhu3Z9I0PtiOeZxkKmzGkpzpHMLFAEdTPMhyFoiBz6KoHZU3k8avROmOFSmW9
	 gBHL3ChI2Qw1557SGZJinmBf21yLiHDCTv0l3vBAAYg45adJkZEeaZjTrXKC+B0fb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nGb3wX49;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A481606A31D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 12:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A481606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nGb3wX49
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso456377a91.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585918; x=1793190718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=nGb3wX493/8Cy5xh9Atv9Axf7FdB26I4tXoOvows+NmU+dGzu9kENcWlBHxs15w1GP
         mdcvYp8AEG55IbTZ5Su3d8WP8ZNv82n/4ckpyvmOsVLHo1K5XWHuSPH5NlMRCCZHLTC1
         AwhAhGqyJe4T9JdWlEB0XGiuEcl1WM9Fmqo8PdAXOj+iRrGF8Ti52eDst6wiCw1JuTmZ
         1b4WTVdujyqoMQTdQYM80J7ooVmOkE/gOq0bckjO00L4tHmA6mOPglYdczt3NREXSWbY
         WYyacpcewNI4/xJGRDOUhavr2nBe4qPA/rhpY74WpXAbssUGEqpfKn0GAOmq4nILfOHW
         Sd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585918; x=1793190718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=Y7EVW0az/ivmtkY7L0LXKYx1gcnngNluqPfypCG+wGrBu86vHZTbgN3LAG1JdNYnoc
         uc573BDIz7juQKH2LCFdW5BA+v4xmmbNZmkO6nxmnzda3oxMkMxzQOu3CtIzC29m6UBn
         GS5xIoDvNnwFzAbTsTrdiFGFp6E5hfz95TF5PCASlAr+9plisfc89EVrLvu9MgSwB9Xv
         TIzSLSxFraDF1gExsU2QP41kXgGC4x3aiqXF8vSqAkzBgv0ZWAX3QIPn8OA+dFF4eHt+
         adXqASCONcyuvwdnG4EiI4GSWLFufX03AWfUM0o3sV/CzSWCw2Cp6VWN/c29k98CzmGJ
         5cvg==
X-Gm-Message-State: AFq9FYL/Z50BNf+Wh0C/kKds21NMU0zfzvl5cgx4tcHPtkYSiSwHR2i8
	ocGetDW+EzqEDfvBaTF42kJHw2myRZCrkpwJhetBqQms/EUi8JSDHMnV4L+TbtoSiwV/FA==
X-Gm-Gg: AYBFou3Z+IoZRBWBGxFdD5EtRQ9Dwa7EplQ46B5MqLjw2S4mhwvDGieoE+kiVx7f/ix
	0yg5UBN4w7J7auhbxx+SmG0icGj0FaReq8QhUBreL0mBs1b6N/DLPRiglICjH3FVFd0ftbWmaI0
	Ge3BnpFI9I3p33PbU1u4wEVVQdkXy5LQoBQ4h1Ww4jZA0HtBf2HxdJ0CpE/dhtXjQJkpv1lQUO2
	PyJAcg4L/gp3D4ygTfjm+deGnj+HwMDWOFRL6FWmYh253e4f7xkpG0efGFlr/h5r1voWSkyE6cW
	4wemSinawrJn/F1mtYU34so7NqPk28eudNT/ajVswpvJbCGue5J7JPhmhnjSHL5gdCF+3MBw3fD
	iGT7xhJd77QRLdMXJKrWI2+jxZ4Sem7jmModZvrCADMSwnCJB4lm7H8xeaiNLTtzDcENxwGtqKn
	nxeV2CtupNKDgT7PQd9+UEkI2tarsQmeO+9yP4zrRN1Ogy+XxrxHppeuSYjg9kcEBzrvd/FEfUX
	4naKte7EfYENJ0qVgxRMM922bnTeInFdHeRC97JyF90oDBdyqxpKiDI/q8Wnobu9lYPyqFB0A==
X-Received: by 2002:a17:90b:2646:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3ad86f1c073mr1747613a91.18.1792585918204;
        Wed, 21 Oct 2026 05:31:58 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813eb9casm4229523a91.15.2026.10.21.05.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:31:57 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device subpaths
Date: Wed, 21 Oct 2026 20:31:41 +0800
Message-ID: <20261021123146.17202-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021123146.17202-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
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

USB drivers often build device paths by calling usb_make_path() :and
then appending a subpath. Several callers use the deprecated strlcat()
API for this.

In preparation for removing the deprecated strlcat() API[1], add
usb_make_subpath() to format the USB device path.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 include/linux/usb.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1da4ad1610bca..c90ccea0cdbf6 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -14,6 +14,7 @@
 #include <linux/errno.h>        /* for -ENODEV */
 #include <linux/delay.h>	/* for mdelay() */
 #include <linux/interrupt.h>	/* for in_interrupt() */
+#include <linux/stdarg.h>	/* for va_list */
 #include <linux/list.h>		/* for struct list_head */
 #include <linux/kref.h>		/* for struct kref */
 #include <linux/device.h>	/* for struct device */
@@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 	return (actual >= (int)size) ? -1 : actual;
 }
 
+/**
+ * usb_make_subpath - returns a stable device path and formatted subpath
+ * @dev: the device whose path is being constructed
+ * @buf: where to put the string
+ * @size: how big is "buf"?
+ * @fmt: format string for the subpath, without the leading slash
+ * @...: arguments for @fmt
+ *
+ * Return: Length of the string (> 0) or negative if size was too small.
+ */
+static inline __printf(4, 5)
+int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
+		     const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int actual;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
+			  dev->devpath, &vaf);
+	va_end(args);
+
+	return (actual >= (int)size) ? -1 : actual;
+}
+
 /*-------------------------------------------------------------------------*/
 
 #define USB_DEVICE_ID_MATCH_DEVICE \
-- 
2.43.0

