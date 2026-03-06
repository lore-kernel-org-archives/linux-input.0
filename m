Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F54723D2AB
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825585; cv=none; b=eiJPIQI0xC2M5mKn4X+IhAQPWMLa2NiFljnGAh4JaymnCBWCEYAoq8+fVjAeO/xMvUIPN2XB6pmtLv1k+BIf8UaIJZUGyGciIvcDPwfm4wCuh0fiORkmfuQoRzKgnc55TPnvihWTfjDhyCjXcJWabA5GnvWf1TPaCsrAOg9ePuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825585; c=relaxed/simple;
	bh=6A07t3D/mlfj00VNguqIxJaGrvjIBUdnHRlaHnUsjY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxPlsWkVDPpXKlxLOgGO25TcUuAxKZGr24wKG+R2zjqY3zDK2my5SDeoyn5eXV0h4KROcd6/Jzc+jhKUDHCsj68auIN00UGO8sG5cXjQCwTxeN/jlfHn3VLT3E2+Ea5B1myTLEls4M95wIfD38z2XXJc9GRjxTMgiG3NdZYMmRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goxJoYrl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goxJoYrl"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35980423087so3256715a91.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825584; x=1773430384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+Ycv3P6s1IClLI2RRggHKTQiq4Ee3yw7TYNzdk8xBI=;
        b=goxJoYrlYCm4cLfY3lWHtZCzpvOik1PorTSFBBQH5QJCW32i1JovJ7SRQ5O16T+/EM
         saar0OiJfMzqX+n8ME5AKKLYYuWUJ+NNxtQnFHa1dXXtjjjmreBf/1YCaGLyEt/WDh3G
         leSyidvbN1HZ5FZVktCk8IR5p7rGadfz86foeUQs+KjD1V5d6B5pCKNVH7pzub9gcOrQ
         LhkKbO8KO/6uqCKvmyp5VSAjVyI/Hi8wX/KyB+ZO/k4dFQ4ZLjyTLVkvxzyja9jBJQUR
         jJrNIF4S+SW0qGTC3jaBHhIxGD4ko/nc4Il9Wsw4m3TTBGY9TYCY4BxugJELhnFC8x55
         xNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825584; x=1773430384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+Ycv3P6s1IClLI2RRggHKTQiq4Ee3yw7TYNzdk8xBI=;
        b=VztK2DAkwBxuAofU+Sm4BzNv1+NYH1+6jGOL+0sAM1JEqoTWcdy8GKu+JBkfh9D/Ef
         ehK73e0Mriw+XaeYlD8oM5CUuxncwyziXMHq6dxMnbgEf+SKsRwal+Lr6xtOLOgT/SDZ
         H6Tz3H/UwgS/m9NDKwAhtc8bKn272vj+JUt1nX3lMVUdA1cCdoyA/uLZ62KnghXRZnP/
         DJG5p3QTWDkYywfuN1lQIaQDOtjCW7jF6x8C8Wv7RYN6Gw5JUJ8fbK0ZXvexent5KTkM
         DqTGMnn3P1vOsOIJ6bSeebtLMEpFz4/JNchFDktiqh95u1Z3jcv1G2eaPH+LMrGP8LYN
         NnUw==
X-Forwarded-Encrypted: i=1; AJvYcCWubHpx6p3wnwh4Ny2QVpKvEmNM87pkNOTRor0a0cFZaJgH2sU6y0Hn2RsSyTyURmO3cIFJ6izT/p0RoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUBoJKKimSFMjxnB3BuCiJrwv9LmX3+vLtAe20BJiN/Eq+2Ug
	GfRJqk5MR3+eEDSZgAm/dZL+pXvPmDxJkO/UhibyDhn6t14D3z+jXEma
