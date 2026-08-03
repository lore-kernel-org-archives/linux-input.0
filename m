Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BD3BCD04;
	Mon,  3 Aug 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778916; cv=none; b=sEIwKFkqQM805q42wHI67uEDQIzLF2UptT6gjOOOa5jqEjn/LWqF2pDTIGgD+7WceqmlLfg1jBqzMausLi99urkcXPgb7kjUP/HsRzOkZ+2n0nPVpymv1MS1bAQp4GrZPhzi7zkyQgrHeo7vplBm4M62IaudddsF6ws3qnyBs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778916; c=relaxed/simple;
	bh=86M1IqI62xk8Ez6VSmMpN4XUTJZRnuaqbwQ/VwkKGdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JBcVMlQSqBVvxcoufETx08wGjaPB8kbJOfFpAAkFEV7owkEgq0XeY8XE2eNMq/Nol9W/P60J37xoSFcY4gNT7EOxnBzQOpzomJJgLakJqOqEdopXofc8KWAZc58JHP+3JbexGhcFD6pdYz1YMn0INsG5ELPabkpOFhIsDSoE7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1m/yI+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1m/yI+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19951F000E9;
	Mon,  3 Aug 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778915;
	bh=bsF0IDlPoFWg1JJUyGnt23KJccFrBGD45OYTzpyi92Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=m1m/yI+g8JNGQYuWpbMCSpdpc00JPLhtGu6QIfjTtpzvvBPm5AS7mxXEYCpkNiCin
	 p3N5VoOAIPaoxZKF7uvz+fXoAzz10R+dmrJlFHKxNs8uY5rh0M5sdqV3umMYi78t/G
	 fLZ46NX9a+9gdi/DMsa06u2XngzvEPpRp3uA/THYxKxD3R1A11dAaqTjo83Xjv+w7/
	 0tBDWmG4Z/JN2uEQrwJdj95vH5gQUsk3w28YNAptNUnvtkQgR41G9mJKheJIkGtebN
	 9Mbr/u6VVWky9Sn3wpq9mioiKNoZbdz7wSUyeJLNckwYrqBCew9nRLtyiNMs+/sMH1
	 hmK6aLMcbd8NA==
Date: Mon, 3 Aug 2026 19:41:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+9eebf5f6544c5e873858@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: synchronize input before cleaning up a failed
 probe
In-Reply-To: <20260628005846.31248-1-alhouseenyousef@gmail.com>
Message-ID: <2oq6645n-8p56-non6-46op-379po97so0r1@xreary.bet>
References: <20260628005846.31248-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 28 Jun 2026, Yousef Alhouseen wrote:

> hid_device_io_start() allows reports to run concurrently with probe. If
> the probe subsequently fails, __hid_device_probe() releases driver
> resources and clears hdev->driver without first excluding those report
> callbacks.
> 
> For example, a report may enter hidraw_report_event() while the failure
> path frees the associated hidraw object, leading to a use-after-free when
> the report takes the object's list lock.
> 
> Stop input before performing failed-probe cleanup. This reacquires
> driver_input_lock and waits for any report callback already in progress.

Makes me wonder why we haven't seen this happening in the wild here and 
there. It doesn't seem completely unlikely.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

