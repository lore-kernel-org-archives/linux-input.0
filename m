Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D4390CA2
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342409; cv=none; b=hTYtHqPYnESMueUaDPWUU08+z0HUIu9gndVhuQwB76fXfgWqMmdTrBU3m5ApN5jwt0bUX/F6hvENEIl439OTOq8QsN6pS725VikZOKOD7hlcKL7xJzZn66t9r3AKGraOK8iDUSCtpC+FBgmfcpGAVJPM6LSKH4Hk/5SL+y3yqjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342409; c=relaxed/simple;
	bh=TqEH68mcLeZvC1yHQh2gWxzLaPd5zKzY01+sSyFj8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+RWrZY0B+g24TVs+DtxfBeNkWo4Px6UDDztZUDysQ6zi6ERL9LTxmCgmF26aL69zNGGknfJKGNWzwZE2fUUvfurDpHj//tenxTBQGKHMIJNhkZlGvugfwjc/6tgJqxBJZfp/Raf/p9BIkfkYW+o8jLAM77CCnadaPsUU3p50+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUWv0QUf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUWv0QUf"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1921399a12.0
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789342407; x=1789947207; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3VTaKaDUNFAWBbBzewXZoJZx7Zs4xkNkmRbw4yrUYA=;
        b=hUWv0QUfCjU12tUNOxUFWghmTfbg+fjdhDrSg2I+0mLPjTtQje7TtDRiaJQXGh67HJ
         Y5htzNxvk+zL6EAgO47S3JkX5tAGNq840ggAgLK/C6eDV7PUZmVoqCAChy3SIArKz9wq
         MTD6P1OVXBNhubepPkMzL4aCdDzYQ2fta/M/zkT/SjTzq4qbtjL0XwO4XitAkSZppK5y
         O6uQzD9OpvvqEH8irIqTHob5POJPQGytvFBX4eLt2jRZwcL0hxMwvu08GpXYlEHB2Vus
         yPM+kNEiTpN+EKbcx+qrtSyl9PK6akS8dqWcTx4cu9/UkBji2JNRKXIX9aPxgXFQTysj
         8geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789342407; x=1789947207;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T3VTaKaDUNFAWBbBzewXZoJZx7Zs4xkNkmRbw4yrUYA=;
        b=fDVMZJV3xRXXqRtkI2vlVYZXyzatU99hFZrjJRDbLLMTziNcPsVnD0LJQ5tw0+UDKd
         mOvHm8ahh5LuixCD7QEvvCP0IFxgPITuHnulJqGVL2f283cpRNOtVZ4ljJd9hQAbHPMn
         yoaZCjuPXOYdOQdCyH3Rac1o/00G5Vk8TOh51mFxYUsa+7abJbIdUzw+2sPe88YEso5/
         OCGR/7KKXyreRGuaQM7/ADhWgrUmTDi8hf0QLQRyZGgUZYr47hHoRG/Wtykgh53vEubL
         yIV6bkCLATu/YvdujH5kdPOE1GM7NKXZ8EngRyg03H62BSaQf7BQbFCUE1948T7VZOB1
         aUQw==
X-Gm-Message-State: AFuF++lU+8oVYjEHLGyIPj+0WGy3L6Tesf7RnVHG5n19QHdXkwwCUuNp
	B28lmPVgFtEo2SfVPgHX3UduI667zg/976IAJZWnNXrM0Z0iL9hV+abk
X-Gm-Gg: AYBFou3zookgGX5wmACIttnvi8RSD3AhbhWkgH/GI0QH/z6Gl0KNYedY3UEUwyEEQvc
	lEmFAnrCwdLZXLk9flfwz/BrExr6AIO1DAh24eZ4RH5pHE5Y+v4kPgPSXBXvrJ4rZ7fkYx2sd5N
	JsWN01tOz5GjVSWXTpNCwNGhls1UfsXUVEEjhFyBok6AJb9GLW9zYU0T5AVVAm7WwvEsCTEn2Mh
	A75G0FnX95kH3B9rBr7FFNUxOnK0iAdwFl8uISAj+FuIuoYWd6OSslmunKsgkI0qhj3QCS9WTOd
	85q3ugz+apiOShB1ItkMb6K6lq8z72eyT7bvEuCpPMhbcaE5TD3EfIcgGiiFAcarkHhPd1QeVLH
	cyjHMkvq/HTt5paL5Jzzz4YORxIUjr1Yz5NXi5UJvk9IXpj5D4OzAWQY43PO7C/rl0m5yxXl59Z
	z/XEbFEX60h30IbiJUVcxVkDYTp7dZvL9r5rH6HWZebwyCPXi+wikZjzjm0jkPHS/nakkUqkC0O
	KvgXvdhQF0rEzQvkJrpZnwIiq75g2T59FRyYKom
X-Received: by 2002:a17:90b:1805:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39dec143751mr319058a91.22.1789342407511;
        Sun, 13 Sep 2026 16:33:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm19771080c88.4.2026.09.13.16.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 16:33:26 -0700 (PDT)
Date: Sun, 13 Sep 2026 16:33:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org
Subject: Re: Double tap to wake optionality
Message-ID: <aqcxlFLHh3V5vQvt@google.com>
References: <4f9e942c-823e-4ab1-81ed-184b5f8388d6@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f9e942c-823e-4ab1-81ed-184b5f8388d6@ixit.cz>

Hi David,

On Mon, Sep 07, 2026 at 12:02:12AM +0200, David Heidelberg wrote:
> Hello!
> 
> Most of touchscreens has ability to jump into low power mode and get woken
> up by gesture (such as double tap).
> 
> I wonder about suggestion what property should drivers use to implement this
> policy where driver doesn't have to jump into low-power mode but completely
> power-off (and save battery). My thinking was something such as
> 
> /sys/class/input/inputX/gesture_to_wake
> (while gesture sounds a bit weird, it seems that TS are capable to recognize
> different patterns, not only double-tap).
> 
> 
>                     userspace
>                        │
>                        │ gesture_to_wake = 1
>                        ▼
>               touchscreen driver
>                        │
>           ┌────────────┴────────────┐
>           │                         │
>        gesture ON               gesture OFF
>           │                         │
>           ▼                         ▼
>    low-power TS mode          complete power-off
>           │
>           ▼
>      IRQ configured
>      as wake source

How is it different from the power/wakeup device attribute? Device's
suspend  routines check device_may_wakeup() and then either completely
power off controllers or configure them for wake up.

How exactly wakeup is handled - any touch, or double-tap, or something
else - is up to the controller and its firmware.

Thanks.

-- 
Dmitry
