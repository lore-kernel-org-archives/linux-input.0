Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318414A60F;
	Fri, 31 Jul 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785474579; cv=none; b=TvMBegSBb4AAZ8iDJbWU6/PhGF8TZp8f2IMBsfSmP3vDWM4Aun9ejco2cTCpsWfpjQxliU9DhOPjolz9Q+X+85MBEvYlei31pw2xAMIgjPatHea4+n9b79m4dXkJUKIrykEIrs22WFCDcwSA7kw6qsCV2v/X7z7aMvwBYA8bZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785474579; c=relaxed/simple;
	bh=X2k00kQ78eLBXt9q8Z13YrdeXrxeJVsYkFR+alya+iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRfcXPoh2SzRUGF7T2etdzAxTp+awWcHePdZMwn5/NcTsfL8j4G/PNsk6aSBfvlRjT2c1KV0rPZiuyrCZkm1ULOL9QUemjqxscUHRehK5LWZ/qCxjoYKYB3emeBNnQpAci2N2TaOxSBayKM+DxLJfg70AZX/OHYMfteVTT9cAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeGGp/Cg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeGGp/Cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDC91F00A3A;
	Fri, 31 Jul 2026 05:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785474577;
	bh=SZgJXJn3KA307tOVFpI1XD6SpSHHyiawkgmlswbYtJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DeGGp/CgLdyUoyV26F1OMRGkAov9PA9DhD9hhj0PsdGzaPkf42eHV+zZzUTFPAKxb
	 Ir76rj2JiiArjLf9thAINkgxTQKEaICchptkhyaAkK5Vkjuav/j3XW0NgpDtAftIrq
	 2FoXfowAxyr4CFp0QKeofUjTd8JJrj8VREN3IEuQ=
Date: Fri, 31 Jul 2026 07:08:10 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: "grayhat@foxmail.com" <grayhat@foxmail.com>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input <linux-input@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Message-ID: <2026073157-stoppable-countable-db2d@gregkh>
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
 <e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>
 <tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>

On Fri, Jul 31, 2026 at 09:46:43AM +0800, grayhat@foxmail.com wrote:
> Thanks, +Lixu noted.
> 
> Corrected tag block:
> 
> This patch was drafted with AI assistance.
> 
> Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
> Assisted-by: Hermes:kimi-k3
> 
> Let me know if you want it resent as a proper [PATCH v2].

That would be v3 :)
