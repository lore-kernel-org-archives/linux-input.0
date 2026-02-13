Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302722F7445
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771019769; cv=none; b=nxnQkos4PDU6YCMKgDeCaAkE4hLJ+6k5J99AQCJUIpODu65SSE0wxQDEaH7ejw8eqEyMIti+WOLB3EHC7wEB/NK7Eurbi8XIZqkQV0bRD3MUi4BmmdMJustCF2epiGaNHKii0l1XtEmjL6ELgvbPgIgiqJ6ifltK8xCXjthkRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771019769; c=relaxed/simple;
	bh=DJUmRY6UaUAKMRryACmrME8HT7tDV2ve9KqOSNybNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cknyw9Re20Z9oZz9zdki3np7tJSCbo/bPF1fhNMDMLZYD6iw9TZVdR5L89Mo0+Wcvvn867NRDsXqqgcrj7ZGA3W/ckpjE7xnx3SQzVP44fNLa9tY8rg0/Qmjig/aK9pAwWTSWEzK3qZvuA/o/6h+WEjAGtmAaIGtA90qASMyJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzAvH1Iz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzAvH1Iz"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f992167dcso174054166b.1
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771019767; x=1771624567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0m1F4N0XyKhDSLVlEGb4S3SVhil4Yg6EcQ4g+T10tUA=;
        b=KzAvH1Iz1VAViINIOgxzT3NIIwOuoWzs2ubkNcVlBerHbTNls0eGp6F/twp1pgC/69
         y4GjSyxKeqC9p8Wbv22g7gMLEmn/8CFv3ZVYN1dQ3rGja3TDjeRv9t69r5P1NtfzyPyz
         ETTIk2cQdlvycn//uzSk1QYPFlpcap1t5WCsAjeu5XCHLFTDNZngqFnCBPqvP2SjmA82
         o9wmRQgVnxdGzYHuZxoBEq1uj1agRyxHshaPmH69QPqV/s0lAoL147QMjNLPrhVhxDUc
         dZWXwg2JS2yiCzDENIrNH8A7nV+8pQKh4BFKx2YDH9j742/AVwgOl0gbQWo3NNfmPURe
         SrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771019767; x=1771624567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0m1F4N0XyKhDSLVlEGb4S3SVhil4Yg6EcQ4g+T10tUA=;
        b=FbMiBxyuc7dURTB2gRJxu0tRaFrJYNci0RasZ1QfxAa/BUIWIrmtEDGja93atYXT7f
         /gu5pg3aZ5H7lrIiN0Jn98In7UflVhEn8UduMoq8MYmj1Xf2WeS0V+zOkskhlFVgLArj
         sS8ivJEXDognJafgBbqwNmBo24f12XeIJiPdAXYlFstDbKz9+MHTe/nQtiagtLGYiow3
         +WPIw3HO8NxFZtU+hFP66jQYoIPPSrB2+EzwnLMJ91bowjojA0DdQ0WWqLOCsq692cz2
         gfLE+qbrEH+UlNAO/ebYHbjFeWIRUtMKYjAUqcdpIQttMgGpc54A6QVt1UL5/DG2GWjG
         +T4Q==
X-Gm-Message-State: AOJu0YxqENR8W23rb790eGfHh30seoUruWvGQdi4A54sIalSJrogT5zS
	fXedd6bDmTQY04TYwUZj396Qk10zlH3zK4rAgRh1MA7DUkkIA62tgnXkwnmFpw==
X-Gm-Gg: AZuq6aLSB7PV3IRupXrfm/AAkE26ajdijZyKxX7obTAUibfmk4xYILgC6v+MdVwuQau
	EkJHDS5LWBlkL0K1CFb/gboTs24Q7QesS/7S+ZF9Tl4LDOCupxudK0GunEW8wlkESPvRJlr/VTy
	3rmIkef2smgw54UqcM5aNTYVvaaZ30ddQBrZp3rALFvME1uGHf38fMQfRDyohVFBkbjoNtOIHGx
	ruuhuB1xbpUSOiQiwGib5/Pvg1lv8oiT+ZnW+1Wgkr22iSmAyAEkBE9VvAng3gkEJVv9GIKAMoX
	ypU9Ze/OHqiK8xEHa5IMXtMlpdXwfoIQEF/EGs3lLw2S9ma4PzxHmpGjPBmj8wQgOisWbXCKxQu
	y2ad82rPzNsOOm+0TlU1ZMqyyHGdgLp+XVXU0XQEbl/2+/twMCWCXqoisoSbV6qN+eAWsx/wLJ+
	l1hX+OHvC6gCdN+w==
X-Received: by 2002:a17:906:c104:b0:b8f:7014:48fb with SMTP id a640c23a62f3a-b8fb41ddfdamr182338766b.16.1771019766325;
        Fri, 13 Feb 2026 13:56:06 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e3538sm1128221a12.20.2026.02.13.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 13:56:05 -0800 (PST)
Date: Fri, 13 Feb 2026 23:56:05 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 5/5] input: drv260x: Don't try to disable dummy regulator
Message-ID: <aY-SwIyOo3pJVmUP@jekhomev>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-6-jekhor@gmail.com>
 <aY4QBqz4tadR2-Yt@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4QBqz4tadR2-Yt@google.com>

On Thu, Feb 12, 2026 at 09:41:04AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 12, 2026 at 01:46:55AM +0200, Yauhen Kharuzhy wrote:
> > Don't use a dummy regulator for 'vbat' because it cannot be disabled
> > during suspending.
> 
> Why? Dummy regulator is supposed to be a placeholder that allows all the
> regular operations (enable/disable/etc) without having actually supply
> attached. Optional regulators are supposed to only be users when there
> are parts of a chip that are powered separately and may be not in use in
> a given design.

Hmm, I definitely had an issue with this. Will re-check.

Thanks for the review.

> 
> This change is counter to the regulator framework.
> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Yauhen Kharuzhy
