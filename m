Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE93783C5
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883653; cv=none; b=VghQkqGEIXCJ0RK+kxnfKnvDzJjYidbvNWbed63u4uVcOSYDHX/xwOuIgM4LTpXqMlToT4LWC6PJI/sf9wxNRGVHvf3LfTNLgavtgbr8JouGSG1fXyFZxVqHzZpXW/TjZJx9IyEbRc1AmsO+1rg58Tx3oFX/83DKkYuW54YOrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883653; c=relaxed/simple;
	bh=Gr0MwIjtUSp0Q2vce1vxvw4jTl+iMwkp3p03PNYPJUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emzvDy8gpqNwRqK7FwyudgGgMBLcImUfKBTzEvmBzyf3rum6Wpi9fQ7WSc7HhbdhEkYjS4I8I0uQP2UTO1OlPasKURunoFW++lUCEiOijGH7l9dackeb1Ea+2m5HZMin/7uW8xFOw0/hAxAQKdwHr+FD1WkoU3K3BYje1dBPK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfJmaM/u; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfJmaM/u"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso5792147c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883650; x=1772488450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgq9ndBKIUBrn8/kJ7sZcZ3gg6ocwHBLnuwg779rJ00=;
        b=jfJmaM/uv5Nf9NBRCA8QU3IWG2AVHyfDv2/TfuXqU5ZhM7RQEinjNZ3mbVlVohvHag
         mR5apm1chdyZ4pk0UMlg3D9P6iy37ERnnbe/DOFrqRkmwVt68FWzUDmkVzTgqAAh/yzR
         Ch+gBoNp5SIOTJdQqUt0dtG26A+z1tm1eGqvpxIuDE6dDcwpGqYDDKsCUCMDbfEdhshE
         3hkEmVgxiGI3LrZ7vPZLpx764ZoqzhtlBzvftI4sCPNvWJw2mvcqgIFcge0Bg1YUVN3P
         N1mqYPkT+YMwkBmD/1RXm9H+gETGV5YHN+B4wH4HxNpV4a2vwKY5oIoqu5c5k4rEpMDh
         XQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883650; x=1772488450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgq9ndBKIUBrn8/kJ7sZcZ3gg6ocwHBLnuwg779rJ00=;
        b=SaxU1RxOLwTI6USPK0L2Fojr8bkh7SMpihsm2gu95GP8EYgVfZc8/iLVjEoEsOX2W+
         DF9TAk5BUQ6bEAb1qVm8O0XoCX7FtOIx2bRLHiecQGjU094foxgimykvjaUFP2dciz4I
         Lwt5Z4owfT348vFYz2xs9qORlYEVGEB/XC03nyx4/I/zDpKTmbEWlUnZDQ6kpaq21NcL
         yJcSje39JBxJSpfmFwdoFYX4v6RKG8GpmO8sZSjsKNZlnz+ed3BjaABRvOZD5PkcWLQf
         Ur7EzUapjvOGFP0B4XMpaLOfmAK1HqWwb9hjYf+rZkS6f3LS617K2xcII9YOnsiIrt+H
         kZZg==
X-Forwarded-Encrypted: i=1; AJvYcCVnyPU6lMxBzMjHhP9DBQWG10veWwfCvPPxXtyc2nYposo/vFn/tnmXK8kMLS7WOCgX4uZ+cz55ZwFmww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBiJ4qFldBOulGCN+7AQtA7gbLU3ChKQ0/fqj0UtJVwmbxOTK
	zL6RbySpv3IKTa7xFpPEfoRofoIAU9s7XVdTxvRXPGEGObNK/ZO3nv0z
X-Gm-Gg: ATEYQzwb85Bg+5FEe3N4WyrrhERUFHSschTrRfhpVvsv+M80LrIbH110ECMPQ/hVxfY
	vTx5rJPW3BRxgZme0AGgXj5B7a5sq7mLe2cSef2FNOh20H5Ld9dgw0rIlHuIV0HdTBueoj/oK7i
	cqRKB8TuZ6r5hO8yWSHGeOfoHo4JTOZxymPC//+wzinbu9BcW9dxgAhmoRrZn5Ro4x7pqv7hFCe
	Z71KXw4ZKtIDbVhDEhNhEajRsPMtvTIayw5vtxAMrqBoJei3tnn/zaV7bOVzVXigQ5a0BrPHn7Q
	9oLHhs4qxYcM/4AAMcqYP3wM178zxo8uPJ47mf/QzZYvUQw9AiM1/ucsNxXlpA/PkvkgIDlDNI/
	H5M9MLrCT5JKYu+i8EP2bK4zvn19jX1pAA2lBNbjjNtGUBUM8S0pwqMjf6xcLORBNk6sE8+2uBV
	wK5JNxv8PGd3fF0yOtTqKSDtU/0Oji2msjVfyXjYbEFceSJFPzSyYcvTe4X4LEtvd1FPbtInIin
	sU=
X-Received: by 2002:a05:7300:d505:b0:2b7:3281:6c64 with SMTP id 5a478bee46e88-2bd7bae9ee2mr3833277eec.14.1771883650323;
        Mon, 23 Feb 2026 13:54:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa9295sm5525596eec.14.2026.02.23.13.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:54:09 -0800 (PST)
Date: Mon, 23 Feb 2026 13:54:06 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD
 to i8042 quirk table
Message-ID: <aZzMe2-4IqzIg3HS@google.com>
References: <20260223142054.50310-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223142054.50310-1-wse@tuxedocomputers.com>

On Mon, Feb 23, 2026 at 03:20:45PM +0100, Werner Sembach wrote:
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> The device occasionally wakes up from suspend with missing input on the
> internal keyboard and the following suspend attempt results in an instant
> wake-up. The quirks fix both issues for this device.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Applied, thank you.

-- 
Dmitry
