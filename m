Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652987;
	b=rsuKsuakMR/nfDs4GoiwBMZ/3NzKoAK6j/4yYxlhL/UmRH6qZWvf3cqD3uhU8ljzTzac
	 SkHx8eTtJOqwZ9q/Al7FVvsW3LpWouSV35nkOogsbkqvbep7tDP+E9iY0ZBJePlfEyidw
	 2E3N4YQiau0L3PojCP56gzuzU6jZpkPN+7aR5OcuavXaueIcwSYiULgOV0btZuM3+dTHs
	 1X/40khv8prVyfMHOsZNMy2K5zs2xLWJIhAXWW5KxuiNspLuGSHn/E63X/n9h7GjX2rdn
	 P/LJi2g0QuynKfznM1KUmHNfkcjCDcLLNFuB2cpiC2yiWV/yhCAh3IWzFqFOK1eAZSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
	b=AhkWY4K4bGbbd5o5mL0tqzCP6AMmMz2CBEhM87i77BVzLMUBCUj3xqN7g9zoyvP/l9Ph
	 dWB6aWMivdEz6mxyw40zhJLCNod0FtDvTcYFEHQa1FuS/tnctSnx78WqZqTCHM/sarMwm
	 YzptRT3CT4SukoSlfWqPrEDReFS32WWuo749dy3rTGAAyeolCr2zAEnWK2UWLUJFYM47K
	 i6yHiF3Ps5VDq3Jjc5iWQBmGGOkShS0Fj9rYA8K9awbR4Zy1LSLTizNtIvco0rxAE0OeT
	 k4GP+sR89HNGbOkz3dRLN5HpMJgPBtgGGdjGvLz6moMaFmFxLkBLRsAVkk1XA2LHZTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBF1Lipi;
	arc=none smtp.remote-ip=74.125.228.1
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168E606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 07:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9168E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FBF1Lipi
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so154306a12.1
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652986; x=1793257786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=FBF1LipimvlOXg4hcf0YrlXHky4zAxyQTFinP8CkurFD/jn6M+yJwf6tRtFBg6yqXw
         GK+bdxY6WZg5zL7A063h1/5kly2IfPqDaL2wa92lxQjXdB0hI2TkmLmjwHlzMim2oVGw
         s/VIKcLAXnYeR6Cr1sEXqZaDgow1ed6sRGg8c5pMr4D5joTBodOPesrPvhW2PzWYmrcR
         FJnfNSYGzRY5DNosRdZBwXilRX6mMukUcyW0IvZVdzt68lcmxTCLHwhJhz0aE5NcMViE
         vRH943rWPi4qlUkRqEeLU2OwKnQ07L1exEd0iDtK12SGnoHDkQu1HayJO3iAeMZW1Qc8
         BPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652986; x=1793257786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnlYdPOPJlOuiqma0L/KGA43PVF31d9BgFd4VINQMpI=;
        b=zPZBdKeVD3hYqmts+NqlGO3fE8M/5zN/ctimGQMWbfhJ3sx8JhFYBIEdG44xlMkG4K
         GU+laedWjUCKyQGPo4MZCpGLEWCpOJPso1JWHP/+hzBXID/5q9mKeq7vwOxecdQtWLZb
         xTJpCaLi3YwOJT2GotQ8U4XQviHvlt11szm7DmDnQRkhklfsAyYFPxAgnveb6QFrTpzT
         nUWQQv/sZM2Gc+t4mRsv/6bSPP6JL7mvJvAAYBBKJgHKzRxMO/9vHCobvvGUVM7C+r9P
         BoCRpndToKfEgNv5libGZbXRq2bN61TCQioEA0cFR39SLaXFSQviLIEu11gvNwm0n7sH
         XLuA==
X-Gm-Message-State: AFq9FYJZo0uSFpKmlIJQ8f9fiaEYZEuaTEluvC3rW6+0q5uqXSuJROOf
	kY3TtHL+y90zxDQ4mc86yd6y50RcVM6lET/yyKhg8ac1JizqDQ7yoo09725M+0XFEETRmg==
X-Gm-Gg: AYBFou1xKB7uKtYFw8q8cU6p7Rry7J4Xw80GhqYaVBpwnWgASQwLvLlQnpD8JZZQB0/
	Ru3AtYlZEX7XfUseVabpszg5R4vTm9odwBLewKSeRVWbfOmaNMXHAz56TMCwTHUBwB6+C4ej7Kl
	3AHvyPhisX5hI+iq0in1PlSV6pJJ2obF3astNh4yJkYeZzkGUhRyBh+Ll+KXqy+xy2ruH+ZU0VB
	Th4J4EaZXGjFamihGxkgU1vkqSpTc+1lkbHPfZL1cQAFLRRWD8YBpvzxwJX9QxoHQ7QpyAlwQkT
	T8qHLcqGEw6AArqpZUZ4Z07GiiAWRHFtQvzhQMmnC3r5j14kiOix/g8WYZBZyM1Bm2PLd1/HzRX
	99NxOLhsdpAkWrUysp/7tXd+t2RkCfk4neUvI2BCaslWpMY/qPi3soMz1DRdhRIgewMCjumUsu3
	jdjXZqvt0xsFDx/vH4KBWdemhRgplc5+nD+w0iYMBRVp5ImVXGkxFYSY5Q1+tEb0Sn+MTuIhdwO
	MnRWd8Tk7pJ2+lhrawRt6Zp5z7zWscPuhsgMQb1D83JN/UC8KzgHa01u8NNbrZcueNpocucEks=
X-Received: by 2002:a05:6a00:a387:b0:882:94ab:20f6 with SMTP id d2e1a72fcca58-8a089c3eec3mr3115617b3a.1.1792652985830;
        Thu, 22 Oct 2026 00:09:45 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm1706039b3a.12.2026.10.22.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:45 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH v2 RESEND 1/6] USB: add usb_make_subpath() for formatted device subpaths
Date: Thu, 22 Oct 2026 15:09:24 +0800
Message-ID: <20261022070929.20820-2-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022070929.20820-1-shlomojune6@gmail.com>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
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
