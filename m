Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0937FF42
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754532; cv=none; b=cSE6OyLeo/sYT4i6L3VBukNWUZYpuXinZb2jfNkjcezhDIWzPa0Rlb6kT+QnCvwXliykk79kOvQD6ovw7lp9IQrS/3uzoAnmJsxDwchXmJigQOKBPvxCexKq0XKmZ9Lo3kMXceHClD6Xbrns7wZ2ZEg7c+LKNorm3sipplZnNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754532; c=relaxed/simple;
	bh=FHzECcpE2za9nNe+C8lB6FrxlaMLj2xcMZKRBMe4sEs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6/txFfJZ3/XHHpap1YK9FG3mP7AF+KjmMFvYagchrAFLlOZ85VzUC9phVYqWlITdtkV3eJywagPb3XnFxJcckciXZ8VwZx0v36zUhPBxGuXro2DHTvGQTgmOEYk72sxmd+b/NmKcV/E6+RDrOavlGlr/wkYKUFzWNzG44r0ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9hwMCHF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9hwMCHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782754531; x=1814290531;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FHzECcpE2za9nNe+C8lB6FrxlaMLj2xcMZKRBMe4sEs=;
  b=n9hwMCHFY/rFS/Xn52Db4juPu161pctHsbb047DqVCM8fqUzyGWh29Yh
   4VTwMusDXEU45DGFB4JJtlrEisObrvCt3V31LXEzYznnMea9GooRTLeQ7
   1kOsNtsXRoPadV07w30xM36N1Kn61PupErSDXtKi4dJzSFeJUoaG7muF6
   T3Aw4k8Nxy+f7gImCrUV9C0s7EfXwAZa0F39hg4xbB3q2O/kYyU38JOKc
   xn6oIjV+8U/3TOpnX71OWkyxbxLWDLPcWhS9pzbm/oFQnJ7OluKSpVLLG
   tJMauptrTFsMA3bzxiKdlGQcYA7viKN+c4n9x8n8PUlzBD+RpJr98tzCU
   A==;
X-CSE-ConnectionGUID: OSYNDm+yRUSOE7ZJk/LfUg==
X-CSE-MsgGUID: uz+vrPIEQQ2UtWYwa1lAOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94949170"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94949170"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:35:30 -0700
X-CSE-ConnectionGUID: QlzFl1PjSGKVoxpa72Glrw==
X-CSE-MsgGUID: Sg5f6LvWQ7GwQCrCGLjemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250318000"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:35:27 -0700
Message-ID: <dd9ced1905adb4805916b173847282ff168a66b9.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Wahid7852 <wahidzk0091@gmail.com>, linux-input@vger.kernel.org, "Zhang,
 Lixu" <lixu.zhang@intel.com>
Cc: jikos@kernel.org
Date: Mon, 29 Jun 2026 10:35:27 -0700
In-Reply-To: <20260627224753.35075-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

+Lixu

On Sun, 2026-06-28 at 04:17 +0530, Wahid7852 wrote:
> Some ISH firmware versions (observed on Tiger Lake LP, 8086:a0fc,
> GUID {33AECD58-B679-4E54-9BD9-A04D34F0C226}) periodically re-send an
> unsolicited HOSTIF_DM_ENUM_DEVICES response roughly every 79 seconds.
>=20
> The current guard collapses two distinct cases into one condition:
>=20
> =C2=A0 if (!(response_flag) || init_done)=C2=A0 ->=C2=A0 bad packet + ish=
_hw_reset
>=20
> This incorrectly treats a valid post-init firmware announcement as a
> corrupted packet, triggering an ISH soft-reset and a full ISHTP
> re-initialisation cycle on each occurrence (~1100 times per day on
> affected hardware).
>=20
> Split the check: reject messages with no response flag as before, but
> simply discard valid ENUM_DEVICES messages that arrive after init is
> complete.
>=20
> Signed-off-by: Wahid <wahidzk0091@gmail.com>
Also you need first and last name for sign offs. Not sure this is
allowed format.

Thanks,
Srinivas

> ---
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 6d64008f2..ec5e8afe7 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -113,8 +113,7 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0
> =C2=A0		switch (recv_msg->hdr.command & CMD_MASK) {
> =C2=A0		case HOSTIF_DM_ENUM_DEVICES:
> -			if ((!(recv_msg->hdr.command & ~CMD_MASK) ||
> -					client_data->init_done)) {
> +			if (!(recv_msg->hdr.command & ~CMD_MASK)) {
> =C2=A0				++client_data->bad_recv_cnt;
> =C2=A0				report_bad_packet(hid_ishtp_cl,
> recv_msg,
> =C2=A0						=C2=A0 cur_pos,
> @@ -122,6 +121,8 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0				ish_hw_reset(ishtp_get_ishtp_device(
> hid_ishtp_cl));
> =C2=A0				break;
> =C2=A0			}
> +			if (client_data->init_done)
> +				break;
> =C2=A0			client_data->hid_dev_count =3D (unsigned
> int)*payload;
> =C2=A0			if (!client_data->hid_devices)
> =C2=A0				client_data->hid_devices =3D
> devm_kcalloc(
