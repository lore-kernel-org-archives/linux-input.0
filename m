Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60F349CC9;
	Thu, 21 May 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374750; cv=none; b=LzSaT/TiaM0hcs+wPuYp9NxoRWh2cJ/wtiUSywcIWDSYa4cRvEGQMb2qo3CMKR1uBxtNRfNRp0cop0mv6ccGDhMBER1WRY6UVFUw/f9CmN0W8tw1zXgmz1huY3qaWjYjKvw/c+fvqPEUdfp3E2HZ9lsZuu9tIMfNmR0kLYn7b2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374750; c=relaxed/simple;
	bh=OWx+VqLxLnccn0uehrQRIR6uazILacnd11D89d4UWw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZoGba6dAk+wUuR5ws9Gubl52uDoqNkPXuZoqxsukmBAP8SJACYFHgUhd6nlVxZNQJNdNKgm1b9TWnUZJzUOH9HmaKgPyox4qlbZ7NGEAOdrMOJnTCjDf47lANXJmpLMUYEEGfkOh6VbDet3Ju0MnBXBiV6KZo3LstjkoW+ZhQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMdnDSDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMdnDSDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ECB1F000E9;
	Thu, 21 May 2026 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374749;
	bh=GW//fLAZT52wRl0rYe08D8pqMHxafbzouEPOK1euvTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aMdnDSDbK3NbrVlk9FcYdHVylMlSm2mQVyC12ceA2799ek9s97W2TgQD5KEiSdmHP
	 41/9YwzFjAX+O60grxk1kR8ewBnvNaPFcyxQWE3mCCo7oVZgLft/Pmvn+Xke5ZrNrG
	 tQX0aqL3bzj0tjAyIUub/vOn9KVcJtqU4WhcmvCl3pzUTrlzVjD2cz3L7NBJNBMRHh
	 wHYKWNcKdS9wcrlx7J7hcpTmdvwiyHpUreULylqTh+wjihF++g7jnO227Lz78a3GCa
	 wvyc4VVKZI1PExVhkLGeIIoKoVCxR8F/Jdf3sq8RKtfhHIN3gn19opTFNGp3C6RdlQ
	 7AO5C7AxwBVwA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260424-u2fzero-probe-urb-unwind-v1-1-mhun512@gmail.com>
References: <20260424-u2fzero-probe-urb-unwind-v1-1-mhun512@gmail.com>
Subject: Re: [PATCH] HID: u2fzero: free allocated URB on probe errors
Message-Id: <177937474841.1109683.5109909022580410173.b4-ty@b4>
Date: Thu, 21 May 2026 16:45:48 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Fri, 24 Apr 2026 22:21:31 +0900, Myeonghun Pak wrote:
> u2fzero_fill_in_urb() allocates dev->urb with usb_alloc_urb(), but
> u2fzero_probe() ignored its return value and only freed the URB from
> u2fzero_remove().
> 
> If LED or hwrng registration fails after the URB allocation, probe returns
> an error and the driver core does not call .remove(), leaking the URB. A
> failed URB setup was also allowed to continue probing with an unusable
> device.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: u2fzero: free allocated URB on probe errors
      https://git.kernel.org/hid/hid/c/2e78b21864dd

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