X-Gm-Gg: ATEYQzx2ER8KbImfdki7zt0VmyGk35eDkzDGje43lALwufR6tPuK2GvzN4vsXMcYuZ2
	Rl00kReyGJA35KgvuwFiwzSx0KRl7prBn0IMgF7iMWQ09ejaGwaw0DGRnt3xsJ9VpN0uXyGcW9f
	Kon1/mH9e2OZwgmw2QNxgxXvMdXFJai9A0ZpYb88NmVKokj/sATdmpMiXbHNh7fJt7kGvJ0kHbG
	GCa8T0+BPNkTR+Sg2wnVrC0gKD47ZKufzvfYOvadO2AQGjDfminSe6jBvVmmaB9/aZcdhKXMolz
	WMnU18oPu3Gbo8H2WVi2Pux+nukntVYaXtLyxlQLwyJwjbpidwrUjzMjVwTIm/TX2VQxW1qz4fC
	7DoMWpw0VwifgsQtFQffJwlm0bDhWkJMtAAGr0vehHKPBssUz2ozUPTDSf64XgId5wjKvKeRize
	dB4vJDh3xnCyk1hJz241p1
X-Received: by 2002:a17:90b:2e0c:b0:359:8ef8:d5f8 with SMTP id 98e67ed59e1d1-359be1317a3mr3166316a91.0.1772825583496;
        Fri, 06 Mar 2026 11:33:03 -0800 (PST)
Received: from horus ([67.168.214.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d3922dsm5847842a91.2.2026.03.06.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:33:03 -0800 (PST)
From: "Gerecke, Jason" <killertofu@gmail.com>
X-Google-Original-From: "Gerecke, Jason" <jason.gerecke@wacom.com>
To: bsevens@google.com
Cc: bentiss@kernel.org,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ping.cheng@wacom.com
Subject: Re: [PATCH] HID: wacom: fix out-of-bounds read in wacom_intuos_bt_irq
Date: Fri,  6 Mar 2026 11:32:57 -0800
Message-ID: <20260306193258.307908-1-jason.gerecke@wacom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303135828.2374069-1-bsevens@google.com>
References: <20260303135828.2374069-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mar 3 2026, Benoît Sevens wrote:
> The wacom_intuos_bt_irq() function processes Bluetooth HID reports
> without sufficient bounds checking. A maliciously crafted short report
> can trigger an out-of-bounds read when copying data into the wacom
> structure.
> 
> Specifically, report 0x03 requires at least 22 bytes to safely read
> the processed data and battery status, while report 0x04 (which
> falls through to 0x03) requires 32 bytes.
> 
> Add explicit length checks for these report IDs and log a warning if
> a short report is received.
> 
> Signed-off-by: Benoît Sevens <bsevens@google.com>
> ---
>  drivers/hid/wacom_wac.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 9b2c710f8da1..da1f0ea85625 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1208,10 +1208,20 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
>  
>  	switch (data[0]) {
>  	case 0x04:
> +		if (len < 32) {
> +			dev_warn(wacom->pen_input->dev.parent,
> +				 "Report 0x04 too short: %zu bytes\n", len);
> +			break;
> +		}
>  		wacom_intuos_bt_process_data(wacom, data + i);
>  		i += 10;
>  		fallthrough;
>  	case 0x03:
> +		if (i == 1 && len < 22) {
> +			dev_warn(wacom->pen_input->dev.parent,
> +				 "Report 0x03 too short: %zu bytes\n", len);
> +			break;
> +		}
>  		wacom_intuos_bt_process_data(wacom, data + i);
>  		i += 10;
>  		wacom_intuos_bt_process_data(wacom, data + i);
> -- 
> 2.53.0.473.g4a7958ca14-goog

Seems reasonable enough...

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Note: this file is chock-full of functions that blindly process the
buffer in a way that could lead to out-of-bounds reads. I don't mind
fixing these two specific cases as an improvement, but we should
consider working on the other cases as well.

For reference, the potential OOB issues were introduced by commit
5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit").
Prior to that point, all processing was done from a local statically-
sized buffer. Short packets might have led to unintentional behavior
but not an OOB read. We now work directly from the pointer provided
by HID and (usually) do no bounds checking to make sure the lengths
are reasonable.
