Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D823E32B
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588057; cv=none; b=ChbUCckHSxjYi5+8XTrAj/B85akAJv0EvvjY6g2x164ejVrEQSx3xj3ZNGPd3ixo6S7KpZ3rk4b3CsVXpDmJBuZhkNoghbQItro3vTpsScDlUgxe7uhYgOj5Guxek5q0ckFEEgKmVixmLD9O5FWKPVhbS8KMWJpkCD5ofud+D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588057; c=relaxed/simple;
	bh=JhpmgQxGqFpXyJFSqedylYLfmAiWGgCRpP+pM7jPeV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyihko1tE/Bvn4lQA96fmECvncECoh7aa8L2FSkaRk8OemOYRXWTudttH6Notp9X5lVk5rzTSL/F7Afab9Lp5L1T9O/Yc5t6zNz1/tIZaEcIVSiR1/B6frpjiy5p2JgwuLDRNO9Pxusf7xfoLNjJ60y8S6Eqnu7snKOCqnGjrC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqRu9O7q; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqRu9O7q"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so7662550c88.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 17:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772588056; x=1773192856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hx9LcQYiXKsj58NECRJHVbTkd1by0K5IAyMx09PxHU=;
        b=cqRu9O7qOtYsO0hlwepUCpLISRN6Xbkdbst2cSCr71aDALO9AWDbEdZ5UfCQl+iV54
         S9I2gZ5k4FYSDlQHY+5/RIfx9UPXVtA5lRJQmx0r5kyvbJe4T+Fx2GorrEdRtk3vBYXY
         DAjrmE0e+xydX3E4Q4f+f7E4dabYtI1udMOevWyzAtsNI0YZgn8o8Vd5nkvZL3oXaEqW
         ZtkUwZI5pCgMmzcrzS+RLb+BUNdZtL0U//qiZo83Q0EtINywAYze7kqZOcAob6y7ISQo
         45/XPJgqlDPuR+Ny4q2L3N8jPkeDJPgswud97Z5ez5qcyvF7LEufkOYYJyRjFGIH0S8G
         crWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772588056; x=1773192856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hx9LcQYiXKsj58NECRJHVbTkd1by0K5IAyMx09PxHU=;
        b=RgxQIr7s1zdUE1JBoLLPpWB1qvdyl/InWqrtpgaYslrGg5yz+cMrSWlptcJlxw5O/r
         Nz/nifdjiC/9J7uNISN0/cu6PILSjqJrQjcYyjlG0To2Tgo7jB2R1Ie+aW84B4t0SB2H
         3M9qHM3ratO4FdcF48KBDP3K4NFjxl+3Fr4fua4TLbD+W142Cj6c67TdVG3zu+H0feyE
         0qsJxDdAcNfQ/BXJhGABejetk26ll8RdVsR+5HVByuGJNo/0GFGLrg1tSlL+BUxjQz0a
         v34sZIxuYcSoPEIHsItVKImr5aE6NSNOUlQeMRABz78DmOWFoBHFxz7FvZr9/aI6RoHy
         9QDg==
X-Forwarded-Encrypted: i=1; AJvYcCVOHh7AykpXu/Qv6RevZJ85eBYfJ3kIIdarQNEyT2pAdBSDKsg2HIG5ih+xjZhTQSf/218w+fGdZ8MXaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAr6CwJzPDy/rzjheSIlDawn3h3CHnOUmS7/sFfv1MVIS0+kZH
	xZ51Qm4c9Xj30t3s7EAlf074AmmMeSOcLEZjnOQiqQydGZAOKy6cxoYUvjLSKw==
X-Gm-Gg: ATEYQzym2RT9Wy+s/0I9rhty0PKhwX+GG3mGYpWt+636fHisJKjh/03SMzL2NIJmarT
	a5ylMXGwjtDJcBRyouDnysFb2E81x83y2iMHith4KZMi+AUp8BHCp7AdhBRjHYorELmSu3sIpzr
	2ybNbKOZv2g6RCUpdJJckBVGU+CskTPfiMF6+sAXq1uORyF8XqOOtUtUHRf5q8buHfDAjTLDc0+
	sES0AN9E0LtCcLHQe6cq0XHW8xlOei3o6d4pvNIr/WTBoF5RdEJIDcKQkjSilt2qXUjhdvkERaC
	lPk8gGjx12CvufqQEhnP0FL9HyJsaWxKNilKUal9Nc17c0/+b5JvC3zJ1eC69kODk5ca2Os9WRF
	lUk42tFyBqESOj5ukszOuGeQ9wZ/Mi3LzReNcCNIPJzBncah90YayMlr7p1fpsLvqZZL0t2t76W
	mh/kbMtCPN3WBReUtr5VGq5T4Vr6Kq1o9PQAcQ/xBiMFzJ4dZnWQguGDDivSVVUnPErpRJTKrmP
	oA=
X-Received: by 2002:a05:7022:6899:b0:11b:9386:a386 with SMTP id a92af1059eb24-128b70eb489mr100159c88.41.1772588055657;
        Tue, 03 Mar 2026 17:34:15 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm7241075eec.15.2026.03.03.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:34:15 -0800 (PST)
Date: Tue, 3 Mar 2026 17:34:12 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: expose xinput capabilities via sysattr
Message-ID: <aaeLgPyFDeA6dxq1@google.com>
References: <20260304010345.1355896-2-sanjay.govind9@gmail.com>
 <aaeI1p_Zd0v31-p1@google.com>
 <CALQgdA0PL82yLxWbjcqchWzsf+bA7_Egq9hZFzz7toL4kByAvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQgdA0PL82yLxWbjcqchWzsf+bA7_Egq9hZFzz7toL4kByAvw@mail.gmail.com>

On Wed, Mar 04, 2026 at 02:27:42PM +1300, Sanjay Govind wrote:
> I don't really mind how we communicate this data, if there's a better route
> for exposing these capabilities I'd be happy to use that.

Please do not top post.

You need to start with enumerating what data is currently not available
through other means and why it is needed. Is this something that other
gamepad-like devices also lack?

Thanks.

-- 
Dmitry
