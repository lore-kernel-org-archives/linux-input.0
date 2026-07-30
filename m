Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277912DA75A;
	Thu, 30 Jul 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415441; cv=none; b=nN6eNL88Y5KZWZ/WbYfkzq1pvtQsREvoVjSvsCP3jFnLIcC+aH5aV2fyHOd5OiD1Z/fVDmWiXGAAjulEW/wKA62JlA1wA9sj7PKAz3J/sjEdaid/DVkO7EpOAERxn28Cz6PMdffYRmf6+QUppdPaQNnmmgm6iQ6z7HHgMHbuZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415441; c=relaxed/simple;
	bh=W2pLEcMzbP1OatMb0ktT5/DoNbQoBQDiTNsrDJcfV1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW40W55vcUaALsS2wtUOkr7+B6eSmFsqyCHiEnmxZTEVW8YpFQblMwUfViq74pTCwkiYLBlmN4SWFKlJwOVYUb5bunJcLLNxMxflcXOL44BnEGvy/EKRDh3Jl8e3TUjHYDvcCGC22CBzhD6YlhGwxNuip3DtR7dl31lYcdxB6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XkXzB2pN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XkXzB2pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DFE1F000E9;
	Thu, 30 Jul 2026 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785415440;
	bh=tz6jbxrFS5/9BTMsrXgUXKKifYDHjG6sLwmmt7V2a3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XkXzB2pNAs2Z0jI4QiDUz8EQ1Q/F+qVctRdM9kphBaLVAejmbCFwiELcIbjWpTyYj
	 d8keSmQAIxY+4xhG2awJSeEga1Vs2eiomZ4pprQGAl2zespn94+V+EZ5zcu+wLyzve
	 Gkb9if4jZIRQQX+jXR+Z1eN3ahKb1Y27xS+UQDjg=
Date: Thu, 30 Jul 2026 14:43:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shen Yongchao <grayhat@foxmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Message-ID: <2026073030-secret-herring-1bc7@gregkh>
References: <20260730120215.226176-1-grayhat@foxmail.com>
 <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>

On Thu, Jul 30, 2026 at 08:25:08PM +0800, Shen Yongchao wrote:
> The HOSTIF_DM_ENUM_DEVICES response handler takes the HID device
> count from the first payload byte of the ISH firmware response
> (max 255) and stores it in hid_dev_count without any bounds
> check.  This value propagates to num_hid_devices and is used to
> index five fixed-size arrays in struct ishtp_cl_data
> (MAX_HID_DEVICES = 32): report_descr[], report_descr_size[],
> hid_sensor_hubs[], hid_descr[], and hid_descr_size[].
> 
> If the firmware reports more than 32 devices, hid_ishtp_cl_init()
> writes past all five arrays, corrupting subsequent struct fields
> (including work_struct members with embedded function pointers)
> and potentially adjacent heap objects.
> 
> Clamp hid_dev_count to MAX_HID_DEVICES at the single point where
> it enters the driver (process_recv, ENUM_DEVICES branch), which
> covers both the probe and the reset paths.
> 
> This is a data-validation hardening fix: the ISH firmware is
> within the platform trust boundary (loaded via CSME).
> 
> This patch was drafted with AI assistance; the vulnerability
> analysis and source-level verification were done manually.

Great, please use the Assisted-by: tag as the documentation requries :)

thanks,

greg k-h
