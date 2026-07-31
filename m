Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72AA3E8340;
	Fri, 31 Jul 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508488; cv=none; b=YsMVvLA8iarFMhFUeAg71hGWsRo2ZgP8yyjHZfZP/KPpFovE4GnAPRzVt+T2CtVv67a+Q29d5nUJoo98sArjwmbGXBhUT65gc+V0a/T/d8tLHUwuTlA6KWqeyIX3Qz3bOvaXwv3NFYMcBiWfWbowCVukBkTv2XHgwZbG7a/4GEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508488; c=relaxed/simple;
	bh=mD+nmk4p0zbJa1XmXsYwWLptVJEF7kKjaY9o9NECgCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WhTbRLBM655PAw2k4044yX3Pw4ykgB0kxWdR4QrgdB4ggKnT7oR3O7PYIb7gOmoVo/mB612amXETm6hZ+647vfW45GaZUJnn3alvgaxLy6aRsGTvBS/ngzDg9UoJ3HldsNwiqrrBA+YoJjJhLRxusRYsStRxBm/XmMOE5vpoZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPnDTpv2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPnDTpv2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785508487; x=1817044487;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mD+nmk4p0zbJa1XmXsYwWLptVJEF7kKjaY9o9NECgCQ=;
  b=NPnDTpv2kbgJaM8todFFx/AYkVbOR4GPz/+hCuRG67FX/EvloheQ57WP
   Si0Acdvb0lyHj16hpk7v5kr+qh2azP2hyJchtL3DXAATEB9y9x5b3oFr+
   sbFZrRvlTaNHAqDaS9KZ7O+Pq2t6vp9zwFKZUHWKX9Yh4h3kgu/SUJLY6
   Ui5QvJoJUw+kqtUO1QufZDTS/XBwM2t9pH2Ye8FKN4BuXBYTroGmXzetp
   dicb60HE3PkEcyZiCkMt+heHmadMpBeVWdIu05qhq75FMPcMOYmJWYQ7U
   7NSlJvYpu5wirV2/T6bjtn2Q6Ysp1rMvxu9vYjI9EaLxxwpT3gBcS6g9u
   g==;
X-CSE-ConnectionGUID: N0La0jAIQfGeLJZmU9kHig==
X-CSE-MsgGUID: +8fNomYVTXCZV+lxxgY3sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="89814152"
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="89814152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 07:34:46 -0700
X-CSE-ConnectionGUID: Jjw6567zSRuVhT/U6TShfg==
X-CSE-MsgGUID: D4GUqE60TgehhRukj5nAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,196,1779174000"; 
   d="scan'208";a="290535833"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.108.36]) ([10.125.108.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 07:34:47 -0700
Message-ID: <f4c87fcd71ac8226edec3b2fcdb30988573089f0.camel@linux.intel.com>
Subject: Re: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "grayhat@foxmail.com" <grayhat@foxmail.com>, gregkh
	 <gregkh@linuxfoundation.org>, Zhang Lixu <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
  linux-input <linux-input@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Date: Fri, 31 Jul 2026 07:34:36 -0700
In-Reply-To: <tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
	, 	<e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
	 <tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-31 at 09:46 +0800, grayhat@foxmail.com wrote:
> Thanks, +Lixu noted.
>=20
> Corrected tag block:
>=20
> This patch was drafted with AI assistance.
>=20
> Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
> Assisted-by: Hermes:kimi-k3
>=20
> Let me know if you want it resent as a proper [PATCH v2].
>=20
Yes with new version. Add Tested by tag also from Lixu.

Also some suggestions:
- Avoid top posting like this, you can add this part just after your
existing tags.
- If the patch is long you can trim

- I think you use outlook to reply, there are some suggestions of email
clients and other suggestions.
https://docs.kernel.org/process/email-clients.html

Also some other links:
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html



Thanks,
Srinivas

> Thanks,
> Shen Yongchao
>=20
>=20
>=20
> > +Lixu
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> > On Thu, 2026-07-30 at 20:25 +0800, Shen Yongchao wrote:
>=20
>=20
>=20
> > > The HOSTIF_DM_ENUM_DEVICES response handler takes the HID device
>=20
>=20
>=20
> > > count from the first payload byte of the ISH firmware response
>=20
>=20
>=20
> > > (max 255) and stores it in hid_dev_count without any bounds
>=20
>=20
>=20
> > > check.=C2=A0 This value propagates to num_hid_devices and is used to
>=20
>=20
>=20
> > > index five fixed-size arrays in struct ishtp_cl_data
>=20
>=20
>=20
> > > (MAX_HID_DEVICES =3D 32): report_descr[], report_descr_size[],
>=20
>=20
>=20
> > > hid_sensor_hubs[], hid_descr[], and hid_descr_size[].
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > If the firmware reports more than 32 devices, hid_ishtp_cl_init()
>=20
>=20
>=20
> > > writes past all five arrays, corrupting subsequent struct fields
>=20
>=20
>=20
> > > (including work_struct members with embedded function pointers)
>=20
>=20
>=20
> > > and potentially adjacent heap objects.
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > Clamp hid_dev_count to MAX_HID_DEVICES at the single point where
>=20
>=20
>=20
> > > it enters the driver (process_recv, ENUM_DEVICES branch), which
>=20
>=20
>=20
> > > covers both the probe and the reset paths.
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > This is a data-validation hardening fix: the ISH firmware is
>=20
>=20
>=20
> > > within the platform trust boundary (loaded via CSME).
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > This patch was drafted with AI assistance; the vulnerability
>=20
>=20
>=20
> > > analysis and source-level verification were done manually.
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
>=20
>=20
>=20
> > > Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
>=20
>=20
>=20
> > > Cc: stable@vger.kernel.org
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> > Missing
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> > Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> > Thanks,
>=20
>=20
>=20
> > Srinivas
>=20
>=20
>=20
> >=20
>=20
>=20
>=20
> > > ---
>=20
>=20
>=20
> > > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 ++
>=20
>=20
>=20
> > > =C2=A01 file changed, 2 insertions(+)
>=20
>=20
>=20
> > >=20
>=20
>=20
>=20
> > > diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
>=20
>=20
>=20
> > > b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
>=20
>=20
>=20
> > > index 6d64008..XXXXXXX 100644
>=20
>=20
>=20
> > > --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
>=20
>=20
>=20
> > > +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
>=20
>=20
>=20
> > > @@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl
>=20
>=20
>=20
> > > *hid_ishtp_cl, void *recv_buf,
>=20
>=20
>=20
> > > =C2=A0				break;
>=20
>=20
>=20
> > > =C2=A0			}
>=20
>=20
>=20
> > > =C2=A0			client_data->hid_dev_count =3D (unsigned
>=20
>=20
>=20
> > > int)*payload;
>=20
>=20
>=20
> > > +			if (client_data->hid_dev_count >
>=20
>=20
>=20
> > > MAX_HID_DEVICES)
>=20
>=20
>=20
> > > +				client_data->hid_dev_count =3D
>=20
>=20
>=20
> > > MAX_HID_DEVICES;
>=20
>=20
>=20
> > > =C2=A0			if (!client_data->hid_devices)
>=20
>=20
>=20
> > > =C2=A0				client_data->hid_devices =3D
>=20
>=20
>=20
> > > devm_kcalloc(
>=20
>=20
>=20
> > > =C2=A0						cl_data_to_dev(c
> > > lien
>=20
>=20
>=20
> > > t_data),
>=20
