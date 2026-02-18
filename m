Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDB1A9FA0
	for <linux-input@vger.kernel.org>; Wed, 18 Feb 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771395965; cv=none; b=k2zGA+y6ucYuytkXelGf0gekVxRmSxnPzXRBzmnJle8g7tzHAqUDVDu0YmkfyVsJuBjg8TR/qups2cZkvJH1hGrP84fNbDb79VL+SVGTjGpSmAyPQRI0GhJKnSJm3hW4iworZ4Hy5hR2XkuURysGyT6jUVhvC5Z1qtQVCI1b+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771395965; c=relaxed/simple;
	bh=2KD23qcD46LwDrPbqHlKefFt5WCn2x6a66SjGWE4T4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3PGGafNbIqUcd39v+ip38Z2Jf4t9ZwmxEnPUvtgyxaaD/JtywxO2nQaYTAX4wOq1gWVMArquLe5J8/ZCjYW0d8Irn5A1VV8sUrKR+2bNU4zYaLp6vTTncfPhex/lT7/BNFLrFoV0yqVWGQVHvbBVJp+Y8NLMYqOI84sW+R5aRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp5oNi7n; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp5oNi7n"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2baa098ffc6so4225709eec.0
        for <linux-input@vger.kernel.org>; Tue, 17 Feb 2026 22:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771395963; x=1772000763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGmH+jRsiMrD2d15l0zE2uXpvYOyAws46Y9MXQME608=;
        b=Jp5oNi7nSite0JqSVnjCz092K5Rmh/iOtpfQ0UY36ytR4jVgaKsorNTzEN7MoS7ZsW
         dNnraLK+6bxuZjyKQSifqKB5xTH2YwaKErc+vgtpScojX1XbmKwhgRJPP7sWePJ3Rbqo
         fjD/Vtt4kx8K7GEv8LAilCt3BnLf7YXESY7XDrNbppJvZW/gN5klI0lLU9ZF6wAdiUeO
         tf+juY+mzAIDHH3MWn8o9M6+6WK7SL+rYs1NqssJwQ8RNvpsmqcDS1scoHvLFcWjtOMV
         bzEzTP6wC2g7b0GOy3gMDZynN+Q0NS1IXqEJvL76GvQq1w3Nk5wYSRQY6jnXGwlGKpqf
         s2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771395963; x=1772000763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGmH+jRsiMrD2d15l0zE2uXpvYOyAws46Y9MXQME608=;
        b=dGyh7ta+rdiNe+5RScMKbo3Iz7HtHJTSdbJUCfdgTXUqzkYw4EN1OlnQb+H5Pao9De
         21uYobEJ7OO++2Q634vEJiKsgHfxNTtTcneXmZ0c/6sG/zxsZPZfFUeU5RcfY9h8fodH
         Er6HbimRIVoYhqQPIqIB7FT5+1Ko/nEbDD5kzVJgHUfV5xn0AaJNTgXtWYLawcrV1H9w
         yjvIWnKuV1gUkylx/8WkYb1yD0BlXNUh0q7lrNgOXc/O/Fzb4Q+tly6XFi5TfPPCqj5Y
         Xf/Ppf0HuRYvvBtd7cQs57toxjkMqu+mtu6EaUkU1oTYlLGdRU/3qWNLiTuD8QHFjrAq
         /E1w==
X-Gm-Message-State: AOJu0YxAkYr2onfqyjQb/1BIcyztTiTpmswnftwztPO2TXDTn9gohMZL
	Uz8qLcrVJrh9iI4Kaub3RhyEpZQi+R6SO2uVy0NeKHgDl+zZugnZF77unfDk0g==
X-Gm-Gg: AZuq6aLHgJD2KD67Zgr8RD7szHVipde7ScC60I0/rnhHJ2yE+SKU3dB4nRMzPd7/tYz
	jtE6H6FCAOxhSGxHuRR5HGkt6a19rDbycxYhkYroF4VUlvt7el3Eu1L+f4Cv0DlnWYuKbhrp/JJ
	gd7W0RtTXnM0/wfgPO9uFjqyp7PQyoCVhqSEz5EdIhxVGCRizqAO/o86/po6VHS122Qxvw2MYDZ
	f9oqEGCNMyRUieIgXiPs+Q5DoShPzsCbtE8HRiFBD69njY4sO/QKlFlG4DDT8Ug0/X71aK1WLaJ
	z/e2nFxLmB1v9LEju5RuN4tYx9dodbOUoacSh0rKLW7FhPv4EvYvTYiVQ58Rjc8fZ9A0CQy+sfp
	G1nDoZIGdaS7zzqbdITx5i/Ol1wFYDiqspkRTZGTCyPTnaBQECUOt8nXS4pSR4wzUFXCRZdcsOx
	rhCp3mk9IclxdIqkNeavr7OwJa3Ar0wgfpe6cwsctwIG56tkBOsgnY1LgGQJTHPFm3
X-Received: by 2002:a05:693c:2c06:b0:2ba:ae6f:8153 with SMTP id 5a478bee46e88-2baba0528f5mr6478556eec.15.1771395963221;
        Tue, 17 Feb 2026 22:26:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:968c:f102:3683:408a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb5653aesm16289728eec.11.2026.02.17.22.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 22:26:02 -0800 (PST)
Date: Tue, 17 Feb 2026 22:26:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Novosyolov <m.novosyolov@rosa.ru>
Cc: linux-input@vger.kernel.org, mpearson-lenovo@squebb.ca
Subject: Re: [PATCH] Input: atkbd: add keymap fixup for notebooks using 0x6e
 as Fn modifier
Message-ID: <aZVZokRqcqWMfLbM@google.com>
References: <20260218041352.797625-1-m.novosyolov@rosa.ru>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218041352.797625-1-m.novosyolov@rosa.ru>

On Wed, Feb 18, 2026 at 07:13:52AM +0300, Mikhail Novosyolov wrote:
> Commit dc8c9c171ef3 ("Input: atkbd - map F23 key to support default
> copilot shortcut") mapped scancode 0x6e to KEY_F23 to support the
> Microsoft Copilot key on Lenovo, HP, and Dell notebooks.
> 
> However, some notebook platforms (including Positron Proxima 15 and
> possibly others based on the same OEM design) use scancode 0x6e for the
> Fn modifier key instead of a dedicated Copilot key. When 0x6e generates
> KEY_F23 events, the Fn key breaks Fn combinations such as Fn+F5
> (touchpad toggle).
> 
> On these platforms, the hardware relies on 0x6e being unmapped to
> properly handle Fn combinations at the firmware level. When the kernel
> maps it to KEY_F23, desktop environments intercept this as a global
> hotkey and toggle the touchpad, but cannot re-enable it because the
> firmware no longer recognizes Fn as a valid modifier.
> 
> Userspace solutions (systemd hwdb) cannot fix this because the keycode
> mapping happens in the atkbd driver before events reach userspace.
> A kernel-level quirk is required.

? That is exactly what udev hwdb is for. Use it. Check 60-keyboard.hwdb
for examples.

Thanks.

-- 
Dmitry
