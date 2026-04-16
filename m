Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474603A758F
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349339; cv=none; b=kJM/tREHCzG2UuhWgarHrg9KgWY6oZ1R3VgCJScOOeYeKw5inyBAAp1Z39CX0z+ywRIdQ4Q4zsQwkPgERYWiGfWFCbbyKt6kc0KuxZaJfi/3Xg+sD4/eOQdubvwhYGhkjuu1G/g7h0stUhfYZY0DZNxSSNTlkL6P8Mzm/znDWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349339; c=relaxed/simple;
	bh=0W9WdKQ9ZVTsjSn2sKBmFdCrD/edyuIoJDuhdVC5j7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwd5CHefBVUUhrs8v5THlQD7DsLkRRYdR4h/JJeUGucy6AAPjq4l4TzmJaOMD4IU8Czj9MhNRU9K6xlW2g0YJVZdvY2ud23G52HLsFRU46vP6xl3jVkGVx2iT6ObwFdq5i+OVj4Nhme5WVISYyA2vEAsFjaDlhxEWy6jGFJTgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bv/j1+mW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bv/j1+mW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4888375f735so80643895e9.3
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776349337; x=1776954137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2m4NTB+CLdKBqyyGrRuoETB+ShVR6sAGsK1M/tDiBbc=;
        b=bv/j1+mW8Mulz/fb5eFHbHmtaBPT3HuXRLihSL1sbx8ejDgmhlAoKnOBgzC0eydbdo
         qZEP++aCiO338ZUe8qv9i2/tlnkzfHzPAISWDK9DB3NBijRJOwcrvRd9qoLSdEyiYCws
         Dihpv4uxJEElHjG1Q9WRVRuCS3vcwA2EXGrqwNsFUDUEEe4ZI3cIddIeTEnJ0QhmDS2E
         twVGsybWcBLaODNG/psywFJ9XaIxW0E1HVigHwF00MUODVMvFCiYfoIxrgw5nSWSvTuR
         n0II+4yQz2OZcH6AgufRrV/k2s+Smo3p+zaf5AS5tGh2AVnJmv/x2ICaKXBbGWUGK/Ew
         uo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349337; x=1776954137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2m4NTB+CLdKBqyyGrRuoETB+ShVR6sAGsK1M/tDiBbc=;
        b=ewJ2CQTfyuZoT+hwgPfeG3Az+I4gkD5VJQIFXfctarYED4zRRf04O4ZA0wyjARmmym
         ug7JPF3lyHfeXUK1/HvbF/WTK078gSZJI9MtKLbR6lz/yel3rTCM9BHTy12ddEAANnWd
         zZvwsrGBvLwmOPqw2zIsQvMVOYqdJCMwW+HEYcthm16JOjByxIi46h09uHvcXmGL11il
         /iCmKuEuJSaZ7KzUNd6/T6QchZ4JHiBARQQRd2X7LIuSG7YITKqXzSSh8nmItLeevEZH
         i+8RqX9AESaDrLd2gCBZ2ICG1l0NFOAUnAYJopIywiDj5aG3MSXpCpEpR+1Kv38puEWX
         vT/w==
X-Forwarded-Encrypted: i=1; AFNElJ+E4vQ9uRlWCpMNa+qA2Am++K6W1q9NX8T2gjZUpjaovOA5wkpr3kUJ+3wPJR066MfCmBhW49ai69s08A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3w94ntNyt73Cucxlp4BxlbY1Js1KhNIcEnnDlcB5eaN4uxUb
	mvYNDushyt9pmhAa11uYcRXhnXFsN57FtVMc0xnLNrhU09dTZWocnU7nF3Kwq/GTqw==
X-Gm-Gg: AeBDieuV8LaGw18DunvPIzl40sbaZAA88PVyv4V36QOYZmx8zphjL+e7zaZ5UdLyqRr
	RzbDt0S+sZ/71p0oTyCeNePRVYlgOi1jRdRX6+pZOwrEaX5QdpV/QKIaY2EMoSuWOXlFSOJZB4t
	JvFNrBK5TmIPDqYliZujBdt35pqoWDhrkr4KksxUh5oNvHn9yQEipjKQNE2OlXrX2rictT6uUCv
	HGBk7L7aXhNol1Te7ESnP1NUBFIqVFOtJkFb0CuvACNs6whradRo9IaGhaRa4c0pN9EAqcM22wF
	56T6BC/ECCqfYMEg0Kekl3xKiAEQ5Jm4QwE6RkbRHT8YDSApBs2C98BKI2cPuaMsPxt4tufOt+d
	iG5nfqCFmywe2sQSV9n3wBivDZ2M0jEskCz+JgHf0EOf3CB4jsf07Hd66uRpb+47uU/Yx/mVJnK
	pvqBnEzwrtpk3kLkRl0eynRWcZtcAO6clZ/6xGhqsEnhXHeXJHEo/N2c6ZX/JsfgKWiHRIjAR9h
	fg=
X-Received: by 2002:a05:600c:a413:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488d689bad8mr280259955e9.30.1776349336139;
        Thu, 16 Apr 2026 07:22:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:7ad9:6b96:1f0e:264f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f54666eesm39056585e9.1.2026.04.16.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:22:15 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:22:09 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read
 during DOUBLE_REPORT_ID
Message-ID: <aeDwkQ-S6QQuK_RL@google.com>
References: <20260416131655.2279756-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416131655.2279756-1-lee@kernel.org>

On Thu, Apr 16, 2026 at 02:16:54PM +0100, Lee Jones wrote:
> It is currently possible for a malicious or misconfigured USB device to
> cause an out-of-bounds (OOB) read when submitting reports using
> DOUBLE_REPORT_ID by specifying a large report length and providing a
> smaller one.
> 
> Let's prevent that by comparing the specified report length with the
> actual size of the data read in from userspace.  If the actual data
> length ends up being smaller than specified, we'll politely warn the
> user and prevent any further processing.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v1 => v2: Add more size checks to protect against issues during recursion
> 
>  drivers/hid/hid-magicmouse.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 91f621ceb924..e84e6b21d113 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -390,6 +390,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>  	struct input_dev *input = msc->input;
>  	int x = 0, y = 0, ii, clicks = 0, npoints;
>  
> +	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
> +	if (size < 1)
> +		return 0;
> +
>  	switch (data[0]) {
>  	case TRACKPAD_REPORT_ID:
>  	case TRACKPAD2_BT_REPORT_ID:
> @@ -490,6 +494,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>  		/* Sometimes the trackpad sends two touch reports in one
>  		 * packet.
>  		 */
> +
> +		/* Ensure that we have at least 2 elements (report type and size) */
> +		if (size < 2)
> +			return 0;
> +
> +		if (size < data[1] + 2) {
> +			hid_warn(hdev,
> +				 "received report length (%d) was smaller than specified (%d)",
> +				 size, data[1] + 2);
> +			return 0;
> +		}
> +
>  		magicmouse_raw_event(hdev, report, data + 2, data[1]);
>  		magicmouse_raw_event(hdev, report, data + 2 + data[1],
>  			size - 2 - data[1]);
> -- 
> 2.54.0.rc1.513.gad8abe7a5a-goog
> 

Thank you! This looks correct now.

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
