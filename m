Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602948;
	b=f67lpdNWfSTnhs6YOwjIyNWNIn5LpApe9L2yRO7zGDaNi0R+k8pyPaky3G0h1ggm/IPS
	 mw/ygRMniEX5UgtlfS7L8TBaLd6RBSqBW9wqthqUjXasOIs9dZxDc9jLjt1yXbQ3mCVDd
	 ijQsrdXN6ifHPd3tXwBzGWaSZHYFBRXaqZZNsNwmkWe4/9cagNj3nlleWqfX3BAWEQzso
	 dK4dJBLc+7+o2cM/H9qQtVJHUuW0U2/j2LdTTSB6JDOWPKQJuY7NYfxLCSbCtYZ9ClaDa
	 8ZC7AZ9tBnvP5zTtGcbqJOjuat1v6FZA/e05AKFnUEwRT0GG3gjbqXjilfgPhMHmQDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=p9BvQ0VeluCXAWmqoKdFU0SfBt1q6ntM16zBa5vzFtE=;
	b=YtZuV3MMaRIRnVIVCHWt5Gh2G0ynFp4yJf02HG+bS0BcDuAdw4SZLJatPiR1lFala7K7
	 WGqvBhSSmA06ia4q2jEH/MtJkrr+WtNDxQIvgaBYkHnmEUOZ1+NwMzAeysZlmCtZ5/ujW
	 kLfu71Obtth8DeomVYh4XqK9T0ynXLO93Nq5Er0zGBFHyXs3zeHoR0cvBp8vEWyITUUPj
	 SbQxT7agH8PHS4hhSCRytlFx7Zq6+FKI4Z7Up3RdK4l3UgXsLUF76Isy307kS1E9htV5H
	 ALI06w/ixs9xAMeo7O6D81gGzmnBgYBkvKtl5vTM7ndA+22MGK0J4/8db35VpT2gIUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ld2Q6zjM;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A39606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 17:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A39606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ld2Q6zjM
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15943c9c005so1156878c88.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602947; x=1793207747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p9BvQ0VeluCXAWmqoKdFU0SfBt1q6ntM16zBa5vzFtE=;
        b=Ld2Q6zjM355/jbQmnQs79eZACeQtT9eZSUVIhd5Iysgzp/Nu+p/pKOhTu/WWo+Bi3Y
         YDzHPb2GMQHGcgieRnH8M0yHs3S9ZbhX1D6HK1y241SRPxSYmYl7PNYV1Q/joCXTVlzd
         LJLLmhyTdlossdq5uzo44GcuqvolB85SLhiRRzYkSl8SOXAIoSbQtfPnkaQgh4+yERQX
         CZZxz4E+lpVBHfyGibdgqyKV1xePoLNyaZV2NlQMl3P2WugENL4CG5tyZxDwT9WuCliE
         gcCMOywWQLjW+cwfz4o5eXweG1or6tmqp92Q5Kjf+ZlvBAxvas1gTdNLK6KgCEECqQk0
         NAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602947; x=1793207747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p9BvQ0VeluCXAWmqoKdFU0SfBt1q6ntM16zBa5vzFtE=;
        b=Jy3wD731fhSrssfGUeKG3Uko96MAvhTkDwZ8Yd27JOV1aWLh2qf7a/iNFI7Ue5j817
         I3PxhqssXwAio2cAyd+4KdHlf6oaADUcM+vFtYt5WA0CANHDCdlJmxHd07SZYuMG8+vd
         O1ssdoQ1cF8r6AzpnRgZNMArgT3V9+/05Ya2AsPJ3fFE8vluKM31ezsSRDWO2Xvf2kJl
         ei/nTL0/eOCsJ+IQvOmQ/Xml6PvgxS+5AotxjbEVKPHzp2Ep2H6XSqQVwMDABTKhD8WS
         R17y8Y0kTyfmeh/KVqSN2dgl1SdRPGo2JxtsGI6qpuPMly1iN5MAA7pgtDKjYnx0Q8zU
         5PHA==
X-Forwarded-Encrypted: i=1; AKwUvBwTNPJDLg8cGH3cInTmWL+3BS4ql7FxYKBw03KDwTIMN2xiCgjNVTDSmw/I1eAwQbvV371tGuC9h5GLSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4H1gaOXUHNpwKfcbBON3KI96WG7gjEo1uF93w6968uN95IFLQ
	lCLxo5pDVzAQQtZ9G/NYPjFIkgm8Vyqy3APnZYDRrdBSQFjfufZbghot
X-Gm-Gg: AYBFou2dkEWooDJDwp7CDmeXVBp7HAOtyCBDF9VhJbJ7MB3f2QTEAAR1H1wYbxr7Nak
	5D8S/+/7cK9DTSrLxENxIZoDxFXnTbjt5Fppmqt6sP4A1TV9ozMTzCccMSaEQ/7P0OtVg8R6mxt
	XOjMpyIx4xZ2k4mrKtIARG5JSZnnktyw9J1JtdnuKMrBiJBfGs6pDa6xPmRJB5czd087S+KyUGr
	xdCuV5uAAamLl4xvIWhgHp2KZ9x2cdqf+vmrWYRaUwR3iym/T/xN5Jx+aDVgX1DSUNEHkqkCCON
	QsHoGvr2KO53yiJMjpKA8b3ecQzlfGHcWDNU2kWiC7byGofFI43llpRT5FoqZKH0CNV3/zfFlSU
	0O08FrHo5eg6yl//yCUhvImSjTAbLlwJaN5Jz71kLXGf02XNpEcQjqZmVXsVcrzDO4CUVLaR2nq
	sbOz4BB68pDDfQUZ3olRX1iKcYbKAo7qqpWEToOTYMLgHA0Cchmvvuc1th3RIDEToyFdZlAErvT
	KbCK1CxflRBcEG39hU/bgDXqyGRev3p5U1vzdTcocXjX1gq7XiiGkkwWwHtSIX5J8qhOhNXr0rT
	9DsNk3HkqaRLhOf7cUXvkw==
X-Received: by 2002:a05:701b:2914:b0:18d:96e8:b913 with SMTP id a92af1059eb24-190a9eaab7amr2994159c88.47.1792602946836;
        Wed, 21 Oct 2026 10:15:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035926fe9sm6166666c88.2.2026.10.21.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:15:46 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:15:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
Message-ID: <atjyyqxnlqEvwNxh@google.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
 <atjw4b-ICVGH3-2a@ashevche-desk.local>
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
In-Reply-To: <atjw4b-ICVGH3-2a@ashevche-desk.local>

On Wed, Oct 21, 2026 at 08:05:37PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 20, 2026 at 06:50:00PM -0700, Dmitry Torokhov wrote:
> > Switch to using __free(kfree) cleanup facilities instead of doing manual
> > cleanup or abusing devm for allocations that are only needed during
> > probing.
> 
> ...
> 
> > +	const union acpi_object *desc __free(kfree) = buf.pointer;
> 
> Rafael added 'acpi_object_free' for __free() (pun wasn't intended :-).

Not sure why it is better... It goes through ACPI_FREE() ->
acpi_os_free() wrappers which might be nice for ACPICA code, but has
limited utility in the rest of the kernel code...

Thanks.

-- 
Dmitry
