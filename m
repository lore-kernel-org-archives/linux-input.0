Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A737107E
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492661; cv=none; b=jp7CtN+NsjcFzJ37e+C1OrEqap8c6sEeyy3zo8CEpPsiR+RuG9v+57/zGTGHXczmmSY9igGaYjQ9o+SMHYxDZeUfuerOWMGiHll0Qo2wgfru+JCkAebPS1fAQ58EgQYxDRlFfaUPEJR8mmcha6FXaElFt+5OmjEsCUBnfZkPSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492661; c=relaxed/simple;
	bh=Y5fhTMCl7E2+LPYpvz3TpNSzrRnpdNGy8F0HtXYutLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAvlTxYCbx3S+A1PAq1hJyyqFcqwxUu+B11swRc5a51JgIW0llN05xSZj6YADtBV+KdScVLjaO1TN+EIwu1Tg5i+1exyq9R8vCq5V72QAbKcLl4Sbn2RBpc4FMrj1VDdji/Q+Q9IGKOsp1y25bxMfHTI3CXxUr597EggH+1hJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoWtd0QD; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoWtd0QD"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128b9b7e3edso1280525c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775492659; x=1776097459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSMkbujMEGIYJ2Ufgro/D38iZGemsMDU57Ub0aBphEc=;
        b=XoWtd0QD7lfitcvLt1/gGW7BKvlUbCdTM0/xCRO4161GyrJUqROdSU9QFwrVlCTgU4
         FkTzdQ9lfNg4ziRbSYd5ba56tQCIlsObIxWiRlEk3MToXdy9WLZIoY4qR8vbIAOk4kcV
         JUtel7H0teaQvVnD4wXA5qPYto92MMUJdKvrNEppsLvVmz1hQ/pbs38bKxovXs+pjoxE
         RZaHS0UTcJhCOwueItynQnK60doDNh1uT8q8IdVzPfi5FrZORSMFRZX+4cgvk5IgiKQu
         fJQVba+TY+ucnbvJZF+Ial/ZfZQ/9pMLNmUbXaR72isUWMh/Mu98wLjbZVESSl5QK6fp
         Tocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775492659; x=1776097459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSMkbujMEGIYJ2Ufgro/D38iZGemsMDU57Ub0aBphEc=;
        b=eN+EDN4HyzLtvFb5IhJrt1y+Al8f85GycNpnGCmtU3zm+Uk4bG6gGm7nodKhRrjbpJ
         D9JzkIu+jDESo7j6KnhbK9y4K+yCWS23f+TLkYmf90CLoMziQPg3qakeaqT0yMiU+Jwp
         FQd2T+6Sn+1nXXWSDpScwQYxLmb1jWXgd4QikFR3ELXBWnANGUo04nC6ev9o5GgmGvdh
         lwBYP/oaAuyVna+YNzsnNwjFcBSES8xCq1zIXecX+Zxbl3HwdQs85uXHJIMcX7rTtsAe
         xHQI3WEJY0Fue4w6ZtEq0kDHJDlMyGX3B4z4Mn+QnlnhQnPuQlWTlFArDTxIr945VjkU
         Iv5A==
X-Gm-Message-State: AOJu0Yx3ZJMC2BvxHT0J54l1ewnqpd4LP4pvCA6ADLAAwM2zk6uZc96G
	LnS+qN6jKsD9Mrza/Ca0VUDYE2YmbZX637MixS5zWFICNkj/+B12UpGk
X-Gm-Gg: AeBDieuX4cMUpz9iIrGKxzRaRz+tXum3RReC5z1yFMgmhdL/tK2jGRIorCuyU/0zNz1
	NtzgImCPIhlWl57XmpkaRroT8wO/uHbC6/ymJtev2Y6YhTvnjmCUJGSB2fwwIC5geXUP4kCWP2t
	5eO+0dAs+4sI7K+vyF63/qsPVGiZUYiLOD0PabZAbEn+894fyGNbCwUBBzbOQi6VQdGS6eGnGz1
	Li3YmqLrZsMq964xASPIbrPi4RJiJP98qAnnVzAbksWqqESBF4BX5rb2+Tca6d6sozi61jo9d+B
	6femlJmcb1a3mAtfIJ8POwgI7ihAh9C8R4ZpAGveSVl1LLUPoQXW9sxFsnxnBvAb7DFUXGd8vNw
	YEYfgXmajyg0GjvOxKLyLrr7jeWRiOFEUjv2AqcmzGBFBMMpkCwnI1TCoIG9aKDDUaYfXdrnzcc
	oai36X3WaNtc3FSdMawlNUvw4Ho7G0eMs6nx5e3XSzbZTe3+mvr9iI2jubiTNa93KE
X-Received: by 2002:a05:7022:41a3:b0:12b:f881:d8fb with SMTP id a92af1059eb24-12bfb6ec86fmr6997876c88.3.1775492659220;
        Mon, 06 Apr 2026 09:24:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm16348439c88.0.2026.04.06.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:24:18 -0700 (PDT)
Date: Mon, 6 Apr 2026 09:24:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Armando De Leon <auribe84@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Armando De Leon <learmand@amazon.com>
Subject: Re: [PATCH] Input: gpio-keys - add hibernation support
Message-ID: <adPdc2Z1SYxvqDmP@google.com>
References: <20260406160437.3084755-1-learmand@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406160437.3084755-1-learmand@amazon.com>

Hi Armando,

On Mon, Apr 06, 2026 at 09:04:37AM -0700, Armando De Leon wrote:
> The gpio-keys driver uses DEFINE_SIMPLE_DEV_PM_OPS which maps .freeze
> and .restore to the same callbacks as .suspend and .resume. This is
> insufficient for hibernation (suspend-to-disk) because the SoC is fully
> powered off, unlike suspend-to-RAM where hardware state is preserved.
> 
> After hibernation resume, GPIO keys fail to function correctly because
> the interrupt controller (e.g. GIC) is fully re-initialized during
> restore, resetting all IRQ trigger type configurations to defaults.
> GPIO keys require IRQ_TYPE_EDGE_BOTH for proper press/release detection,
> but after the interrupt controller re-initialization only a single edge
> remains active. This causes buttons to report only release events but
> not press events, or vice versa.

I believe you just described a bug in the interrupt controller handling
of hibernation. It needs to be fixed there, not in consumer driver.

Thanks.

-- 
Dmitry
