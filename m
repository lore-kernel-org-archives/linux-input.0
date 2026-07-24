Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204535675E
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921150; cv=none; b=QVyDFdFDJ1to5CuZpyByVe73SpVl8+dJK23cXxec8TkgBU9pJ2arF5wT3vcXQIR6dF2veZTcG65qaix9U9FozMOpoD/ffDaZ1qn9JdidykUqesdT9WlON23SxVNUODLgHmkETDyHyQK46M9H7a87kGiKjasRIrXupLGAW1cPnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921150; c=relaxed/simple;
	bh=2ksqF5z1sIMNtrP1tAqgcwchwd8cY45U2teQX6Ds30I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRvSTY/BGQ4tWCyE6VZGltj6JfqjkGliIJH9wXtAgvgv/tJOUt9EpU8vIVAYg8+O09+Oy+/VgEVDdmzjBthjBlMSgfL8yOVRbSepsx1jr0hzfOmMF1uhat6EyeCSojwsqqfOQZ9zeC2uZIWDUSSPlXKgrRgZkczjrwXokeKr1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5DpW+Qj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5DpW+Qj"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso9308355ad.2
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921149; x=1785525949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c0tC7vV+OGBtLj6C1dSzqQ74owp2ZWgS4CBF+5vZQqs=;
        b=U5DpW+QjLEhqPtA+4gUme0zWGhUPsgeSIqst2Jeo+WStjwobZ4fKCeqjNNhq2XTuZs
         jE3VHDwxCvUV5/MadJGYXMJxD1SnPUf/29Q87RU/Q6A4d/b95GjVc/SyKpZQ1+D0g8iY
         zniCZVpX51oPFw7WKgTLGGUO1lxc+SRK2z2nISMo1doTxNnZUms5Ksa/TRqNYQf2ZclK
         U3trorjmjVZkP/nrlmq0KymALkVquD81llgC4dPj9VYgxEtnmX4zDCS5l4HrIgYAAZjM
         6m5MeAUXpskUg3DCncGrJpTDk6ZzM6+9wHY0vI0z+T6YLuf9a1MbH3iYFiBDe0bHyfgc
         4bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921149; x=1785525949;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0tC7vV+OGBtLj6C1dSzqQ74owp2ZWgS4CBF+5vZQqs=;
        b=Cm5bL3s5yfldjou2OK0EO/YWlYzy2u8rBxK7E5q1vNpwT33YErGUhhNiBY1azf9Z3l
         6xK0BC6YtO1MYvyP2R5ywZ32Au2OPkyynOiAJW41XG355wl6TPsOssMh0wgTCJa5o0rO
         s0sQpZWlMgBW93Poj8lj3GRyiCf+kLWjjmpTPg99KjtRFVcP8oEv9PEo9FZmm3mUj8H7
         GlEKOIYscv2nFH5izxmENEPsP6eR3JHq7Lh0I8oYUadTK7ihgj2tdosWekqsxqGfj3cK
         aYVt8vzMQ4KFPfVeNHyKfZDDJFi8g3inSvxm/BtPnbHA7ljXbyd/6o8hXb7gKPcflnzK
         M/4A==
X-Forwarded-Encrypted: i=1; AHgh+Rq1J+V6O2TWYZaeDb9PL5ZAVdUnZMGb3Mf6gsxYYc3g51t23kao3nqrnXJqY9b8fSDArT2PAu2fA5Y0Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOcN2xxaoBhnP5zT4R3tmjwrKR+Ycgt/Ou4iojGSwlv9OBq2Z
	WEVrv/W9HrQD7I2c0aaXJkEADdvvcV8oHB+a7B2bvchNGseAW+8ucf9Z
X-Gm-Gg: AR+sD10WmunReTmfJ+LvPgAJj8hIjIb/2rbvAUnaOTeBgBz23RpkGN2KulA7OzChtx8
	zA8JxEUbKJidwTudlxsjyseFxUX8g8hN9UdSYSHXG1aRoO+ETkvpq+hA5Ms/Qem6zX5jbRDgLgE
	0/OoWR4vnvJIVL3w8vY3+U+8smwZy1FvXXsF21+oIAYEawSLnf4N9usYQizMp0GcaUHFDhbH9y5
	ygz0d+r5qXV3zvQQIdtXs5bERDM4wnTAjUEm1pZSZ7looOqox5EZgKl568jna6p/c255ogQBf66
	qGiuMvCE9NBrNxlfwTCp9en4ncQH05qmosNEtjH2hyCicZFNlkgwn8MkJsz8+eywdsvISnLLAPn
	dvCUM2DE1pc3RNVtztve9nwTmJuSmrWsWkxpYN5/+C1WNIK0OmsPIra+XxmF7oGybYZgpZF2Qn7
	vNWpG3fYvwlxQT5iMlWLW1liO1F8s8ktGL0AN3cC+/FKE=
X-Received: by 2002:a17:902:d491:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2cfa6b77547mr101121265ad.14.1784921148827;
        Fri, 24 Jul 2026 12:25:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc579127sm1679206eec.21.2026.07.24.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:25:48 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:25:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Srba <Michael.Srba@seznam.cz>, Linus Walleij <linusw@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/5] Input: zinitix - add support for modes 0 and 1
Message-ID: <amO7_sEL0hknUGO5@google.com>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-3-f6df7d86a878@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-zinitix-modes-v1-3-f6df7d86a878@disroot.org>

Hi Kaustabh,

On Fri, Jul 24, 2026 at 12:54:05AM +0530, Kaustabh Chakraborty wrote:
> Zinitix touchscreens have three modes, numbered 0 to 2. The driver
> implements mode 2, and leaves out modes 0 and 1. The difference in the
> touchscreen modes is the schema of the event data.
> 
> Implement modes 0 and 1 in the driver, along with their event structs.
> Maintain a common, canonical event struct which is to be the superset of
> the mode-specific structs. With that, introduce functions to convert the
> mode event info to the canonical format.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
...

> +static int zinitix_read_point_status(struct bt541_ts_data *bt541,
> +				     struct touch_event *event)
> +{
> +	switch (bt541->zinitix_mode) {
> +	case 0:
> +		return zinitix_read_point_status_mode0(bt541, event);
> +	case 1:
> +		return zinitix_read_point_status_mode1(bt541, event);
> +	case 2:
> +		return zinitix_read_point_status_mode2(bt541, event);
> +	default:
> +		dev_err(&bt541->client->dev, "Mode %d is unsupported\n",
> +			bt541->zinitix_mode);
> +		return -EINVAL;

Instead of a switch this can be a pointer to "read status" function.


Thanks.

-- 
Dmitry
