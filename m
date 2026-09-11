Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747E49E12F
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128660; cv=none; b=epus6eh/mH+wHO+3GNMaxVNcPnWVgy3jbY8dWfTjn8dWG18/s5ASdrTPu50EFHlT6GL9Nq9LWjVxuLtjfcJ7lCYAkb0cK5LqCBJPa+dmlp9S7a7SA1n35kekN3WMe0Tt8nhwgyzYn/AAUUyyDZKrc/Gf3vfEXrO6vN2OKobY4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128660; c=relaxed/simple;
	bh=f4B4XRhxVR7I3VNWpHdNxWiBmniR+4DV95rdGTxSvEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AZjcbLpGEfNeaiadSFW4G+8kDk9DWKZo7oNbqSpSpw8kMSi6Vxk3df0pHlxbPA1CBwWcplQNQHuD81oosS6epBr6+M54eTOW7sMb+ipllegF4vHGgKzka8JtYN/XOaA/im3ryj/oz8ZBbjFcFux+V2Cp+LowwOAHGRkue3+F6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZaudlZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZaudlZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7DE1F000FF;
	Fri, 11 Sep 2026 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128658;
	bh=xFk2TChjxWkzShHnL4v+YJfXYbf+gD3o+wP052+6ls4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZaudlZzzBZVk84d7SNb8o7v/zBiTWAYGS8RnR5EDbveF6J0qdIRg2iM2vrI2piRf
	 3OVfbEgfISJnWss5mgEh0lrAoTyV3TH39AneE061mMzxl72wHviXzSIh66jSwWQuz/
	 4Th4oqGC4ebyqEnuTlIWQCxx0Li0E2vS0rG2YCWp6cQb3Lyu7KBX7G4D71hgER55Fb
	 Xmp4TXjH58OEFzAFRNy2gbVc7LiaIfGtqE4e9EO/5XHnGRYWeO3Qeif+hmNEzXiD0G
	 DZOnNXv/zML6Wb6JaYSL8j00bcu0Z++fAn3JtRvJClv14vg8bIckeA/G6T+bs7vxW4
	 WRhY0pel6g6ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: logitech-headset: add a battery driver for the
 PRO X 2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TcOpdmVuIENhcg==?= <meven29@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260911120208.21698-1-meven@kde.org>
References: <20260911115346.17133-1-meven@kde.org>
 <20260911120208.21698-1-meven@kde.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:10:57 +0000
Message-Id: <20260911121058.3B7DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver cancels its delayed workqueue before calling hid_hw_sto=
p(), which violates the mandatory HID subsystem cleanup order.
--

commit bd334ae3e07d607cf268d197e4923d3fe7f27cad
Author: M=C3=A9ven Car <meven29@gmail.com>

HID: logitech-headset: add a battery driver for the PRO X 2
   =20
This commit introduces a battery driver for the Logitech PRO X 2 LIGHTSPEED
headset. The device reports its battery status over a vendor collection
rather than HID++, so a custom driver is implemented to poll and parse these
reports.

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
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);

[Severity: High]
Could this teardown sequence in logi_headset_remove() lead to a
use-after-free?

In drivers/hid/hid-logitech-headset.c:logi_headset_remove(), the delayed wo=
rk
is cancelled before hid_hw_stop() is called. When a device is unplugged or
unbound, cancelling workers before stopping the hardware (which unregisters
the device interfaces) means that hardware events or userspace interactions
could theoretically queue new work after the cancellation.

Since devres automatically frees the driver's private data after remove()
returns, any lingering work executing subsequently would access freed memor=
y.
Calling hid_hw_stop() before cancelling the work would ensure no new work c=
an
be queued.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911120208.2169=
8-1-meven@kde.org?part=3D1
