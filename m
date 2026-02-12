Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4521E5714
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918069; cv=none; b=o/ouWTsFb1GP+snWvm6CPzpOpJuzrnBpTRCJa5QdC3FbsETKtounDG8ITcJpb4ZE8BGS+m4ZPHlAN8la7Mq1yHt8+vKOnEtH6+xPqOrZJcqUFvPagrp1lnI8Fp8QR6Ksf2UD3ULrx45GA7Vhr6q/taViC19lMrpYl9fdTg5hf2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918069; c=relaxed/simple;
	bh=7452iyhUpe3ECbuz6zVis5eRJKHGAR3D+5quV8Yo03M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhCxMnMBWVXS0kDH+pHMyayr6rph5EMit4J+Bj/45yvEk8tjd9Pz0bOOfAsBUz1NNruJs0T6QNw+h0NQz5Wr0KLWpYw8LhFdXQwOdvs4Gjx2o2q0GYnIkzqhLFRZCvEcTQq+m3wUig5zExQmKoqVBvX3jbJaYJXVTsSU2suHbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh/8UNo5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh/8UNo5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2baab3137bcso79965eec.0
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770918067; x=1771522867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuLmEuoZ3x+9Cso6c2rmJeoqiHjeMzzLvBiFmbwdbJ0=;
        b=Xh/8UNo5W6B4Cp8d2zY2FeDbpB0LHFS8vVDqQzgzrWZVutCrybnDjhznvQv5wDHTOz
         zvC81YsZScqzmGmPtRqu+knNKEKYwYM9Jd9fDHsLpePJ7/3FhFI52eQEThS7JN4p0Pyv
         0+1xKKQHzOX/RnW9t/GSQy8nY+LiM3ArZuYEUdHclUMt+tBvZIYzQUKvbbZ/6T3dccae
         S1wbiNS/W41E8idQ0xhUwKNdwbkpgIKAclINOtOwbCi7Dyl4syR5KtR9S25QR4eU+lXY
         ox73aTidxk4ugXTeceyfcjLKDm8giV/LfpdhjFsLaoUvE6M3DOtwRlgol2f0CV0GPbOW
         UDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918067; x=1771522867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuLmEuoZ3x+9Cso6c2rmJeoqiHjeMzzLvBiFmbwdbJ0=;
        b=tJt/+UwRy4RcEiAUKzFPGqIAWZNdRCbOk1YEFWxegbs3VAx0GZe+vedRhGtyeuLJfi
         1lsyz7YWo7is4Au2bzayI7Ee8YQFsvhZro5xeeAaSeitJ2nzS/1RH7oJnR1CsILGl258
         aEKJXnLNTtcVdeSgc8fnV34pHdqfEo+fv9VB3D2XKBL0cxpOU8jXWaJCwYO9iygN8BhL
         gWX+DeDsjvxsmIyYpd+JwF92WNCee1d2B7qAMaDJdCLaLQJnT2evUwY0p5c+ARP/0XSS
         /jKYI9ATBy+gFaZBvvs8+JONggXNvNKtkNQJNmE4d2Gm2a2t5Phdv6l9BqRtjKL06Tfz
         DlfA==
X-Gm-Message-State: AOJu0YyTrBJzTeHQieqyD1JFNjTW2K3UhfwVcLt2R8pBMXu2JIHRVdBf
	zhKJrQlPCujRhXwkfVmdYxJHoJ54TbZ899njpfbou3mW/d4S/mKSVAMt
X-Gm-Gg: AZuq6aJVU1+j1j5bvUVI9xXz97TzdZBZLnxJ7XNEBcqoXwUBVDnbaJo61IU/VyEWu8B
	dtZP7x/+h/8puQGln9dm2GcBDpYLYhxVL7I/RfNcdz2J8SDtO50wZZgUNmUqKtDqR6V/iQC27wU
	PZQp7BEFVv++/fe5nFSKxiJFtzRN9US40GMos1G9nLGAnBkJhEKf1ofSCNMvbj73wfqKXglx5GG
	7BaPR5+athtfoBviv3nDGYlqk+jAJLEI6ij7K/sekCHihFuwq5BbilZWM/5EG52v7JjxzURlHWx
	kqI14ZstUULlU2XEeVbJ+dVEAvxmQnw/r5Vc7pwBM7Ni0JgWwKf7iFwx3y43h1LNq1LzBQDATK3
	UkaxUjhGJ6t0zMQkKCn/270myQVufQK/aoYPFwM1QUH8oIHgNQzmSNdA5kxkgFJUAk0qix+l5NQ
	0vKQNL8px1vrrw2TrFHqGXAfCf/tOSDKI0rB2dJIxJ7gDCzJGYWoIW70b2RZOsyaT2tIbLucyOJ
	oE=
X-Received: by 2002:a05:693c:3011:b0:2b7:8b4a:15b7 with SMTP id 5a478bee46e88-2baa7fdb519mr1464149eec.16.1770918067406;
        Thu, 12 Feb 2026 09:41:07 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:7027:6cb0:48e2:2882])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbd6524sm3838484eec.12.2026.02.12.09.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 09:41:06 -0800 (PST)
Date: Thu, 12 Feb 2026 09:41:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 5/5] input: drv260x: Don't try to disable dummy regulator
Message-ID: <aY4QBqz4tadR2-Yt@google.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-6-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211235902.4156624-6-jekhor@gmail.com>

On Thu, Feb 12, 2026 at 01:46:55AM +0200, Yauhen Kharuzhy wrote:
> Don't use a dummy regulator for 'vbat' because it cannot be disabled
> during suspending.

Why? Dummy regulator is supposed to be a placeholder that allows all the
regular operations (enable/disable/etc) without having actually supply
attached. Optional regulators are supposed to only be users when there
are parts of a chip that are powered separately and may be not in use in
a given design.

This change is counter to the regulator framework.

Thanks.

-- 
Dmitry
