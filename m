Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6F3C553B
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788022130; cv=none; b=f9FvaWGl2nesCh0P1AkaG6ycoXR1L6p+2LTC+4SItoCqyUqUJxqlDNAxly8zT/bi8E0sKvRY9rokQauhsWH72NyeWOXB0Z6uBz02+vtQuhEN3L08RV+zloM3f60buzhNS2ffE1jIFfuH9hkH8brVWzUeB2PFkTRqBNdE0ybKb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788022130; c=relaxed/simple;
	bh=D7eWHSQ6FGL04ZAqbgWpMwlhuvigXVm6r0XakhIFW4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxtCZKP8Z3zYSA2rpuMdmbXyOox1XYYdZHDAyQTqAoN3zq8C5I63l+uaKzaOHJqXOqoSEbw0B+7AZt5+KYiLnoOijJLq0agmEpf37386JXr+rV1nWGeN3N9wQJLJCnv9pnKpo+3Ebr4UaPks5k22MxhAn4WGMXTTr/c7LASnjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V20XgBOi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V20XgBOi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b445a84fso40785ad.1
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788022127; x=1788626927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cV+7C0QRGOca2ge1k+P7X0BTEoHbXlPi6yIKDKsgu4M=;
        b=V20XgBOiuU0T2FsndiT3PGA9f9hB3JxzerJvOjv0BwkhYrfwejXBA1ueJU0kOK1Nkp
         +I0yn92GCroqLgVjUgDA3/nXp2ELxsjuK2wgUX02XpGfaRHvVmxJCYV5B/Ix6/BEfFAc
         DcWGcu0/UaBMbdIigXlz66EO9iYsBKuAeuk5pfv/EyreOwf5+tjVAvcIns6LLjKZKVmg
         wb15KlGjSMIaHp71giBU5mfXjUpdt5XAs0htvqjaMeyqsL1bNm2ypbs4NdykZoOddAwI
         r3DuI+gYxQE1hTMag28YO8znVddYyYxvjE6kfBuSOQwEA+Z41pnBk9R1Wh7RZbaxrGRV
         KPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788022127; x=1788626927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cV+7C0QRGOca2ge1k+P7X0BTEoHbXlPi6yIKDKsgu4M=;
        b=AcFBibuuFtOUMgIbpxQVnVaEO35Mcn2aZ1QNHGnZZYYouuMaxQkpQ8O/aGZLkl+akw
         TYTjQoyndHbrOHC5IiS6uokuSOcN9zXc7YwaQrzUl4xZhQwF5FilstK/c9Va8AYNLSEQ
         0ukHLgR/CpS2ZlmT+JLZZD5ol3ju/eok2SPyYxfsIjAxln6TVxqmwIXet4P2JfMvpIjU
         KQ1aaQ/LuwoHLJWRgl7poGu8onlrp60NF5ELOChONgokShM8ccpqAhAqdLilN5f7Vktq
         RxS4vf9hop56fIOenWVynQs8qbGRNdSCvFWiCpwwyvSPUdE1CpgLvumbSNk+2TTWk0Ix
         5bQQ==
X-Forwarded-Encrypted: i=1; AKwUvByjyrkiZW2IZh/R4uWEA2WNX+ejIfaMJvA+LuSXq2ONc8GzBVyNsqkuJmSGqJQUJ6XSjP2x/fGMj80Jlg==@vger.kernel.org
X-Gm-Message-State: AFuF++mV76iAnzXE1p8lb6icz+YeWlYI65Wm32NozMV75gM+VKuLpB9S
	jgcHaqNuR48V/W1u+ov1MDTyETI40iemB5owT6d4mvSRQJXTAiwpDxx4Yh3CiadN1w==
