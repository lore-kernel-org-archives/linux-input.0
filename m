Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E31372062
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937812; cv=none; b=POKLZiutixtrQ9Ho9pFT7LHTh3107bbrF+9gCk7bPxLBPIiUZclagMlE4wWZmbbafVk7pC+kBxNfT1M9fYh5j1xq4FSDc3ti+bMBWG+W8GwqfeX8/Gqzloc3Oh3ZVHKNTiFsh0CSWl/aCehpaposeZTm2sC7gAn7/05OuD8KXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937812; c=relaxed/simple;
	bh=C1PD1cUSId6ObmvDRcysve+oP/kTqBM6v8jsyuYu2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxF2wNrEonY4HVgs9/YtDOBCnW7N9IMhM0Iqs15i/yLhqSk8ajbepovL9oguJTnWhM+IOojS5GajcJqBQ1cliO/Fr5corxVYqRX5O5bBteeUZ1xgJcqeQSg6A3YCn24zS8p7zH3wbnWNr3Xq5DOdwxAa0tHf0Fs/pNMewUKilKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkZrgWm4; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkZrgWm4"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso8124214eec.0
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937810; x=1781542610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpwJ9v/AiXpP4VJQJr26kjpknRLuUcx7eSaLf7M6YkA=;
        b=SkZrgWm4K3Rsi/FlkS/ENS02ZGtySbzI98rVv/0YhbbDgNPMPvJLWwmQnjURT+JYo5
         iHjBn4F8iQj3lr7ZggCDWG7PcKxxvnF5wkgTvHltmTvvqI9zN1Cq/hU2Utb8RMVFrClM
         yh4kLwt7zQZ5pEHxYPa5k8EQ68QMWub3+Qv2ksTTES5yCvr0wBx1U29b/h9NcW8hH6+/
         x4UR1hvo4AEGxTUv6p1YCooDWuZaS/+20WyR+mZ4pSHcw69Q+mhJlngpYaBPJAj/I/MG
         EGsID75cM7tGQZOn8ZOchXSTKanaaMsVl8hqfMHwOWHchCWoRtzwG60xdZVOjdPk2FjU
         Tvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937810; x=1781542610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpwJ9v/AiXpP4VJQJr26kjpknRLuUcx7eSaLf7M6YkA=;
        b=dFnESwanb2/VLOzoxz6zXWjU3fZYItiYY7NSn0g/LV/xyDmuWQGxq4z3rDaClCk/HO
         sRlqQfIXKojLGha0C0jmxmQJYUvqeILyUFaGLXTPdqrk4oAlVW/EDd3pOdTJyNm2jG7o
         UwzD7f9QN8RtdorQxA8+yrXRyRx54GBRsRCdQyGY5Mu2bAIg1IQ6F8was8mBOIJI9caW
         kjwl0eTBTvSUMbLr81sWZyoIw/hZmaCtvvee5k/NkqN+htfF6WtAD9a+tcINv369j8Lu
         q3KdQD+HyHCoooz6ifdlwqDvZUA7sTZkoz47uYtG3Ypc6Z7vW1krzNw3E6Q5YnRqxl3o
         2y+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+c5s5+KdVPI4Sp/jN+A4kP/06Nxo0vUP5bMJZt/NrYk05MIw8FwDSe7S4MIqRFIfe/y2Y3u3k7r+WwAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQrAlz7ffzTdg/13ohpCHej8Mup+g7eQfhXcRK+G8nJTQAz+Z
	/5HZ0MHB32EeB2G3vc14kkZjAFuSwcTixnFSQY67D3AGVnyi7FL6sJPg
X-Gm-Gg: Acq92OGdbXK77A4AKDdhtlzhUccAjorNiGoPGKUxxoQAtsZqCbWAAU+8OJgnMeYFFEg
	fohjM4x9DXI9QgdV71wRaq0PIKhq+zIbBvHZH21zzkSVPlPwkKL4Il5fSvB8y5chSnjROnlU+83
	eGHjbtUy4RSwUSI/jz85HXeeSvy5WrGq8xeI2fsgWkIjAkTJ9lhL2wakrM//hqAj4GkRS/rPzht
	e4xCvhs7awAEjbNsUeRFHc11ns/WyuKP4HPJoXBVFBAPwunDea/EEgul5UlOyY1OEaULK9YzHeS
	MoreGJ8psQhWryEegibbTobPqGOYYPzKMgYBQn3paAf7s3QIqAhFCZVul+y++FaQoqsegKcbY4Q
	itHESWiNrLPRYvFdv68h2mF7EOoncjq1JacHq+prVwphem9+rbIdFgDoPAkO/SZGRWkB0J9NMEv
	dEBy/mYeErR30H5YR9Dcxzfh48LA1XKkhA2XWVsyWRiJmsB6XmMtn9Av9DWehghzF5R8P9LGHrZ
	JI=
X-Received: by 2002:a05:7300:7488:b0:304:e566:e000 with SMTP id 5a478bee46e88-3077b2db403mr9281297eec.31.1780937810237;
        Mon, 08 Jun 2026 09:56:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df3b234sm22816203eec.23.2026.06.08.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:56:49 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:56:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, 
	linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
Message-ID: <aibz3auoiq4CFa9l@google.com>
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510052107.555825-1-enelsonmoore@gmail.com>

Hi Ethan,

On Sat, May 09, 2026 at 10:20:49PM -0700, Ethan Nelson-Moore wrote:
> diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
> index a8f4b2d70e59..cea72bd888af 100644
> --- a/drivers/input/serio/i8042-io.h
> +++ b/drivers/input/serio/i8042-io.h
> @@ -15,9 +15,9 @@
>   * IRQs.
>   */
>  
> -#if defined(__arm__)
> -/* defined in include/asm-arm/arch-xxx/irqs.h */
> -#include <asm/irq.h>
> +#ifdef CONFIG_ARCH_FOOTBRIDGE
> +/* defined in arch/arm/mach-footbridge/include/mach/irqs.h */
> +#include <mach/irqs.h>
>  #elif defined(CONFIG_PPC)
>  extern int of_i8042_kbd_irq;
>  extern int of_i8042_aux_irq;

This does not look right. Did you mean to drop inclusion of asm/irq.h
for all other arms?

Thanks.

-- 
Dmitry
