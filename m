Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961445D5D9
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128181; cv=none; b=W+9bji+DDfORmHQTa+hRZIAvswkDF6YNPg7D/4N+DePj77+OijmZmD9pPMoKxV35i8Nrn2gVQoK3ByK6PyDCM2RwxtyQmv7b0RmAwEsR0wF1dXKQUcRDXhRLUipTSOnUfUCUkfoziJCfeSoPS1ZuPLSbkQueXsmScB2rFA/w8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128181; c=relaxed/simple;
	bh=NOUFlBt9WS32QAoxl5AHo8Y2hU6AdchW9oW3HXPKha4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XvgU7nPgRHgR0J2MGsreDcBKqJNEMzz8DTyDP9NYGHETp0u9S/ini4NIaFse84vAFiZcOnfN9YeLHgQmIuJpF4HaSSnK2wcSt/PK0RmUgr2iXj+Rgnn5ypwys+EHG/6x6qshhPoqK/iy0HQNI2uSDQR4JBiEb3++b2dRwLyjdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMOMIfio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMOMIfio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8851F000FF;
	Fri, 11 Sep 2026 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128178;
	bh=hZ+UpUg7OZhfHUSW1U6MBEsxwvtLHqUTtAsX2Xtu5r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMOMIfioqTKupZtMjJM5g3LGgIxH2WpljLSp0OKyBqJqPSb1rcs8mwedjoxxnC3yW
	 PdnRmrjuCMZ9YQMGntMQS02lSOsIzSM6HWWTraq0/ivX4bT9Du8jJUfAua5RgozMiq
	 dLdZ+EoOUrmrtDSdmT9Qr1OkbX8vd+HcRxKlGv835RuKZzuQh3FIW21xWT7YvW+Hh+
	 HyNscWjCkYIkTxQJPyJc156EavjcryA/Tw8cVImt6qY3EYJeYdlHkMLxcZsIi2ArGa
	 8P7mfyXIicRcdKT/r5a2SlXcyy32FEgTuUmmiyq2Pjdgf+LX6iatfBhgcVKWpw0821
	 KThLMhoi+oq2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: logitech-headset: add a battery driver for the PRO
 X 2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TcOpdmVuIENhcg==?= <meven29@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260911115346.17133-1-meven@kde.org>
References: <20260911115346.17133-1-meven@kde.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:02:58 +0000
Message-Id: <20260911120258.9C8851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect teardown sequence in remove callback violates HID subsys=
tem guidelines.
--

commit adb0241c4db099ec7ce91b1ebd7f292627e20d96
Author: M=C3=A9ven Car <meven29@gmail.com>

HID: logitech-headset: add a battery driver for the PRO X 2

This commit introduces a battery driver for the Logitech PRO X 2 LIGHTSPEED
headset. It communicates with the hardware over a vendor collection using a
polling mechanism scheduled via a delayed work queue to report battery stat=
us.

[ ... ]

> diff --git a/drivers/hid/hid-logitech-headset.c b/drivers/hid/hid-logitec=
h-headset.c
> new file mode 100644
> index 0000000000000..9081ddf5f42f2
> --- /dev/null
> +++ b/drivers/hid/hid-logitech-headset.c

[ ... ]

> +static void logi_headset_remove(struct hid_device *hdev)
> +{
> +	struct logi_headset *headset =3D hid_get_drvdata(hdev);
> +
> +	cancel_delayed_work_sync(&headset->poll);

[Severity: High]
Does this teardown sequence in logi_headset_remove risk a use-after-free?

The HID subsystem guidelines specify that hid_hw_stop must be called before
cancelling asynchronous workers. By executing cancel_delayed_work_sync
before hid_hw_stop, it is theoretically possible for new work to be queued
while the driver is in the process of unbinding.=20

Calling hid_hw_stop first ensures that no new events or userspace requests=
=20
can trigger work to be scheduled during resource reclamation.

> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911115346.1713=
3-1-meven@kde.org?part=3D1
