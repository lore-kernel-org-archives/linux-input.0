Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257E32C302
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116431; cv=none; b=Lj+xJD2DNsuI9NvW+ZhiRG0vqLsIgGJcgzbIAzaI7JNSrA8sWk+3/QwK/sW4K8mFtDtVP+TLG9xLIC4K2WUbAlUt0fSYSFxNs5pVgzZmuXX5J4CMkA44heKYfqKOOnbBB/PM5X0T5ywyParLc8acWA4xeG96qKCnMRofQW1OBNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116431; c=relaxed/simple;
	bh=hudPfaB5Y8u+39+QhqcnbqU4DSfvZiJpkZwi23yNzcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfHRW5JvFLMu1aWnv9DdExZZL+SlYY+1GfZyNU35MKfCq5x6rd7AsVqCdSVQ8l/KYUyXqix6WtAxujNPzCzSX71ZyhYaFuSTVDj+E+pA3kSW1zeUyvRxYvvSzuOFv/zWWCoqqdRYrtK0zt4wGYysRAwG0TWQZeThk1G1nLfTQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBRpzMFW; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBRpzMFW"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6b0500e06so8095289eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 03:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116428; x=1770721228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JgnMsXOh9YRopf/e3+gz8PgFtk2UitVTNFeIUt3zTk=;
        b=bBRpzMFWc8IrJor0xe+IV8RxvGmwWg2IpM+53bbVASZd4OkxSngWIl2MFsLiOonJoJ
         xcJZQcwaXuyOVM4fqJxUwBvA18HTc/8qpo8MKA3ce1MrHwEBbmkQoyrVPTW16jNpRso6
         ntlLX8WJ3qOMSVmTJKjPs91RM0TI6BRM7U/fR84Mj4wF7q6LHua4cLe3cNcBSOj692a8
         oZjPP5rPdXcjhmS+qCQchB4Yp60mtm4DX6JoAeaiaMUGA4x3dxt3nxItVVc7orX6nLju
         8FIWXxyczFTl+olaraL90nsYdL3tT4xxoCsNtlgv3m7FkABGH/qxnK9B86rwKq1lsEh5
         07dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116428; x=1770721228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JgnMsXOh9YRopf/e3+gz8PgFtk2UitVTNFeIUt3zTk=;
        b=DVlbwP514H5nzNmZbiJY7Z3DHUJrf+kTZBCcieiAtXYgxti4aMktYP1nnjI6Y9Ukrm
         RyVUJlyKZorXFMicrxKhE3VPcBccnM3T1+w/SRF+HykpmFSQrGLY41YsQr214qxDEv21
         90BI6JenUlnYBGnQ68dL1AV96ImAK29TG72JONWUOlmHsK5QlcJaN+wYGLRTZMzEDIWL
         NicuO3HTIZwLkWFLaH7M15WMWQXxA0gtL4bP4NFApVWrIbD34zcd9MVgyWD6hrzIQEe9
         FciYSOUIIvZEEc83OHxPV/WDGnZ4JwjTGzw08+vaqMHpY2RqDlPguwd1YVM5NjcUZuFk
         jQcw==
X-Forwarded-Encrypted: i=1; AJvYcCXjddSRI4281Jbwd+onFqwMcMGfuL3npkwhqvm4LmXkmOH9WXgnyi1HQwyntmI6wRvx6dnHsPIvWT6HzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtFSXhFW/6ASAomu2fJnrcyARJLtVhUK3IX+Ylc7H575PkYIO
	7aEZMs4LULPkr+LwqTCBREwOkRrq+HbjvJZKzTzcDHW7ltlNcn2f1YF9
X-Gm-Gg: AZuq6aL41O2DaRl5eTCcIXpGbMTPOHmuLlCllJnln4PpNP4kZ4oHa+JaBOq9nhubpin
	owvqwoel7JQQXAShiKQM7cPkwWX4yR5yQxe9a27SFQa4ZkisqmEEnfOeNy5BqRVUYMTAkOuE3fE
	TYEDW0aE6uQlKOygRf96SUtRumkd5gQSHNcPhhCU+VV893wBTRD57MacX4OXVBab6iqGqkCz+Nq
	d0HzV7XZmquy3mnYFTPrCxMTZ0rkqdYTJF75ZIEDPeR8RJC3xIDE25RBJiZyDNhRGmcrYGy2ASf
	4KRrjOy7swjmChN4VCihhIwUANJ7AnzicZ0zxePR38iodE5z6m74ztuMU+nmIwMQWL1mUjfiRQA
	YpKq8/HASfABG77IYnVDRc7vIsxiWXOXQwXpAoATD9o8XmDad5wGXwJIc4PY62xL3byqrw7KjDU
	oINgkHoSefDg4MqTlGqI1BgEIaN2UHgsAVH80wXZ5RHHwkNO+L
X-Received: by 2002:a05:7300:4306:b0:2a4:7f22:cc0d with SMTP id 5a478bee46e88-2b7c8909ad3mr6722053eec.32.1770116428294;
        Tue, 03 Feb 2026 03:00:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea13:571:b19b:36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add664sm22262633eec.26.2026.02.03.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:00:27 -0800 (PST)
Date: Tue, 3 Feb 2026 03:00:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 6/9] input: keyboard: Add driver for Asus Transformer
 dock multimedia keys
Message-ID: <aYHU5g5iOVjrHrE_@google.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
 <20260201104343.79231-7-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201104343.79231-7-clamor95@gmail.com>

Hi Svyatoslav,

On Sun, Feb 01, 2026 at 12:43:40PM +0200, Svyatoslav Ryhel wrote:
> +static void asus_ec_input_event(struct input_handle *handle,
> +				unsigned int event_type,
> +				unsigned int event_code, int value)
> +{
> +	struct asus_ec_keys_data *priv = handle->handler->private;
> +
> +	/* Store special key state */
> +	if (event_type == EV_KEY && event_code == KEY_RIGHTALT)
> +		priv->special_key_pressed = !!value;

Is this functionality supposed to be triggered by any keyboard or only
the dock one?

Thanks.

-- 
Dmitry
