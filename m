Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DB38BF8F
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2026 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283042; cv=none; b=paGTEI86e7Hky50eUQ95xISXR29yB5NlZw9vDon5MhdXYYFy1Qcf2c+h0QWfiRwA2ImoaqvBIqpGeJGeZZ/E5KoiOw89YGXXVOtoMCKyq9tS6eZZnJ4+Gapep3U+K05xk+DyXaQ+q97kL7DUpj0raXIdcbosz8VcpO2UxfZiVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283042; c=relaxed/simple;
	bh=SvZjA0EsbKT1UJegblU4BzrGXyqpheN//TCkxSFMpN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIe9DFLXPrdgI/1YC/8NQzGBUiiCSQZomCNChVa6AlD/xqNWvyw2ldXl0fy16BZI8Bx6lEHP4lcMts4avfj2g08cEDWriJxwG2kWdQOkonH7A7mj0gPg6brLMvxeLRrmosGGHkZJavt6wQUp3nUtFRBvFKEgj9cOixmlCR47cTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TndmL8MT; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TndmL8MT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124566b6693so463c88.0
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2026 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283041; x=1770887841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WykwMmrlseSYAJtne8UaOqbeDmTnENQ+OJ7LWzY/Xbo=;
        b=TndmL8MTxBAcxOreNu5M/xUQPfxFOnX2rHeBVGZJDyfSbL250n4UXiobZccCpLOl/J
         anPCrqMP81tAqnCoclCxAFPqqANMIhxTl7HPILG8SHgSILhw8V7bvFLOX6OdffXatIjw
         oLdbg3q8cqMuc5UeqfVPCapmFtrVRYV6D+QzVzxZvgxuBKWFRtpVg1HEEBsjQIZiGLNN
         WS7Yb2PSKTLnUO2kbRPvNmZsWisF4s6QtPYpWv5UHK9M9fjDaVdbC9tMtRAIVQfTQTK1
         T8KSMA8cPXrYQ164AyiKe033hl+TdBFvdzBTj418MzpIJ8dHU4d26KhCrVhGO4ruo5ZX
         m3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283041; x=1770887841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WykwMmrlseSYAJtne8UaOqbeDmTnENQ+OJ7LWzY/Xbo=;
        b=lkocBFu9zsxUSSfYRUlw+3xPkbjI8kwqJ5XNwBSKhtCbioGxqeQdFIAf2gY9g+YtyY
         z94EIYt0MlW8DGsrA0GJCaLN7N4wTWhcvT7drqv3QhJPJ6Eipfhn4veAR3pmnREWPzAJ
         /uc40E7FcudxA1C/Luaewa3M7dy1h10+G6W2/V7J+BFYmJakUlS5JmzUCQeZEoEfVSnZ
         NfI2ks2q7Wa48uRIoZT1S2X/0sbvLcQlEptlU1TufW1DGuw71MtA4FVlVCpwzDl6MlGb
         Ceke7G1GqH3WoU7/DbujPAGUecXc37UkXSZiRkBJ7iLQM3GvhLDgl/ba8t1GbaV9s5At
         ygcg==
X-Gm-Message-State: AOJu0YwwmXRx4Uy4La0oRrraYZX8Y8bJaAAW3Hd/TvbYJFLNt2Pr9Qca
	H225fcb/pFWqeB25PpPmIz9fLezu/+9pgjLWy+gsKXmYRYGhFifatTJk
X-Gm-Gg: AZuq6aJldTyJUopP+A1spgKdTAV+ldII+jm/m3E/yNouFdFnbMOdbi61kHeF6rXLIKy
	ex2i/7BZAydNdOFkQ3BUE5Vd03MJmpkq2hyvn/8Mjv6DJ3Hu3zV62RCHoZD1a4sre1gHcjMnaOf
	vHUERK4Kfbcv/DDw025YdyACsK0nWbcZSujk/V7o+148a+Tx9WS28/VRuByrk8FNSQTc0Mvd84G
	Br/tIo6kYIq5jAMZyEHTnK7s64SI6HIKmykXyOMPoQTnE6Tgq5Bp+Kj2AXQFRKQN+AtfU7N+jpu
	+SeijBbfbElH1r20dbCryncHB2FDBETB2nKAzgpEYu01iCnNhhmOnbuMQ8p8D+ATzUnXFdYnBAw
	0ytK5W4l5IK0rf55eiIlWhWEAVZxc/5YHO3BbbQ0RTHHw2t7Io1o1Sx1n/stfjqLGrPpM0HQXZ/
	n8s5UJX4SyR8MUad/Smrv+TN/Nu8aqUOLckEynqC+42HSkO82EZ4o6
X-Received: by 2002:a05:7022:207:b0:11d:f440:b758 with SMTP id a92af1059eb24-126f47c4656mr2593061c88.25.1770283041293;
        Thu, 05 Feb 2026 01:17:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:9a9a:afcc:9a68:2606])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e05ce7sm3852912c88.1.2026.02.05.01.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:17:20 -0800 (PST)
Date: Thu, 5 Feb 2026 01:17:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, 
	Khalid Talash <ktalash@topcon.com>
Subject: Re: [PATCH 1/2] Input: st1232 - read firmware version and revision
Message-ID: <aYRftJPEKEWE7VhK@google.com>
References: <20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de>
 <20260123-input-st1232-firmware-version-v1-1-32df7eefdafe@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-input-st1232-firmware-version-v1-1-32df7eefdafe@pengutronix.de>

Hi Michael,

On Fri, Jan 23, 2026 at 05:28:55PM +0100, Michael Tretter wrote:
> +static int st1232_ts_read_fw_version(struct st1232_ts_data *ts,
> +				     u8 *fw_version, u32 *fw_revision)
> +{
> +	int error;
> +
> +	/* select firmware version register */
> +	error = st1232_ts_read_data(ts, REG_FIRMWARE_VERSION, 1);
> +	if (error)
> +		return error;
> +	*fw_version = ts->read_buf[0];
> +
> +	/* select firmware revision register */
> +	error = st1232_ts_read_data(ts, REG_FIRMWARE_REVISION_3, 4);
> +	if (error)
> +		return error;
> +	*fw_revision = get_unaligned_le32(ts->read_buf);

Why unaligned? You are not reading at an offset and allocated memory is
cache line aligned.

Thanks.

-- 
Dmitry
