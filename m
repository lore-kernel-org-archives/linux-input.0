Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69420380FC3;
	Mon,  3 Aug 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777371; cv=none; b=AytpGJLa9lI+XKyslhiChRQpuFUT3wWs4/h5dyXPHPlkonbMX/PI0mkW074QVJQ2OUsb46aEpj8JYTPXEXAbrWVqaI7NfBn7jVILKO9YEUJC0zotzs9bhDVg0DlSQ4RbH89Kv6C8sh/MzLCLM4J2dZf7Cgvio3a+NELn7RPvm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777371; c=relaxed/simple;
	bh=5m+iPAqq75hv7VfUFvXPO1ogpuOGUQYXbxc6zf+FcDI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RzsxDoA6lTzJwXNSitp+1c92cCK7QWlNm71RgqyRXjBh6U7XLavBkwx181G+Of7lFVKsGhIEFobYJ41mhdBoEbRxMbJIfCyZiejjYe2Ns+zelTfRVQ8bmUCI3FElEqd1+srelQ7W6eG5BhGZzHBqh8Y+/63ZdSiMoaufd+pvlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJGg7rJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJGg7rJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B421F000E9;
	Mon,  3 Aug 2026 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777370;
	bh=XV0LqaRs52swoayCHZPcZPLugQUXbiDRfzkvm1W5VV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=oJGg7rJLQkOS8tldMWTLeojQUqhrxQb58duO69lOzryS69pN7e3CrKYgY3Qf+o8IS
	 gKS0W/augEuCtsV32Pj3aV2jvb9B0GB9hmuQmkKvGmeDDcfqyI85111lalLLn5ZFqQ
	 5nS5fqIQYYBscRp6m6M7Omn37ESXLlhMUkW73V0EOLvJpTaMyASMIBIJvVlLNaJ9nh
	 x6QclWxJ2a/RjEAL44T4jIvuxWX66vwnj+kzQkiYe47sxtMbqPhkbzsj5cy4RRCTd0
	 xTyyIr5aITz94OWrnZyUSbgYQGsWc1b1nLeZYlbrc4qvHMthgNbQEBQmYRe5Rpp44Y
	 JCUBptxAP06xQ==
Date: Mon, 3 Aug 2026 19:16:07 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
cc: michael.zaidman@gmail.com, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ft260: fix SMBus block read protocol handling
In-Reply-To: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Message-ID: <4onpr0o3-1794-3213-9o52-33478n727rps@xreary.bet>
References: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Raman Varabets wrote:

> For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
> data->block[0] + 1 as the read length. But on a block read the byte
> count is supplied by the slave as the first byte of the response;
> data->block[0] is not initialized by the caller, so the transfer
> length was taken from stale buffer contents, and the count byte the
> slave did return was stored without any validation.
> 
> Implement the SMBus 2.0 block read protocol properly: read the count
> byte first with a repeated START and no STOP, validate it against
> I2C_SMBUS_BLOCK_MAX (resetting the bus and returning -EPROTO on a
> bogus count), then read exactly that many data bytes and finish the
> transaction with STOP. This keeps the whole sequence within a single
> I2C transaction:
> 
>   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P
> 
> To support issuing the two reads as one transaction, teach
> ft260_i2c_read() to honor the caller's flags instead of always
> forcing a START and unconditionally appending STOP to the last
> chunk: START is only emitted if requested, and STOP is appended to
> the final chunk only when the caller asked for it.
> 
> Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

