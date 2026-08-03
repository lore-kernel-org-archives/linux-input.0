Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5E30F7FB;
	Mon,  3 Aug 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778178; cv=none; b=NWSpGeFJet/4NBqs6m0CgnzwLvpG8Pp4Fa7GXcvanmvpFzrGtMc5TLfivpOIqMfwINW04NsNAi6CYGz61hhpRbC/xxelwNmjnpUebpPeNHz7O0V67oKQB5lX02EOx1yqdwOsLXPNU9+CE4JZCc5FaR9Tg20K9v+0ekHhxr9lgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778178; c=relaxed/simple;
	bh=vMq2ri0zcsx7AjfcJi7wb/+8Z+DhFKaz41Ure7KRW+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DG7USnCmWCCctw1+p289w5sny8ZMgnDbsmeTWeepQTq+CvmdUUQNN0k6MBz9QTyHS/6kUqPXPq6MiYCb73SfcbHRRjii4/9wpiLA7SdViWaEsJlYCeQmaECYPgTfe4yi/jWjGa+zPm5nA7iDvI2MPEC+JLQ8jKxfRIUhYjPJpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYj4DGU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYj4DGU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6471F000E9;
	Mon,  3 Aug 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778176;
	bh=oPA1bswAouQO+ByxL/N4UpGEd0qJPAfXKi1qIBwi79I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=JYj4DGU//dgPMcK66Di0u/zdNKInwqw3mIXjlql7CoHnKI8IfTT66UDvvaQuY8CuF
	 APkT5cPoawfcyrSJik8elNv/ZXsb/gpXIa6AmjQz4bZnvkDIv/QlUWe33Cmnjzy79O
	 BWq1jDfOaM2oVu1TSnvuf1/N8EKaS2MkIgMZbNglMWhTCphi8MCTaMi82Z9/xUSadb
	 hG/r2L4gkS0j3kizaYQBPG7dM4ffIM2mFN+YuJob2cN+vrWe+9dbanJlMUEYzctsc2
	 C533Wyu4zFnWtb3ZdE85cSOAfivk96hITwJtPSui0qFnjBuMacjFwem3iF0XKvtIEG
	 ps0wKYpUFYfjA==
Date: Mon, 3 Aug 2026 19:29:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: return an error when response wait times
 out
In-Reply-To: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Message-ID: <q4r2rs1s-0767-14p0-937r-p5n8sn28rq25@xreary.bet>
References: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Jun 2026, Pengpeng Hou wrote:

> amdtp_wait_for_response() waits for request_done before completing a
> report request. wait_event_interruptible_timeout() returns 0 when the
> wait expires, but the current code treats only negative values as errors
> and returns success on timeout.
> 
> Return -ETIMEDOUT when the response wait expires while preserving the
> existing success path when the response has already been observed.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Basavaraj, could you please review/ack this?

Thanks,

-- 
Jiri Kosina
SUSE Labs

