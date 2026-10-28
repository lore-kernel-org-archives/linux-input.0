Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187100;
	b=WJiU5EEI+zDHjMOP+sG7nngOc94ZOWZL2O0QMaD1lw67dtffs9n8d58VrZBYZAbUvVgs
	 aXnMNRjtuiASDNYdL0W/nlky3aojWSY+2a+e1CvEWGXRZLJ1+HDNNcFjKS/GdpxQoK+eK
	 2XfIYZcHNrSSFeVDd4E6hmeI17zKe1h4Ua3+aIU/Fj0ebK7b3QSshXHAwbxEr8n17H6J7
	 mSCM7PWIoqMAH0u0RhZxoUVEiqke/q2BS0pfXGSenQ+t5k08TTnLuQ6jspbNqlCp+7AZh
	 eRnxJEWi1mppARGsHMbkTLwLA+mnlMu4xdxeEfmVk9nI29fB+2eazzkuOtUL9q+ujig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lfduVk6WL3qxz+PLjNWPWc64OrVSRQ1XnPZOSEOY2mE=;
	b=g/a3GN09f4+c+dnHE/6XUu3JPP2okB+QDVdLWbh52IB7J9tnP0PbghqccrfXDbUuVVmA
	 c+/j1yH3w2Wsjf0xO5UFWnNC+KHvTs/bvRwv8OzQ/9K0KVsRJiKCcVbvYHBj2HLXG8eS5
	 oPzntUEhEsnmMw0E8Mdhyj8sgVc0NHV0W+3/ScgfpATcAEK/G1EICej8rFmMo4hxu+QPr
	 6rOHrgkPtgTnsVUOIhZWQi7Q1ojBnxYh8rzmXdiNnloGErlAXavmF7Nc2ScvqSpD1U2xP
	 r5+gzC1BAJx/oqVnhXOQyOLUYYSrIwrRF7x59Wf0vVUTaz13OjPqj0Hxl0+JsUHlfHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy4Qk0Km;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F1606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy4Qk0Km
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7891F01825;
	Wed, 28 Oct 2026 11:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187100;
	bh=lfduVk6WL3qxz+PLjNWPWc64OrVSRQ1XnPZOSEOY2mE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hy4Qk0Km5x4WwL8ONwvDX1+5MixKSND8MDaOKAw568Lva1a+bjp1F6qS2iYrejeVV
	 Oml3N3enTGOd4DzInnAA4iV2vaddYISsKmb6hbOulmPz/rWpjU1WIXdbuOemS3WYiY
	 x32J6VCPuo39aL4KDFbwzWdpJF3JedCau4CewSCew1/jOO9qXkhc7ogJgJtqsCue4L
	 VFLekv3hrMi0AbttC7UPasGHvIV04yQ8f347tqN0YiTFszol5B+PvAXIEc7PLda8Hq
	 eTD6+tuHMuKL/raNjSDe8HVO7kvLFu7s/NtCmqWzwKTX6LM4EBwm3D07pyERWHatS/
	 QpVvYaInR0zVA==
Message-ID: <sashiko-outbox-187819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: logitech-hidpp: Replace
 create_singlethread_workqueue with alloc_ordered_workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Karagounis" <taterraster@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261028111853.22429-4-mail@taterr.org>
References: <20261028111853.22429-1-mail@taterr.org>
 <20261028111853.22429-4-mail@taterr.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:31:39 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: logitech-hidpp: misuse of WQ_MEM_RECLAIM in hidpp_ff_init()
--

commit 652f6e8738d9258b57261902879ab9a6f517f7aa
Author: George Karagounis <taterraster@gmail.com>

HID: logitech-hidpp: Replace create_singlethread_workqueue with alloc_order=
ed_workqueue

This commit replaces create_singlethread_workqueue() with
alloc_ordered_workqueue() using the WQ_MEM_RECLAIM flag for the
force-feedback sendqueue in hidpp_ff_init().

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 27d83b8bbaaf3..4efd26450539c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2875,7 +2875,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
>  		error =3D -ENOMEM;
>  		goto err_free_data;
>  	}
> -	data->wq =3D create_singlethread_workqueue("hidpp-ff-sendqueue");
> +	data->wq =3D alloc_ordered_workqueue("hidpp-ff-sendqueue", WQ_MEM_RECLA=
IM);

[Severity: Medium]
Should the flags argument to alloc_ordered_workqueue() in hidpp_ff_init()
be 0 instead of WQ_MEM_RECLAIM?

Per Documentation/core-api/workqueue.rst, WQ_MEM_RECLAIM is intended only
for workqueues that may be depended upon during memory reclaim.
create_singlethread_workqueue() was deprecated because it unconditionally
set __WQ_LEGACY | WQ_MEM_RECLAIM even on workqueues outside the reclaim
path.

Passing WQ_MEM_RECLAIM to alloc_ordered_workqueue() drops __WQ_LEGACY while
keeping WQ_MEM_RECLAIM. This spawns an unnecessary rescuer kthread via
init_rescuer() and enables check_flush_dependency() warnings:

kernel/workqueue.c:check_flush_dependency() {
	...
	WARN_ONCE(worker && worker->current_pwq && ((worker->current_pwq->wq->flag=
s &
			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) =3D=3D WQ_MEM_RECLAIM),
		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps",
	...
}

Furthermore, the commit message states that WQ_MEM_RECLAIM is added to
ensure hardware events can be processed under memory pressure, but
hidpp-ff-sendqueue only sends outgoing force-feedback commands and relies
on GFP_KERNEL allocations both when queueing work in hidpp_ff_queue_work():

drivers/hid/hid-logitech-hidpp.c:hidpp_ff_queue_work() {
	struct hidpp_ff_work_data *wd =3D kzalloc_obj(*wd);
	...
}

and when executing work via
hidpp_ff_work_handler() -> hidpp_send_fap_command_sync():

drivers/hid/hid-logitech-hidpp.c:hidpp_send_fap_command_sync() {
	struct hidpp_report *message;
	int ret;

	message =3D kzalloc_obj(struct hidpp_report);
	if (!message)
		return -ENOMEM;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028111853.2242=
9-1-mail@taterr.org?part=3D3
