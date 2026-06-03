Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A73016EB;
	Wed,  3 Jun 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489186; cv=none; b=OslUQKuJhhCGfbO3CFyB4tnAuVc/BRcudxN0Kvpz6F2SAVZKOpyuKF6mTA45QmSDHpLBQ+m1v8wf+b4GFUch+TsKDOerzefWkqazb5CD0iGZACZbR/YjATWl3z2SwIfm9ApogzgVuvXOGkG3n5me3K7JfOvnf8NX2hAMKTUhMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489186; c=relaxed/simple;
	bh=9oLyxV5F7vtpnS3k7rCaW5HJSHFdo9UR9r7hMhAnRkI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dP7wLWqumyiKRjEISndQUaUOx6/mrr/h3btelVdcPwCRim9cQk/ft4ziGW57gGGo48p7ELFaS13aca8zmFdP0LSpjTeBMTv5IHhM/LBJkiHoZ56Q55vgoD8mCsmtz8iBNSztHZhuKJwVbqRiCGl55x9SlcvQCrWGVItFwpyeTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOtadUl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOtadUl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B141F00893;
	Wed,  3 Jun 2026 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780489185;
	bh=R28IGM5lhTxjfXsqvGZFUp606udp20V8bbW6zWzMRBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=TOtadUl1o45s5ZPeS+I3vaW5f4vyrRDR+tFv8WS8bsF3UWJs85LnzN55f3ZKXULX4
	 BO60IjLPUExQ8jnoDFeM9K5yF3xxExuoqMEiggx+PsGZjJX2S8o307FiPXMWOTFtaO
	 GR68gbPkXc5boog/U9HGfM7Fy9qEGTGpB4ipV4mRFvWgI9VkzfaFTWADC4suFSJtpo
	 GzljAnvEwFZnBNSq3+GCktXHPgxDCeStSMc16D4bTp9qKAwocoZlJlxDyYochA/T/z
	 wfGujitZ627xxXcE0hzBKO16zSs1CxBxQbMdnLRn5KyDOZtNYdsU/QkHrtVmUIXWMz
	 lUUFvQLBii9ig==
Date: Wed, 3 Jun 2026 14:19:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Manish Khadka <maskmemanish@gmail.com>
cc: linux-input@vger.kernel.org, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-lenovo-go: cancel cfg_setup work in
 hid_go_cfg_remove()
In-Reply-To: <20260515153607.76175-1-maskmemanish@gmail.com>
Message-ID: <6235ro32-5885-5np6-392s-646332831705@xreary.bet>
References: <20260515153607.76175-1-maskmemanish@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 May 2026, Manish Khadka wrote:

> hid_go_cfg_probe() initialises drvdata.go_cfg_setup and schedules it
> to run 2 ms later:
> 
>     INIT_DELAYED_WORK(&drvdata.go_cfg_setup, &cfg_setup);
>     schedule_delayed_work(&drvdata.go_cfg_setup, msecs_to_jiffies(2));
> 
> cfg_setup() dereferences drvdata.hdev to issue MCU command requests.
> hid_go_cfg_remove() tears down sysfs and stops the HID device, ending
> with hid_set_drvdata(hdev, NULL), but never drains the delayed work.
> If the device is unbound within the 2 ms scheduling delay (a probe
> failure rolling back via remove, or a fast rmmod after probe), the
> work fires after hid_set_drvdata(NULL) has cleared the back pointer,
> leaving cfg_setup() with a NULL or stale drvdata.hdev.
> 
> Mirror the sibling driver hid-lenovo-go-s.c, whose hid_gos_cfg_remove()
> already calls cancel_delayed_work_sync() on its analogous work, and
> drain go_cfg_setup at the top of hid_go_cfg_remove().  The cancel
> must come before guard(mutex)(&drvdata.cfg_mutex) because cfg_setup()
> acquires that mutex; reversing the order would deadlock.
> 
> Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manish Khadka <maskmemanish@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

