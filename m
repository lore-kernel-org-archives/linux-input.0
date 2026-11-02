Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654076;
	b=JJahtrVm5xlKC4+e+92jLJSYs8U7Ho6lTPaOdTMxJGMvDgiEPHfpomLp2da4AI+4U4r3
	 Ua0SrkngeOLeLewLHqBE1k29puZDTQSp/cPCKlOP92xqqVchc9V15TTYhmu6UJgXEScAr
	 VTgyiMLIYRnNfhZ5ElSNxmgc11dMVSGYXZRw3ZHkpQeIO5AKXp7Nojotd0ol7vm5yYRUq
	 EK+/aCuZgFrYWhc783cPBBgsY3RqJl2wE4SfTF3NWwyiuPcBJgxRyt9IUAfmOPaLNRkTl
	 QFMCkXfVfaQRRpYz0wESrR+GPdaeLuOJGDYsUUbrnsp+O+yBJnero7hJWCiJoaRba2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654076;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=e/MGsEabL/7GG396Jx8SjaCfwMIwyJ2tMCUpq+3DLDI=;
	b=hfZ4EWAeCLjTfliemugzI3VLkkJWNsm48mH7WuPBT9sfEu+xU/HjpNiVwxiDUPvGjRiW
	 HwVQwretsqOCTBD4Ev283nXttVF+WrOlpbozRa0PiMwWd6WK5/bd/Dmj6oJYTmi1eAhVC
	 Sx48fxOYWZjSHFpNzXGp15HFAm5QkqdfDSB/yNGhehOVLvsOKJH703F8WjdERUrjaLzlr
	 obRs/23FCj4lgH+0sotUBAh23jEw3mfHSOoDBUKcE0DX6clwKuJq1QxlyHCM4fWof3K9M
	 UJSZIxdvCTsXYdiXAy3xpXpPWgZpdc8VmYdSwxvViiRxtkUd9eQ93JWSpe5g1vzJvGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2OLFE46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5519606A33D;
	Mon,  2 Nov 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2OLFE46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FFF1F00A1F;
	Mon,  2 Nov 2026 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654075;
	bh=e/MGsEabL/7GG396Jx8SjaCfwMIwyJ2tMCUpq+3DLDI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=e2OLFE46TWKu5xklyz12ylfAApWKZbuHBOHbJd4znhtERP8z6pMgTnOEkR0yCqqrf
	 X0ZpIxeRlmWvAmyQE1zfgNegRkiz/UubbxC458xD4vJxAxkhweyZ+HBxeRFiQik0hK
	 +wEkAFlMdFp9HsCjiJFPZbKeeOwmN0SnZ5aHmLjB22Z3BdJ0oGBndBu3mtUx6S5oE/
	 tIdpACOgd6ZR4AXos/A2m04KYmJFV8XvlO+eyAdHJnBloO1fr3KqE20ddvUwAJAsQ0
	 ou2kTaLAFJf8XG/NKph8fFPzcavx2664UTYz2c3HH020DXXlEBK2jAFQFfsL593flq
	 hlsd3atef5CFA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26958F4006B;
	Mon,  2 Nov 2026 16:14:34 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:14:34 -0500
X-ME-Sender: <xms:Ov3oaudaRP85NzNgvo9gkP-MXfbogSw56-7TMRTbPKxIonQDu3IxHQ>
    <xme:Ov3oajASSRT1bTVfE6Yfylz-Q2cb5WzhItUIpzyOnYi4Ho9AOkdZT6HjOaX20rb4D
    9taQ97lq5DfA_nhyUWeMZ_W1taGbwO-fS7RiMfZ9u2zRLst3-ycp9NX>
X-ME-Proxy-Cause: dmFkZTEwFlNdOZMJt/6ERsMJpfliFwApaNUQtGyzrNgUVhL+xr6t4hflHpnCpvlDcd34OL
    tsnnvmlp46QcBNUANprPsj0jIeIkFlAHqmtQZLa2Sf8hNpQ9wBRFf1oo7j5UmVKMmxUPoD
    CAYsZ+irDyVCdEsc2qGBd+J6vgHB5jfhOit/H7yfEU9O3BgxuDkP6BIpzFQICmtidThPiQ
    wQ5iTjbCuW/m/r0nOijWyl7wYDNa5di+BmhLTsIvAVvDZmQjQEiKQbgS7OaGcQ8IrAe2iJ
    dzOrAPUicjvABQdhm6+s8X7yR3H/OnFcIOzSI3sa7nr++6wlo9Nr7XGUu9npauH3EjdnZB
    d8SiICjs57Bl5kCrWEBHfpiNyDf0VcOFdp1B4zP1lS/QTex+fDbly0ZmI6Oy2ConL4lGxh
    /glhXDiohYMGBeqhE1OFWto0WwZtKmCLBCeSZfL9MCPfURDGaHHisnCZY6kvsOFDvhaCor
    VZqgtiO/SBK/Y5QgrCdW3HFV3LwJ8YmbXP/DugUPUadgGyQm7Xhur0+oUAzHb6By+3knGi
    7OFiG2suqU+MsawnGTt3KtMcmomuas+uDRlvRDytGDwdPSUnJzYsk2KECbsMV0y2fBTHk5
    K+qTiHGAHJZkj+8vu51m+NPaw7fmZCNvqOYyO7NAnNI1SzeRX6rDMtnriOEQ
X-ME-Proxy: <xmx:Ov3oajAjXaAo0MCg-5mOh1kpmlpYdD2YfnidScMjdG05laxXGCBcug>
    <xmx:Ov3oavbaygWZIZ9DvVH6jb71mOGY1Ado5jGzZJVcQaL4VUVNzfnyLQ>
    <xmx:Ov3oahBfqIJHdV5qBhjnVnio35nQ6hlhJrYFiJZOCEftQWgDSSVQhQ>
    <xmx:Ov3oam6fLaNBtJqW2gtTD_ISnxMIg_eBjR3o4IKYsrM5dijacJsK8g>
    <xmx:Ov3oaokDgUdqdaNtT5fJJp84D48qBuDsZWPWAns4MbOuSRRfIzDAfjj->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5D1F78273B; Mon,  2 Nov 2026 16:14:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AnCeav_jaY2o
Date: Mon, 02 Nov 2026 16:14:13 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org,
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <f29a6aca-edda-465d-b6ab-9c7a5d7cddad@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-5-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-5-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 05/27] nfsd: factor out setting up the exports seq_file
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Move setting up ->private and taking the reference to the network
> namespace into exports_net_init() and dropping it into
> exports_net_put(). The procfs file needs them without the seq_open()
> and seq_release() around them.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>

-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
