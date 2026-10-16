Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154F4749F6;
	Fri, 16 Oct 2026 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145136; cv=none; b=lvaAOH++jXOKYFILg4RKkfgY8Lvj6UUdm+ZmkN2VTV1i0JgOuxz+eJo9rxL+o4zv17CYZvSR7n6pVolLCxJV982rjGxafHowcKW7+8D0RbS1BW8UC06OM10LGnC3PHMx98xEmJdUdaa/msvxZ1xTwZ+LzE9vCAvEPheQUerKnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145136; c=relaxed/simple;
	bh=VStLBXoLiprR96gLKmkBFgTdjoL1rR+flTuzQn5YcFk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E2VvBc56EagYCO5470eb20dcfa4eOtU1faIcRbl/V/fJlPOzS6txejNvdyUSF6+/611b4ryNJc3QcjflKqLuhgFDJjqFMufo4G8Liuek+MT1s9esv89fWudiFi7DtopgqgdlZg3vEvOD/0OEf1kQQXINzM3wfh1otcInvlWMlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC7rT/Gz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC7rT/Gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402C91F000C7;
	Fri, 16 Oct 2026 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145134;
	bh=i8QgdyUqOeFuTCE9I0cmKNBAb5hfQF5hhzAZTnA3pME=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=IC7rT/GzQee2ne6ySN+V7kEk7rMLbM76IiSmmOcjIYT9fSMEyc6kCKSEJQykg6IaH
	 yAGZP63PZ9Djnf7ME2i3bw926Njr+7yyMUq7BIV1xSCHDs2h3EGapa87YAdNc2OWUZ
	 yU61GJlu79mR/YV/w+xoGEj8imobiHe8dKw3Dzob8ZGFnhlkbvV3NS0xLk86lrxDp5
	 QM44facLS4JchDe7TVpZYH3h0rsQhp7nINZUwP0CW4iPt5RxchBE7K+KFTDjnuXj8P
	 rUJ3X/I8n5NhJx6KAOIMAznitQlkaoYNbYXVx8C6Tt2NRQf0Em4Bbyhzn6UHTxu315
	 TIX/Mp4PbWPjQ==
Date: Fri, 16 Oct 2026 12:05:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: wacom: fix wacom_intuos_irq NULL pen_input deref
In-Reply-To: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br>
Message-ID: <p183n608-3rrs-2o9s-2429-p8p58nqp46p7@xreary.bet>
References: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Sep 2026, Matheus Alves de Almeida wrote:

> Currently, wacom_intuos_irq() passes the parent of wacom_wac's
> pen_input to the dev_dbg() in the unknown report path. However,
> pen_input can be NULL on interfaces without a pen, causing a
> NULL pointer dereference.
> 
> Get the HID device from the enclosing struct wacom and use hid_dbg()
> instead.
> 
> Fixes: eb71d1bb270e ("Input: wacom - use dev_xxx() instead of naked printk()s and dbg()s")
> Reported-by: syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b5a7cd83622c747977de
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

