Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972C3164B7;
	Thu, 30 Jul 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434928; cv=none; b=WZtF5SgfBFcoVLoBaVBkiS0RqtAvuxnQcuaN52XvGcXUGBKgRaavRCurELAlSTE8DDXqrp3DqwbAUNwkL5+IqiYdyBg1IvMf/lgsAL4/ehtnJKu6buDp+jMS9SiNhm6wT6q5JTBXyL+dnEWPomcpO2a1cSK6znMP9kTkoDAkZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434928; c=relaxed/simple;
	bh=QKpVGzWRseZNbLmP+4Y0d5jtyzMQI6zZpTfMJ5vylxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzoOLxjF374Jcpc3TVIUuo5C4KIni6YeAOflX/H1QoH7j+vxOQMMdDUfDDsdPlIOpIrh0PdjUefEb88eCMcYvr7ajUWgU8TqExrzgzdv27XxHC03nKwBqtJQvpmo8cO1eWC65/gxAb7PI8yIHkoKoDGxDcYxhMmTo3sPN5vOJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJYWcSav; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJYWcSav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785434926; x=1816970926;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QKpVGzWRseZNbLmP+4Y0d5jtyzMQI6zZpTfMJ5vylxU=;
  b=GJYWcSavNvYoqj7pGsuc4qGWT6szf6FtBECxw3gT+t6XXvfGedWIWckT
   dF7PrV1tLXFRrVXUF1gUA9Syecpv8hqdb0jWuBw697KyUhalcIBBZzgq6
   J9+LETup3y/qBi9p/i71uMkayUx2XpCdjQ7STE19fpopcHeTQCNb9oNWi
   kUvzV5Dvq9UQzdK1DvCpLWNV4IZfzc/81xtCKzMg1tMiyMjIGKmFIKmay
   Y8KrJe5ysL3W/Xb3ixmLIHMdLwH95BvSrT2Rwo6vZ3ag9A9ZuZ/c+TDN1
   F6cr9odxYl7Poyb6R1050UotrB/oEE/ewk1YouhlQjieaxSgDbv5eVb48
   w==;
X-CSE-ConnectionGUID: 7rkBdcY5SV60HTwBLW26jg==
X-CSE-MsgGUID: vxzv7hgDSWysDd5yrDjM8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96420980"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96420980"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:08:46 -0700
X-CSE-ConnectionGUID: 7I2+h4PoS0KL8O5bAN8KyQ==
X-CSE-MsgGUID: BCBKXkpmTjuXSxRS/o2HFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="284961573"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 11:08:45 -0700
Message-ID: <8836d77de5c2de98876f49a866a7f149c49fff89.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator
 pointer arithmetic
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Shen Yongchao <grayhat@foxmail.com>, linux-input@vger.kernel.org, Zhang
 Lixu <lixu.zhang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina
	 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Jul 2026 11:08:44 -0700
In-Reply-To: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
References: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
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

On Thu, 2026-07-30 at 20:52 +0800, Shen Yongchao wrote:
> Since commit 63cafaf47a83 ("HID: ishtp-hid-client: replace
> fake-flex arrays with flex-array members", v6.13), the
> HOSTIF_PUBLISH_INPUT_REPORT_LIST handler iterates over sub-reports
> using a struct report * pointer:
>=20
> 	report +=3D sizeof(*report) + payload_len;
>=20
> Because report is a struct report * (not a char *), the compiler
> multiplies the advance by sizeof(struct report) =3D 8, making the
> actual stride (8 + payload_len) * 8 bytes instead of the intended
> 8 + payload_len bytes.=C2=A0 On v6.13+ a legitimate aggregated list
> with num_of_reports >=3D 2 drives the second iteration far outside
> the message buffer.
>=20
> Replace the struct report * iterator with a byte-granular u8 *pos
> so the advance is computed in bytes.
>=20
>=20
> Assisted-by: LLM

Need to follow:

https://docs.kernel.org/process/coding-assistants.html

Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]

Lixu,
Please give a test on few devices. Not sure if we have such device.

Thanks,
Srinivas

> Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
> Fixes: 63cafaf47a83 ("HID: ishtp-hid-client: replace fake-flex arrays
> with flex-array members")
> Cc: stable@vger.kernel.org
> ---
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index 6d64008f2..ba52e185c 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -74,6 +74,7 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0	int report_type;
> =C2=A0	struct report_list *reports_list;
> =C2=A0	struct report *report;
> +	u8 *pos;
> =C2=A0	size_t report_len;
> =C2=A0	struct ishtp_cl_data *client_data =3D
> ishtp_get_client_data(hid_ishtp_cl);
> =C2=A0	int curr_hid_dev =3D client_data->cur_hid_dev;
> @@ -280,9 +281,10 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0		case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
> =C2=A0			report_type =3D HID_INPUT_REPORT;
> =C2=A0			reports_list =3D (struct report_list
> *)payload;
> -			report =3D reports_list->reports;
> +			pos =3D (u8 *)reports_list->reports;
> =C2=A0
> =C2=A0			for (j =3D 0; j < reports_list-
> >num_of_reports; j++) {
> +				report =3D (struct report *)pos;
> =C2=A0				recv_msg =3D container_of(&report-
> >msg,
> =C2=A0							struct
> hostif_msg, hdr);
> =C2=A0				report_len =3D report->size;
> @@ -303,7 +305,7 @@ static void process_recv(struct ishtp_cl
> *hid_ishtp_cl, void *recv_buf,
> =C2=A0						0);
> =C2=A0					}
> =C2=A0
> -				report +=3D sizeof(*report) +
> payload_len;
> +				pos +=3D sizeof(struct report) +
> payload_len;
> =C2=A0			}
> =C2=A0			break;
> =C2=A0		default:
> @@ -956,4 +958,4 @@ MODULE_AUTHOR("Daniel Drubin
> <daniel.drubin@intel.com>");
> =C2=A0 */
> =C2=A0MODULE_AUTHOR("Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>");
> =C2=A0
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL");
> \ No newline at end of file
