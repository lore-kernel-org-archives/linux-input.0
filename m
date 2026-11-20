Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212987;
	b=1cTX0JCaS/AAW+O6PaeNy478dEbEREBlhCqXr8c4lDnWSjOpCuemfXNihVdBt1AFYvXo
	 xr5Yrio6pskgUhl4xVKTjdT/CjmKJcshrac1bwedGMiFm9wni4iBANb5rDoUl9Kdcln+G
	 liK/rPNSzuTbnEzJnS+J4B0wO9GERx4UdIng44WYWdz4ocCoJWy0PmbS1+56Oz2SYHDuI
	 lE/51rtRjVD58Bf7l+PRmk4cKy2/xDY1J6exs5EybUgcIur2CHE4MrFzdIQQkKDBXKW96
	 3sRnJnQah2tWC54GmOyJlaDP14BWQW5yiELX55sF8nf60Df2igf5qIL36BsmfKtHEJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
	b=rk4i0PBX4Kyz1aCKi5M1Z3xmCE6ianf1A4vfhcVlzZyrZIbkOGBdmg1Mn1YGcaQSvQxd
	 g5L3MW7VC9pwWGQNu54nLLkqG5La9ff2xkntDKVms5G5d/GKpdDowrfJ7Q4vl/qnz0kPE
	 +nHsQlVirGiayMoNXtD5B5LkELIcMLE2F76lEBbrpiHrH29DWCXues93dsjzlWFMGj1y/
	 IvUdLe0bbfK9/smB/UMskS/2J9I9u05bq3182mDTSXbzNEHJGX+hKvhLHbOcD6XRtwd3S
	 oNwfNFH6OmCq+xHAHLhxQEg3sffCcYavuYv153ISy24CkHEE3trpCEyn2zPV/hVDBWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbWXu4G;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8C606A6BB
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 22:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D8C606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CwbWXu4G
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2818311eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 14:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795212985; x=1795817785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
        b=CwbWXu4Gf67XgRQAKW83cKuO1Tx7sE4RkWJwMBpwgx1bN94kAgrbAq0z24RU/nxf+N
         r89b9CwxyQrRXre5mk27unPLZEFEmxfR4d25UpRNK4VbTjRzGlRlul0SLmH2eeXBh0IM
         R52jhZbmX9rsTNqqfWeXVsv74sC9jDPseXP9nMaUeUlUPWn6A+EroFQP4MoGbl+iiQv3
         73AdQQtnBebyldtmb0kpmdwnzrWwrKaTzHqWziOcMtbnKpwsVwq4QS/62g1LhHqAzfi2
         E548CbBRuAMcp7BrPq3IUIu29xFjFcxgNgh2krPHLKpkJaEbMYDFJoEUcktbYO/59PQp
         3fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212985; x=1795817785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmmQLb1KRWWR3nD/qKb9WgJQmetkxtKbiRKOhfslFTI=;
        b=luQizdyoP0gdm6BT3YVEsstaCe2/GkRQME+8q2OMjKG8h+QfB4OVs85jVbR/6j81zT
         8KnjGkzVeudQWo4LBlVfSFPsyYQn35cy4e3AMek3NYrzj7CMtqEEXJAaNKBxdcFqIHnu
         v2sFp6+YtmkpYtpEyTBJ9BvOYAH+N5WRrwkqj9maAogohIQZ7/Y68qaRPrawS97Kg5Qc
         HtftBnvTqb9fs7QXtTZ289uOyIJ+Xc8kgkSu290N/lb2CXielFJqwwyqlUZN682Uuqk1
         VGbkSeCtSiuoxNsNHnslJ+WF4EqgdCHjcwlAPv9LdXq+Hq5MxJ1tkeVE8U/pbZsJh9S6
         D3Vw==
