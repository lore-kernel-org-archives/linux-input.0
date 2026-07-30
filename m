Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA4448CEE;
	Thu, 30 Jul 2026 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435083; cv=none; b=thVYmzz+9/G2X1ii6lkct7mvrDO89hoBIYmZq9ZXFWBJeHluJT+X6v4rQhzcpQxGylMzfmIUU7TZWAuKpSBGih/jzo3Gm4VPHchvF7w779BJBeaRnFXrsLOcNu+xzEglq31ZQVur8R1KCPyR/cXo9lWBo+MD8eg9T5+xub9zSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435083; c=relaxed/simple;
	bh=beEu6S0fwn8Hdoi9I6zC3tVTq+Ny8jr3hL9rMFhRY5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmIk0JrVS9RPgmTusDdWuYm++yYGNYgGod+PtX/y3P5pv3/1BNGiU4jdAViMb0qcovcFoDk+uN4jw8qU+2Gv8lZ+LnAlohMhnwDkbwc1VU1PFIC3PsYiF8Lbk1BKTtD/K5y7UNd4MCHDZ7BknCg98OiC4DiUd3+zcspgMcMgb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpW2metb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpW2metb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785435076; x=1816971076;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=beEu6S0fwn8Hdoi9I6zC3tVTq+Ny8jr3hL9rMFhRY5I=;
  b=OpW2metbjk1eRsXV4/33FFkcEdxlY3+HsyQz/JHva2lpqvso3yr/K86O
   SYcGw7iBeVyzZRhUyB/6mk+7bZGlRJQfiheLmy2aTML7SLsEN+5sNd/5H
   2ly719T68RcfzgnjxeLopF9vVPyHHgrwb3PvdaVC4U1DK2p8dUL5BVh5w
   Elqlt4tDpbSMOIyyTqV6bXKA/13CoE8Fh8poSbC6b/jFM+EVCZf44GtGN
   gr2Vicz623NXQbFKu2Z1gsfEzc+wocMBpXoVsQKb0f+DD7mswBMgzm2WF
   tN7RilugjIIkk9ecCnEVw3wu2lccuvVxZpJNAqmkcYOdMV8q7MuVGPS6W
   Q==;
X-CSE-ConnectionGUID: uFtH6OYRQSG6nSgpPb1UMQ==
X-CSE-MsgGUID: qZHuTQNkRG6CTevprJi20w==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85827795"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="85827795"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:11:09 -0700
X-CSE-ConnectionGUID: hin3VgF8QNKL7MadDk4wvw==
X-CSE-MsgGUID: 9Vy/abKvRLa/KlsRMZLhaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="260434070"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:11:10 -0700
Message-ID: <e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Shen Yongchao <grayhat@foxmail.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Zhang Lixu <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Jul 2026 11:11:09 -0700
In-Reply-To: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
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

On Thu, 2026-07-30 at 20:25 +0800, Shen Yongchao wrote:
> The HOSTIF_DM_ENUM_DEVICES response handler takes the HID device
> count from the first payload byte of the ISH firmware response
> (max 255) and stores it in hid_dev_count without any bounds
> check.=C2=A0 This value propagates to num_hid_devices and is used to
> index five fixed-size arrays in struct ishtp_cl_data
> (MAX_HID_DEVICES =3D 32): report_descr[], report_descr_size[],
> hid_sensor_hubs[], hid_descr[], and hid_descr_size[].
>=20
> If the firmware reports more than 32 devices, hid_ishtp_cl_init()
> writes past all five arrays, corrupting subsequent struct fields
> (including work_struct members with embedded function pointers)
> and potentially adjacent heap objects.
>=20
> Clamp hid_dev_count to MAX_HID_DEVICES at the single point where
> it enters the driver (process_recv, ENUM_DEVICES branch), which
> covers both the probe and the reset paths.
>=20
> This is a data-validation hardening fix: the ISH firmware is
> within the platform trust boundary (loaded via CSME).
>=20
> This patch was drafted with AI assistance; the vulnerability
> analysis and source-level verification were done manually.
>=20
> Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
> Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
> Cc: stable@vger.kernel.org

Missing

Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]


Thanks,
Srinivas

> ---
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 6d64008..XXXXXXX 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0				break;
> =C2=A0			}
> =C2=A0			client_data->hid_dev_count =3D (unsigned
> int)*payload;
> +			if (client_data->hid_dev_count >
> MAX_HID_DEVICES)
> +				client_data->hid_dev_count =3D
> MAX_HID_DEVICES;
> =C2=A0			if (!client_data->hid_devices)
> =C2=A0				client_data->hid_devices =3D
> devm_kcalloc(
> =C2=A0						cl_data_to_dev(clien
> t_data),
