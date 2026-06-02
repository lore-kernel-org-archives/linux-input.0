Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163D3033C0
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443166; cv=none; b=e6aCIRyjUqY3zom15LlLc3tcb+RwMn6MpzfbG7ZslMdcYNmS8jRLY/xs0vKnv8nMsvP5L6dXlzxsByI2bRp9zO6jF68LDvuzvHGnA9EWWrEISE9DRc4f1KQLixJEma6kXsH2akhVfG2EJh6McdvnPv1VDtK509W9BIkxITbFpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443166; c=relaxed/simple;
	bh=S23384rCKT/Jgpy+Gaf4Uo6Ye3sIdEXrRPt9/DPwx3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzDDhc8ErhFkXKm6W3jUjtdJwqS/9/JuhZZKOj5lmAMgLjBpaoDtu0XbEZhYKamtCWaRACs/qbn6LlUuGvpfoedl9knIS4XIVrasGrKSMDvl+XMxkZxxrQYJy+ZP4qbFdUwS1WOA6cOShrV7L1racnOfCiGzmZblwyrMyW0inEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu4JaTt+; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu4JaTt+"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30749947917so1805425eec.1
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780443164; x=1781047964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0fkUuSK7eBrvX2jOiksSptpjklRegQ2WIUw4VVxCM8=;
        b=Yu4JaTt+SGTl6JUXco48ZRd7UHUG7ckIMoz6OYmSvbh7WzLZXfkCWv2PixM2XjiSus
         DyXXi6ZDYXPGSDK8I98fR/Y4pfYCIh5M/gLGZAhZ5pXoLjSZ1sB6Uvb67K0y4qhjyD2W
         r4CuxC1hQOsRG5RBpZI1hLW6TjtIErNqlUVWUt63EYfQBZ8CoFmlt42EUJQEBGFGxwzo
         2Tu8fXS+mCtsGibN7FoKNqsRoRuaGRRYYugNWuEpvyvODsk70ezxewU7NArm6YUKNRxt
         0DkTrg8vPLapLjn50A3nmTSTwB1HFM8mfKMqLFw428aa8GXJbbhl0ydtKHsCWG834XYO
         uNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780443164; x=1781047964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0fkUuSK7eBrvX2jOiksSptpjklRegQ2WIUw4VVxCM8=;
        b=RxTNbaRYwDBuqkogvhRVY35pDRLujrCEtUpZpbaTt3JxrN6SEF2mFXuFWN/u8eiVEs
         xZmhA26M7cPaT0ALspTQFA+M8BV9y4XZpTs1/AjGNRY39bstaafqH8XFi1Shs1ancb1W
         Pkqe/KtFoV4ym50Y7avRcH2XYNY0FHusprW88lqqhVijP6xc88yz+KNruRyr7AS0bTFk
         cnNBLWxKC4ftQ22sIyPnXAnFUoRE5Mo6kX3l8YPSqDNFuXpxqJhilHH4tufmsSCk7xMD
         i8nFnWWqYJsY2pddZ6JDfPOkkuFk8ofUYcZKv+18xWRBnD27ZXPS7vx+JhidnUzrQQrC
         s+kA==
X-Gm-Message-State: AOJu0Yx+NCvz2CN1n8tWvjMQz8+rHQ65XNQNKKcjoHM34hQJlBt+KXS/
	oAi+WRDQBCkzb125zsM4leTs269HI81rddGiCAKu5SVRPxjO8IUCtSJi
X-Gm-Gg: Acq92OG5ydX90B4q3GATSrwFyIqCx5pv+H4x+midjIlC7GB3R4KAgduKzApIFvjmdVF
	/SqLts9TP6VmjsU44UVtLQ+eHeaPJCmvV2NwMtIEZqe4vQ9qM0PN+5nkhg/6CPFQ0BGsp8s55rU
	go5LS7iwzvpDt16g49QcUKICOXzYxkO4tEgQhipi8HmWWxIdiwOcf70ua+IpEWfyRxOe04ZwN7E
	DSCnayJsF5JKQgTiq54OO9jLk7WE4AS4pONvV7b1iJ1WAi0P/5rZ+i//+y7KIrukUCIPEKP+NNT
	f9auHjN4j81j/5B6DqG1W5m6ylevdtPoIxmdjkaqQ7BfnxGJwkLNo5F9jHu3xNpiH6mu1Fhe6Yw
	+Ff2Uy1louu/u4vgd2J2vK7M9ZEs/B/VEDzlRV6cV0Aa35cDq9Gul3XlNz/ELHVZzJ6+epKnKk9
	FK4M2krXAjl5yNaPl0Khl2tr09erCClmclm4uNPn6ru6oxAa50NzQaE/8Jxv3ZE/rhZeW4Uow+p
	H0=
X-Received: by 2002:a05:693c:3746:b0:307:140f:d511 with SMTP id 5a478bee46e88-3074fc930f8mr394349eec.33.1780443163891;
        Tue, 02 Jun 2026 16:32:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df64eb9sm666037eec.25.2026.06.02.16.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:32:43 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:32:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zeyu WANG <zeyu.thomas.wang@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - add DMI quirk for Lenovo Yoga Air 14
 (83QK)
Message-ID: <ah9oAiBAHiDqPYUQ@google.com>
References: <20260602170909.14725-1-zeyu.thomas.wang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602170909.14725-1-zeyu.thomas.wang@gmail.com>

On Wed, Jun 03, 2026 at 01:09:09AM +0800, Zeyu WANG wrote:
> The Lenovo Yoga Air 14 (83QK) laptop keyboard becomes unresponsive
> after the standard atkbd init sequence. Controlled testing on the
> actual hardware shows the F5 (ATKBD_CMD_RESET_DIS / deactivate)
> command specifically corrupts the EC state, causing zero IRQ1
> interrupts after init.
> 
> Skipping only the deactivate command (while keeping F4 ENABLE)
> resolves the issue completely: both keystroke input and CapsLock
> LED toggle work correctly. The reverse test - skipping only F4
> while keeping F5 - makes the problem worse (zero keystroke
> interrupts), confirming F5 is the sole culprit.
> 
> Add a DMI quirk entry for LENOVO/83QK using the existing
> atkbd_deactivate_fixup callback, consistent with the existing
> entries for LG Electronics and HONOR FMB-P that address the
> same EC F5 deactivate issue.
> 
> Signed-off-by: Zeyu WANG <zeyu.thomas.wang@gmail.com>

Applied, thank you.

-- 
Dmitry
