Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715176;
	b=FFB1bLGJovF3xqVbh8pD2A5pLHMXDXJA2uN0MCWwTk9g+Mj98FJxlVAikIy9vti4Ma6s
	 YkndxPnS5cNRtkM3W4mczJwngxxDzU4/ABNS8XxBCiOifMgTv/YN7IH3Qzk+n9y6z5U9R
	 yHHpmx78y/RTBQZ6oaOp+awhkeM7wqjlxtqLw+2FEMCXQYHFjYf3SoVPe9mLCSGhuBrpR
	 a39+ZYadED72+Jrc7lk5jJ7cKvda8Qi86sEP80Aj2ViBwH06WCTvqpG0yHQjkrGr4t7a+
	 Z8nYvwVXhxphBChYo+hc0fYBxagIo/kuFf8FYDiD8VTDNtGDmRmydXnezgGp2sbSOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715176;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=VJiYm7UJux9idX0JQ7Nj/k1JSHluv9DMg/+XlxnNVXM=;
	b=XL+sRzvLgOm+KxlDrj1OYfS4madjdBc1RMdTuHU69QG7yp6Db94LYnWCnbD0cAVKN/g0
	 IUF8VDeomECbikm/xl0UNA/yJKOyDMuh2gMZU8dAixo/WEIQSuaQtAGIeo1TFikX71+pj
	 HWOUtnbtUAnW3ooEiIlz+3R3GBPT9dFJ7qyz0z2eKe+omEdg2JgbgEevV6ZW6K+Hh/uDd
	 FtsvLOlDy31JOcwGS/XScIL3uffRuwl28kyW/cxFjQla3Hrp1zTULvmkHCxs/v1VlZz2c
	 TktH5kYRB/Og925/BnwYfgzvUCroCyarpT2al436SK4q1qGgtK+iS4bCZa3hFk5+6TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="G/MDCWAJ";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F79606A324;
	Tue,  3 Nov 2026 14:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F79606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G/MDCWAJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793715176; x=1825251176;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GEtSxpe7gQ6US0v+DeHjs5kOMzZtxFEAD5UmXw0Um+M=;
  b=G/MDCWAJPihWNvGBHMVc2D64silIEmyMi7l6UviepbnvMnv/+ndPBidM
   nWM1OcD8OPsyUHKgUegl1baX9SSD7pDJKo9ATnGGw9KuHPPxgLuYFcYgs
   wdGORYmrOmcPLzutlkJ6aNgaQHMdYnWm07kxrF52bvULvlC4jNbrzUIRM
   IcTqkFE+bwotaTTwNJQ+5nI1Ze4vRH/eAHTrhmTmK3CKmleBPfYxYoxMu
   va479aUTVtHCFTG2CO1phGk20azLPT3PcmgHWBQrEJajryVg/Clkqragw
   vyTt6CcX/AKvxasAZghzDNJOaASDNpxavcezmGRbsJfDFURcU9dDyUe6S
   g==;
X-CSE-ConnectionGUID: U5/SQhvmRkmpfyt+NXiKTw==
X-CSE-MsgGUID: kny0DaCYTT6zzi3PpcJ+dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2455525"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2455525"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:12:56 -0800
X-CSE-ConnectionGUID: ThEnGDMZQKabsvKHZ2R5FA==
X-CSE-MsgGUID: h3UKpd6eTV6kDZLmRg6ckw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6772446"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.222]) ([10.125.109.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:12:55 -0800
Message-ID: <e936116958efcf6b4220b1769654d60628f801af.camel@linux.intel.com>
Subject: Re: [PATCH] HID: sensor-custom: Synchronize misc-device teardown
 with file lifetime
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, simeon@maryasin.name
Date: Tue, 03 Nov 2026 06:12:54 -0800
In-Reply-To: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
References: <20261103015734.578613-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-02 at 17:57 -0800, Srinivas Pandruvada wrote:
> The HID sensor custom misc device frees its per-sensor state in
> remove() while userspace may still hold an open file descriptor. A
> reader blocked in read() can remain queued on sensor_inst->wait after
> the
> object has been freed, and a later wakeup races with teardown and
> touches stale memory.
>=20
> Synchronize the misc-device teardown with file lifetime before
> freeing
> the per-sensor state. Set a removal flag, reject new opens, wake
> blocked waiters, and wait for the last open file to close before
> deregistering the misc device and freeing the FIFO. Fail in-flight
> read()
> and poll() operations cleanly once removal is in progress so
> userspace
> cannot access freed memory after the device disappears.
>=20
> This avoids use-after-free on read(), poll(), release(), and open()
> after the HID sensor custom character device has been removed
>=20
Hi Simeon,

Shashiko found issue with this change, so hold on for testing.

Thanks,
Srinivas

> Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> Signed-off-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 27 +++++++++++++++++++++++++--
> =C2=A01 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index c2b425afd951..c9338ae47050 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -53,6 +53,14 @@ struct hid_sensor_custom {
> =C2=A0	struct kfifo data_fifo;
> =C2=A0	unsigned long misc_opened;
> =C2=A0	wait_queue_head_t wait;
> +	wait_queue_head_t remove_wait;
> +	/*
> +	 * Shared with the file operations; use
> READ_ONCE()/WRITE_ONCE() for the
> +	 * teardown state. The actual lifetime guarantee comes from
> misc_opened:
> +	 * removal waits for the last fd to close before
> deregistering the misc
> +	 * device and freeing the FIFO.
> +	 */
> +	bool removing;
> =C2=A0	struct platform_device *custom_pdev;
> =C2=A0};
> =C2=A0
> @@ -653,6 +661,9 @@ static ssize_t hid_sensor_custom_read(struct file
> *file, char __user *buf,
> =C2=A0	sensor_inst =3D container_of(file->private_data,
> =C2=A0				=C2=A0=C2=A0 struct hid_sensor_custom,
> custom_dev);
> =C2=A0
> +	if (READ_ONCE(sensor_inst->removing))
> +		return -ENODEV;
> +
> =C2=A0	if (count < sizeof(struct hid_sensor_sample))
> =C2=A0		return -EINVAL;
> =C2=A0
> @@ -662,9 +673,12 @@ static ssize_t hid_sensor_custom_read(struct
> file *file, char __user *buf,
> =C2=A0				return -EAGAIN;
> =C2=A0
> =C2=A0			ret =3D wait_event_interruptible(sensor_inst-
> >wait,
> +				READ_ONCE(sensor_inst->removing) ||
> =C2=A0				!kfifo_is_empty(&sensor_inst-
> >data_fifo));
> =C2=A0			if (ret)
> =C2=A0				return ret;
> +			if (READ_ONCE(sensor_inst->removing))
> +				return -ENODEV;
> =C2=A0		}
> =C2=A0		ret =3D kfifo_to_user(&sensor_inst->data_fifo, buf,
> count,
> =C2=A0				=C2=A0=C2=A0=C2=A0 &copied);
> @@ -684,6 +698,7 @@ static int hid_sensor_custom_release(struct inode
> *inode, struct file *file)
> =C2=A0				=C2=A0=C2=A0 struct hid_sensor_custom,
> custom_dev);
> =C2=A0
> =C2=A0	clear_bit(0, &sensor_inst->misc_opened);
> +	wake_up_all(&sensor_inst->remove_wait);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -694,6 +709,8 @@ static int hid_sensor_custom_open(struct inode
> *inode, struct file *file)
> =C2=A0
> =C2=A0	sensor_inst =3D container_of(file->private_data,
> =C2=A0				=C2=A0=C2=A0 struct hid_sensor_custom,
> custom_dev);
> +	if (READ_ONCE(sensor_inst->removing))
> +		return -ENODEV;
> =C2=A0	/* We essentially have single reader and writer */
> =C2=A0	if (test_and_set_bit(0, &sensor_inst->misc_opened))
> =C2=A0		return -EBUSY;
> @@ -712,6 +729,9 @@ static __poll_t hid_sensor_custom_poll(struct
> file *file,
> =C2=A0
> =C2=A0	poll_wait(file, &sensor_inst->wait, wait);
> =C2=A0
> +	if (READ_ONCE(sensor_inst->removing))
> +		return EPOLLERR;
> +
> =C2=A0	if (!kfifo_is_empty(&sensor_inst->data_fifo))
> =C2=A0		mask =3D EPOLLIN | EPOLLRDNORM;
> =C2=A0
> @@ -736,6 +756,7 @@ static int hid_sensor_custom_dev_if_add(struct
> hid_sensor_custom *sensor_inst)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	init_waitqueue_head(&sensor_inst->wait);
> +	init_waitqueue_head(&sensor_inst->remove_wait);
> =C2=A0
> =C2=A0	sensor_inst->custom_dev.minor =3D MISC_DYNAMIC_MINOR;
> =C2=A0	sensor_inst->custom_dev.name =3D dev_name(&sensor_inst->pdev-
> >dev);
> @@ -751,10 +772,12 @@ static int hid_sensor_custom_dev_if_add(struct
> hid_sensor_custom *sensor_inst)
> =C2=A0static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custo=
m
> =C2=A0								*sen
> sor_inst)
> =C2=A0{
> -	wake_up(&sensor_inst->wait);
> +	WRITE_ONCE(sensor_inst->removing, true);
> +	wake_up_all(&sensor_inst->wait);
> +	wait_event(sensor_inst->remove_wait,
> +		=C2=A0=C2=A0 !test_bit(0, &sensor_inst->misc_opened));
> =C2=A0	misc_deregister(&sensor_inst->custom_dev);
> =C2=A0	kfifo_free(&sensor_inst->data_fifo);
> -
> =C2=A0}
> =C2=A0
> =C2=A0/*
