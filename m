Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2178394499
	for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426071; cv=pass; b=cg6f7bRC7C9V2OXGyNiv/HrC3EFbg+8j0TGvHt0yp/0YKSZUSd8DpigG1xWQJ5tbnAU6CAecqUE6v9bxWtmbJ/+MRbt5zRYn7I0HJkcFmXUMlH9ItF87ZG+U+29jk+QYWyyRKlzZJgLtlUNOeGHrslQvC7Wb6cpofNS3UDGOjuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426071; c=relaxed/simple;
	bh=qE/M7ktEn0N59mdnr1atw8SbEh4Cm/p0PsekrgTMOKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBUkeQ+OZfKTXZtBK3phM77Sd6GUd98FWt5dLwgKer5q1uQXioU6SS6NTkKjzm8dc4TX18nC80FnDTklJCI5f1B+pCm6nWtv/zgwe5gfuy3BxIIZmcrLukKxhjdUjQuFLRpN2/2dn/1G9+IdMXucS7kim2yxmZuHsl/oa020zyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcCLTl1t; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcCLTl1t"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso6746565e9.2
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2026 04:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776426069; cv=none;
        d=google.com; s=arc-20240605;
        b=QgxUftm4CLdQXK9IeRBtUGJfpbjk6DVsi9wxmnPa1zBUdmc/i3lh4J8fnTyV2xcSS3
         kNOdUP26VD0V9KDwjlY10D0hjtGrC5esbCNvZ/1cwdDfShUO8vNeTwcXkCQrea6GFY9E
         lwSFSLu5jYGYg3s8zmjP6Gq1TPG8hkVaTaffpOs+vbi6lRPCcCO1WhQwfq4sVC+dxu/A
         8TTvE1W71sniYKayqLgovVn0/nfZGW+arlw+NQ2qkvIH9OaUNQk/HEf8/KDgl9reKF7V
         ZFQ7Q8QW59f1+8rCWJHODZiA9KdZo5FD4q8rZA4s6sh+vuHIhd1iJn+BHuYgiyIAsKJz
         iB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        fh=z7lTkMYdbSiaPahfcIeCEP6fz7xVWr7SOnAo94kUwWc=;
        b=OkGKcxZ254dFJyllG3WrHvDcmzCeS114TKF65OpDQu1SD/bUfkz3PzMU24Q+jNtFYG
         AZiDWRqdOUnpCzWsA1QypC008geg9RHjbHx4vKU71YAbHJLamzIUu/tBz+74+n2nvmhF
         m1z7A2H5bedho36lJOszTN+LD/bFUEe/eWqWJ2G9u+YGYp2DGMIeMZrN2FQxA8mxAc1K
         GMl+yh1VAXDPuueo4T+EN65zlM0IHUAzcII819q6uiaXDPbRr7RatZIE0FjioXp4SSfC
         0ZIvVNEAMMxdVqQ9yTwrl08xz5SH7oRde8do2d+3pPwXq2UDYlL5TY98Wm/9emIc2ifx
         BBjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776426069; x=1777030869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        b=QcCLTl1tKAbMk8xC4Kk3C6yuu1WiZHIFXcg64Xu0cpb8GLHx89fS+2px9o2+Kig/+L
         TerCsVBJegzHKfR5CqHdN/lXgfllTu7kAjZPuN50rgwQCZ+qMo054nTja5jZ5RBY0EyI
         OQvNo1S106B5AyvVDqjS7ZTNpTABwpdjrhdQ/pnGNylMG4QHfHDSUCSkR5lR+xp5Qnoh
         /99fWwKzVTen+roFHyJSLICyLyihUuwumCo7TqSwXcelgqW8rRtQm/uO97keOjT2JrLY
         IzgW3KY40QboM6eqxs019+RRNAOOiagLdaTBkh/kOWfSwVBsqPTFJJbynSpPNchNJQfG
         1fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776426069; x=1777030869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yrXYBy/QriFyeZcNaaVKwZRLpB5Hr40xXAwGnR3uJs=;
        b=ViZ0ddPBT2ICo+J1rvPegNa03z/CkcCUJ6jhsKqYAaRj0M7MbXKREO4ZLKsp+HQAuT
         j6vU90D1AvpI4spxAD8kfxpzi8+KhDKIUhc1ykrC+s4TGpLtrB98uktHEY2kcsftVrmb
         wWdcAIBH23Ri1P9a/1JHSJ5xTt6BwbJs1RRZuuHd/eIXUO57WGtVdVRjloptYUStIuCI
         NTO0JJdyCRC4xrHm//sWEUea5LRFGmigKq+3oAc4jK/MRdPfwXdAXYK8QVsERDjFKKAa
         NTgE0Lmg4Z/I/L1Tpitx8m7rFJfZbkAWHIyaSlyyUv7Gxt0h3NcIbqe4eQZU6Qe6j5oF
         7jvw==
X-Forwarded-Encrypted: i=1; AFNElJ9yb5oNF1fK996dYX7aX9TmsXYm3+zcr379NHz/KnpwkcnuGeN4aDgx0QZYW/YeoRE3+tekzyPqzotqlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzat07AN+ERRxwyiAQbsw0KQeW/3Pz7VGtgMGiD4ayBHb8POEcv
	NqAmw4c0me1DiL7GynPj41JSLI8U5k/ueiPnvs4iNQdmKZHiBnDXwdPAfz5y46RtwHiA//uv4NO
	t99QsAQUIWKZ5QTjNr36IlstFMpgTJEQ=
X-Gm-Gg: AeBDieuM6/p5oscSutpkcyQr1j9mFoeHe/C+dLySuVP8GZqxXtuqiMc/0T3VrckKl7A
	qBH3ukbeAOzayKfmF+SdTwNVwWlACYhAu+wjA9jSV5dSRL6snKdT5/KVgYPY+vCJn7SUdQPKwLf
	/0cywHaMW7EfEMKTmv3NNblU9ijs0b4Z1WyPzzkKpr/2CEvupfoR69xNJShbBp8PpkRm2DAuiJ1
	szba5uTfu/PvHQKuZ6bA/3PAu+pXJt+bZM+1A2ucSybqmP6gxydzQ9tcWo4rlMcmvoiwJyBaUh0
	sxnUkayRpOMT0+YUNI750LXl7uzojO9NJrE8E67eCXaSeXxVMzAUr+tFyUlhbpwLuuvPJhssi+/
	rsWUnEzDqwEDsQSSoCrF0APjL7SDd0zhX8AUVj/WM0iSb5c5mL5uAt00javij9QPL5DI+XqQ8uA
	PX7uXtkEYDd9c3DnNW
X-Received: by 2002:a05:600c:810c:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-488fb79567amr24359695e9.29.1776426068797; Fri, 17 Apr 2026
 04:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417112808.1280-1-joshua.crofts1@gmail.com> <aeIajr-NaBGdhvK9@ashevche-desk.local>
In-Reply-To: <aeIajr-NaBGdhvK9@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 17 Apr 2026 13:40:57 +0200
X-Gm-Features: AQROBzDY0XGmZFVB4m_-CwfXO3jjob3O_F0dI1q_SN8S45oIFW4dQRs8kjENFx4
Message-ID: <CALoEA-zoEgCpzrnXDmwCKOWFPMF3p0C+rhxLFw8mLq+p-HFG1g@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Apr 2026 at 13:33, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Please, use the same types as defined in the respective data structure.
> https://elixir.bootlin.com/linux/v7.0/source/include/linux/hid-sensor-hub.h#L87

Fair enough, I'll send a version using u32 tomorrow.

-- 
Kind regards

CJD
