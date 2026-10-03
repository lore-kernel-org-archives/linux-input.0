Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3E33936F
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791004102; cv=none; b=lO/8S5QZhkMzDM8OI9n4W77Zh1rxNzVhB3fJR0oF+vv3qRt+aSGuR05MA4coLa9+PVPfszSTPv9B6x+2ca5I674APBJNU8ueL/VEXSDzI8L+ZTsWC3J6ZpUpUKLJgCUaTFs3GmApYa4tw0iOu4QaU47XUlIdRPEzZGT31BB3HCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791004102; c=relaxed/simple;
	bh=CpIVr0I85Zas4kFay/lmQRfyzCeQAC85EdsxCTmXls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC8iFgcqwiQdAgC/M7y/hNXmh9wf7stR1Yi/RInxj5saU9e77aXLuW8jhybr/ZivLK4rAuoU37a4afvQApaoRpsLWh38D9o2RIp2EnudMmNBDC4mj0iqNQQEdCBWoN++CbDf4+J4xVXyig1q/nlF9YNZQyz1SZbtm65F4MNTwR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esf+2oHx; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esf+2oHx"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148b5c829e8so33567c88.0
        for <linux-input@vger.kernel.org>; Fri, 02 Oct 2026 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791004100; x=1791608900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=26XkV0aC8VpwuUxrEo6yFlDkCBgaJ9gL4qbHVPOCbZ4=;
        b=Esf+2oHxxWBcgV63QVIVzoxn5NGWhzBxDgZMzd1vXOKTbcH30FYRTBVTzJQ6EgVmBc
         GhiJ+6mYQO3btI5o71ZQyrrjJSI1aAdKd0zg2NN+2ykV/hC5Gaf8cuHjfRw6EPI6XKq4
         492uv00kJ3bd7g+QHFD6bcFXJn6vMOM41W/Stlau3PaQ6CF/0v8LIruz4U7WDLyqvQyG
         mubaetYtNOiTyQOCuAQn4NzBturOZZTvEUwl25ent63gMTsjVsJYEO5FRovbOScBf6Y8
         28RS/Qv53cPoujUFxbXHRjQT1VbNXcaAf+KjWS8Htoup2mE9Mp5Yx9WvtQ91rPKagkoL
         gpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791004100; x=1791608900;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26XkV0aC8VpwuUxrEo6yFlDkCBgaJ9gL4qbHVPOCbZ4=;
        b=PdXlbCyGZOvplMeXpgiourxN/a9JZylzXqK4JOGdQ9W0F4s/CR8vnetXze9RiAZvfQ
         APvyBV/99REEMnzXx6bHGyYMrIAAVggoKL8f/Rrc4UukNVHxBmksFpiFCTjGandwXaHH
         9qk5FIdR7Ag9BIJFkuJocFuxLpDphA8bRqpayjPgMN/Qf+uxXp8EpHY+R6sxx33u4IWl
         NfZPc9RN754+cYX/afGDGZ/jiVmQDzk71nLA9cDbH657SqIpj74MPHnwZK3iS79/PhLg
         hlyN5XJouDfUxfL3fms5ZHyACkpRn/utauCjFTvVrJUPqDp0jLTcZjFpDZhx7mhznmXy
         89Sg==
X-Gm-Message-State: AFuF++m6mbHvjRSTPikAgln/3EFjC0V3zpMM2NSP6D7lF1SVSivXzQ6E
	ZMfaUCvRT5tnHFGe0jcjcMkU4HZ/9DH2cneYpHm79/ta1IjXq6ZO/3b19R1MYgHF
X-Gm-Gg: AYBFou2YpEnEXsb6jCLL6cmrq06ll1zuZvYTVgqfzyV+nzEw8MtDxkhCiXlUXOtnOgY
	5t5WdzpC7wHeRXJvaIyxqeYM8kU3OpuJSiDxhqrfMn4aZvD1OYOt2v5tQUsQ3qLhYf3hcHp7bML
	NdwgWYYfHppVo9rPUUuOeP1gmZT3rGQ8ZdjTcyYmWFJbZlxr8VKn+4haX9IMcAoDmVTplFq0B+c
	TC5Y++uBxbszsZF77VcRknr3fPQliHrGfySNrKA9Usv55wXMx2KxJX2PRM1Qdjn/qzZHiMFMrpM
	Dp8L9Z9bEUw37AYPvmVFKIjnDm+YYhh7HX5CPe5zl47p3IKnvoIoO/n++d3rAi+UPOS7ebFgcWG
	iaiddLVO1Na0V8mn9y8551P6ROxei4VOHyja1D5R6gFGfEhwFOm1H1owDV3eVm0tu6w11Wm5rbp
	/XiJ0Uc1mqjInLpQ9YK/maWHeHGBfUQ0ZZ9OeYxiuNsrOsumsLLMo3TNt1cGi7YePrVNbfR/Qsf
	EWVAwT1n3zzQR2UJTN/QX9M1fS56GtKt4aVE0rNxYebzC+f5bY=
X-Received: by 2002:a05:7022:107:b0:14e:9480:e5a4 with SMTP id a92af1059eb24-14f5c4ef00dmr7752937c88.23.1791004099685;
        Fri, 02 Oct 2026 22:08:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f6b0:90e5:8010:fce8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fcec9a95sm2363486c88.15.2026.10.02.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:08:19 -0700 (PDT)
Date: Fri, 2 Oct 2026 22:08:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Martino Papero <martino.papero@lcb.to.it>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 15IWC11
Message-ID: <asCNvLDGPHHpV3RU@google.com>
References: <c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b597b8-e7ad-4fba-a2bb-5d252e3dfbd3@lcb.to.it>

On Wed, Sep 30, 2026 at 10:10:41PM +0200, Martino Papero wrote:
> The internal keyboard on the Lenovo IdeaPad Slim 3 15IWC11 (83RR)
> does not work correctly with the default i8042 settings. Using
> i8042.nopnp=1 and i8042.dumbkbd=1 restores keyboard input, but prevents
> the Caps Lock LED from working. Using i8042.nopnp=1 alone does not fix
> the keyboard.
> 
> The laptop works correctly when atkbd_deactivate_fixup is used instead.
> Add a DMI quirk for the 83RR to enable it.
> 
> This was tested without any i8042 command-line parameters. Keyboard
> input and the Caps Lock LED work correctly, including after suspend
> and resume and after a cold boot.
> 
> Link: https://lore.kernel.org/all/4f43465f-98ba-4722-8e29-03df20315369@kernel.org/
> Signed-off-by: Martino Papero <martino.papero@lcb.to.it>

Applied, thank you.

-- 
Dmitry
