Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF83344039
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818675; cv=none; b=HrZigLSpL4fRoXGX9KlvXZ+LAwv01GCERIp9ES1rJjzV0XAeeQV4wAQId89OKE9C9fhPTNLOeigcwa3O3CY1O4TlFs1NkDZwSzohfxYZpVuCjMks03JlD8oi6r64TfAqA3JkTyngFiFY6WMKDpF8CJpZ9A/ZBMUJZ046WyFfmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818675; c=relaxed/simple;
	bh=9TBG4KJWUkto8xndWZTre4mHkMZaycGfjsH3VaLQrFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njMww9m9zQoUFWqOfp2bYBa3feh5eUb9klgLoMD9KQ/aAgv2Y1QsKSw8NpOyhHA2odXamfTm6H0hSjP2U8pwHMRENA7IZr53BYGN7rb5xKsa+d8OXDMyPa8l1FOphd8f226L820xn8kdrikjEqSK0ZkOk/LHvl/LHMMC0TeLLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGPVp14s; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGPVp14s"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1274204434bso3235250c88.1
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818674; x=1772423474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXpc3Kmvnut3VwP6NNidiPJA7ThQhlqteukIsGvSTQ0=;
        b=GGPVp14sza6574sp/SnkeVJbLQ//5wVCIVVkmbvG7hxPU93BusFi2Ms7xQt8tKyoXo
         PKHKh7rUpPIUUTFfKvvHaZ/qZCykL0KLW7LNBnrD9Jr5rKbHeIhhiGhL2MPd3PD9igFY
         dSvnskSqG/aiUlXdgs63aPYQoZ1LUuE0MZ3Vfo7/cG+BWJI1CCF5jP3YAgD/+DDaalo7
         QIE445azzymQMaduPVROjCqMEjjWw1CdVfDF66pUu1Mgy7+tspiOpe2HVkUPp8OAJpUn
         kFsSnTfignMUFfj7FtluSvwcM2150wZD/8NXSRE4UmRiGvzL6z6vwPv2lAaNOdU3Barc
         NyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818674; x=1772423474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXpc3Kmvnut3VwP6NNidiPJA7ThQhlqteukIsGvSTQ0=;
        b=dF/ChyS4M/7ZGeqjtd8YORXUH0xaDyUee9wxZuB/I4xQwJj9UlHzFRASd7Dfy9Mex/
         wd3xdO/RrhhMGxKYHo6Ciaxbx6xSVlo8CXWjXpZNzhF8vFINKawlOmBlowWzcwph/dBm
         C0/RZsKar1bT+QvHO6Eo2S352Eds5OqwzziikcC7LoNZUoWNKIo8DH+bxLVs5PQlq/UW
         KmqEV5B9GsR58jN+XKUCd7AknQUhJcZkcWldb94xhA4W3ZFXU4LK02iNSxU3s7iPbYJr
         5cEQyvchi3mjpBn+KqsDmpqYJChj0Od3Zc1vk0IlZ85bgTHzlg1xNWjMMh69xTFkaTe1
         zQzA==
X-Forwarded-Encrypted: i=1; AJvYcCXSA5k1gG1M+yGuK2TfGsnGc+/MuT5il7piPMAydvQ+5bhokZvE8PL49G6lkXVYTwrsSl786WvGivkXHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl40lRLo2yfymsymVf6wAM5y4NcM4hZzTYz7PpNlPBa6ar2XOy
	xE7u86Fuujj+nZw6hPYyTZYHkjTyDsjjw9VPi/uB+16Xuw36Zo0LLrlT
X-Gm-Gg: AZuq6aJ6xhZ6fPHjbvGnAPA3COZA70O3BiwrG6e2/iFvT3bHgd8FC3CZyRYL7uDj8C4
	UN6kM7S+6qEzQgV4xx3PvzfTbtFWZQL3QAvXE4ShNEvEYNJZQUOPWrdLW7ITs4b7xOr2k6mG7Qv
	Xl8v+un3MCSxVQz/LE6yX5AzOS25vrequwlexNBPxj0DkO0A7Zg/GTzm05BTGCikkjbSbBLZBAG
	FKVCa/rWTe4x8ntjG5dAXKfgP9giwfeq02EsklkkY44BC9/bAfiLXjqbehimWeYqsgIiO1o5U13
	kizHTGYu9Wp9WkQZJEQj1cftFTtzeyBisWa28VjAGpFA8a1qk4ww0WEAPaL1n0+UvHC2NaCIfgY
	cUPXaJXOhFjvVkY1jE7jAkHIK/JzoeZHjAFGw7BeW3MCEJhXNAQue1YQWjBBsMbed8W0lJ97Saq
	RMdFoPyk77tiFVRPfSY2DRpgBc5Yvq8oRDCG3euiaLCi8QxQ+hAvCwa3/JA0IYSQY=
X-Received: by 2002:a05:693c:3618:b0:2b6:f13c:8d58 with SMTP id 5a478bee46e88-2bd608405f2mr5499375eec.20.1771818673826;
        Sun, 22 Feb 2026 19:51:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c6c:6cca:170e:c77b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7da3eefasm4173867eec.5.2026.02.22.19.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:51:13 -0800 (PST)
Date: Sun, 22 Feb 2026 19:51:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Input: cros_ec_keyb - factor out column processing
Message-ID: <aZvOcaGq3VAVV2Oh@google.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
 <20260222003717.471977-7-dmitry.torokhov@gmail.com>
 <aZre8rWDvVDZ_T6p@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZre8rWDvVDZ_T6p@tzungbi-laptop>

On Sun, Feb 22, 2026 at 06:48:18PM +0800, Tzung-Bi Shih wrote:
> On Sat, Feb 21, 2026 at 04:37:15PM -0800, Dmitry Torokhov wrote:
> > +static void cros_ec_keyy_process_col(struct cros_ec_keyb *ckdev, int col,
> > +				     u8 col_state, u8 changed)
> 
> What does the second 'y' of keyy stand for?

It was supposed to be "keyb", I'll fix it before applying.

> 
> > +{
> > +	for (int row = 0; row < ckdev->rows; row++) {
> > +		if (changed & BIT(row)) {
> 
> Maybe
> 
>     if ((changed & BIT(row)) == 0)
>         continue;
> or
>     if (~changed & BIT(row))
>         continue;
> or
>     if (!test_bit(row, &changed))
>         continue;
> 
> to save an indent level.

I do not think indent is too deep here so we can't spare one level...

Thanks.

-- 
Dmitry
