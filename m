Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B001F0E25
	for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774076797; cv=none; b=PY6E6i9oULP+Q+JXhsU/En+hnV7z5r0FMT1GwpiPhMGmLls01C0jIAuoneoyfM1eKUxdTsVLWN4jmxhcSAtODXI9AKsjK0vD6oLd7CTvZW23UJip0ozDFB5hvp1L6ZqiOg89mZJDwc4fm71tZ8cLheRCqdyu4/frMxVrRRq9Tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774076797; c=relaxed/simple;
	bh=z3fmfS+LImVeX1+tGTz9kHAxSZ1FCOZ2h8Lcu1Luy3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEOOhDav9iNBHUslVQnxfqnQb91doMLpR3m8zXGXlfWlcFfSRMuH3kA68e+uR24FCO/Vt/BYaw668Nt4U3TR5dbx/+F3/e5BXdsXh6KBmsxmA/Eov0Pz98nItb72JwhneDyEkZ0N5Drzqm4f6gzeSOpuqeFa5P3zC10Zu/7kdbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHOGOXhC; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHOGOXhC"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4e9694so3234872c88.1
        for <linux-input@vger.kernel.org>; Sat, 21 Mar 2026 00:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774076796; x=1774681596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8JZrG0B3dlINvpjIa5zOH6GeUNvOA11xJxOZvdAFWI=;
        b=NHOGOXhCUGyfgPmj2Qvrt1P3Cka8KkE3ASxzxDTyLaDysvSkwp+WugCppPjsi2vOKA
         siQkL3kv65Um1tq4mzcyyotIMcDkjoN/XuixDrPOLsJt1WOWA60fnn65Qt2nISsVmtjH
         aIeSGXePYtrslXnPveAzYfpBL/4djQLTe7q2xDc1bB4xD9ILZUGqQ9N3S94IFOR7BzLM
         4F4bY9dQZbF9kDQfxFjkMPlh0dj1dsCISjJYvIdMUB1SSxH6o8EJZ/hKTmZdHYuMP1K0
         fXUBoQLdX8pUqH7z8FhQZi01rDyUI5bSVcydLkGJlA0MBSjcqMopdDNHd7Zyv3x7Cx08
         kJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774076796; x=1774681596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8JZrG0B3dlINvpjIa5zOH6GeUNvOA11xJxOZvdAFWI=;
        b=GGbRg3w43q0EMusuMzPUuo2Ze/oFUFFEcBY0zBsdzmz6YjGKcFlOrZhijwxYAd2kZy
         ZQSlrjAXbAvwUkmttETY+TXeihbgCZkKkR4LktD75/QZV5UaciO/d2wpLnoJDcdlZ0Ct
         TvnPk9sPrpO78XkWZ1dVF2SSooNm+S4bmquwMFaGN0n3N5dqbfTSqi5cC8SGbJKky1wC
         wTBcKOn0kg80RcTSrpIY9GGcm8kbO+0QbUmwVr0aMwP0HzLLn5C0fftbYJwBAKNrrXGa
         Lh/mWqz7RL2QCT+C+XhsuuzQOQJVXEy6tPUOp7SqS+u6ly2BF9lHwCRBkr69f3Bge5EQ
         rFUg==
X-Gm-Message-State: AOJu0Yx8Jn/gaQ0WoYNQo+vhX3YbpN1Jukw+9pmi3Sx+mBlq0YIkv4NN
	A2zqw5R3WtcbyDG3ZTmf9PPUCfUKCnwmnyMXlVL5MKnm8mqfu+N1f9Rr
X-Gm-Gg: ATEYQzy3nsuUNtx/Fm5uSZiwyNpuKp+z66upSeDc9/Ecwu9MXCx0yii/P61UI8TNuXr
	orWCpmnfZ3Ig9lvfSSm+hJCnEwOe48r2RWtzfEX6i1h4KNPLz1sRezhSt1FQ/7aJ/8dXrzDu64U
	DffiugwKQ0qJ2nWvTgc981ewJvSPsdpR5D5Pd9/CZHaXzrfMwUcZJnQtUUvMzOMpAacsozs7FpR
	jA7vz3SPoc/YGqW8Uyk7a+MYl8FEVGrgZ3Gq8KPlJt42pB23cADmD3ztXkY5Wy1JIUK2IlLEqHn
	3rA/niOacg5fe0Owp8eAs/0T5bZN5+4jIhBOc0LkLelkT09xzkFSicjedWAv2KM3UuHf5VhLBvE
	Z6CL8+PYNF1zWiweOAZ6R1CPEFFHCYX+E2dCrArmFYbrxMyxfo+QRJ7ruJY0cmC8uHGpHr3gbqx
	uN9Zh+VEok5qmQnw0kLewP9fb5LBMG1COQKQ+aTGe1OeUv00hhpLktcmf5V4exRdDD
X-Received: by 2002:a05:7022:41a8:b0:127:33e0:ea33 with SMTP id a92af1059eb24-12a726b3177mr2850825c88.22.1774076795723;
        Sat, 21 Mar 2026 00:06:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9f7e:6d98:a88f:a990])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm4589877c88.4.2026.03.21.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:06:34 -0700 (PDT)
Date: Sat, 21 Mar 2026 00:06:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Xiong Nandi <xndchn@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gatien Chevallier <gatien.chevallier@foss.st.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH] Input: gpio-keys - add full support of EV_REL and EV_ABS
Message-ID: <ab5CXO6Fk7lhGazv@google.com>
References: <20260320145217.9088-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320145217.9088-1-xndchn@gmail.com>

Hi Xiong,

On Fri, Mar 20, 2026 at 10:52:14PM +0800, Xiong Nandi wrote:
> gpio_keys_gpio_report_event() handled EV_ABS but silently ignored EV_REL,
> while the polled driver supports both.  Extend the interrupt-driven driver
> to fire an EV_REL event on button press.
> 
> For EV_ABS, use a shared atomic counter per (type, code) pair so that
> a zero-value reset is sent only when the last active button on an axis
> is released, avoiding premature axis resets when multiple buttons share
> the same axis code.
> 
> Add gpio_keys_set_abs_params() to call input_set_abs_params() at setup
> time, deriving the axis min/max from the configured button values.
> Without this the input subsystem reports unbounded axis ranges.

Could you please split this out? It looks like there are 2 or 3
logically separate changes.

Thanks.

-- 
Dmitry
