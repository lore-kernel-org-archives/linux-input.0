Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34831717D;
	Fri, 15 May 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857775; cv=none; b=cTcKtaWl54ic/XoGiMUu3OLt53eWW/2xNukRgbInlUVzqLgdpmSmaYKAQy4d7bLCcq2N9PW0lEbX09paeo6CaZKFrgIB5diwrFMeS+1TqXgI/vwKDOPgXO6J3IGosaCfHwgOtzNu5wU2OR/qbnjrUji4Mm1O8MQyl595W/XKdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857775; c=relaxed/simple;
	bh=1Ol5z1sBHfv63JQkmTgsfnZLCmBCFp+8yvHEkAHOznE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOytzh4URd9f8z2vrq6eBymHAMdUcO13z8BDKPwTKsEIKls/MFHJK2pMO4MF2E555Oa6hJScIY456BihpGntwQ/uRa2FJ/6vzzZ1WG6U1PbXOO7LnM6+vvesTKKhs98IJY3mID/fH1x3IXfF39kWr62j8G/AzakgVcnSPDCg0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXB1fajG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXB1fajG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778857773; x=1810393773;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1Ol5z1sBHfv63JQkmTgsfnZLCmBCFp+8yvHEkAHOznE=;
  b=BXB1fajG9TPtoB2PmapphF2NSKYqj8yuUxV4fGSaxLydm5Okxs+Zofm7
   UQmzpU3l9wyr0RZ3QMw2wvzDP/+uHTQPalfq3ra5PBfwdcjandJMKDAcJ
   Fofg2eexb+lOz8pu7PfeCE1omkuolL8qswgkMuqDMZM4K2OdR4yVhwg4S
   tnIJ5569wUEkjXHGhLAOxkZq1lghBKmuQAwoAhkzvtn2UJGwh7YzD8Lv8
   TGu0V5fkXXi6OkCRv0p3QwdpOFPKjsIu+IA+dbPdOcXoLwfKhupS556K/
   e9RnS37j14rCiHJfxjv8qrPB0AE9rTR7nR+62wnGP8cit7nt+hR6+9z81
   w==;
X-CSE-ConnectionGUID: 6uCL/br8QMqkcCVpUQ+O9w==
X-CSE-MsgGUID: 2Obaew5TTDWUEneam0b5fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83671002"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83671002"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:09:33 -0700
X-CSE-ConnectionGUID: bLk46KX/Qw260Ndf1YMJOg==
X-CSE-MsgGUID: SUaDPKFYQZabVyqeCWbSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243692394"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:09:32 -0700
Message-ID: <fbc8c9659f707f46b5d8a6479fc42d5bb1d0efcd.camel@linux.intel.com>
Subject: Re: [PATCH v3 07/11] HID: Use trace_call__##name() at guarded
 tracepoint call sites
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Jiri Kosina
	 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Date: Fri, 15 May 2026 08:09:25 -0700
In-Reply-To: <20260515135941.2238861-1-vineeth@bitbyteword.org>
References: <20260515135941.2238861-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-15 at 09:59 -0400, Vineeth Pillai (Google) wrote:
> From: Vineeth Pillai <vineeth@bitbyteword.org>
>=20
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
>=20
> Original v2 series:
> https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth=
@bitbyteword.org/
>=20
> Parts of the original v2 series have already been merged in mainline.
> This patch is being reposted as a follow-up cleanup for the remaining
> unmerged pieces.
>=20
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index ed3405c05e73..8d36ae96a3ee 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -110,7 +110,7 @@ void ish_event_tracer(struct ishtp_device *dev,
> const char *format, ...)
> =C2=A0		vsnprintf(tmp_buf, sizeof(tmp_buf), format, args);
> =C2=A0		va_end(args);
> =C2=A0
> -		trace_ishtp_dump(tmp_buf);
> +		trace_call__ishtp_dump(tmp_buf);
> =C2=A0	}
> =C2=A0}
> =C2=A0
