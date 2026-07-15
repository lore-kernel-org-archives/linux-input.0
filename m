Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825343CF1F1
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109526; cv=none; b=gdc0LHhV0QIWVGVQ4BSwuSd/d9LEU+WnkXz6+X5XoLEgnELHJRAt0RRIfJZRKzOk1hqnvh0XQH7xa7wL9tHfaxm7SgYadFIFdRrGnr1YTzlS3ahUugx9kDac0z+myh6IYKrBSvtujluzl6qVUEfh+54OodCcNM31pcYS5WFBz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109526; c=relaxed/simple;
	bh=BfGt85DiurTwPPPPJnYiJnALW1pStXMockuMLNCPOGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRjVJ7SWPDxX7/UXeLY/f/OUSVggNXyuMmnjNjM1ndcuWVna8/8wYQXlnoioPRAgOP2T6rJMLrWY8WgyVBTkGxJNzH4ivzwzR0EewESh3iPL0oalqOvGXGtgnsrQBztC4TZpnz8RG5ahvbQ/PRowj3RQ1n/zmfFvgqDF35rnAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W00nsNg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W00nsNg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2B91F000E9;
	Wed, 15 Jul 2026 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784109525;
	bh=kfJaHA7GcB3P3mD9UMjFVKPYT0vEm3WZIx3HJMxxUKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W00nsNg8qbjYKh0SvNeUgSsLjXUCczCp4NhgHHjD7QF6PAj5epwAjqgUmseS8nRzh
	 pMrfawyneZvIH+n9XMsC5FHi0Wr/TnzCAtMr8HoH1c3ovVts14HZqwoGzs6y2T265C
	 oD/umNQSPfHqtVfON2Z0tNFarS3CvIb7jWXicYi67XhvpiYX0vw/pKsdRtQ8YDR3Pn
	 i0Xy9dBCz0zhR8+GcQ9iOi3vTO7b0Pcam2d/a0xJdI/MbxQQLkODHDQDOygZtgbWBg
	 Ijqas1aOnzBK18jSK1vwfcAg/UojqjSk8YflrnYF1Y4iEL3iJKEBf48L8ruUrTCiEf
	 Fpf3+XeQukDWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: amd_sfh: clear hid_sensor_hubs entry on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
References: <20260715094622.115062-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:58:44 +0000
Message-Id: <20260715095844.DB2B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown ordering allows delayed work to be scheduled aft=
er cancellation, causing a Use-After-Free.
- [Medium] Unprocessed requests in `req_list` are leaked during driver tear=
down.
--

--- Patch [1]: [PATCH] HID: amd_sfh: clear hid_sensor_hubs entry on probe f=
ailure ---
commit 610c0ee48e98cb215b641a8b6eb6b1d6375db3cc
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: amd_sfh: clear hid_sensor_hubs entry on probe failure

This patch clears the hid_sensor_hubs entry in the error path of
amdtp_hid_probe(). Doing this prevents a dangling pointer that can
trigger a use-after-free and double-free during cleanup when
amdtp_hid_remove() iterates over the array.

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-=
hid/amd_sfh_hid.c
> index b04f675d49b0d..9eaa2785a9aca 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
> @@ -162,6 +162,7 @@ int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_=
data *cli_data)
>  	return 0;
> =20
>  err_hid_device:
> +	cli_data->hid_sensor_hubs[cur_hid_dev] =3D NULL;
>  	kfree(hid_data);
>  err_hid_data:
>  	hid_destroy_device(hid);

[Severity: High]
This is a pre-existing issue, but is it possible for delayed work to be
scheduled after cancellation during driver teardown?

Looking at amd_sfh_hid_client_deinit() in
drivers/hid/amd-sfh-hid/amd_sfh_client.c:

	cancel_delayed_work_sync(&cl_data->work);
	cancel_delayed_work_sync(&cl_data->work_buffer);
	amdtp_hid_remove(cl_data);

Because amdtp_hid_remove() is called after the workqueues are canceled, the
HID interfaces remain fully operational during this window.

Could an unprivileged user concurrently issue a hidraw ioctl, which would c=
all
amd_sfh_get_report() and re-arm the delayed work?

If this happens, the delayed work could run after the driver structures are
freed or destroyed, potentially leading to a use-after-free.

[Severity: Medium]
This is also a pre-existing issue, but does driver teardown leak unprocessed
request_list nodes?

In drivers/hid/amd-sfh-hid/amd_sfh_client.c, amd_sfh_get_report() dynamical=
ly
allocates new request_list nodes and appends them to cli_data->req_list:

			struct request_list *new =3D kzalloc_obj(*new);

			if (!new)
				return -ENOMEM;
...
			list_add(&new->list, &req_list->list);

These nodes are normally freed by the delayed work function amd_sfh_work().

However, when amd_sfh_hid_client_deinit() cancels the work, it does not app=
ear
to iterate over req_list to free any pending requests.=20

If there are unprocessed requests remaining in the list at the time of unbi=
nd,
will these dynamically allocated list nodes be permanently leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715094622.1150=
62-1-chenchangcheng@kylinos.cn?part=3D1
