Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DA371D01
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133454; cv=none; b=RycufFo/cCEyytnKSb4KT0TVoIkomyUxL6rtDSnOa8+hE8bK6O652Occa9h2rIi2PfAhgD33DdRz3UMy3hwzSqbGvgXyVSextTitEgbj2sPQIOrgshUH0cB+2dOlmBbH65wHgrUTiBf5XMd3t9CkI+iLlwGGKuVKmJMQ1prDaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133454; c=relaxed/simple;
	bh=+dycLYKDF4lcP+GsM7RTfuFMl4+If+s8q7wIPGWQELw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAz1DqdaSL/9qWwERuaV+wH+OXlXsGHNa2udzUxmLB6cj4BWPZJuNS30KvJQj7oK7JvybilEi8QPe5uO8oHP5iNJuQ3oN19YPHXSdUGkpUBMVqRtA/1iXa2ajZA6apSwY+ENjTKzSTRif9iUsv94xVKWfF7kYRsweKscWbQR0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhOtzOhN; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhOtzOhN"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137ec563a95so9133398c88.0
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781133452; x=1781738252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnteB54CdcOiXG3dNWXU3WtSLChq2Py28c8CG8TQeyA=;
        b=FhOtzOhNTLCEAscLn6D4Xgx+Ev9fSNCijN2PVRXPKAEvBL/w1LGbzqNWzohut0JVZX
         Se+NNXGKfkGPSTyRR1ecr+V7SY7jY3hn+BJTC37dps5+xfSPlS6qcWUx9s3ggfBw13Nv
         dnOKOGH0VJaI8nu+e6vN3Yph6N8W32QbLycgDdz5cSYtupZC8lkwdLV+Xl5q4HzDfk96
         UHehydZWqjNUCs7RMZE5M9gOC0T/nq2RpaBqbs7HM1bCso7JUE94n1uSR83XSp7C7Bkt
         k1cIC5Q2fLBKQt1HXs2ddGrYzxaCDIUj7UPtQ0nwxjqBzbkDDIr9qxn5kJLBmfiynuxO
         pOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781133452; x=1781738252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnteB54CdcOiXG3dNWXU3WtSLChq2Py28c8CG8TQeyA=;
        b=Cn1O2aGMwP+ts3plhZr1blCkW8H5rj+9/aYZK06V5o1pDVgkrHMjaZBwpmoedK88fp
         QKkmd2+TRyhchtoutrikEaw/tJqrB6DlevrNKVKsk8eTk3k3d+vf8lJABnqYdsIhoKPI
         HENrsH9jm1ly8TehkROY0Q0PVpZHBs4Ko17Df/aMyTsOvjIfixc9awGROXGt0ltcoHGv
         qFqJicLwDDgwPYpEXdUriUFD00pNbOWgARr3QVPAV2t7ftVmIPXpFvSFyFc65HId8H9/
         PIFBYdTyS3oLEvP2EpE5h/PKORB/hQxhYFRL2EeS4k9WhUqm/MXGr71iMGzn5NbPQnQo
         t6Yw==
X-Forwarded-Encrypted: i=1; AFNElJ9zWEACi6rexNqvqiCu2yL2AjqqSM1aBd2pgIyEIo2NTm+e9Tuf3QtL4CTJ7jrC+PG1Paa//586bsMrbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH2n0o84xHiFgtbhtWEHmjzA9JdWxmwjUdaP8wXFQdzfe5DI2g
	1PbMdldcyCCdrYOjAZSDc+KluxG6UWlU5ISdzFiJvR1XCE7WZjbXnvlJ
X-Gm-Gg: Acq92OH2kPUf8CZxPKsyWLwHqM/UvUFe+6zYWbA500wuIhQRWeQ4PbSlu31A6WDdCcB
	NW+aA1e6eg7HY13ZgBkOzcTW1xmm4//14ooKO2gJd+5eOmqqkatHn8yDF5DymlR5pwO5Uu6TqaL
	E220biy6OKsC34T/0e2PhuYYxwUfQUAp6CkkITT15imW66CiIHAYQI4G75mhWy05rFjxKoqrLLQ
	GxQRMdJ6btMu0m4p1YXHqtcWosrGT7j+aSrT2PE4m34e9dmwx6rfpEtNrQOwMIfyapHPW+eOP2i
	srIf4aPv8+3pL/YWwMprX/gMQsBhoJGVJ1PkR1bjbNtJSXyimu/ZMjrI+z58GGekzQER7ukK69N
	XR9IT4tldMCjIXZ9AQg7b0UXOKbnLTMef6pmeH1fCG4cJze7PSTDWam+3TJO4hZxsVkUyf5zcTK
	GJFDGoQlooSVYhSDYNGa6YEsA0TVCeKdSEMaY73cKDGgC5F5+CNmUPAf24805Wef/wbVC32WZVG
	vg=
X-Received: by 2002:a05:7022:45a0:b0:138:25b3:5234 with SMTP id a92af1059eb24-1384211e73emr153458c88.2.1781133452143;
        Wed, 10 Jun 2026 16:17:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138430452a2sm9181c88.14.2026.06.10.16.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:17:31 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:17:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Message-ID: <ainudW7jgcL-yLN9@google.com>
References: <20260609121353.3743782-1-lee@kernel.org>
 <20260609121353.3743782-2-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121353.3743782-2-lee@kernel.org>

On Tue, Jun 09, 2026 at 01:13:38PM +0100, Lee Jones wrote:
> @@ -3308,13 +3309,12 @@ static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
>  	prefix = data[0];
>  	data[0] = WACOM_REPORT_BPAD_PEN;
>  
> -	/*
> -	 * actually reroute the event.
> -	 * No need to check if wacom->shared->pen is valid, hid_input_report()
> -	 * will check for us.
> -	 */
> -	hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
> -			 WACOM_PKGLEN_PENABLED, 1);
> +	rcu_read_lock();

Since the driver already uses guard notation we can use

	guard(rcu)();

> +	pen = rcu_dereference(wacom->shared->pen);
> +	if (pen)
> +		hid_input_report(pen, HID_INPUT_REPORT, data,
> +				 WACOM_PKGLEN_PENABLED, 1);
> +	rcu_read_unlock();
>  
>  	data[0] = prefix;
>  }

Otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
