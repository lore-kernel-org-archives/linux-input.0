Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A4353A95
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789842577; cv=none; b=Dxyr1r6mEa/hn+p5CoQdnCwxG3GyfqkulqTytDdzoDUXHd+U3RuVEGDU9gkbRxgerPiKUGQ+TQVfbW+ax+ZcvwvQdXZg14tU7I7ONiltla/Qzf+l8BfZv3mAK/bMAr7GQ65OyWfoIob8xgZ3Z5Wk7KvhaEoFAVXaktGPUSaInyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789842577; c=relaxed/simple;
	bh=j6APRU8TZhQ7kXjX2zQsyvDPEva7Z3097pushL/oTc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7fLh70s0ffhPgGf/MSk+pLvQxjUJuRdZPk1gDabnVZanPmD0iD+1F/0B8SPX7pCrg5O/zPx4AC5cZJFqMly8nS6LvfqAH9EL+5I5Y4Eph2+ITZv81NdE1l5OzBtcrMvhgsJ1B/7pK5LR+ikvCkCmrU/OdDFVPcRJ88tSLTraVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3Booux9; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3Booux9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1388084a91.0
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789842576; x=1790447376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaWxCP+qVZT/frWKs4KNaE5bweasvyj4HpACIQQN7yM=;
        b=U3Booux9oJBYffZ0PMNdz1q3FzXnKMQNqlBaya3ZaJtCycyfPIR69O5dvAnBDgcJEu
         SYv8Gm1VaBk/Qx5RThAx3qlSHFvkif/VeDCRjIqj6v1bUptLxpHRtB2kgs6qDo5/p5XM
         fBXUi6vXNBHe9PIy2ZiF7YfstAtvCWaiBMB7ekT21+wfOszSLuYgTe5FpTutEa5+Chjv
         xbfekZWAxal9rauIS1wt6nyee321Yo7ciudn07wmQz3rLJSw2/YIpdfopV6nrZYqwIeB
         2R11DJKZJBiwUK/L4II+sFTQx523ID7zgGGLDOxDfSkYF4ExGQKX7RViPvGJwA4YVemb
         bliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789842576; x=1790447376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaWxCP+qVZT/frWKs4KNaE5bweasvyj4HpACIQQN7yM=;
        b=DfJOEOM8Wl19u9yfreeA2VaKZIZRdQ1WleHB+bZnIDulbBhsfkJUTdB34yDpkcfyIP
         URF6JMk8FbRCBRgBbFNWSIDJS78no4jgYNIKOdoau8VEy76ualYscjlmUCaFnbshD6bH
         OBJcguSINZqd/fGdMQel3RriLV0vrL0oDcFzF9G5UhMlAAflR3YxegpyqccGPlJEVEUg
         yMP3DtTn3b1LNyIJqM59bUMVxgvW9BjkLAPEeXe1OfY31Y/dTxn5kmKAAPxuy3N4NDTA
         NeA1nNVB3N8P49E7WM8eSf9jWd+A7+qNPyhV52JG6GDcpKkd+ZVqzXk96gee48/snrId
         9pJw==
X-Gm-Message-State: AFuF++lotUnHIynxv/+B0BybegGXVt0R8+MdlpLaQdfKmlSQrmXT7otb
	kmSx257DMTDzb/GsCkWhtWqnyNlyUFcjVinXiLDwqO/+iqG0+Gs0qnLjanfEJg==
X-Gm-Gg: AYBFou2zd0ReZi6fKdZiHgs4yMW6/bnCwOkPlLPUKJGDNaDsk8HHuLqraHiMlPUizQS
	Ud6TNA3wUkmhwY7pv6Les+vgnTGc/dahvrSoljiYxYfrgM1l1Kyzng4xJum3HsfyEFuKY2atgyq
	IiUjP8iNCLH4rgCvKOc8Waxvy3YICn2iO9k66weBuYT6xEssLaocBAk8PP4UA13AOWW2kxF9dhp
	WX2ZfV+JJgzAlrTKnSW8sKwV1cieczCXUlGnd9KDUfgjFy8E87wN5lnRSnYVCYAIv1sR0z2m4rP
	s7EDZe0sS+JJFaocW1SEWg2bc5dfK5Za7dIZe1g44JdXlIowv6JmwSZFi4+FT6eLW/s5idBrcHc
	ev7SW7g/kVZSbmLi/U6RlgW+5WNW86XX+yMDf027Lu4+fCZ8UlM1esIVoYrQjuWHRfS4H2z2Pbx
	fqdalxkIA0pnT20h4ta0YQZQCmTprmVR86PoqtGewD+qslakYwdNbVvtVcYkFN7iZ+Ec2bZxn0o
	CQ30yZ7YqUhQECUvzmCLokaMFJSEqT3BtLa8FIJQ+NLMYfS3g==
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr40771395ad.64.1789842575482;
        Sat, 19 Sep 2026 11:29:35 -0700 (PDT)
Received: from eggarch ([2409:40c4:1019:17ac:cb7e:823e:6cc7:69fc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc178889dsm11834085ad.18.2026.09.19.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 11:29:33 -0700 (PDT)
Date: Sat, 19 Sep 2026 23:59:29 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: heiko.brey@gmx.de
Cc: linux-input@vger.kernel.org
Subject: Re: i8042: Fujitsu LIFEBOOK U7410 needs i8042.nomux (keyboard and
 touchpad dead)
Message-ID: <aq7SdGsoL82CFBZp@eggarch>
References: <89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de>

Hi thanks for the report,

On Sat, Sep 19, 2026 at 11:52:19AM +0200, Heiko Brey wrote:
> What I tried:
>   - i8042.nopnp i8042.reset: no change
>   - i8042.nomux=1 i8042.reset: keyboard and touchpad work, on warm and
>     cold boot. The multiplexing message and the Spurious ACK messages
>     no longer appear.
>   (I have not tested i8042.nomux=1 without i8042.reset.)
> 
> Could a DMI quirk with nomux be added for this model?
Yes, but could you first see whether including the reset parameter is
needed? Or it works just with nomux=1 so we won't include unneeded
quirks in the patch.

Thanks,
Lovekesh
