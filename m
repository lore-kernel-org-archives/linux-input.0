Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF84A35
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893053; cv=pass; b=O5nhVAW3PLIi54YAQWn6USRUNvN4vYctDB6Jycre/53ydqWEnMA8jesESmKUBCDYmwwl9Al5M85xAgochUTS3B0wEHkpgNeqm4iDjrD1LCHsXBpvle2v6DIK92fa8WExWLZMstBT2f8qpiIGFx6sewdeku1P2Wvy/4DHIHuArtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893053; c=relaxed/simple;
	bh=tmxvPnC8g8NOlS/WboF/VhTQfeG5R00KcSwfFVREwI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6dNNaURwd9wPseT4nqT68K0IwTikqTPE30uYu7aVD9Uj18dfrf7wAJB5ix758IwBZ9jBnnYmLxgP2LO4+qbRHLC5rPok68jA+0QFD9cCqHmQ06D587Rq6kOG3RGehvFKYGD/YUlYjzsQcJ4co2EuKPdDhgiM+j9L0lnzA067bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=pv4BB5OS; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="pv4BB5OS"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66892c81725so614758d50.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 18:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785893051; cv=none;
        d=google.com; s=arc-20260327;
        b=FPwmiL3Naa5NFU3krAo5cWrm+JKTgRVn0IM9/js0EDuKkT9uhAwr9tA/nJWdpZVS71
         JfMughu/f/4IajYvE4ZEa51sfqCZfHhrTRXGHqYgNkNP3tzWhe4bVLc5qF5MlIxFnkiT
         5KVFTU65kpvQdcP3r95HPXk6ZkO4DmDcqfE0LYFOHdWPkEGmThuzQTmINBWyUS4EZK9w
         Snu1p/uPRXuFvVf7paRpyP6fksLbotVRNBcUIpE3mQjPYNJX89dM0EwK4LnmUSXt9Zf+
         MIigFr0FQDrlRenfpK/FXTVC49Jd5ysX8i0O9VbG3TU5UIhSuG4OYW2DbFT8+P7vRURO
         uQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        fh=Fp9ajLKPd8Ktau++vnGDoTv4hUCffcE/Bfbc1h/t1Zw=;
        b=CGBYHOpbj86zK/vcJI/DuMyA6++oxNFb0vlzSEhfMakfti7J8DkVMMsbXP7JmmV+Jd
         D63Bw3qOBzdyJZw6vyYkCh6kI41z5sB0U3TTemfisHltmcbH69djTj18E93S+P2oCtb6
         gvU18wZ8fvl9p4dp8icouvIl2hYjGFiQIRi63PSrrypNBOSxwZcX9C3ExFPpaPQneVdn
         Vch9B6s27L9zh+FtmfWnP8QXZVJ4WCbHVEZ4AcYfY+4Wnjiut/uiYtVjA18aEVg4Msiv
         hOcy4nhFMT51UW/pyQVDF1L4CZgZEfmuOnEc5REz8cb1eWQGBpGg5d8UwjD6knaINtul
         XlLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1785893051; x=1786497851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        b=pv4BB5OS/Ri0wgCFSarJUf3N0JOGFZYuXr2xbeR4bvI2W8GArKV3+OsbE/MRw7fc1b
         M2uEqhRei+ktencUNMoi4ipc/Ji8QG4fpQjmKcOiA2Z1BLUosZRZ6kikIiFdxGINFRVM
         huiu5RNMKz+4K3fBpaIsdc+iNn7gpeAsX44fhRlyz6NhEVqS15xmn5DjsTH2zkAmNdA5
         DwIZx8687P/NC4TotAbJtZVqX1vS1CSv7yQEyPJ4tT44FTyfX8Jg8Z/Yo8VEeNUXUcI2
         L4ld3TtADjO0yXbXSbxRTfcJV3x5STVHqjE5DWWlf0oOZoCyMcNu24RBaxsfb1NfsjqC
         LHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893051; x=1786497851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        b=VzjNCiOj81KXHe8W4g6Eht5VhWhhxFJrldqniVci52D5qNBHHetFt0Rmc9bZzhSgfn
         Q75q8KufHF/yvR175bFKxCc1/GBgikqpjFgA4dbQPuiNDIpFx6RhZ1P2YtSb5GnAtkxo
         g4I5KqZzmQ50FcpGhF3r+AgBKxUWKzags2kyN2Sdw29dW78i6i0C8kN4ywjm+QQICJgz
         D5iExlVBV/8qAJDzd9bQo58oDWqR3SFMgU1xtFNS65OZjGB3MbUDqs24mgyogTHOIgG7
         09R/Tx+aMmdJynETj4gOP7IPR/58cavkLWI8wWDGborJaxlgdmY5mmTiFGIL68Ewl8bW
         2mEg==
X-Forwarded-Encrypted: i=1; AHgh+RqoCkEFjSKap039q1Nauhm5k7Qp25lAlOXzlULVtNq/d7BCRcuNlxlyHZWG/WQ5RUYzgtuv0ckXZP8AWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuP7uaWEQl6qTsSQsrVviEEtp4Ac8uQW7rt6fOGRoIcgJz3l1
	Ess+xf811jP25gnCDhW/Ge9SetlNfBHSCOsvtDXVK2bb7ovIofwJLuBW62Hb2ih6Ahgr/MOrGco
	DqnwcupCu4+XVXHEStvw7QGDrFNuE3bwAMRqhP5Bf8w==
X-Gm-Gg: AR+sD10+t3cs6cUc0PFxgZrVscqZ9hek5YOo7xYWgM6VKLwE75Xh+l+MOc0gKLTncQl
	raxOC2DKS6jPNPpFEhdYrvj57m5jW1/r3jODUEBo0FmqX8sN/94gdh92Bk58wt/tbx722DBLK9e
	+FN9b5uBstvjynFwsI0ztCNwr3J+HJjh6qi1f7tGip0HV5qg2CkSqpU1zuRQxSVDxIrYgGHvb5c
	AtfVDCueYglII2VOwc/CH3QKyS3PmOEafSxLcGAXtllJTawn6maino3HJjypfSfOgJ0pshu6U0B
	KZfTJLHN7K28q6Cs4OIHXxhmaEpQYcjj8xCqGw9mtLPBGu0HbLj6+HL+cdo8UnstDOl5c6rUS2r
	N+BSom8A7hkLCsSdS18yd0gPSJop3v0l7RU+L78WbNpy+1rfIZdrouOfgLsI=
X-Received: by 2002:a53:de46:0:b0:668:8bca:3c41 with SMTP id
 956f58d0204a3-6699aa07c2bmr1434552d50.17.1785893050757; Tue, 04 Aug 2026
 18:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
 <20260727221338.29f1da9b@jic23-huawei> <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
In-Reply-To: <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
From: Daniel Schaefer <dhs@frame.work>
Date: Wed, 5 Aug 2026 09:23:34 +0800
X-Gm-Features: AUfX_mzowNSw8oJ_BWsMvsuBfDPCC2ZoMA7KG6a59qc4VajLvGMGgnsWHW0O6FI
Message-ID: <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>, 
	linux@frame.work
Content-Type: text/plain; charset="UTF-8"

>  I'll queue it up on the testing branch of iio.git but more eyes welcome if
anyone has time to take a look.

Sorry I'm not sure what that means. Is the patch applied or
should I send another one with commit message update?
