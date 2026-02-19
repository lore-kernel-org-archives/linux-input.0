Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B618320CAD
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495912; cv=none; b=M8cifBNYkS04tLVZCKM0EEORF21SYS0B1OhA8g/D2P26QdnGOSDvQRERlFf02Eq804eUa1X+zQSeHDoUAQQdwingEnRllUdqCC7eFh1Ew8Pc0ukR0BOb1lkJP0FIrekBA8/wNVP3O4D1au+DisRy9Q7JA++g3Gimz06CqJOivRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495912; c=relaxed/simple;
	bh=4PP28JTi4vSYXKVlJie/fjCnni0V/SyFvW/cSYUEEak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwwbMW1v754OYPC6UNvzHdZMIfDEUF/2QJtmT0S2V4Sz9qQhAHR43Mrpj9IUfGKgecPoB71dTGgErUFl8c7ic2UzCK0LIJI7NM+HDeyMN/8kzGmf115hY74uYvxDk4ZFYd2G/Y7nbp3H2NPgKOqKVhQxE5xy+re435yb/QJHElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrpJnF36; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrpJnF36"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so1117252a12.2
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771495909; x=1772100709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCgIobwzKfkS2/wNucv6X5nIS/1dp0j/HP/5gpbPJ9Y=;
        b=BrpJnF36RLWRy4E6VE2MbNv8FWdOqbmZ/toRwy6h17UZuQuhW+wUs3oCivOU/GrE/w
         MQpFSIf6ZHN8amBF6IxHKokUW7Y9Je823UhVy+6IF37mFbRKI0zBp7/hje3h5OZZPi+s
         pO8z04mrQ+afkNk4N8C/SDqVUOzYSORPbWAUeZv8rYza0t3WUoa5ugkudPjWHmOoR6Ce
         wWNUg8TTxkOYsGMmFo3bn2cq8IW5RFMuCdbMf5pl+wLcaWrDmwMZnDz/HkWjWFvJZJD1
         qKoeRp7GnN3dRtWekdTpZ0iLGBDXqe/bCNCLqhKEQkreWuyo4fxJRnqURX6WriSiH3fT
         8+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771495909; x=1772100709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCgIobwzKfkS2/wNucv6X5nIS/1dp0j/HP/5gpbPJ9Y=;
        b=hEXIp/uMoRrF2AshvI+bcqP4naM4Bw7V9bk3gg9B0Z0ZaqFT8HpzNEG3IenZRKeh84
         D4JJPBEaeSXz+Ia1uTGSr4wVtySY+fPJEmtvvDRC+UymQeuZ+lArLyT7y9ehk7M2BioX
         Y+U1On2rEtSbsP9xtO546K4l7fPMdM5LB4/zVlz3EiKmC0iIG2e8HdiDsibKDQeUBejG
         CWuzV2VnnLElE4piHwK0kPCQY7EHf4LqX3WM2xXe4fpCVTxCG5lxWbup3Fj11B+KLAj2
         CRLgP6cOtFWbp/LQwzo4/aLuBcOHmi+FkLYvCKff1LXqbLwkRAsISP41/Z7xwRKve2fe
         OwWA==
X-Gm-Message-State: AOJu0Yy/YdkctjxScGuOSjHRRHbl7L7b17vZzOsItHJ2Q5d8h2uAo1zq
	BAoY8mtgsK3E+kiO5Hygr/NyTg1C+DYti9s8sds2lq1iiyilKAxUPinD
X-Gm-Gg: AZuq6aIaIc6A2yF6uziyXH6KDLNkEFn6qVBqQ8P3MoOWesY8o8VYJNslZtypUQF1N7n
	ZyVMfYgEWENqJ1PTh7+LQQxcnTnR3iC7DXqx8YdV0o5ZdHB063wOC1+mrCQ/rUmjgZycKNJz3/e
	pO1blPJVJnY4w5tydOP44DwMbzsXBYKB9I0X6329+4YMS9ufkZgzQ9pvDxEhBkS4M4McP/1oEq+
	zTY3Uv7Mukaulk1rU6JJ9lJzoQWchgCCy+ZRbap9DO5MBiGrouIrVQfWoXVn1vK1l51K57IETNy
	TNqNA6913jd4bxa3bjxuJriHrXXmG8QuuxSEKRedFaLqKdOw3ScxS0fGvj1BTU6Lpib+S32759z
	zp6W7L7wQzq+q5WE5n8xO1TrmuR3T71KxMMg8WCIAV1A7AaaYI204585gwD8eGbftH1DA1aFKmz
	9sxV4MSbAFjiy+1Q==
X-Received: by 2002:a05:6402:1470:b0:65c:63f0:a92 with SMTP id 4fb4d7f45d1cf-65c63f00e8bmr4409640a12.23.1771495909325;
        Thu, 19 Feb 2026 02:11:49 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad19bed1sm3736600a12.7.2026.02.19.02.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 02:11:48 -0800 (PST)
Date: Thu, 19 Feb 2026 12:11:47 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 4/5] input: drv260x: Fix unbalanced
 regulator_disable() call
Message-ID: <aZbg2w2lIahy_sM9@jekhomev>
References: <20260215141435.727872-1-jekhor@gmail.com>
 <20260215141435.727872-5-jekhor@gmail.com>
 <aZZ4jqZQZ4vA1SFO@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZZ4jqZQZ4vA1SFO@google.com>

On Wed, Feb 18, 2026 at 06:43:30PM -0800, Dmitry Torokhov wrote:
> Hi Yauhen,
> 
> On Sun, Feb 15, 2026 at 04:14:34PM +0200, Yauhen Kharuzhy wrote:
> > +static void drv260x_remove(struct i2c_client *client)
> > +{
> > +	struct drv260x_data *haptics = i2c_get_clientdata(client);
> > +
> > +	regulator_disable(haptics->regulator);
> >  }
> 
> This will result in power being shut off the first thing during
> unbinding, which is too early.
> 
> I switched this to devm_add_action_or_reset() and applied.

Do you mean that, in this case, regulator_disable() may be called before any
devm_* registered actions? Good point, thanks.

-- 
Yauhen Kharuzhy
