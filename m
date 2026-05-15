Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159A305680
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860719; cv=none; b=FiZBBoBJO6xuFz9xjfMH7ptW7HFST4jLXhXmPzmrjsohtHoZgW25okRzhc2NJSsX/IZ0f9ta77kKzeYe74LvjtrPh3WbuuiQCjgV31nz6WhjoTaP2bazRB5zsEZLjwUXrRQiVBaI1wP011fDIxDRMOWVVmrQLkncuGcNysU4oAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860719; c=relaxed/simple;
	bh=KL9kkaDzXsxm0abjJy55EHUNgIhoYl5OyWuF0ZLy2uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEahXEa1bgzG3dOKXb+xhvlz5NqL63QdCV64vc6eeGHg1IcWgHzbMHd70PvmVb6Z8folCvwXrnI+TV0DG0cMPhDOkjXLjV6nOlavT1hDNnkltvBbsVfLEtGABfdb56jphKGBt5/ktiKuQEPzRnZJZztcSakmdLSK8h3L8ZIxCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZA2IneC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZA2IneC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4247C2BCB3;
	Fri, 15 May 2026 15:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860719;
	bh=KL9kkaDzXsxm0abjJy55EHUNgIhoYl5OyWuF0ZLy2uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GZA2IneCu8HvqgZ1w2dXWyeu+pXhCE3B55iaFmN2oklclS+0B332Thw+I/XAEKgik
	 eTJl88gKcbq61kxxWKDgZtH29cnU6hvQnIWD8g44GcAGAW2MxiWwHSZ1MeBscpVIKY
	 nYgFqRzVoaBsDKasQjH6pYPZ8oNqVmhHB6lWu+G5V3PhKLDIC8xR5Cy0CHql5KkgRQ
	 k5hKMYtJ5lhxCh+nT+LMTbUTtKqoHDX8z422zMuPHH5IFVctLG6rZFm2qWWhuxmpkh
	 cQScu38yKeQSHG91NWOTE1gW19fD7GdSLJSDGg9A149ysNiNIdltOUs61cZzkCoUEO
	 AzaqcO0lz5b/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: letsketch: fix UAF on inrange_timer at driver
 unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manish Khadka" <maskmemanish@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515153551.76162-1-maskmemanish@gmail.com>
References: <20260515153551.76162-1-maskmemanish@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:58:38 +0000
Message-Id: <20260515155838.B4247C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing timer cleanup on the probe error path leads to a Use-After=
-Free.
- [Medium] Unnecessary spinlock and state flag introduced instead of using =
`timer_shutdown_sync()`.
--

commit 2d88d7acbcf7e811559cfcb0df7e33f55178711b
Author: Manish Khadka <maskmemanish@gmail.com>

HID: letsketch: fix UAF on inrange_timer at driver unbind

This commit adds a remove callback to the letsketch driver to clean up
the inrange_timer during device unbind. It introduces a spinlock and a
removing flag to prevent the timer from being re-armed by in-flight
events while teardown is occurring.

> diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
> index 11e21f9887232..0dc9496d05f80 100644
> --- a/drivers/hid/hid-letsketch.c
> +++ b/drivers/hid/hid-letsketch.c

[ ... ]

> @@ -305,6 +315,23 @@ static int letsketch_probe(struct hid_device *hdev, =
const struct hid_device_id *
>  	return hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  }

While not introduced by this patch, if hid_hw_start() fails and returns an
error, does this leave a pending timer that will fire on freed memory?

Looking at hid_hw_start(), it enables hardware I/O before attempting to
connect. If the connection fails, it stops I/O and returns an error:

hid_hw_start() {
        hdev->ll_driver->start(hdev);
        if (hid_connect(hdev, connect_mask)) {
                hdev->ll_driver->stop(hdev);
                return error;
        }
}

During the window where I/O is active, an incoming event could trigger
letsketch_raw_event() and arm the timer.

When letsketch_probe() directly returns this error, devres immediately frees
the letsketch_data structure without draining the timer.

> +static void letsketch_remove(struct hid_device *hdev)
> +{
> +	struct letsketch_data *data =3D hid_get_drvdata(hdev);
> +
> +	/*
> +	 * Block raw_event from arming inrange_timer during teardown so
> +	 * timer_delete_sync() below cannot race with a fresh mod_timer()
> +	 * issued from a URB completion handler still in flight while
> +	 * hid_hw_stop() is running.
> +	 */
> +	scoped_guard(spinlock_irqsave, &data->lock)
> +		data->removing =3D true;
> +
> +	timer_delete_sync(&data->inrange_timer);
> +	hid_hw_stop(hdev);
> +}

Could this synchronization be achieved without adding a new spinlock and st=
ate
flag by using timer_shutdown_sync() instead?

The timer_shutdown_sync() API permanently disables the timer, ensuring that
any subsequent mod_timer() calls are silent no-ops.

Alternatively, if hid_hw_stop() were called before cleaning up the timer, it
would wait for all URBs to complete, which structurally guarantees no new
events can arrive to re-arm the timer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515153551.7616=
2-1-maskmemanish@gmail.com?part=3D1
