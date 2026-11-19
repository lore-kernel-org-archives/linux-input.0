Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120112;
	b=r+Sx6ow7hkDkQqQMKo9a+x1aQtvGQx7aEI5eyZbZr52NBAlykRior3GUAGr694bCpWCl
	 axU/evaj6PbHsub1mfFfFTx594IgaAjps3o1eedjXM5LzZiiTN97bdf5pslCKxzYLqAfM
	 tOLk246ALVgpn1DGEPly8Kw40RbrrSwuiFXyNu1ZFGSPVddJEpO5H9n8/iDZMtV6PWAAW
	 hTYwy6XqleeHSVVmvFcViMVOthTGULrZPaOAvb30/3wqbln8uHDWQg9wFYYDpNxA84YZ/
	 ZkBvYDPEgleZPXZh13Dv16T/VbaMjcOqJo7Y9OEs4kTMO1KEdog8hNJ7WaZrWN+tTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120112;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=LOXZwmai/ssHeC9/gnNk0xobJMHfMZCT7eqtQHAHiDQ=;
	b=zQc48w3yDdZEc+1Lr94WLkWxRpQGdXIS40dmVijj+DdkCmZazdDW1U+RZPDDQHisBUn7
	 WFVrN1UfVjLmFHWAYCeE8Hhmjz0SCijEgr9ATzp+DQ75oWYQLUGkCtFSqUunDueyxxdNm
	 yXbXyGWMNc1evhB61DOYCwYATIbrpihsoMhMs/f4LxA/JCJM6ZDv0MNL+mDOxYPLRQuhS
	 bDca13LBZKWXMflMOy/IMg9yi7wLrq4jHzUytZNi9XYLbZvFcBPcX8tyAwPioF0jJiEHq
	 PoYDrzv+TELzO2IlogWHbdfvfjmjeAKUqbUJv9U/Rj4ji6OoSY+/0VDCOxzgIRu28dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czdSkdMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30E606A325;
	Thu, 19 Nov 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czdSkdMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE6A1F000C4;
	Thu, 19 Nov 2026 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120112;
	bh=LOXZwmai/ssHeC9/gnNk0xobJMHfMZCT7eqtQHAHiDQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=czdSkdMumOAdJiBcJ7Y//KyBXaon88F+FcUreMAOR+nxjBkY3cl43+mWBcOTdMaK+
	 AAPXhfjPcZXTenau7cAjl7Z5qNFg5Yjyu1MPacihWKFbPPPdQputz6FKSpHa9ZdQNT
	 TkBVOF04rqgWT7AIeXHHRTVLc7KnylxRJ1aJxQr6mhe5doZRxcQmqG1UyKqRk3xiSY
	 qjUH3RKyXZo1LYkvD3eq2sOvT/+HgQhiTWHh32spCf1kspzZNBLg+P4Rl5hcighoFw
	 fEX3Mx+ChbXfULnfJS/PtUI7jY/DkWiuZCj14stdE8dn1gJ0P3XenMaksbLB/Lk76i
	 fjYCYGEEriAxA==
Date: Thu, 19 Nov 2026 21:28:29 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: disable the multitouch work on
 removal
In-Reply-To: <20261110043001.56615-1-mhun512@gmail.com>
Message-ID: <83r51qpp-968s-6pp7-682s-5n7po8q443p1@xreary.bet>
References: <20261110043001.56615-1-mhun512@gmail.com>
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

On Mon, 9 Nov 2026, Myeonghun Pak wrote:

> During USB runtime reset-resume, usbhid can call magicmouse_reset_resume()
> without serialization against HID driver unbind. The USB interface
> remains bound to usbhid, so this callback can queue msc->work after
> magicmouse_remove() cancels it. The delayed work can then run after
> devres frees msc.
> 
> Use disable_delayed_work_sync() to drain the work and reject later
> queueing. Probe initializes fresh work on rebind.
> 
> Found by a static analysis tool under development.

Applied to hid.git#for-7.4/upstream-fixes, thanks.

[ ... snip ... ]
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

This is bogus.

-- 
Jiri Kosina
SUSE Labs

