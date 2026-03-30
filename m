Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965C38734D
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914941; cv=none; b=LTyvE8DP029EWsmLupX2xGmg1zxpsDiJhVsGwXK2UDmoLlmt5CCwVzRmd/j8l80/uT38VYZQBDGazVrkPdvKK46E3AOg1I9fjcc8vgZH1IGu1+zyjqe2AD0WIzeSGRQ8TX5yJhM8aoWJk10uo7Gwxr42/uIW2F3EuUfIR6X7YOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914941; c=relaxed/simple;
	bh=LwI+CiE6pIO/AB8N59XqmvZNktl/MKerpTrg0HT0azw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f92KGX4/l5aDXaGOozOpI/7zfqim6bhvyNioS0l+E06+zvvqvlOTtB3JaN/4JxKYh8F+/BlX4umVHr2Vd8UP+xLMuCq9MlJaaC9KE19QA8A3tBo9yd5Hs2FLik911h9brILT1dXTBPHO4tJeYAzuNibfjiof0hN78LrFGNW63tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTLVi7Dj; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTLVi7Dj"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4b77adso7193740c88.1
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774914939; x=1775519739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg8D8XEfOkFVOMw5ZtVCdG4PbsHxrk/qzzwRvU2t3HM=;
        b=aTLVi7DjLQx6KM2Co4mkQcN344ab7o0mTsEQWZJ0mHRFWM5Lar/hQcu9ZJOIuRxSFh
         M3z55HX7Ifom76CNmqnUtz+aVU2DX4Dfkp+rbHfc+jc9oPfmZTCAzfGPz3XQdd/pCrU2
         eF3pF8+Ege6AISSFobMGug94zNQg/ktfmaM6fZnXHEFjX/zyypMI1/aVDfmJO9S0TiZ1
         mYo7qhEIKwD1MX6D4W8Bki0CbHFpWR1KWzE0BTXaQV+ZZgcPP36jlJtKr85AoJ5xaxWv
         /vKinGK9u5fju6ugNNchCAWLDgtw+2ZSwYIvyO1sHUy4RcrxldXbpYwgYc4MMAd+kTp5
         v+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774914939; x=1775519739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg8D8XEfOkFVOMw5ZtVCdG4PbsHxrk/qzzwRvU2t3HM=;
        b=mEWVXdgFeipbBQdB1JLsCpNFJ+n9JgxA+ZI6u7bj2Y7eouDaNhFvkoRT2ChZSg1PoY
         C187pREng0z2ijcBUFkV3uAuqjDxD2HIwsoIzH5kTJdd4ga+2eM+fvno9DcodtlF6Ioq
         rVRDUv70faARM0zJj6tNFpr4UrfLshucK6GfmVphK/Ask1enQuVFR8xG90Z2Fid5HQE3
         RKuK5BLY4eT/NCGEDaRx/L1CEwsF+WY5aSSDwlha9FQ005AmGXG9e/SXLHfh30iJns5k
         lstk1bULtiO7NgNPtMxOx+Wo11XWX3e1h5xiTo7CuPpANWbhhUTQrB76eC6TmD15Z77N
         fQLw==
X-Gm-Message-State: AOJu0Yz+s4MeLyEGSJItjeP1Ar7ayV3CBTqUthwEaDE81QgKMEFi2/Ra
	xv2rOFc9ysK1Y6GQcDmWypz1dCKiWnxrpILOWNt1dJ7rCE+RWqQfZzq7MuFIUQ==
X-Gm-Gg: ATEYQzwzFesUD74fmgYLqFPwy6Pn94yg5/bEPnIwJHuumfOjigcyQrHOOyiRbbR07Xt
	W6T05lmx/brjvq4zJfOxa9u09jqi4Wxd0TBjDBWuhaIQpLXMV8UeM8n9UiKG7FC6MpODAxcNqLI
	QiIczMSSKh2SaK9vKPha0LmpbrZh5ZskpIByLOOKeQg38Oc/YJGw3yprLJvZ5GR3ueu4iPP325v
	LQ1YatpvWSorLqAWDlT3nmt41/rpP0w/yqJTBN5TcN1mGREO2ZTAbJQ/KSdVTiP0C4NMCqr71lh
	fPo35QGSMbH7gXoYnzXGpNMsqBZ6SsyY2Qpdlfpk1Ic9gilAQRZzToLj75+h9WliXoCsaqXyFis
	+IP0PAZ2q2bGLjvnr9EHyRTXTEoQD3XNXTam/6C0/kgbmmAGtho2wNP4WS2CpBe9SgexpPW2FYQ
	OPmmOK1lDUzdmrrsXiW1ybj2J+Fx6EhfDBcxIRrHSgJ1hJWaOmFU4ZEorKHRdUjwMw
X-Received: by 2002:a05:7022:505:b0:128:ea68:27f1 with SMTP id a92af1059eb24-12ab28de6cfmr7843019c88.23.1774914939203;
        Mon, 30 Mar 2026 16:55:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm14277064c88.3.2026.03.30.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 16:55:38 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:55:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Input: refactor USB endpoint lookups
Message-ID: <acsNayeGbU6cRw3P@google.com>
References: <20260330095948.1663141-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330095948.1663141-1-johan@kernel.org>

On Mon, Mar 30, 2026 at 11:59:44AM +0200, Johan Hovold wrote:
> Use the common USB helpers for looking up bulk and interrupt endpoints
> instead of open coding.

Applied the lot, thank you.

-- 
Dmitry
