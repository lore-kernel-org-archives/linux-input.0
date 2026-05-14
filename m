Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB6349B1F
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742412; cv=none; b=YNtGOzV0RH3NTEHa7qGOlwoD5FOCZ5R7rne9nsibY1tOaX3XZmgt0NsKMXPk+M86FQyE1eEIBfutQt8d5AP+eNx8dDEKwdYHWOrqf/e86j1jlYTIl5MBQTzDZllbv90nXWHn5nVhucDziUNi4VuLrEJ0ObdyeJf/CtX5+yX4cHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742412; c=relaxed/simple;
	bh=uLhyCl0YWMdaaBoG09SlvWmuPFnMWww+V3edtBeaOG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkOl7r1gIlmUAKh9nT3/prFeYAbNjg5gbiOMfAmt43jj74prBB3HqWldhzeP7DBckHcAmj++dmabwCJpl27BTXl/90WRn11C1CYfCNxBhL5jEeJNgRxZZnsa29jApHFppYrP9HwLXeYFwwEHbITeHERgkZclyS6jJQkFn0nWQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAj5TppD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAj5TppD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D728C2BCB7;
	Thu, 14 May 2026 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742411;
	bh=uLhyCl0YWMdaaBoG09SlvWmuPFnMWww+V3edtBeaOG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tAj5TppDjr2YnCd2SLvotYKpyhQHof47SaB+PvioqECtvb7ePBQ9VOb5g3BWvkhrv
	 VAw2aCEdxBL9TWrZtmMG1iHbFAQhHPG4LSl/HSz1h9SLpYhpACV6Bertav+4dbWSeP
	 0ypxbYiM+Fge6YfmrCYNdn7EhpklDp4qiY1O9I4c8aoAQYaee1wMUiPZzTJro7zano
	 uNOdSnQ0vD8WS3Fonrn+Bt+B+cw4+CGR7vnar81CrmAjaCCmaxKY8H22K1b6vZhqgQ
	 SIBLYm+AnN7hMQVhAuv+uLQpiLxnPr/k6LfPlokCqNuMuECSERKdh0PGn+TFauzkbx
	 O7Lnw59hMPp+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] input/evdev: move kill_fasync() outside buffer_lock to
 fix SOFTIRQ deadlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rik van Riel" <riel@surriel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260513115000.77ec5975@fangorn>
References: <20260513115000.77ec5975@fangorn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 07:06:46 +0000
Message-Id: <20260514070647.3D728C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving kill_fasync() outside of client->buffer_lock does not resol=
ve the lock ordering violation because the function is still executing unde=
r dev->event_lock.
--

commit 803cd2c3ce0ada2c1fe4625fcbef594cb58290eb
Author: Rik van Riel <riel@surriel.com>

input/evdev: move kill_fasync() outside buffer_lock to fix SOFTIRQ deadlock

This commit attempts to fix a SOFTIRQ-safe to SOFTIRQ-unsafe lock inversion
by moving the kill_fasync() call outside of the client->buffer_lock.

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
[ ... ]
> @@ -280,9 +278,11 @@ static void evdev_pass_values(struct evdev_client *c=
lient,
> =20
>  	spin_unlock(&client->buffer_lock);
> =20
> -	if (wakeup)
> +	if (wakeup) {
> +		kill_fasync(&client->fasync, SIGIO, POLL_IN);
>  		wake_up_interruptible_poll(&client->wait,
>  			EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM);
> +	}
>  }

Does this completely resolve the lock ordering violation?

While kill_fasync() is now outside of client->buffer_lock, evdev_pass_value=
s()
is called from evdev_events(), which is invoked by the input core in
input_pass_values().

During this dispatch, the input core strictly holds dev->event_lock:

drivers/input/input.c:input_pass_values() {
    ...
    rcu_read_lock();
    spin_lock_irqsave(&dev->event_lock, flags);
    ...
    handler->events(handle, vals, count);
    ...
    spin_unlock_irqrestore(&dev->event_lock, flags);
}

Since dev->event_lock is also an IRQ/SOFTIRQ-safe spinlock, does this
just shift the problem so we still have a dev->event_lock -> fa_lock
inversion?

Would it make sense to defer the kill_fasync() call entirely outside
the event lock context, perhaps by using irq_work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513115000.77ec=
5975@fangorn?part=3D1