X-Forwarded-Encrypted: i=1; AL+hErH3agzveqCFoKmkNrrW3gXmY8vI/P2sPnTTW4AZ65ORg9y+SpAeopl3xOyV4Vu5IEH8xJpDA1UkfZS6Yw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kfLFBZS8BOMPuf/mKHOjrz9ZAPEaKslCBtYHIyddci5YyFGjX
	9MHKwwA7myyzkdNInJia2gKKtHPephc5fuOnFx9FYQVAi+WXAtCJA7DD
X-Gm-Gg: AZFdTZf/LKMyhr8G6oCRqIDF9MdiF/XD52nhNHgENUkwVI0F3uuvYpIvHZmA8ZS7vR9
	THv8eDhLMTyduDP+WzzstTjIr99hWMrvWf6c/v9X5rRv2Vo14JxSasaL0sKkc1hxeXdQ53FPQlr
	pP1NkbmnGb6afznyQDM0pm76GN0QmlLBKdDpzzCARHZSbQGavdhRsA/pxaiW66ggv6Betj7qiid
	w6MXNOMFdUO+C4AwhiLEruVU3RWLF2dhJHFPVw3agp0+SeunX1rmvYA8EZaiPBB2kjNYi1jnoIS
	E1hwJiBK4KvKQe7v6Wwo12ZqbnWln4P4gTwT5FvNkowUQvMly+zMC3fNDAd/fvxPMqNmQKmTHKB
	kDffdDSfR5Jdm20SAH8iNjKRkMDLw7xDiml155NGLr72aNz7DwiTFkurCLawCkWywIWpJBPD1rq
	dhQON37uydNP+WaTyOj6UPb+B/bIEPJV6lntqdw2qjKmxK+8jj3gyyB9M1ETTB0vdOIw8ZAP0MY
	aHz73dHwg3BG86faAry/MYdY3qM9/mW7qu9AiZRswvOTJOLfIUzrNh6Fp+8DcrrYlSjPqeX/Q1D
	u0EeM6uQz3NoEt3x6Mlzt4AxWiXKnVjdgifh3grIqizMDeH2VY4VwROVDDnHcGqm4Cghvtc=
X-Received: by 2002:a05:7300:f483:b0:384:e31e:3c58 with SMTP id 5a478bee46e88-385714160f6mr4024577eec.33.1795212984850;
        Fri, 20 Nov 2026 14:16:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm10787009eec.23.2026.11.20.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:16:24 -0800 (PST)
Date: Fri, 20 Nov 2026 14:16:21 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
Message-ID: <awDGXhaRpNcNirgq@google.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
 <r078ror3-9q6q-s581-35r4-63pnp1p93s85@xreary.bet>
 <awCMOvYf64DZfuWF@google.com>
 <73r1s387-pn80-s74n-o50s-056r1pn8512n@xreary.bet>
 <2F4EEC0F-5662-4FE4-B9A3-9FCB83B587B1@gmail.com>
 <op182q3s-q21q-2r18-9p5n-60p7003o64o1@xreary.bet>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op182q3s-q21q-2r18-9p5n-60p7003o64o1@xreary.bet>

On Fri, Nov 20, 2026 at 10:45:21PM +0100, Jiri Kosina wrote:
> On Fri, 20 Nov 2026, Dmitry Torokhov wrote:
> 
> > >> Ah, yes, I un-exported it in my hidraw cleanup patch series that you
> > >> just applied.
> > >
> > >Hmm, but that cleanup is sitting in hid.git#for-7.5/hidraw, while this 
> > >build breakage occured in for-7.4/upstream-fixes, which is based on Linus' 
> > >tree and doesn't include that hidraw cleanup ...
> > 
> > Doesn't next mix it all together? 
> 
> Right, the build fails on for-next, which is a super-merge of all the 
> topic branches. Sorry for the noise,

So how do you want to handle this? Keep this series as is, and apply,
and drop either entire hidraw rework or just the offending patch and I
will resubmit it once Logitech rework settles in?

Thanks.

-- 
Dmitry
