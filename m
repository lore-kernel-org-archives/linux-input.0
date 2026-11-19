Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124782;
	b=xL6kMOQhBotHnDXddRiXTBK5ydN2OjXHavw5izFFSXwXjavEsPkb1qLNd+tQYFvclR9m
	 1WfYySOieKU9zqXWag0CAny91d/9uHWP+wcyuq48F/GCzRE0RDBoaKsy+5t+Pn3mgQM9l
	 +rGoS0DUuQ8/b4mMVRInxPJ+b4jTssduAo9hIXyCFZ9AFKqCCijQ+P2yZOBX1uUnmDQq9
	 qr1wJobahsZ/PM9YRX/26NRhYhfvPH46zHsgvOcNzQ/VYkN+7syzCAGourt3u+6oBVCm1
	 KHTMJbiOgCT4k/Y3h3i68/KKosD8U4qw6YOFBYvpwHwXT1FcgIPnH+EE1EzdGlgQo0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124782;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=8F0k1KhCHENQeh0NNoVpIWFSzNqGn2Cwj34Nt3DUq3s=;
	b=TCO+7IoWI3YI3MriyA0hXD34k0E22Qev7jMhqFdKJIrqQqV4NjrPTTTFRK0RR7LMjW0s
	 gSvZaDDL4YSNaan/OHn7OjK3o2++AJly01Kc3Tpox7JzCT1EWO2tI3ZEeSfdrHFKC0eze
	 lDiTxdBcxwyvjj81WNQclDkG9mQv3BVMdZTChjiOwYgPZ4IweETsjflLAQ8m/+rrXXwyh
	 m75g2LVDVeLBYRt/+BIQjdApUesMGXAlvZU9h1lSclQUrivMEtm5JkW8l4zXqRxwiwUbN
	 cCfE4YUXM8XndPLptZCcC8X1uTwWnzVVmN0Dn0FwG5D9BmCY9aIbFcJxSnmMcwA1hjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jj/hJxlk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA80606A326;
	Thu, 19 Nov 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jj/hJxlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FF81F000C0;
	Thu, 19 Nov 2026 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124781;
	bh=8F0k1KhCHENQeh0NNoVpIWFSzNqGn2Cwj34Nt3DUq3s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Jj/hJxlk3KtHWBNxJKT/eo/NOtnWDhroRptRFSw/ku0g0objOCJoLYhARUdtSKRUe
	 A+ZxPjTOlItuXpf1toxJ82dvAh/3EX8YNNxnVyO7w/WlPssEHpDJ5JZCKoRzVyiAje
	 sNHfihSLXHtSXRjFiznYc/zTDARG+IXLk1FejVqb1DBzzduYWz/S7MLojilLKrjHQy
	 4Vz9x7epvW4SGECbYqVYvwe0PgHyVFkI/OKUJfDk/FS6ya2778Ty1gCPDkypRvdfKr
	 cMCVTcDNXZiN2EUX6nFIsLK2lsO/ZLNFr1CQydMp6HTwkY5dg+drZTc6Sd2udjg1mh
	 Fg3OFG5Zd/LCw==
Date: Thu, 19 Nov 2026 22:46:19 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Devarjya Purkayastha <unseentactician27062006@gmail.com>
cc: linux-input@vger.kernel.org, ping.cheng@wacom.com, jason.gerecke@wacom.com, 
    bentiss@kernel.org, linux-kernel@vger.kernel.org, 
    Indrath <indrathftw@gmail.com>
Subject: Re: [PATCH] HID: wacom: Prevent NULL dereference in wireless work
In-Reply-To: <20261030173108.45408-1-unseentactician27062006@gmail.com>
Message-ID: <p743r626-05s1-qnpp-ns72-6r2686p38p69@xreary.bet>
References: <20261030173108.45408-1-unseentactician27062006@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 30 Oct 2026, Devarjya Purkayastha wrote:

> wacom_wireless_work() assumes that the active USB configuration has
> three interfaces and unconditionally accesses interface[1] and
> interface[2].
> 
> A malformed configuration with fewer interfaces can therefore cause a
> NULL pointer dereference in the wireless workqueue. Return early unless
> the configuration has at least three interfaces.
> 
> Reported-by: Indrath <indrathftw@gmail.com>
> Signed-off-by: Devarjya Purkayastha <unseentactician27062006@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 628372ab818a..dcf2811a5c48 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2619,7 +2619,7 @@ static void wacom_wireless_work(struct work_struct *work)
>  
>  	wacom_destroy_battery(wacom);
>  
> -	if (!usbdev)
> +	if (!usbdev || usbdev->config->desc.bNumInterfaces < 3)
>  		return;
>  

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

