Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEF118C02E
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245423; cv=none; b=lQLBE84DGrs4X4V+AjzPJAwNS6UccgVrDG+sRvBhTic/iODBE+r5g/6320uvLhSnUoGSv+nmpcWp3AhEp8fgSxA4buGp/cltOPde32geg6hrJqTsm51RucWUdwt7gehxyiKj3h9vsbWnCPyW2DpT3lzmmR+3vcOss2fRjfv6dTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245423; c=relaxed/simple;
	bh=8BRSIfNuxasrs+np4/zGL0jN85kmQfFIyqaMO8Ngz6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAploj8PLwsjoKhXk9Ccmtbl//aVNNiwnwzZSUmE4cfU1piUic+O9d2xkiwK/h0FdkH/t16/CoxyU4Exaldcb8oXZklj7ffGQr14uuN/uOiDMeZ5Q3r9zmmP4VWaiehj4QNJqNbbParL8911O8p5t/VHMHk6LWfmW1gwkp5qwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W5iiCME5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W5iiCME5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EDC2BCB0;
	Fri,  8 May 2026 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778245422;
	bh=8BRSIfNuxasrs+np4/zGL0jN85kmQfFIyqaMO8Ngz6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5iiCME5SxssVVyErsOgt+4n7fqykccteYL5YGDVYp2qc6HH/YHfSGEsXAZFPv6ZC
	 IpXh1v8VBHa/ZsQ3rTRMIFR+l0f7FfMc1qvhmoH2oVdkWycwVmfkA/+MgZnLUmvBXa
	 mZGtk3jspLdat/BxJYO6yl92uDRlLlu9DgbfpVbA=
Date: Fri, 8 May 2026 15:03:40 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "nsa@linux.do" <nsa@linux.do>
Cc: "gupt21@gmail.com" <gupt21@gmail.com>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [RFC PATCH] HID: mcp2221: bound I2C readback copies to the
 receive buffer
Message-ID: <2026050806-repeal-unpledged-4cc2@gregkh>
References: <KL1PR02MB68008465E12BC2D8449F3D6EF73D2@KL1PR02MB6800.apcprd02.prod.outlook.com>
 <2026050815-guide-skater-a292@gregkh>
 <KL1PR02MB6800676A9E8DCB6454F59B6DF73D2@KL1PR02MB6800.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR02MB6800676A9E8DCB6454F59B6DF73D2@KL1PR02MB6800.apcprd02.prod.outlook.com>

On Fri, May 08, 2026 at 12:45:44PM +0000, nsa@linux.do wrote:
> The MCP2221 I2C readback path copies data[3] bytes from the incoming HID
> report into mcp->rxbuf at mcp->rxbuf_idx:
> 
>       memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
> 
> The current checks only reject a NULL rxbuf, a negative rxbuf_idx, and
> chunks larger than 60 bytes. They do not verify that the reported chunk
> still fits in the destination buffer for the current transaction.
> 
> As a result, a device response can claim a chunk length that exceeds the
> remaining space in the caller-provided receive buffer. For example, a
> 1-byte read request may still return data[3] == 60, which would cause a
> write past the end of the target buffer in the unpatched code.
> 
> Track the receive buffer length for the active transaction and reject
> MCP2221_I2C_GET_DATA responses whose chunk would exceed the remaining
> space.bang
> 
> This seems security-relevant to me, similar in kind to CVE-2022-50131,
> although it affects a different path.
> 
> I also validated this change on a Raspberry Pi system with an actual
> MCP2221 device attached, where the oversized readback chunks were rejected
> and the original out-of-bounds write path was no longer reached.
> 
> I am primarily approaching this from the vulnerability research side, so I
> would appreciate maintainer review on the overall fix quality and whether
> this is the preferred way to address it.
> 
> Signed-off-by: Lexpl0it<nsa@linux.do>bi

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
