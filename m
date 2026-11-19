Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119832;
	b=DBkGR9zdDCee8mAj5hJqpjNG2/+rLxK/0GOn0UPiAtRDdgTWis7SwBgOB5se6ORu0eHU
	 hQkmMqcq8iYkMjo3Z8Y+xZ38p/bpqyLJgZgHTPDHPLFKbgFAmzW/hlHBUR9EDWKazh/eI
	 N78UcQS/ZJqWaDICKRNqfl/aNYxKCYcw7cPuKz6B5eKl4rGPNm/wKMHfM5MSmqdURkj1p
	 7JEPyWHeRZuLHH0EZWh6UPJ+89Dw8rKPYv2IoX1Cgbo/k1HjN93aeD8WgIKMlBbC63d91
	 GfhrldDPNCSg95pnORYFYA+eImGI1SsELi/eQJm5US5nSSshvPI3amkym2+xrReWsdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119832;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=vGDRzLVq0eKmcPE9ysSV0ph00QX3RbVm824OX26OMao=;
	b=mRsEYdM+pUM2WRdSiYh98bIQY3sy5xoT9suRuaZPuqtkmHRn8jbpRv52qmvwdwI7tpYp
	 GuKxZX1838udd2ufFCxIfH+fuhQFn1zZqKC1XDEOgvD83Y1NQFv3GEzxISGsUkuymUJfq
	 Xmj6QbtOVIhMmoPyrZi6lBisb0MjUoN9cl9YDMN1dwmUBaWKrxVoUpPEdCG4xvd7hq24E
	 rXzlVnS9BQ/NDhJvGArI0zJ9Gs/J1Z2/j64w81pkSoKwHZIfawAK7q+sO5kH7jFClYp28
	 x2EcjQPKOd3V2icnxUmsghUaYKiLAWj57CcudBfDrGLKIGtZtsL0ivT9EPPxB4tEMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3LZlqA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B8606A324;
	Thu, 19 Nov 2026 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3LZlqA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B561F000CA;
	Thu, 19 Nov 2026 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119831;
	bh=vGDRzLVq0eKmcPE9ysSV0ph00QX3RbVm824OX26OMao=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=V3LZlqA1FPxUYDzYY5rGF5hcSBHIA9t32DLNxKR2hUpPeuQTt+BM7V44JDnvy7Wuc
	 OcVih4Cwg6+ZrGOUiN7NkAawVF6F5mywrEzC2TWYa7oW2IbXeW7lQRD1yl2cu94olg
	 b4SdwnXyXQi4Pz6bLFonYsx4vymkki/Bet7MtY8NLE1wTspGGbV0fnRiiLXVotKLGF
	 yC2SzD35fJnoGXMusfI9+h3dMrTs9X3cMWw1qC25IBD/sWdGQMoNH1Axr4+pNwFVAe
	 u6aoDxsRelkcFQeoeo1ZhWQBpo+aLJ1VcC7E6YmJFQqc9+s4cfHXAfoV08bxgL/EiO
	 1ZQpa0qVqrn3Q==
Date: Thu, 19 Nov 2026 21:23:49 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Danish Khateeb <danishkhateeb03@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Chen Changcheng <chenchangcheng@kylinos.cn>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: corsair: use disable_work_sync() to tear down
 the LED workers
In-Reply-To: <20260904161531.160118-1-danishkhateeb03@gmail.com>
Message-ID: <831577pn-07sr-pp17-o79o-405279pr3qn0@xreary.bet>
References: <20260904143610.119808-1-danishkhateeb03@gmail.com> <20260904161531.160118-1-danishkhateeb03@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Sep 2026, Danish Khateeb wrote:

> Tearing down the K90 LEDs races with their brightness workers in two
> different ways, and swapping cancel_work_sync() and
> led_classdev_unregister() around only trades one for the other.
> 
> Cancelling before the unregister, as k90_cleanup_backlight() and
> k90_cleanup_macro_functions() have done since
> commit eb51c9f8cb4f ("HID: corsair: cancel worker before
> unregistering LED to fix use-after-free"), leaves
> led_classdev_unregister() free to re-arm the worker: it calls
> led_set_brightness(led_cdev, LED_OFF), which reaches
> k90_brightness_set() and schedule_work()s the item again. The structure
> holding that work is then freed while it is still linked into the
> worklist:
> 
>   BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x186/0x210
>   Read of size 8 at addr ffff888102a1ead0 by task kworker/0:1/11
>     __queue_work+0xade/0x1350
>     queue_work_on+0xb6/0xc0
>     led_classdev_unregister+0x26b/0x340
>     corsair_remove+0x1c2/0x2d0
>     hid_device_remove+0xba/0x1e0
>     usbhid_disconnect+0xa0/0xe0
>   Allocated by task 129:
>     corsair_probe+0x560/0xd50
>   Freed by task 11:
>     corsair_remove+0xec/0x2d0
> 
> Cancelling after the unregister avoids that, but reintroduces precisely
> the use-after-free that commit set out to fix: a worker that has
> already tested led->removed and found it false goes on to dereference
> led->cdev.dev, which led_classdev_unregister() has meanwhile freed via
> device_unregister().
> 
> Use disable_work_sync(), which provides both halves at once. It waits
> for a worker that is already executing, so nothing can be sitting
> between the led->removed test and the led->cdev.dev dereference when the
> device goes away, and it makes the subsequent schedule_work() from the
> LED_OFF callback fail rather than queue, so nothing is left on the
> worklist to be freed. The ordering then stops mattering. The removed
> flag is left alone; it is redundant for these paths now but harmless.
> 
> The fail_sysfs error path in k90_init_macro_functions() unregisters
> before cancelling, and so still carries the dereference-after-free that
> was fixed in the teardown paths, so convert it too.
> 
> Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
> Reported-by: syzbot+abcedffc9201f2bb66c2@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=abcedffc9201f2bb66c2
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Applied to hid.git#for-7.4/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

