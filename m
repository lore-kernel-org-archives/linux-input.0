Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A113939A3;
	Mon, 28 Sep 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598507; cv=none; b=GWoh4C9w6fQN39afHHqZavw0Y4FKf/om40koYWflk5aRdIAMWq1JBtJm2iAgArpjUzET0cw12yJRzzc/qDGhelzk43L1Y7dEvQ5psg0y/yF6BXcPRkB9/xrfvzpj55dZNU3Vrqap4xg4cuWmkKLRavfeNy13lfuA55++XmU3y14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598507; c=relaxed/simple;
	bh=Bpt9ejFb9l5C95K23KjXoWD6tLf+hNyz0Yw0ctXz9i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUX/M6hVDd+g6VKxmqWgoE5VWh3LTcllbtsiLlSISSU4WP6IrH+Mr+txddOpSARsmdsJQPonHFvHsJDVaTWXd9aPae/lBhHMCOOj6RY787NCZORi2BWZ4axHSMgLOV9FU9qSQ2l59lpLzPs92QPJyOxfVQ3octoKqe2ycgKv5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKCL0Fgr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aYf5crcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKCL0Fgr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aYf5crcx"
Date: Mon, 28 Sep 2026 14:28:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790598504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bpt9ejFb9l5C95K23KjXoWD6tLf+hNyz0Yw0ctXz9i4=;
	b=lKCL0FgrvYpq+uG1997m+I4lbvNpqnj9VBQCN/bPFlcKc33hpeakcM0SHHP7miqsqJwdHC
	xi3Qw3nKOiQO/OUGfViyILHhkbOYtx1ir/dMOBQG8fVhlb+khhTgpRyg5+Nh1iu34ewIy1
	yNUMWOJJH5stQJpiYBkmLrOnr0yz4zYxJnd6zvv8fRI4iPCf4omy7KgWOgE6pvph7dRlx5
	/ipaZk8e5FgJxGA9Z76ctaYSk56U/2xPbeeCV7Ovl1fvOHUtdpRR6Cx1+Kpjt1juGIBlG/
	2Su6FF7mkG4zGQp4TsQcNE4CmKGt3aeR2/VdygRjYPgOqJ5AKxnEhC+68r8Kkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790598504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bpt9ejFb9l5C95K23KjXoWD6tLf+hNyz0Yw0ctXz9i4=;
	b=aYf5crcxVaRFVweazfbc02JeGOHAofY1QjcqDcPG9pEovE3J35p1TJFiAJJjivu82fiQ0x
	KEt+7x7xUg3ATgDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aveline Noir <jm5905938@gmail.com>
Cc: Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+912222e4cb82423535fa@syzkaller.appspotmail.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] HID: picolcd: Move output requests out of spinlocked
 sections
Message-ID: <20260928122822.JdtAHH3g@linutronix.de>
References: <CANOyQmEg5abcMc-Xk6=2hQQWu9vq9wevGR3spe352QLyxsZNEw@mail.gmail.com>
 <CANOyQmGkGwSkwUj-NOKzhQ_mgapoqqoOLaqXaGAjWK8jiknarQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANOyQmGkGwSkwUj-NOKzhQ_mgapoqqoOLaqXaGAjWK8jiknarQ@mail.gmail.com>

On 2026-09-28 13:46:53 [+0200], Aveline Noir wrote:
> Creating a PicoLCD through UHID triggers a sleeping-in-invalid-context
> warning in picolcd_set_contrast() on PREEMPT_RT. hid_hw_request() can

This is not limited to PREEMPT_RT.

> allocate with GFP_KERNEL and wait for a reply through __hid_request(),
> but the driver invokes it while holding data->lock. The same pattern

picolcd_data::lock. The important part is that the lock is a spinlock_t.
Non-PREEMPT_RT builds should complain here, too.

Sebastian
