Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53F42981A
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016484; cv=none; b=ey8kXkkn2Itapi64kQKGR9+M0dqqidYE38qZKP5rqklIU0dkHrj8Qw+pE5uolsxI+4d/fRLFxSa43z6fZMHHM/CFIlfKJXlc6PeieKxXQH9zDvwoTjbfXLYMdaxfKGNamBUWR4WGogYIOmtcDiWs0tI4SFGIM+ql1rNciXHZZPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016484; c=relaxed/simple;
	bh=m5FI3xNAl3TkzNTKrHI4D59YqGJiqS+5075l9UsrcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERvj0S3uX4ZJ6RRjHV+zrm2sOox8zl/DmhYRYapzWcppFnuWc3MKF8EZG1wv2ew1afWKNE7domOc/WfpnBzIIOsZejFSu1jI+QQ++2ouRyEzm/7mw0qa0BuxxamzgMmchr4C6cX++9TZbGugr+tonHM1uW1A/9RwynDG5GWTYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkJvs9cw; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkJvs9cw"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6f85470b6so69961eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 09:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769016480; x=1769621280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODmaEKD4YMc3t8iZSxwisxxhGoFljo8Y2PJTisCWGWc=;
        b=AkJvs9cw/nGdJx6MZgd1w2JMH42K2y/5SikPPxq0BP0UhZeAAqXT+CAGcEpjX/1top
         H4yKflgKcTo86GRxQslhDiu4xjQQY/zBMWLGMe4uv7R8aatcjDZW+smb4fS3sMMeWSOh
         snID/Kemy81qRl0IO6kJUBcmTDV0snHv62LDZ7vTLZZmCUHp323hNMOK6TkhzvIIo9tM
         K28bA0rDOW/CaJLagtqslK3MsgwWicK3od82ATnRn7ECfcGf6GHZmwmP5RLoy9Lxo340
         jtgdWUKO35DsVQbmUTl0IcHEd2jbYBt/+NBXYH95dM7qny5KxOToTFoj2dlg2A70rP/r
         eHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769016480; x=1769621280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODmaEKD4YMc3t8iZSxwisxxhGoFljo8Y2PJTisCWGWc=;
        b=UwzwMH7flfZ4juYpLxte3p/6hJmXgiyGDZVUheQsWEvuc65YNNhuy9BdVppvXznDQM
         fvnwcU7Ye04R0TeW552Pt+a30zdzsWhEOv5rglcxFuEyx5M5viZCbzeeQmlyjULeHjpL
         qjnFQSzQvOOG91iFu1lx6GHOOJ0ihheLdPgtKp9yepJY3tUse9xZfZhrZuifCP1pi0Vg
         gh/CUz9gCAHg3AGAdQDGul6edYUp2orkpR0C9TRjaqbt/dHM2DOTwAQK/BFWPrF8bGih
         dkqT9FFUlIqwFqdEfCb3Nr1RPe47hYZHs0VljbF6rOQ7piLpNaAqaaVi6JgVwE5nevo0
         qxtA==
X-Forwarded-Encrypted: i=1; AJvYcCWk2S3Sftz/9sxCHAuFDlgWfiy2eoLp4Y40bs9eTqHWt9h444xaYpDXMgGxSAhrFt9p4MyjLcJc49LlQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEZvFP2xZ87ekMYH+OfBg3zmo6F63bn9EV8JA0nnFnjHqxh1a
	m8qObhZOiIi0784TK22ywyNpiIOAJ7ufy8dSglVWv/+F2/7zcaPG0il1
X-Gm-Gg: AZuq6aJwteWMfcbCaDnLWzjqLwwp3RLtErhiWebgxkS7a4rJMw9htWy0hSDxx7fN+Nc
	zswRup87xxd3sqa2jgYpMUIv+dIcYpbrV4m2QM8PTrGvX3+B3QUDQcWmQlDLdrRI3ApcWDjyrgW
	jPyykRyOWjv3dBFPiQwAVVE9EXRnc/97NdfAz/U4D2kdvbtG0lzuFAwboocdazczQ4iY/DBtRux
	RrHgIrs60vTYMI9uI2QIsqpaDudvO5koT5ArcTs3/dP09+p+8u0jiPW06iZihhUxnmhD4AWqk4K
	yRXaWjSUXlELG4LLe7qYn8WL6XOK+7zVp3ZoVk8nruNeeCtRCu+AZe3QnHAVqdzUiHCab02nEIo
	g8Rgv+S/fjECOcrFvMEgm4LBJ+/ZVFYm/4Cn3OIjq7GKSSoIl5facs6Pi/ppZG47X2lN/VDpNOh
	jR+1KYpK7MwtbcFpGQX5EBa6HOVCIcSna/J7UXpIWxjWiibDAtSC/55KAAdTUyhX8=
X-Received: by 2002:a05:7300:1892:b0:2ae:5b54:523e with SMTP id 5a478bee46e88-2b6fddb1837mr3771158eec.40.1769016480404;
        Wed, 21 Jan 2026 09:28:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70a036d02sm5292666eec.14.2026.01.21.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:27:59 -0800 (PST)
Date: Wed, 21 Jan 2026 09:27:56 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: 756271518@qq.com, brgl@kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] Add common hall sensor drivers
Message-ID: <wv75wb5bif67u3yzbgbmrfg75zseamfvehewwyl4xnm3ecmqrj@5yqkwsrdlfzg>
References: <tencent_3AC818B2FE367BA7DD8940E08827CB146806@qq.com>
 <CAD++jLnSXPhqnTie9U03B7mn2x9ogUpABBLFwbt9dgtzdb3yNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLnSXPhqnTie9U03B7mn2x9ogUpABBLFwbt9dgtzdb3yNQ@mail.gmail.com>

On Wed, Jan 21, 2026 at 12:43:01PM +0100, Linus Walleij wrote:
> Hi Xuchen,
> 
> thanks for your patch!
> 
> On Wed, Jan 21, 2026 at 9:59 AM <756271518@qq.com> wrote:
> 
> > From: xuchen <756271518@qq.com>
> >
> > This patch adds support for common hall sensor ICs used in Qualcomm
> > reference designs. The driver handles both rising and falling edges
> > to detect magnetic field changes.
> >
> > Signed-off-by: xuchen <756271518@qq.com>
> 
> Why are you going to such lengths to create this driver?
> 
> What people do is usually just create a GPIO "key" input
> for the hall sensor, for example:
> 
>         gpio_keys {
>                 compatible = "gpio-keys";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 vdd-supply = <&ab8500_ldo_aux1_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&hall_tvk_mode>;
> 
>                 button@145 {
>                         /* Hall sensor */
>                         gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
>                         linux,code = <0>; /* SW_LID */
>                         label = "HED54XXU11 Hall Effect Sensor";
>                 };
>         };
> 
> This turns the GPIO line into a "lid switch" which is what you want,
> and already supports regulators and pin control out of the box if
> you need them too. (The VDD and pin control properties are optional.)

Right, we do not need a custom driver for that (especially one using
legacy APIs and custom event codes and defining special classes).

Thanks.

-- 
Dmitry
