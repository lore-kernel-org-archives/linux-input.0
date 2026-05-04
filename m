Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B33AB284;
	Mon,  4 May 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897298; cv=none; b=LF9TTI5lrrIIU8UpugiNwNeUhbqRY+AWTgepSwJEARZDjKz0Ry6DWgIsCYRq9r8vTzvx4m8zD3W+Mj5pAvgaWljVle47TTXHNkj4c0n+sMi9T66dfZIlefqS95Wn0LahHPkbEKnseBRO9+R90o+Cr6Nq0WkYpqcH2SH4PYlKbPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897298; c=relaxed/simple;
	bh=Z8SAKRyxI6dxznZ3TCO/2Fv/KBbA9puBSTqFnDS8k3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I103EwjNwSf9KZkf7906fsFFFJqBnLVlsSmq9embcyp8A065KqBJpC/iRPygwcNrU2TSqIYuEsj8sZ2MlRbbIAW4lUNFIjMFjCSTgtcQT4nT2CEOtpMfoI7l/c4EEPDrb5GK/SXVeRObs5lNtf7Enbsy2aKuc/uyp9amppL5yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NvIHflDA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NvIHflDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3D2C2BCB8;
	Mon,  4 May 2026 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777897298;
	bh=Z8SAKRyxI6dxznZ3TCO/2Fv/KBbA9puBSTqFnDS8k3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvIHflDAQxgoXQzHWBL7cbXJBPBKuZ3DuTmMyUvg1JfmWs8cEVcb1j+M6hnexMFGA
	 PS3HT7q5SRExAwCTt7mKCO5J4l2Bz8+IiaXucomFUdzvbn18PD6crq/3WW1ou+6Z4S
	 03KucJNKdVbSLzH1fvamxWdySvC6BfjS27KLuuHw=
Date: Mon, 4 May 2026 14:21:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, Lee Jones <lee@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] HID: pass the buffer size to hid_report_raw_event
Message-ID: <2026050426-roping-shrouded-af7e@gregkh>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
 <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>

On Mon, May 04, 2026 at 10:47:22AM +0200, Benjamin Tissoires wrote:
> commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()") enforced the provided data to be at least the size of
> the declared buffer in the report descriptor to prevent a buffer
> overflow. However, we can try to be smarter by providing both the buffer
> size and the data size, meaning that hid_report_raw_event() can make
> better decision whether we should plaining reject the buffer (buffer
> overflow attempt) or if we can safely memset it to 0 and pass it to the
> rest of the stack.
> 
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
