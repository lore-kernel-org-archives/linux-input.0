Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFC449B1D
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581201; cv=none; b=OXoKc6VpA6ZMcRwDJigha+4cAXRNgH73LfPNsXRj0q1PHyFYFFytJDJSi3inZpkwLoG9pst3qpSI9uxzHn6kvgjDrJRY7CxzG+X6xUwyCja90k4DY8pAhK0DxtcbEKkQdtH3UPF+8w7VyZjNR86h7ihgDWHevx+nJjOE4q0sHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581201; c=relaxed/simple;
	bh=X/0gb8oBsjiWKuoxn/UWaeUs1szQvzV3nzh5QK+4esE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kPcnlWD8UVF2sFyZT2VyyYLbGW+/fRSGOJHLGOTDsnohsNlvQnWqe9RsTIurWI0fr07j4ipqgPTOiF+aVmXZp+/OGjtGt2I/YYE/rezlGMuRpoTQBnx5Z9aaVaKxME0ENRsX3qS7KGZmzUJJGYf/stf9fU33burR5bvWZj83wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mudvC29v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mudvC29v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784581200; x=1816117200;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=X/0gb8oBsjiWKuoxn/UWaeUs1szQvzV3nzh5QK+4esE=;
  b=mudvC29vz7XhtHsw7eAVksz72mOV8yowvumWHW26Reu1aZc9l1Z75q7w
   LPfRnf4EM5PLuXKpEAW0vaZDDeZpSnSJmVkngS/HkM7OeEhSPKAq5zcoW
   AaHZFVR0xPdvTt52YQEji4npRW3QS3qXmgdlKFMBVXidvbDjwxYo2J8oy
   XD068OdckvluHZzsERWjGmzDKiU4+zGBDXUgi67JXcr0dEvTyQJwDnqna
   BVIIcft5pabyB+6D1LpuR2QkZ5SRBT5u2fkE/8LajGKRv4kZgG+vLdFvH
   mHk4iC6CX660F2+d/aCA0pIcynRUE8YohjIrzmb52w/CrD7yoU4i8iAqY
   A==;
X-CSE-ConnectionGUID: +t9knZwBST2R81fGDM3vFg==
X-CSE-MsgGUID: +NBRxLVHRZuuMCzdHZfxsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="102591770"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="102591770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:59:59 -0700
X-CSE-ConnectionGUID: kOF91Ar1RGiuBidPTgZdhQ==
X-CSE-MsgGUID: k34RyTzrTfmwG0yeSzVIpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256998943"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.170]) ([10.125.109.170])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:59:59 -0700
Message-ID: <efbf11ebb2faa0a60857408d3b820dffb890666c.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES
 from firmware
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Wahid7852 <wahidzk0091@gmail.com>, linux-input@vger.kernel.org
Cc: jikos@kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Date: Mon, 20 Jul 2026 13:59:58 -0700
In-Reply-To: <20260720175656.559351-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
	 <20260720175656.559351-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-20 at 23:26 +0530, Wahid7852 wrote:
> From: Wahid Khan <wahidzk0091@gmail.com>
>=20
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
> Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


Lixu, please add your tested by. I think you already tested this.

Thanks,
Srinivas

> ---
> v2: added proper sign off
>=20
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
>=20
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
> --
> 2.54.0
