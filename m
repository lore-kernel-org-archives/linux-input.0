Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437935C6A5;
	Fri, 11 Sep 2026 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136551; cv=none; b=JmzPyttC3VJYMP6M0WroWdIIKslrZu/oNc1QumSb9lZBhvbCndqPTz1jy1YufREzkBh8HvhxqDwbd9rYWeQ3Vyz6xE4weISi0QCFe3izfLf5YUFc99OiiOj4QtSdmt01m3yNH1ciGwwaZDsW8yPsMHpfy5+ZmPuildCFwUc9D5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136551; c=relaxed/simple;
	bh=uWOrzaXvG2Yf89CBRuN2sB9GRYTs5OY3PS9d+qNCzcA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OAz5DgZx7SjdGSSEJKayZCojW1rrqp7vmxJgU03v9vdsH1vuNIIVbwgCguPCx0nFcuysqI+6JifRbFar1qjTiM+iJLDI7PU50k7JZBTFo4rbJFTbLpxBXOQyTy1dCUQJPujLziSAQi6ebqviWpUdxx9pFYgprS7oLcr2G9wVwYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV2EBE5Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV2EBE5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33791F000FF;
	Fri, 11 Sep 2026 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136550;
	bh=VgnRZ70Sbk3i9nIYZSSl0brf7pmFUJLQBruWGNhTJ9s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SV2EBE5ZDfnu91xo0OWyKwvZltlMjBN/gU5HAxRA5Z5MJAVgomEnHZA2IlVR4TySn
	 CMGTKdLpThiWoCwn4FCffBstPdLRgrlj7cSXliZcniCa5Cr1XEH2GPeB32RIT6ghPn
	 6R8dzkVXwltJmuAo5hCCBiJ8pbsFltoNwvP/Dr44kIGG3RBUZvE4DLdPZlMvVZ1+I+
	 8/PFiuN6DMrCSFzZa21m+RY7WROeOclCPneehtU51i2ZoM1SbnRej+PyYXKvcSty6I
	 q4FsnmICnfX4XR83oJLMPz9v7r1aq3ipzsh/D+Lz1avVmWQoqIBW8Qj7orQgxXd+Cx
	 fvew2bUQkAlPA==
Date: Fri, 11 Sep 2026 16:22:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Preetam Sundar Das <daspreetam4@gmail.com>
cc: basavaraj.natikar@amd.com, Benjamin Tissoires <bentiss@kernel.org>, 
    sandeep.singh@amd.com, Nehal-bakulchandra.Shah@amd.com, 
    skhan@linuxfoundation.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: amd_sfh: Validate BAR 2 as memory-mapped I/O in
 probe
In-Reply-To: <20260815121938.1337631-1-daspreetam4@gmail.com>
Message-ID: <nr9p85pr-39r8-0r18-60os-p7958qq473oo@xreary.bet>
References: <20260815121938.1337631-1-daspreetam4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 15 Aug 2026, Preetam Sundar Das wrote:

> Syzbot reported a page fault in amd_mp2_pci_probe(). The fuzzer creates
> a malicious PCI device where BAR 2 is defined as an I/O port rather
> than a memory-mapped I/O (MMIO) region.
> 
> The driver previously assumed BAR 2 would always be MMIO and blindly
> passed the I/O port address to readl(), causing a fatal page fault
> when the CPU attempted to read from restricted memory.
> 
> Fix this by explicitly checking the PCI resource flags after waking
> the device. If BAR 2 is not an IORESOURCE_MEM region, safely reject
> the device with -EINVAL to prevent the panic.
> 
> Fixes: 4f567b9f8141 ("SFH: PCIe driver to add support of AMD sensor fusion hub")
> Reported-by: syzbot+4eadd4dfe9e66522bae8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=227a9acbe565367eb7a1277b47115df8706d9a12
> 
> Signed-off-by: Preetam Sundar Das <daspreetam4@gmail.com>

Basavaraj, can I please get your Ack/Reviewed-by on this one?

Thanks.

> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index 4b81cebdc335..aef105a81570 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -451,6 +451,9 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  	if (rc)
>  		return rc;
>  
> +	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM))
> +		return -EINVAL;
> +
>  	rc = pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
>  	if (rc)
>  		return rc;
> -- 
> 2.43.0
> 

-- 
Jiri Kosina
SUSE Labs