X-Gm-Gg: AYBFou2+9r4hK7xy+GdE5Xnzh8fzDfcJyrJTCGVxwlpL4AmVAGw/kyrd8rTTybmaD7T
	NhFBJ7F8D4UspZTHEwkI2YnSlLxc283kMAMT3fQ5wbPT9FEA2eFUNLrdyyt2652lvyQw2CDaLne
	ZUOEt3xtT0UC6LY6t6kFkfuJdDOLX9RtqrWwQIRkxdLvuv7EyoxhG1VYufrtSqh22dCUx4d2rcf
	pH1+BNIPI7r1Rv0LqqzLJfRbN70GfCpsUttzJoxvIEYztzZV2epw2HECdbVkB2SFqpQBQuh/gPa
	9w1Ki1gmkU2dZ+fUv5Pd9MSmjqZxB017jzIPr6n+gntmgnOseOE2YbUGCEraJHshvBReAxqp5ky
	GNIIfqQW4cDWuU5Lk9Qx9+J++E2Ion7Zczcvt/E2tcHukTw+9CHFz7AroJgPK6gDb49y8MPgGKE
	jpB6lb1IMRjIod7eqOTIBwIJte8p4ScZ9DFKWMLkiatexlxl4ctFGLn6FFdBY2maozWgIh45BRB
	0Z7wRzsiU9O/7CKar5H2K3nAOwl4RdZAq64oLFevbRLuX6sWMqFy9lwBKyBziUf3w0CrMSlKlnh
	9BykuRI=
X-Received: by 2002:a17:902:d48d:b0:2d5:db3d:1a45 with SMTP id d9443c01a7336-2d8df7af3dbmr4629915ad.18.1788022126689;
        Sat, 29 Aug 2026 09:48:46 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869283sm15242575ad.43.2026.08.29.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:48:45 -0700 (PDT)
Date: Sat, 29 Aug 2026 16:48:43 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com,
	Lee Jones <lee@kernel.org>, Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] HID: uhid: convert to hid_safe_input_report()
Message-ID: <apMNa0aiNEuS2G94@google.com>
References: <20260827220428.2988999-1-cmllamas@google.com>
 <20260828-stable-daily-0004-hid-uhid-safe-input-report@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828-stable-daily-0004-hid-uhid-safe-input-report@kernel.org>

On Fri, Aug 28, 2026 at 11:34:35PM -0400, Sasha Levin wrote:
> > Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
> > the buffer size. This prevents the reported regressions [1], allowing
> > hid core to zero-pad the shorter reports safely as expected.
> 
> Queued for 6.12, thanks.
> 
> Could one of you send adapted backports of the pair for 6.6, 6.1, 5.15 and
> 5.10?  I would rather have them from people who know the HID core than
> do it myself.
> 
> -- 
> Thanks,
> Sasha

Lucky for us Lee has already backported all the bufsize plumbing into
older stable branches. The only missing piece to backport the remaining
fixes would be adding the __hid_input_report() bits. We could extract
the following sections from mainline making these backports trivial.

Benjamin, Lee, wdyt?

---
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b924980b5783..154f0ff8021f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2072,24 +2072,13 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
-/**
- * hid_input_report - report data from lower layer (usb, bt...)
- *
- * @hid: hid device
- * @type: HID report type (HID_*_REPORT)
- * @data: report contents
- * @size: size of data parameter
- * @interrupt: distinguish between interrupt and control transfers
- *
- * This is data entry for lower layers.
- */
-int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
-		     u32 size, int interrupt)
+
+static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
+			      u8 *data, size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
-	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -2140,6 +2129,23 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 	up(&hid->driver_input_lock);
 	return ret;
 }
+
+/**
+ * hid_input_report - report data from lower layer (usb, bt...)
+ *
+ * @hid: hid device
+ * @type: HID report type (HID_*_REPORT)
+ * @data: report contents
+ * @size: size of data parameter
+ * @interrupt: distinguish between interrupt and control transfers
+ *
+ * This is data entry for lower layers.
+ */
+int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
+		     int interrupt)
+{
+	return __hid_input_report(hid, type, data, size, size, interrupt);
+}
 EXPORT_SYMBOL_GPL(hid_input_report);
 
 bool hid_match_one_id(const struct hid_device *hdev,
-- 
