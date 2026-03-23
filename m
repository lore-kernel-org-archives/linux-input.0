Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385512609EE
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242751; cv=none; b=o26OzEWeY46qnB1SIiyWH/QL6Cr4SAJX7hG7UF5VLMsV8TWze2EjSZ5VYIQkZ0TP+07jr0zIjfNZMBcdsNDMbl7lvrnmfPX2mExSFOzVtceYLeJmY64iQCdNnttv0M/grY7Bdt/vELycgN8jvmfrS1Ak5aSYpdvImQAzcZrHm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242751; c=relaxed/simple;
	bh=NKrMi73IqQ46eVsbY68Xq0Mn71PRrCKQTsaSsDKzMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3JywJTZ8ZA+Ji3YjtUJr/oDE9Olvunpuf9JMVfXCwbJbzc+otKV4xMARgZLPx5p0S4h2RQLE7xUKDpDyS679AnkltVEDdC8bnTqeeT9DsRLHUeiP5E4Qpt69FtQNup001cqZKYztDk/WbsuqF6My3jepFV3zceNKIOoY8eycAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1v6g3fJ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1v6g3fJ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271195d2a7so5512197c88.0
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774242749; x=1774847549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C10CIn9egPb7Wwv3+IYiGxhrZ0mPyMt1sPTDwK7YNzg=;
        b=H1v6g3fJVlgBXOufWxqvGDebhUGp+5v73v2JjBLPAsI0E/iJk9aTv7/lypfOuL8jZu
         JFRLmT5Z/H9uW/N7hpdEplg8pE5o6MZQxoPAu69xz1bsaJZ6nmAesXw9KArpS33BvZYp
         +OERE7YEfpnpPcVk7HBe4X1QUHq62KMa+364GReIr/fALWqFa3mdFoUO53MZ3YPbSos0
         eL7vgxtDAIqIgZKp8vBD/ooJ3o6RdcAC/8ckhQhqWRq9SbWf6uA/X6lBjpvx78cQg/69
         QSRY8jcnKZkOlklFDzgILNE11QBMooGxpiw3CabBNE843ej4PMu2ntgFQTpo0DELiGzj
         3jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774242749; x=1774847549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10CIn9egPb7Wwv3+IYiGxhrZ0mPyMt1sPTDwK7YNzg=;
        b=EzfbuZn5sgDTpilWLx32IK5awBCnkWUjXwLRVGTYKOzU9CQxJQi69+SmV34tOQlwUG
         96ryEhMJZBcYZlwrsogij6lE7Nsc3JDn3033h4CKeOxQTULLhp9Sd3LwCX5V+BLZEhJd
         WqLIin0jIZzEefUdlFLZxdi2Yng4lZ4UWGsRk9hWyn97BNf2qdo4lWq7CmPB4e+vOVmf
         P/LT03cQg0yR0WNJkmmINjVnorsgzrkV02N4DcZv/7lwAqywHPYl1LxF8q86Z/cQUbMd
         19QahGAduLi8Dq1sUYXWLFK/WlBY9cB1ks9VOHo/Kh5o+ZUZdSalGgZPy6hiyngjuhU5
         6VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWio1QBlQvFzeTUT6PSXCODJlWBa2xT3+GANNzsDQqVkaLcWLOL4vW6bSjtYFd1O8tnnuwFhzO9rSCq1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdg4vKAzchS3mIqIXRmhl/bf1FiVBhNWt51V72QsYZIGLg+Lm
	ObXMXVhObUol7i2Od1+wJe2sHkHRL9cmsq62jAjqagilTwHBWEJjrk+E
X-Gm-Gg: ATEYQzwI7TFTXZ7klheU+636jBldSMDPz+24eeVfGhQx5/oWBOvOGycUUjREZ7bEV03
	VilyWEAbEn1C+MYdAlRdnW1qqanMjbPmHIZFpCZDQUKi/PQlkBbm1vOqXmC6dH81TZzRZ3ls6RV
	t2LoQfoMSAhsxOWrZ7nQPbo1jEerattLX5AerJ1cpbahUO3FCvzzGLNDF6o3bNWmdv9J2CzUukg
	rOQpaKenRnMHMrZ+XDeNTYdRrtQtbTeMzIHPCLjVIuXAoaIAPZj74mVXEgiFEhJmHwahRb4XMgS
	QeYMK3V6SS/ll8YfZOPOm3NA9hlun1lSypB7kuMOJjNwwnpZitXdH/yub6HYnlaMIw6W/P+Ocdc
	vas3nNffiQaFLB5qmLTtX423QCtVNo1HWmeNN8FiDSFdi2YbV8oknxCYdVV8cp/faO+bakfUDhi
	MiGTlLXfdr1GxI5Cuyt97XUP6tJxud12KflP4nqB2mdfqg2BrVGCbR9GfymMBwzAgg
X-Received: by 2002:a05:7022:ef09:b0:11e:161:c008 with SMTP id a92af1059eb24-12a726ab2d4mr5210493c88.26.1774242749245;
        Sun, 22 Mar 2026 22:12:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736cf7e1sm8219871c88.15.2026.03.22.22.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:12:28 -0700 (PDT)
Date: Sun, 22 Mar 2026 22:12:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: charles.embedded@gmail.com
Cc: Anshul Dalal <anshulusr@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Charles Dias <charlesdias.cd@outlook.com>
Subject: Re: [PATCH 2/3] Input: adafruit-seesaw - add interrupt support
Message-ID: <acDLSiujizhuYfOt@google.com>
References: <20260321202446.724277-1-charles.embedded@gmail.com>
 <20260321202446.724277-3-charles.embedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321202446.724277-3-charles.embedded@gmail.com>

Hi Charles,

On Sat, Mar 21, 2026 at 05:24:45PM -0300, charles.embedded@gmail.com wrote:
> @@ -289,6 +341,19 @@ static int seesaw_probe(struct i2c_client *client)
>  	input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MAX);
>  	input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_POLL_MIN);
>  
> +	if (client->irq) {
> +		err = seesaw_register_write_u32(client, SEESAW_GPIO_INTENSET, SEESAW_BUTTON_MASK);
> +		if (err)
> +			return dev_err_probe(&client->dev, err,
> +						"failed to enable hardware interrupts\n");

Maybe this should be in seesaw_open()?

Thanks.

-- 
Dmitry
