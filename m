Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF93366DA4
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933913; cv=none; b=pQMLtIwZGLRZ+mEHTR0ydh3AKxb4MBKaCChyQ3aYO4q2iSYo63UgfyqRuRs6ctz+rrzvsFOROFKN6f6zVFPTzAPArKJ1cxtHJPBKMNo5oKFzZ7T86G9l/4x8O7kiHLOG/dvpaw3pBdTK2Y4eaoljieLeSC3424rcFd643XJo57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933913; c=relaxed/simple;
	bh=PxkI9ZEVl95ef0uAgeS0w20WL27T1aoU+i2r2y+erRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqxiba8DZKWHl60eF722nyqV17Us7SPx0/DKOkcZXHDkarKy22Czoh6NXF1Wwom3asYaEYnSEJVUUIkRYrHbQ/lsZFEl0pMfdcMLIi2RQzTRoZjm14JXHilNoF5Yr0bhLIbn0Bv4cCFI0G+SPaRW7x7g1S9eubv6i3XAwLJ1Ivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JONTaoPI; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JONTaoPI"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12460a7caa2so3316602c88.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933910; x=1769538710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+oiG92vmpU02Q01PF7tnGA5Qb+9FeY26FbggeLUk/w=;
        b=JONTaoPIogLOwBf186uAsWG4ZD9/b1Dn9JUmiSkssn6E57GVKfAtLGy+Wg9faIYJZt
         0BUr5XqAH7LuvCNlB1q5GYhG3w25b/zUDKzRFD1K/zKKIUWURZnHQ4QewDO0vdkTuHKS
         gpymUDnu73nPN4vMa1EjWZnwotiyIXGrz+E278Vy8nr0oX3IDfNSaRFlbL2OYdMy2KLQ
         NnGwzPpXY21UH/knFMrBgtDnK0txuvF0HlqSMCHCMPsZKkf8zfGYM9f5u4fh8ZLrFNBl
         8DsqLnrtKafJX5kpyKOnAb7KqOcA1d9lW2k1oKMctM5P4ri09TuxPdjj3fHeya3dtS0n
         A/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933910; x=1769538710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+oiG92vmpU02Q01PF7tnGA5Qb+9FeY26FbggeLUk/w=;
        b=IX9nGOrZOyj9aLNi/UgnmS4p9Q+gxKRdr03SlDVY82sunejoaognivV91CGpuLuQ24
         BjG7B9MeHPGz4o7EyFzlbTjetnvnCn1yX2rpBm+rl+PUDRBlzWUTzsArHHqEa54bs0lg
         g+qpuAmXOCiAxgdZm8Crhb8/ZJn1gYPmKMVm9+TV/XuqSzRmQlYeDvCWTtsLHZLizDyQ
         7y6OQn2pZZGOIrOJ/w4SDCchvMJBPQ7gICBCGSCS4EjURFi3yF/24xRAGH+vcsgXFBpO
         +yhK617hO4GtzdqYTtsH+6rVHZb/hV3yRfDJGk8RJ5kmErVIPssU3+0UJ0w4aJka1Nea
         229Q==
X-Gm-Message-State: AOJu0YzVMkQIIzj5Qawush8wJeB3hSqI4WGr9kWE/2tqkv+rUYRClysK
	tgShJWHmZXQ8938dOsArJD0TrwOpI3tiggWcIDZkyetY5mC2gzZABSlA
X-Gm-Gg: AY/fxX6ozz728qf+FZ1N6dsLgoOGnU45rONVyRLTfYUfBYZGLQFSMWzQjGODfNrlvMu
	U1Pw5ZgeR4O80wFvMzBgzTTEo6pjezj61EeNkQcCjg/rXarFMRIthfU6tQXOUlg1+fo87E5xcqV
	cyVZeSGqqbLyGjlFROmNIZUSowimLCdgwodud40cQSW3Q7Ua2SdqfqW0npWvgK3Obu3giJjYYAQ
	kg0CCSr9NduyNtnKw68MNy3G8MUAju5BJ1iivwzP0p0K0dXiNl7yJMXmmb2rn5MmrQCHIi5VZwQ
	rCNMaUPnB0aJ2T8pguGds2ZyEQymW9gA1qhBrQ0HGMnucO5Ep1ugCx3NsvWWGOLkZXyWfxh4xP3
	AR5/cAGOAm2up1I3/GJp5WhepS3wl/dDBAV0SL29YwsMFerfxbe9bCUcqwH3k6CamTugihvKo2u
	D4W/DOBblv5OtJfzaf1Cvff9RHKt6RnkONTAmAHdqS/r7m1KYjHnrMP0nE3NalTrQ=
X-Received: by 2002:a05:7022:2204:b0:123:3364:2cad with SMTP id a92af1059eb24-1244b36d95cmr10423848c88.40.1768933910467;
        Tue, 20 Jan 2026 10:31:50 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10736sm21990193c88.14.2026.01.20.10.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:31:50 -0800 (PST)
Date: Tue, 20 Jan 2026 10:31:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Job Noorman <job@noorman.info>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Input: ili210x - add support for polling mode
Message-ID: <wv3vil4b4lgfrqt4qnzxiffnniw422xjfdiz4svkklnfrslz3g@yzqc265pj5t5>
References: <20260117001215.59272-1-marek.vasut+renesas@mailbox.org>
 <20260117001215.59272-3-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117001215.59272-3-marek.vasut+renesas@mailbox.org>

Hi Marek,

On Sat, Jan 17, 2026 at 01:12:04AM +0100, Marek Vasut wrote:
> @@ -860,16 +893,12 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
>  	 * the touch controller to disable the IRQs during update, so we have
>  	 * to do it this way here.
>  	 */
> -	scoped_guard(disable_irq, &client->irq) {
> -		dev_dbg(dev, "Firmware update started, firmware=%s\n", fwname);
> -
> -		ili210x_hardware_reset(priv->reset_gpio);
> -
> -		error = ili210x_do_firmware_update(priv, fwbuf, ac_end, df_end);
> -
> -		ili210x_hardware_reset(priv->reset_gpio);
> -
> -		dev_dbg(dev, "Firmware update ended, error=%i\n", error);
> +	if (client->irq > 0) {
> +		scoped_guard(disable_irq, &client->irq) {
> +			error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
> +		}

You already have a scope here, no need to establish a new one:

		guard(disable_irq)(&client->irq);
		error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);

BTW, not a fan of the "_noirq" suffix... Maybe drop it and add
lockdep_is_held() there?

> +	} else {
> +		error = ili210x_firmware_update_noirq(dev, fwbuf, ac_end, df_end);
>  	}
>  

Thanks.

-- 
Dmitry
