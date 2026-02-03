Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE9399031
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112350; cv=none; b=rG4jzxdrkH3TNXgVMJ1FUGAJ7Abt4oZdWcHlWwK/PjLQ+4DuYHBCPAxGWkzzhVSdIk723bQbjul6iton8PiY6d97y8wUvct7ECHvPTlS9sjCFkW68FjsLakWYIStSiXuGtJ3Xq5cujda4V7ctCmDWp2f4/OMFNwJyWHEQ7G3Hxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112350; c=relaxed/simple;
	bh=HzsCTJ/5Wd6XFseGcL0tVxKNA/JvuB7yGVCMu9C+LzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es8J1/vmTkZtOu8XaN+99LK+CfU/YykUdKtqgoEmtsqTZ8P133MN/N/rKrLT0TUJnoEmQ9cz61EaXI9Qf69VvJCVXtrJNBYNUXgOe7uaaJkQkdR+FNJPoIDdnjw/K3JpFUU6OppI4P1j3awNQ8bmR8168pGKwt3Z+3ldC+4t1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkyj49/S; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkyj49/S"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1248d27f2b9so6570138c88.0
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112348; x=1770717148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiAadb0pFwx8A76fRfrBpUk1j2ZUlXkLIXp59kF67is=;
        b=Lkyj49/ShpFV6P0NuhYqwgFoWtsAyBxRY+L9hI2glGivdwsVvHhX7UMmV/7ghErTyB
         85q3l5nhj51ipkjid9LhKAuhCO3tkbCznDtp/mRAEq/5TT8VQVrQjfk+0565OOF3GQPI
         RSXpF14qb033DNF8wYzHdqayRDMDx4ZmiI0KB/QYN+dKL9D9van0muYi/eZ4H44LD/Cd
         +JAeFYdNY/yJRJqvy8sZoUt/xYztbm8G4NGD2jnImTgXUcGxtbICLeFZXMSefgPaU9Uc
         CEkppZNEitHyO9iuJEdtMllUSG1+9LaSr0jZQFtVnsYQyz882A2K8LbWQqg56/YmoMob
         CVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112348; x=1770717148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EiAadb0pFwx8A76fRfrBpUk1j2ZUlXkLIXp59kF67is=;
        b=LkzeQOflyQC7iHAB/jRf5JOpV1cDmqiPhSrvjXui+WPw65PVgFPgMrP39Oear8fzNx
         5goG8HR6PQ87BrBKbwFHk2n/wMxtPpfyAArIpd48pjoAmbO6lcvrXsZ3Vo9MmyJbU/V7
         D+AEF091Y9mEG9EwJ/cqk4QvV2fmHPbhqoZgKgqg2r8H4gjmKm2NUwnGhwch4R3aFEmo
         dJ9SI9s8unvMp+QmaXElDmglJ6GDr9ZfbalrEt0sJX9g1G4c4LAaHotCUZnSlnr7OBIG
         sze4XsFaHOK7+rehXBTAxQE/5Ti2Qrfz5Hfh2uQjt/HP+/j89zdv+P9BDEtdPTRoj/t0
         ZrbQ==
X-Gm-Message-State: AOJu0Ywes1lHhVHlCMRY1F5dJYKrJWuxU83Zbm+G+MDNTV8J7bS/szU+
	ha1JYjWBUV32RQz9kllS8dzCq6ZtAGbQZ30VYrgfn7U/TjrdsFQB1zw6
X-Gm-Gg: AZuq6aLlflwPhgHBoXha01Qd+59nCatwMU0KcGVNAEl1uFLDwKOy4SIgzEip2LP7l6D
	+ZqsCqN2tbmwo4ldlRBR1TLFNZg94oAz25g/NNc74Oy2iq+qAVHPIIRtZ/fKklIWYh/f61QrO74
	gJDB9UFNMnWnqFV8+SdK7FTucLBdEEaYg/Aecvp9UMmBgOMQQt3dTYVZAhvA6yhqWoISgW4ZYbL
	CU/yS5PmMUQrC11UcU51Jfh1V+AOxb+IogY4RBWsX/j75ZSn9tEEtjCMZdM13B9KOoSAIiZqDDN
	HW0XStdcrnXKPI1PBMMNhHOXjSqW8+u5eHju6+Ex6qQksj4LF8N2SkvQIxZiaADk3XSRWlNhT+z
	NmNh+iJjWHYWqydRCWUZNz5LF9ZY0T3GizqJ6AxIl8ICTKl1wCga284DtAaz8LVmrif4qCwm0UR
	KZTGR3z1YCOnquazXZeTU+KLR9lLWevq+nOVCatnjuhIutd26L
X-Received: by 2002:a05:7022:6986:b0:11b:9386:a381 with SMTP id a92af1059eb24-125c10222f0mr6269308c88.48.1770112347603;
        Tue, 03 Feb 2026 01:52:27 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea13:571:b19b:36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm19703882c88.14.2026.02.03.01.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:52:26 -0800 (PST)
Date: Tue, 3 Feb 2026 01:52:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyapa - fix missing input->mutex when calling
 input_device_enabled()
Message-ID: <aYHEzf5nYpA1H5Cj@google.com>
References: <20260202220223.2471730-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220223.2471730-1-n7l8m4@u.northwestern.edu>

Hi Ziyi,

On Mon, Feb 02, 2026 at 10:02:23PM +0000, Ziyi Guo wrote:
> cyapa_enable_irq_for_cmd()/cyapa_disable_irq_for_cmd() and
> cyapa_reinitialize call input_device_enabled() without holding
> input->mutex. However, input_device_enabled() has
> lockdep_assert_held(&dev->mutex).
> 
> Add mutex_lock()/mutex_unlock() around the input_device_enabled()
> call to properly protect access to the input device state.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/input/mouse/cyapa.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 00c87c0532a6..e5fe3b8b6548 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -525,8 +525,15 @@ static int cyapa_create_input_dev(struct cyapa *cyapa)
>  static void cyapa_enable_irq_for_cmd(struct cyapa *cyapa)
>  {
>  	struct input_dev *input = cyapa->input;
> +	bool input_enabled = false;
>  
> -	if (!input || !input_device_enabled(input)) {
> +	if (input) {
> +		mutex_lock(&input->mutex);
> +		input_enabled = input_device_enabled(input);
> +		mutex_unlock(&input->mutex);

This solves absolutely nothing. The value of input_enabled becomes stale
the very moment you release the mutex.

The driver requires much more through conversion to handle potential
races with opening and closing the input device.

Thanks.

-- 
Dmitry
