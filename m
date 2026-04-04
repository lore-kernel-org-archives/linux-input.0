Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623031A065
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775280892; cv=none; b=Nxt5CwXfo2L6jUs0poqIxbrVfE8csRl6/94mKBqIY8AfHXKouxRepC6zYT6GHdnLPdBayYkMeQh3sZs5PZJYf6zE9CPbe8g2MP18ziZ9LckzhQ4o2VokykvckcjUDdJdpuMntySK2saTWEa4Z4voxL0HNGJGcNP/aeXnAVGLt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775280892; c=relaxed/simple;
	bh=bFLPTySGRi/LJdYJ0xYHfMvx9HM4qK4POHUsXlq1C5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGZXCZVksnrEjpEC+qyrEO/UsVq7qWFKrV95qY64Xd27LWmJUFZ+jFkqB+OyMbIcsB5heTmk9JJoNVwa2NAZAaynLDcs18PBObjYzN1f6eUdsoaYfpzOydExS7T2uRRyD+xCxGD1s7JLs3iZWN+TGX49lepcMfcAl4W7+u5Rq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwbvjVD7; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwbvjVD7"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2629802eec.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 22:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775280891; x=1775885691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=202lC+qQpiT3rD+WzQyBCqZNjdHmqtjJn6nwBOOF08g=;
        b=HwbvjVD7bYEMtK4Y8LHgwBT6xXFnxZqmy9c6cgjKYAG55omBhyg500z0KcRlT+eJ7j
         1XdWqHTpFPtRzkYLQUxW/p6ACaTkd8uRQbxUgUM9ifTXKkvOQIoiQg9S1A1PMPYxpEnZ
         aW3pRYS6OUNTZFKK1fCnd4ZmwBMNvJdE6DFxLRLGFFa7jOdBvJfQIsIn9vZSy35BIOeJ
         3FMF+9ivy6taRQ3uBFLOJiyKTr6B0u1ISPk/FE0yKUuHlVzdPSQx5TzfXPkvxw0o81DI
         NY2Lvcp2Enk1RNKyvYEuCIa5Z8ZrOsXdKRkE2x2+j+HCNn2My5PRIzfeocXjzezg7VNv
         8IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775280891; x=1775885691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=202lC+qQpiT3rD+WzQyBCqZNjdHmqtjJn6nwBOOF08g=;
        b=k+0Y7YX4Km8a5VZ0k5yZL/9UcmUx20yvUtj4H2SMPwwmuYY5StFOeS+swJeCR7AbxF
         jcAdx09Q+bkHgTd8dRSWtKP1+B7P7wkV025XpDcVOcfbSFxVQaQlniJaRRi8gjyw53LV
         vGe4TSXaengklWBEEMheqT6Rr7w5tyJ0lct1oB4tujKK2FdrpYmjKrFmaiv87471MGf7
         /1Ywni4xyHohRID+MMxWPNHHCDtlnVtXQjpQo7rkSZ8ciFZvwo7tNWT+V+hAaH0sed/v
         vg3saLpBgVTs2lauakHrlBMzO/zllBaukYhw4IKQgXf9efMg3ahCqFBVemFASim3WPpx
         zRPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVQfQIiScxkgLwfExX9vjPLn3CrKuFaks3limfYgSbp2Vd9mT5jdVzEQxkygHwIben9aHA3yl9Ims/xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWkYTtij1AXcMw7T/hYRnDNSTnfa4YlrTzubxdSp+KqVq36/6
	cpQgJpzU/JzmfaBFjdGiJNFYtT+SNZRaPVXJPyaixGopUPr5rXcU+czt
X-Gm-Gg: AeBDieuqqovIJPRGhLoqpSMU/OJ2LX3/OPhPKSwKD79rJVUbaJ5oJptPu4Zeb4g8pON
	eShNl9SGjoWI8L9ddck8FrAMMF+apB8uiWg0WIatcOBsUHlfaq5G+1a1doWecg5fs/2PpM2LMVq
	f0T+gOfyNronAghsEzYZoYW/kunNbPh16yKmpWmE1ja+xgpCKlN240/GNroLwJoN6P5cpf2L2Nf
	CMEN+AiTVZuDil93SBMmEtbTEP+dIjkADNlq4BRmcnPqS/bg4MbZS7U+ul0ke2wkSsry85IGzkO
	J4o/k/FtXDqwtgwlLLKepf0+z3jcJj/wYDGRg7e/33KIrsX+W5P2q4KtF2qoO7sJn5VnzrtIiv/
	d/d2OBw3wNkpLzebLuuMd43/jukdivhVWGMWxU+svekW9vHImMOpkM7sUGjmKJxUFiE0NMrO75d
	QemMBerGtP+CKuXBWOp5S+ukaupj9Po7JtS8pwyR9CxIJuHvrSmpriIxAsTyqQHKSg
X-Received: by 2002:a05:7301:1288:b0:2b7:fdb6:ccf6 with SMTP id 5a478bee46e88-2cbf9fe7b2dmr2656201eec.14.1775280890766;
        Fri, 03 Apr 2026 22:34:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2357:9278:e4dd:85f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm5031825eec.21.2026.04.03.22.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 22:34:50 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:34:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Lode Willems <me@lodewillems.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xpad: Add RedOctane Games vendor id
Message-ID: <adCi4mG9C519Q38q@google.com>
References: <20260311213106.271577-2-sanjay.govind9@gmail.com>
 <adCb-7uNtq90McnN@google.com>
 <CALQgdA3AzKnjD-rooix=8K9-Vh_zZa7HaZdM-mHhgqg=tVPxYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALQgdA3AzKnjD-rooix=8K9-Vh_zZa7HaZdM-mHhgqg=tVPxYQ@mail.gmail.com>

On Sat, Apr 04, 2026 at 06:13:25PM +1300, Sanjay Govind wrote:
> On Sat, Apr 4, 2026 at 6:07 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Don't we also need to add some entries to the xpad_device table?
> 
> It's not strictly necessary, xpad will pick the devices up with just
> the vendor id, since they have the correct class, subclass and
> protocol needed for matching, you only really need to put them into
> xpad_device if you want to customize the name or give it different
> flags, and that isn't necessary for these devices. A few of these
> devices are still in development, so we don't have PIDs assigned yet.

OK, I'll queue it to the next release then.

Thanks.

-- 
Dmitry
