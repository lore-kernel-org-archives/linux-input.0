Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AB2EA154
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145359; cv=none; b=PVD0fwAQfmgVOKqqzaAHfYwi1AIVfkVol5iuiyZygFPrUx4tT1DLuSDe7Zm9mvMDto/y23n6oIJgXwnXa4lPnTlYSknQAco7sQlXc++Aa6SSVOVtfK9W4xDxfESKZ6EXQVd3yKW8HA0JjWBWSbN92dt/Wi95evfg8CWe+1Q399A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145359; c=relaxed/simple;
	bh=GwRkKxivVeILu7aVemEJYkvsEhZ8KVF80W0sYYk7B4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hicPnp7uarSdJhVPLYoFha/P6D4QgcXjDxZ102AFM5AxD/V2epnWsXemuUtxcnh5xHIMRYNEb434WpzHz0FFIfAo3cgk4Dkzzqviaf0W89d3T/xHNUNqbFvHwyu1nysgyLHH6TJzkDsye3pZqHRIIMx0RJIBOsKjHpmRO3LbhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXCzjcqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXCzjcqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E241F000E9;
	Sat,  4 Jul 2026 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145357;
	bh=KQrZGenm9x09INIciWSbfte5XJmxhg3pH/UhHQUx1PI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXCzjcqI86TbIit1a0FDWasKOoka00xiE6bMoIxwMhlAqGlB3JM8SDG/NLwFD4h46
	 /oVQcNJayLM9kWizAK9zv+ydlabwV39NR7L1XRRE0dd7cN3l71RZi/7duuvls9SOzM
	 n9LzjeDL2t28OTfMswKcYioNTIcQoo7eQYcUoB/QDn557GXbiZTMxZzZSxN5GoqmME
	 Tgr2+Z9wKUHqv4iDzQgeNIGZRilPQyML/WcGkURrL3/Fg2eWUUMkLQ3my4gnSMKuN/
	 PhLBl9bbvWAweIkYlo+mvh0R+ZGYFlttNZrrl3vhduYt8E1VPIzykSgkyj3fj8I498
	 HIwatQjQFn38Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/26] sh: maple: remove unused driver field from struct
 maple_device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-16-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-16-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:09:17 +0000
Message-Id: <20260704060917.67E241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] vmu_can_unload() crashes on hot-unplug if the driver fails to prob=
e or is unbound.
--

commit 03c570da1dc6a7b4d15fe87da8cdddba6169830d
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

sh: maple: remove unused driver field from struct maple_device

The commit removes the unused driver field from struct maple_device since a=
ll=20
readers and writers of this field have been eliminated from the maple bus c=
ode.

> diff --git a/include/linux/maple.h b/include/linux/maple.h
> index 22f2930251edc..90c26c86e3ede 100644
> --- a/include/linux/maple.h
> +++ b/include/linux/maple.h
> @@ -64,7 +64,6 @@ struct maple_devinfo {
>  };
> =20
>  struct maple_device {
> -	struct maple_driver *driver;
>  	struct mapleq *mq;
>  	void (*callback) (struct mapleq * mq);
>  	void (*fileerr_handler)(struct maple_device *mdev, void *recvbuf);

[Severity: High]
This is a pre-existing issue, but while reviewing changes to struct
maple_device, I noticed a potential null pointer dereference in the vmu-fla=
sh
driver.

In drivers/mtd/maps/vmu-flash.c:probe_maple_vmu(), the can_unload callback =
is
set:

probe_maple_vmu() {
        ...
        mdev->can_unload =3D vmu_can_unload;
        ...
}

If probe fails during device connection or if the driver is unbound via sys=
fs,
the driver core clears the device's driver data to NULL. However,
mdev->can_unload remains pointing to vmu_can_unload.

If the device is subsequently hot-unplugged, the maple bus core calls
maple_response_none() -> mdev->can_unload(mdev), which dereferences the
driver data without checking if it is NULL:

vmu_can_unload() {
        ...
        card =3D maple_get_drvdata(mdev);
        for (x =3D 0; x < card->partitions; x++) {
        ...
}

Could this cause a system crash on hot-unplug? Should mdev->can_unload be
cleared on the probe error path and during unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D16
