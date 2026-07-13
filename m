Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A002E414
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945406; cv=none; b=b+plfUGIfWm/CYnr4COL5W+RNTKRitaMIOO9Dt9gx7KL2W1YQKaokYkIEVUkrCdDiw7NsblWvV/GB1NT1C9v1mFSfHeeKgQ6LQp5tk/e8gJfw+vDHdMjE1noqEwFj4E/OywPdZJyFkU6x+5wP8gmtSvVdzKcqMeJ6lSuHXvMXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945406; c=relaxed/simple;
	bh=K8zKAyMcdPhKZKdIKxt0tc51+lIcVDtkoFqsQZTMExw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHLt/lYFCVGzNhdbnFCDL3h8X/RZXkY0CBjRtdM7D+Yzv/gXWMhNgu9c6h7jffivBbK6s6ZVN3HzTX+zMzreSW8H2W3lyFNzUp/QicCMVn0FhMUQYxYnIIn83M9SX+kh1DJmZrWtAlXmLNEy9shgkACDvaVA3UB7pM5BgvZJyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9Zbkgh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9Zbkgh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E471F000E9;
	Mon, 13 Jul 2026 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783945405;
	bh=lTe0pYFNU/Zh6mKO/XlA/jR1LKQhV1b5qlD+AGY+hVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9Zbkgh6HL5fJ6Why/KJG99pe+et74ohfOAaKsmETuJgGC0L3frKiS40WIHOaWiyY
	 d00LML8btwRWjluzuKf/ewZ98g3h52gmhvr5sXim2K73qvsFNfZXQ28onsH0owQlnt
	 M+VuIHSjowi90901FM4mGYkyZwYWgNo+UvpL0RquzJeI3r5xmwKvXjtsYrAFwrVKza
	 FViS/Nl9jpIvcHT+GzGbLY06wgbyEwDBuiu82KQp24w/Pro54A2ZJHgXxw+aLSHn/K
	 n5yLkeJ9JpxQK7frb8SUgr7g2bNdFbYYI/GtdJxuqk3E2kvwNvbjAtL8OAF7Cnox1U
	 VKGnzw5/A8/3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: uclogic: fix use-after-free of inrange_timer on
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713121042.2321-1-security@auditcode.ai>
References: <20260713121042.2321-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:23:24 +0000
Message-Id: <20260713122324.D9E471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reordering hid_hw_stop() before timer_delete_sync() introduces a U=
se-After-Free on the input_dev structure.
--

--- Patch [1]: [PATCH] HID: uclogic: fix use-after-free of inrange_timer on=
 remove ---
commit 43bb5d633bc4358be3fe68adce4de35e0008e236
Author: Ibrahim Hashimov <security@auditcode.ai>

HID: uclogic: fix use-after-free of inrange_timer on remove

This commit attempts to fix a timer re-arming race condition during driver
removal by stopping the hardware with hid_hw_stop() before calling
timer_delete_sync() on the inrange_timer.

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index b73f09d26688a..925178d8feb40 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -548,8 +548,35 @@ static void uclogic_remove(struct hid_device *hdev)
>  {
>  	struct uclogic_drvdata *drvdata =3D hid_get_drvdata(hdev);
> =20
> -	timer_delete_sync(&drvdata->inrange_timer);
> +	/*

[ ... ]

> +	 * Stopping the hardware first and only then deleting the timer
> +	 * closes that window: hid_hw_stop() will not return until the
> +	 * device can no longer feed uclogic_raw_event_pen(), so the
> +	 * timer_delete_sync() call below is guaranteed to be the last write
> +	 * to inrange_timer. This also matches the ordering already used by
> +	 * other HID drivers whose timers are re-armed from the report path,
> +	 * e.g. hid-appleir.c's key_up_timer.
> +	 */
>  	hid_hw_stop(hdev);
> +	timer_delete_sync(&drvdata->inrange_timer);

[Severity: High]
Does this reordering introduce a use-after-free on the input device memory?

When hid_hw_stop() returns, it has already disconnected and freed the input
devices, including the one pointed to by drvdata->pen_input. If the 100ms
timer fires after the input devices are freed but before timer_delete_sync()
completes, uclogic_inrange_timeout() will run and dereference the dangling
drvdata->pen_input pointer:

drivers/hid/hid-uclogic-core.c:uclogic_inrange_timeout()
    ...
    input_report_abs(input, ABS_PRESSURE, 0);

To prevent the timer from being re-armed without violating the safe teardown
order, would it be better to keep the timer cancellation before hid_hw_stop=
()
but replace timer_delete_sync() with timer_shutdown_sync()?

>  	kfree(drvdata->desc_ptr);
>  	uclogic_params_cleanup(&drvdata->params);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713121042.2321=
-1-security@auditcode.ai?part=3D1
