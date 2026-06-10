Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6885369D7C
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131778; cv=none; b=EfxvxQcsQd1ByRCNzBdeDpN8zCsT4/qhN5SstC6qAoW8Sqi2thLMIXGCr9dvsNcHxWsfHRgKw1jQRHvg12zLHUBPASXZiha7jjwV2rxePNhgU8tSNR4gi3If6cw4bgFKjjkRi8Quk8zF7s7uPiM0nu17HlwPFoCeSZbNprOn0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131778; c=relaxed/simple;
	bh=8f/3NqncAopUkhQQ7pVzzHLYV7a2fGjbRa0tql4HClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtTnm4MOm4FswzHxQ5SIhvE/ypItsAJ+5RDMX1YIcbHMiLBrjAebBVH3RqAW8WR8OOZzBMesPNpYs4qQ9hjhYnZcjF+P5KHL6wIIflF2+1QyGtkF7uuhR7E9W4nNORV64DpRWwJUNCPMTRHRa/+ChYkdVQWzIjCoSRfMB80QWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhN7oK/b; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhN7oK/b"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30759632453so1898459eec.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781131777; x=1781736577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI334LxgKLmlRyNgL8Ur4M9ac5DP95VOVSvPZmKZ8RU=;
        b=KhN7oK/b7a9RnLa9mMF37ZK+61y4EPpJqL/eyVcaOOi8WXls07hj/HNRoHXMc0TLv2
         q1yN3KhGDnEuTziYHIHOhESubSuGRtGdqrfLmJwuQGt+ySMBlnV7KEG/rf3tijK4eZRa
         PueZi7+rCSNUtJqMUC+u7+qczgWuqThNgX5QehFr1eGeGs8ravUBC5gPlIR7Pt0yn9B+
         ytYzLvNC6/1WlXASHQUIXM/LIisIZrdlL2dYk5GNBUs7oBJhjpYLOPSs304IAI5jq17a
         Vv/X59nrCo0YGwd1Gnv5aYro4rimJ5bOTHTxpTPbtMqT/HTcISaeqtUpkkYr5c46aMP9
         viHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131777; x=1781736577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI334LxgKLmlRyNgL8Ur4M9ac5DP95VOVSvPZmKZ8RU=;
        b=FqI7I1tFU47wdrcEz/TnqOwr1bkd8/tLB77TOzSULJNVjcLWXIPYYvm4aSTFR9M8w0
         Qz3yCztDbN+CcjUpMFpLLaYvxpQTicrzFIx7fZgAvt6cKpMgXM6Hsg8kFITBVLafX7KM
         f7bivEuzRxPRLotSBRo66Oden6mJsxkMW0rvGoxhKBCpwWs4fi2kJNMhzkYbd1j8eXMF
         v35QGjs/Voxsq3AxraNuyiKZGjkhUhRjt9/nscdUaj4dWWFGKb4fBc/JIaURBHUW3Njd
         GHKyole0cGCUoM8yFzw/gQNe6wcrOHfKkMGuXBdrV1cGEmHsVh0DFx9jK6C8qr5BlBMn
         JABA==
X-Forwarded-Encrypted: i=1; AFNElJ9Loq5v5jsC7amLzuWwRRSZykxez2sK+351o/wm/fkJSldWPwiesjB36xmLSDLZckSXxy1078/wY/VXqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfnI+ho+ILiDAX7BLplUx2n5uhKoRFeFEMu91yAMdf2y8CVlc
	svxu2tV5BV+X5b8u9eK+aGxM5Opup6EP565HlfcX8M2K/gvEuEL6FWS4
X-Gm-Gg: Acq92OFBIaz7uia1UoHSTdfrvhe+xHgUHrOsr7Poe9f2NZVtRt3UPkpqighwGOQpPYz
	4FohMNzkiNgwk5AbBJakhaYpukphOP3DWO57wxEXUGLWWZ4574RPmUvftjqXlhy5hhk2OY0a3Rj
	qLlV1i1Vlao7/ugpADnGB52VDd6XG3VGUrIPP2rRK5TS8jHgDXH++TDQMtmK89zfbuZKJBBvXJ9
	beMAOsZ5DcNRorXKUn7ha/cIhVdfPYqBHs4LvUhoGXKFnKTf9p195MXmRT3lsJoOKZUcjrYJrK0
	bRXqp6+O7E4dxtuXOR5mOy8AIKUNWF2j0WXRsu6lOKupU3F8mHB+4bSE8rpAMIi6Fot0iOYF1WD
	USPLE1Fw8Fc1SY+eizwh16+mocn6ld+FDgyHCNOYhxGT0Ysrfv8A9Gnl0N0nLXfT7letPXsDTDA
	gHKwg7r9IvOrAU6ITBZ3+fhYhclqp3hRRq/wuCgMv3OHWbK/WcUxShgL3JoQC9QSFWYkJMH14az
	Yk=
X-Received: by 2002:a05:7301:9bc5:b0:307:3a6c:ecf4 with SMTP id 5a478bee46e88-3080465303emr215050eec.9.1781131776830;
        Wed, 10 Jun 2026 15:49:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df191d0sm39841199eec.21.2026.06.10.15.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:49:36 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:49:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <ainp9-NDND6AFLWk@google.com>
References: <20260507164943.760009-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507164943.760009-1-kris@embeddedTS.com>

On Thu, May 07, 2026 at 04:49:43PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits and use the scratch variable for the rx_buf for
> both the 1 byte command to and 2 byte response from the controller.
> 
> Also relocates the scratch member of struct ser_req to force it
> into a different cache line to prevent any potential issues of
> DMA stepping on unrelated data in other struct members due to
> sharing the same cache line.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

Applied, thank you.

-- 
Dmitry
