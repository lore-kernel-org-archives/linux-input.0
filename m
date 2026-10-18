Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54537F006
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792303995; cv=none; b=c221B6ETJy3/3ulThUTnnQiKTOSzpRM3S4ODbVyvOg5XRuGGjwxNt93Wy8oPIU313qsFL7xz3p7ltu8ZNnRazyPzpVgMrYPWMDY/ndfkX2fr7IhI4l2di59VTyqY2hArMV6AaAbwnPIQbaRKO5JDQuzDxHVd65niIcCOrp0EkWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792303995; c=relaxed/simple;
	bh=vnmtHZdDhZBGvwYO/xiOdpYmtwT2RnZuhXGsUW+JVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+8rTrMUX9nBpSPXpbA1eLIbL6zG79A+9XtvgT5dZP9qLt9RHpmUMGUDFaWUynKxKyQ5mcIPR06tmN5V4tu9vIpW5UJvvZ79z9+4G8HXR5zJrjhNMOfr/sdI/zUykfPqiX+KFhuhCp0vMUuEYcewWzzzMIWgqNKPFRTgE57AGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/cZlE06; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/cZlE06"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so2722653eec.1
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792303993; x=1792908793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p0BOEICInirRlc3DFY+n9uEZ/XoIYazkQMk4BKM0uvY=;
        b=A/cZlE06yFSRDSGnwJykwHaXJ3wvOSifcelBJ5hA61DVhrb3TLcfGttaQMpbEDCAuw
         dJRc2q6o6N8mFcKbYdHbp9jfiKkBVPGcA9sR5sQz7rFOwkDFJehyEc+PA2lLpwlZutYc
         /rKtLB6Uh/yJiqXqoH4PXefOkzew7fwU5wamXKYKy8rPzm6jVjeBw/S8eFR1zEU5SV5s
         7imG+/cySN7Zr7Xk0qchaZLo8kmwyJv5j1uIJE1SQ9CYWl6vD58aKoLOTbrN10JOffo6
         u2TLcIJl+M2YmPUyigYFgqKLaPGQ4VjaBoT/KTsXiD41XzbB+uspgWEZ1AOPtrvhsiiA
         RS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792303993; x=1792908793;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0BOEICInirRlc3DFY+n9uEZ/XoIYazkQMk4BKM0uvY=;
        b=cqD7TRkscpZKNuxsEbUm0KXZBwtZHxbS1A0uNToxhLiNUjV74Ar2Ref+5s2r9JdeGN
         RcJ/HQ35hA7CbcNoepo1lfSRWn+DlTgNayYEDDBVJeKoyZETcjtTv0yEYYbiJh7APGs6
         wu0zlABoU70Etb02VFKiIsgpXT93yUPnchwxKkdys0iZYfi/vGEH2hQe1jTZrGJzQG62
         80u56wTlaynIUR6YP87oC6g1569q1Ozg/CRsyU6HcXLf0Zf4+0av8vUHeqnfRpXoyMi6
         Zr7UU45vlwgSOGPnLWwrzsxlpyk/RP6s7tE29sufvA4b4pWJwkTDPHVlTRZvePSh4ZS4
         GzVg==
X-Forwarded-Encrypted: i=1; AKwUvBy0ftjgG7hVHQTypZn8uQN0xvni1L4G2kAFONEGKmgBjU9xGxeIxjuQUVIAxJeBJ8q6JnnXL2pr20VgeA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKlUVo+HsJDeV/tZABLxjwCLMgQasqJHLS1ZNdx1PSotonXnGuL
	83zvlnl6TCt1HLlViuVtAO4EhwfIQDA95f2Bpp6pHjGRYeAWei1I3shS38y0JQ==
X-Gm-Gg: AYBFou1kJPbckVzhQ94h0lRHG5rC+egOsR1f1UhzqfTufmAI1vIDfOICSdCdu5xWl+0
	45OgSuL9/Op5bklrRRXY6uTevi7O1L2zKk6oUyFg0RD0xTAb+GPf9QgGwu+QiLnxTiSVv/4+lgr
	HoK0NWlokSVb67NOckyp3HrnSk2A489uOpTkO1Sa7wiPahCurbrVb3CPqvj0IKDjONu8HGuilYD
	1tJRRpSbMUzJ6oxS8dhl68WDfsEoKmTOpCv/B6eDIQUKkRQQvwX/5sxtj8aTvM9t8IaKibjSzvv
	9SMj2cPVU1w1PpXg+CjzBYLt7gKbdlFeXgmRAd1YXmE8ImVcPm/mYPO58FONy4ZmQC05m/q9tRZ
	YSZFO9UhHS/MKA00zaG4Fgvxwy9r5uWWZL2+z4a11a5lr/N/f/g2YiDc1pB3XNtULmLcl2mxdmY
	BkCBUJYIjj9/bzQnKsau6CL8mkrATddVLcU0KlPd31ykp5OOIkkJHZzmhi/X7vBrzAFPA0LI/hQ
	BcfQax/k7R20jluQOo1qUb3dyFdKjKal04/vKI=
X-Received: by 2002:a05:693c:87c2:10b0:35b:20d6:8eae with SMTP id 5a478bee46e88-3619ea243ccmr6997406eec.3.1792303993423;
        Sat, 17 Oct 2026 23:13:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:297c:6f48:9e5:4e5b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm25179839eec.2.2026.10.17.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 23:13:12 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:13:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] Input: da9055_onkey - free the requested IRQ on removal
Message-ID: <atRjQCqkFbt6I3LQ@google.com>
References: <179229215687.3924264.8583597004889642167.da9055-onkey@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179229215687.3924264.8583597004889642167.da9055-onkey@gmail.com>

Hi Myeonghun,

On Sat, Oct 17, 2026 at 10:56:50PM -0400, Myeonghun Pak wrote:
> platform_get_irq_byname() returns the Linux IRQ number already
> translated by the MFD core. The probe path requests this IRQ directly,
> but remove passes it through regmap_irq_get_virq() again as a chip-local
> index.
> 
> This can access beyond the chip IRQ table or yield a different IRQ, so
> the requested ONKEY interrupt is not released. An interrupt after the
> work cancellation can then access the unregistered input device or queue
> work referencing the freed onkey state.
> 
> Remove the second translation so free_irq() stops the same producer that
> probe installed before the delayed work and input device are torn down.

I think it is better to convert the driver to devm as in the patch I
just sent out, it will take care of this issue as well as make the code
simpler.

Thanks.

-- 
Dmitry
