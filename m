Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B5423774;
	Mon,  3 Aug 2026 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779273; cv=none; b=t+ckowB7kZv6VrN83aFTJnZLrHqAJnKrXkmyS6UUPH9g8GxWrCO/Rqp7zZZ7eKZHeYfgOl+p93/ReDVYwj0ZFoIo5o8JhYI4U4uA+xltpByGVmsOKsb25JMfhybRPERiJi5TyLHBGni3x80ckgyR1xIk5Iy7a4qyNwW6bZdFM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779273; c=relaxed/simple;
	bh=i+hU5fqU2W0gylC1ftXGBbGUg8vvcP7obRyDv8hkUns=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r2oBSHTQLF+GbeCfnQavNlfIhYyDMm+5DW+rZLLzN60jiqBSlkbnHB1KtiARYIR65FAlFh2dxx7iHFxAOKKJk4hQSJpxPz0PSBuxlHQoM0EPPILlYX6iOFQQffqCzw1Ikl2cUSRcJWUF6Bu4uQ/L5KdfRMPwwBDIEtCQ5xlJ0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVTGQ5RF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVTGQ5RF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0541F000E9;
	Mon,  3 Aug 2026 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785779269;
	bh=2AsbDoCIumgKqQYZ/nuNuS8hloxzjeqZAFgMjT01IVo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PVTGQ5RFjwhV9aFF+wWQ7xI+ROFyhRBYVblebxVdYSwec8rUH1Oys/954+FaqI+pD
	 80mA8m/2fgUBwngrsamqkuIgLUf64nJRlzMKmyFUbzt4FwiB0sLSnsLBskUB9IoAfY
	 Kx9beM5sfqMmGkcc04ycJ8pSHDLEDwhKw/eaMKfCz3FnQEFzDajuCaVYgmXlaDuZ5f
	 mvQuBxE9eH+HNM76ag0/pXGHR+R+MeYQCAhLLG1JgiurmFR9s+xVKk811tirEbi9NN
	 yd0QcjeiqvwgrLc7qY/wrrZk2id53hcKZorqL1rJHnXm4aGY1jwFBq66APqspSelnk
	 0wfkrEdLQ2+Zw==
Date: Mon, 3 Aug 2026 19:47:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: rmi: check report length before trimming sentinel
 bytes
In-Reply-To: <2026063007016439.1-ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn>
Message-ID: <9p90o702-so88-p21s-7s46-r2s193r5nr5s@xreary.bet>
References: <2026063007016439.1-ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jun 2026, Pengpeng Hou wrote:

> rmi_check_sanity() trims trailing 0xff sentinel bytes, but its loop
> reads data[valid_size - 1] before checking that valid_size is non-zero.
> 
> Reverse the condition so the length is proved before the last byte is
> inspected.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

