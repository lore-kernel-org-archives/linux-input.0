Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0F3D3323
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659763; cv=none; b=QyDKr2/P7KD4hm8mYIG0viHszhMVPoLO9/wrNZKJ6ZwWVojx0WlILwY7Lm6oeDlexIEB9oT3WpM/zuf/+46SLyDX/301HVzMHD6iQKE/C3ELtHnkMMbpC9Y1Z6d6UGUhWdA25Qf6S8/qiSwlz898JMbkYJY1Gp7l0P4Saf69I00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659763; c=relaxed/simple;
	bh=o9STrf/iCq3m+e74zKqDCADz4OBNvsL234xRZz9WpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6nrkgl1h8Zb6ux4ebEv6q44m/NLXTlIsNmFwfUwv4vCAZon062qp3LrilVXfXn5wJ3EFjsBUQxwHFlUaYFYKXWmZXBIQw99ElZyK+cWe3klqtW8ItldSfg5KY3bk2d3VeF9d0U578Axfoo8Vj2goWzxfC2Ym+okxYbitnLsYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThejYIUp; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThejYIUp"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c15849aa2cso8771157eec.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 07:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775659761; x=1776264561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9fAZcQ01x9kJAyrTUxUiIA4cCSrlzmv9hEhGyXokOQ=;
        b=ThejYIUprGlAWt1YwLst3ihL5aLuarK7eTbA6G3jvNmj9HxXrsGPXBUO8/1iXNWspc
         VMOh6Bufj5zPw2c0YqZn3D6xCKUOKOfzpOvOu6diaQwtSZUx6KssmHIVHynlAM1rtiMO
         02KTnu2Kn39wQ5ScWfA3s7yWyFakNj4NbIDWkOlFW0v3blPRI59TJPdbrrcGbQfmNQ+4
         METoKdbHvcL0ub/l9cHEla4RPY7Q43pJQ6eBL12EwChxIwwTMFtArKwUyb95HEFhYPwP
         lR8TLBGG/q7S44fSHO8vsJex+2zFKlb8KCS/b3SlXfM+x+ndqMJjKhrl2llZ/UueRrg/
         LFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659761; x=1776264561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9fAZcQ01x9kJAyrTUxUiIA4cCSrlzmv9hEhGyXokOQ=;
        b=TxIoTDoun5omO0GrLFqyqtSlNFCzTiIjmLDXewNNu5AWwg5YFwXr18JW96wKslu9Sv
         8twsZ0w857EQB9ZSqrMgnGjUyA2A5jHLZ4F8Oyuhv/guEg2NHhuCIy3rlSLrAyGOCLeZ
         +1+N0PdjGguGxD+TPVZar0vtCfquBYnRAByR0aoiuPJSQUNdlxp0MGVPn7maKUnSMGqj
         UG5TVzbQW8cSFMafRmpHZWRCjf250JrFSZdoDDyTs7+sowCf3Z//mSYRcPnEZeGt5uZr
         Smhz7C4PpM6Vf811wrNrYBDJ0hADITeZrk7oSJkqh/sKMmok79kiw7NR6U0qGsgedGGQ
         UNng==
X-Gm-Message-State: AOJu0YzviKkI6G6pWCbXE7i0o2tnlti8oFSvDSqW56vHkFqc4dQD7Ptw
	gUKgEz2ivzw6OLKqSfWziQbu0+xzJr8nu3lYBRKqZoNWH9FMcv45V5yq
X-Gm-Gg: AeBDietsuGcDsNMokWzqVlgGJMdMKoULlWsh7gNZai0nPIl3aNk7VXxIW39DlRj6kjv
	gf6oIcpU7Vcd+aZqr+NiYBzkm2x9GJM24SCQpuXZGmMAL4uG/u2Zt7EKJ6yK8nUsHot/r0Owo1D
	x1+f+a81Mq+mt2S+HT+rtY+mHpGUc0PyPewxzHRHm3ECl9nLhgU44IuCh7YTJCjzE3Q4SzDWmv9
	0E8x9uk3pf0UTDYVvnuLS1sTD5jYmkN+tsmliom1SjBJ4Y3HZ/hD3dCL/3AQJCeNmEJb57YsVIt
	rvJxXNR4sIAFfckEJhAPiewmFzvh0Mq5IB7EQv0jQfdZu/Q0rqMJ2UOTPXAAmCmbaEEUT6d8oj4
	itKxp+H6tYrrHcyOnXU7m8zVC6SyoIaKqfDbFgbvaAAGEiCPV5cmlQevwULeivTBN24iE/Uuz8W
	apV5A9ES2LlKOMl8LrR3ksWO4rMcsOOKubnDw30bo8HtoP25E9cBkzMB7RRFCk0jzt
X-Received: by 2002:a05:693c:3005:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2cbf9ee9e0amr10566761eec.8.1775659761014;
        Wed, 08 Apr 2026 07:49:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c30asm21827763eec.15.2026.04.08.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:49:20 -0700 (PDT)
Date: Wed, 8 Apr 2026 07:49:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vojtech Pavlik <vojtech@ucw.cz>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [RFC PATCH 3/5] Input: pc110pad - remove driver
Message-ID: <adZqt-67eZHqewSS@google.com>
References: <20240808172733.1194442-4-dmitry.torokhov@gmail.com>
 <20260407195138.GA251078@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407195138.GA251078@bhelgaas>

On Tue, Apr 07, 2026 at 02:51:38PM -0500, Bjorn Helgaas wrote:
> [+cc Maciej]
> 
> On Thu, Aug 08, 2024 at 10:27:29AM -0700, Dmitry Torokhov wrote:
> > Palm Top PC 110 is a handheld personal computer with 80486SX CPU that
> > was released exclusively in Japan in September 1995.
> > 
> > While the kernel still supports 486 CPU it is highly unlikely that
> > anyone is using this device with the latest kernel.
> > 
> > Remove the driver.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> I applied this patch only to remove pc110pad to pci/enumeration for
> v7.1, since "x86/cpu: Remove M486/M486SX/ELAN support" has been queued
> for v7.1:
> https://lore.kernel.org/all/20251214084710.3606385-2-mingo@kernel.org/
> 
> I put this in the PCI tree because pc110pad was the only user of
> no_pci_devices(), which we can now remove as well.

And I am going to apply the rest of the series. They are really simply a
historical curiosity now.

Thanks.

-- 
Dmitry
