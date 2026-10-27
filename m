Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126463;
	b=fUCqbFi/gOar6rrORPJjhhgphx1/vPEl1FSLFL684JOI9oREt1BIKyir/XzjvZTZIs6Z
	 4ZrT794etDv5JCMkVSXu2ePXyQ+83TUl7tPvmDY8wZFrVM+rvjhI1l/xrmnREUiXFsPxd
	 YqKeG1Z0V1iofNNZh0YE4pM5USy08A8PmZBstCGExEGIN+B7FEiPsOsBw8bfmccjblZrs
	 4rxMA8MlH2m/vAL+xngTcmFcg5A1Ea266m0VqImnAbC4KJNW3oN71fGl4yxssp+3U0jCe
	 KxWg9iRM+h+YJQ0wAUcikNrbtcWbXJe546Axe8VTu8j4SpbUneRp6ME/Mxsq35auoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=MGa+01wbtNyQ/XVL80uNubXFCRJ1XOxsv/KCxmazccc=;
	b=FUhQQt9YatBlDdYUjrodgnq9EjbDqnZom1BxOAC2DXhWogBvpvis2zjodGSwq6yB19JX
	 Lau52qQLMeIsEXTh9wpZaec6ceQ5vW/tVnV7sAXLZoZiDCOVs1FYCkmdC2KdswQmohg2E
	 vYo0s1RDZNVNDkoRPV3y+u5Ejf3pixoN+Y60/ZVMdZgzeuHTadWPMxrgPRUYd21nxdZ2B
	 3pll0KbiI52Tsc3zSq3vu49VeI3LdPpjZ8xizLD62fgKhIX8khJLeH8Nov7jLG9VYnulL
	 9inHRon7yZKyZoyLKrkGgW2C+3GsmS+jKu7zQExR5F/QVQ6/iVOod5yoSK6kpKd9kow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRwwEtg8;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972E606A31A
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 18:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A972E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xRwwEtg8
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-18cdcfc05ffso197967c88.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126462; x=1793731262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGa+01wbtNyQ/XVL80uNubXFCRJ1XOxsv/KCxmazccc=;
        b=xRwwEtg8lVhrxd6fBgm2ijlywYQUnCNmHSjhNeIl098SYXq/KExi1Bdi0xvA5yzn9T
         Aviojnxm0v0ZDOIE2Jb6PeoYlvoBzI/0q+bnrUsrRYb4Ug/TyDmane9YiFz+2gngytg0
         pKuzr9l6Qt8AWppgOc7GYx97mjwyyzjgI44qlHc8xpjo2T+6xPwrw+nGHfDpHWuS9UPd
         leJp9poolLSIrZBCeTRCC0DEu5vYbKSGFHeqmdXksR2KUft9LjSXWNh7clIPNKyxZ53n
         rvUUktHK18LsmGHj+rahmkhp04vSqCrAoB7KX0NsIPtCymwlf96nRKySygVld62PJZ9i
         gRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126462; x=1793731262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MGa+01wbtNyQ/XVL80uNubXFCRJ1XOxsv/KCxmazccc=;
        b=jOfw6sadeysDa0Foxy5R5Vjj6zF/W4ViJX2M9gzQ4x1wQLNnjfVYZMpqcxvtw3aiun
         CerUqOaPxMr+uE4PjWY4QahwofAl/80r8PjPAlpAlgqpKUPv0m+eM2WuOX44HHi2uab7
         pCMClbYvoVTUeZ4e2jHhjWaU91AV7YMMyispt85/s0aPiq/pRM/Wn5t4bjLkUsHLe5Xk
         ZIio81lUP+hTWm5SxXoHuFlr3RWTHzpH+vaF7wVYhuDnBHSoMLOBZyLhvng4k5m09GbX
         5k4ovBW4OOVOR9dqzwRbXd/pdNoyfka0kWLb/GDx8v3GdadTFAL09y60beLvRvkJIkk0
         qwjA==
X-Gm-Message-State: AFq9FYIKFYUZpoHeuZXVziLjytMz1YGevB2qCXq5UIOl3jGC/qkbP314
	lCzL22CmdP6TdE5nFGoadADYj2P307l2WQm50+RlP5f8CP7G6nTuVvqmKW61Xg==
X-Gm-Gg: AYBFou0VmK+Tjmy6ATT5SGzBNCakieExmkYTNipqZl0NznmPAiRJ5umXT6MIF/dkAmh
	DA+SjgrCWhI5511lu/GP7jH0YJn1MKuR+fz5PJDAz/CM+dMCp6mCZyymiBd7LwTCC8DXXmvYvAN
	3suDx0Y0NAV9iTWXEtawOCsV7FlRazv18HqzjgE+mzyAW+keIOIO1w7JA46l6ox9N6+UeE2ZNbC
	kmyOziiXPcwum4Y4tHqJPFei9Z4KalLzIjSpJyhp4PCl7bSwDVpJ1vyum4EqQJbhY1Ne7En8ifM
	NJKQlgoUTAlArGNFMTMvPtWOL8YBriwtAGNB8ylbZH4yClOjXftKikri961JNYXwWemnYMKA9hy
	KV5lhnDbNpk8TOBvvmI+l+O6+Jpv5S3z5Qc0v7GdxEmxf42GzBOq5bZeN8bpC8wO1PMpqQEJNsz
	1+pWq23F0WpL1jZJxt3m+N5pWJbJGlG46HtwMPasKXTVvmkMOn/N4rQZvqwZ3zBxmE07K7w1dfl
	AOA67wEh0vJ82kJKytZADtmQa7HCMvSriCDlxSDcJjUvrgdwNb4rjw+P+8VIRG4vPTU+27KmRyy
	oe9sUmnhLW0lD5/uOoA3yHPEKxEFmd8Q0hBmv5t33sY=
X-Received: by 2002:a05:701b:4203:20b0:160:a80f:3ed2 with SMTP id a92af1059eb24-1a6cbf75033mr124085c88.10.1793126461616;
        Tue, 27 Oct 2026 11:41:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c9b00sm46942c88.15.2026.10.27.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:41:00 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:40:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: uinput: return -EINVAL for out-of-range
 UI_ABS_SETUP axis code
Message-ID: <auDwDT29Y0Ru-iEb@google.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
 <20260831192752.258550-3-ivanrwcm25@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831192752.258550-3-ivanrwcm25@gmail.com>

Hi Iván,

On Mon, Aug 31, 2026 at 04:27:52PM -0300, Iván Ezequiel Rodriguez wrote:
> uinput_abs_setup() rejects an axis code above ABS_MAX with -ERANGE, but
> the UI_ABS_SETUP documentation in include/uapi/linux/uinput.h states the
> ioctl may only fail with -EINVAL, -ENOMEM or -EFAULT. An out-of-range
> code is exactly the "incorrect values" case described there, and every
> other validation failure in this path already returns -EINVAL.
> 
> Return -EINVAL so the code matches its documented uapi contract.

I wonder if it would not be better to update the documentation rather
than change user-visible behavior.

Thanks.

-- 
Dmitry
