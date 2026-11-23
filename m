Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396633;
	b=GoToGowPg/jhpwtmC8Hq8s4hDIOkSJK07irX1rwk5CsCpzbX3ingKN2aRBDG3FbLIU7k
	 EgMChh6bfQbvN3WCrboE9cDqyOc3HrJjJZjK+ze4X7bfImpCieXdhfuF/jtCTbomwNVsi
	 Mpavs9hT0ht1RMZWig5V7nbnqS+obaNMOOh/snFj+1Jut40MW+X+xRQhPRmaR1IgVf5tU
	 s7OJIVDbXW18qT9W662PGjV6ubWFcFohWnDeXiTi9xIY/H9PstMNR8KL+Qxp1dwybA0B8
	 zzN7ypKoNxpXYsRfD84FEo41an3dIDlijUnx1dwNWIGL429Zf2nxnLh8nvMQ/oS3O3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
	b=hKa9CGX5509p0ajbHUqrQZn/Dr83Pp5+Uq04EeAoKJJbZhS+HCPdjnUwA8Zk/cSgEv9S
	 ctqAJzJSFONklX6Od7JluiyqA4uqVTZYGAZAJvwHToPhQCez24UHqIQUxb7eVOKIYjvj/
	 yDyLJOBRAEWkobufZOTC8DQd5Xdcsx/69p0GM1/bzMcACt9M63AA81/CXwkOLF/9bDZeb
	 U3yAnPKFByIcnW4Ul8hw1FTi08TSreEQBE3coQWhAjPJIHgRFb8+wx9SFIRuXJfjS9oUf
	 vjC3nhkmppE/NYwH+Edipw5z3SFPxgqitwZd9u6Vf15hFJbKMmC4utHjx9ZnR+uD51A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3oiXrb7;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87A606A327
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 01:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A87A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D3oiXrb7
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so3874961c88.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795396632; x=1796001432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
        b=D3oiXrb7ZmV6BWAyg9ScNT/pB4kPE7fyRC3Fy7kYNpwrjx3he5btiKZvcUhIe41p/G
         JhAEMuGmmzQPQd4cLdMi6Pji+ComVY+E5+WpVWCvDkb/KE2VjWuqoPzDYDw+vNYAoZHm
         vh9EZrh06QHbkwflnvIKtYD8TWxfbCB9hquDR+zecgKzlth6KSPemD9z+BExFCcES+5c
         mERpZRe01ozEDuHbKLe1TRWij5M38D8FHyCfRGJq9CB6LPzvK6hIlkzov7jmAe2JvRdQ
         +P4NMcO4Vox5Eh/HgYXXkOjWQ/n2T3ZWjhmWkYnLVc5+4WbXYzFcr3PblxFCJhAlcePW
         OtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795396632; x=1796001432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UgZ/UaOfprcYE1+TJLcwuO2nl1zM9v7WpMLhsF+tYU=;
        b=uh2nt4opzOeVLtxkkyudpzxwPV1o9PtngScEgM+JSckMEDVbThucobRyG143aaFiyc
         tA9SoIUGSPUUlppoxAhMRLd0F/VvPz3s6BT4ifqTPLv7zATHNyX9U+M/lITf+im3n/xk
         mB+cZXdaSu/2MlYg3QFL1O4BdnALS/1Rh8IwO/jkYTqg3Kvj9B6inwbU2ISsdVOb1rEH
         0F3GyOvKX4R9W8FFdpx3wfVSQUi2i1a1BKvNQRv3/PsksDbifj+AlOIRJnAN+ESfovl6
         eL9ffJI1Pcupk/KN+00dCx3hPQwvI9nsKOQUynhErWbd/wx47ApDvtWcGsnu7hH+3EZF
         R5TQ==
X-Forwarded-Encrypted: i=1; AL+hErEmEk2LNrh2bAuRXDtgYb9nrgJFF2EgeL3yamwKNUHh1QJfdflmSVgVQSU90x8vU/3S/7eJ9dG+gMc9Rg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IqT/LOZJC3PYLa4HM8dpwg06AzEn58irVgNFqVbUrihHoNz2e
	BAel2RyWNGzeq/Z2pIN91m07+ad1ndNLzJjrOJ+1JBWnZdMUGN8n9OiU
X-Gm-Gg: AZFdTZd7LzVsOU6LU/rwserXAuNPkDVmGmTb9k3ptmbP/G8B4BCWpNX7ZN29jZxzfxj
	EHWEAGY63SummpnRgfSHh4HxpNWBedeObg98Dqsozot4Q7vJQ4adsGA9p3S82sKEbYYBGHsmnl6
	uqdSca5zFqykUghitGw+S/nyYXal20/LTxRM6jkMJFZsg6hShlfU09VkEgxokM8EGqC98x3zfhS
	ccznnDaolXTmn0VTyn52/KPo5WCd3OYQZilX/CClB+bsp5c+kIL55iPk14zTTkSlXbxKMDp9NDa
	2u9ZEyNn1Wvd8UX9/tTydRWqe/WvXgzEKvYMmnhfTrAxyrNp6p4Q60wjGC69YL9T4kRWXskaRfA
	vQa7cWOs2ulNoYdcJukJFwcWX94k1ewUCPSaaPmC+1ON4UlbfzejUs7IThGl+aMTX6xZCpw1LER
	E2ife7pWk+t/WQqL8W0QWWRQVlKl3+nuVicC1K3jO41OGEugY0T3T6tzYW2kXcTDZcF4WsWQzLk
	TMuULqgtszawfNJqljBe3zajn3jlSRf/T4DexJR3P6/2JnR+4a+G9EqbEUq/m+4DzOPKpeAQ3Mn
	1BySN1+ugF7LyLFEBXLsVIARJRkv5Zz5vKPZ6l33mQrx3QND9vqbln6hWTKDBpAZds3JA1o=
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr16998658c88.17.1795396632411;
        Sun, 22 Nov 2026 17:17:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm23764321c88.1.2026.11.22.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:17:11 -0800 (PST)
Date: Sun, 22 Nov 2026 17:17:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Martin Diehl <m-diehl@gmx.de>, 
	"Alfred E . Heggestad" <aeh@db.org>, Thomas Reitmayr <treitmayr@devbase.at>, 
	Slawomir Stepien <sst@poczta.fm>, Jie Wang <jie.wang@intel.com>, 
	Manuel Ebner <manuelebnerli@mailbox.org>, Randy Dunlap <rdunlap@infradead.org>, usbb2k-api-dev@nongnu.org, 
	linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: remove obsolete yealink USB phone driver
Message-ID: <awOT9WG0ZdNkIm69@google.com>
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>

On Wed, Nov 11, 2026 at 01:57:21PM -0800, Dmitry Torokhov wrote:
> This short series removes the obsolete yealink driver for the mid-2000s
> Yealink USB-P1K (0x6993:0xb001) USB 1.1 Skype/VoIP telephone handset
> and drops its module selection from ppc6xx_defconfig.
> 
> The hardware relied on dedicated userspace bridge utilities (such as
> usbb2k-api / kb2kskype for the defunct legacy Skype desktop API, or
> yeaphone for liblinphone) to drive its keypad, segmented LCD, and tones
> through custom sysfs attributes. That userspace ecosystem has been
> unmaintained for over 15 years, and the driver itself has seen no
> functional updates, hardware testing, or new device IDs since 2008
> while continuing to attract syzbot USB fuzzing reports and drive-by
> cleanup patches.
> 
> Thanks.
> 
> Dmitry Torokhov (2):
>   powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
>   Input: yealink - remove driver

Applied the lot.

-- 
Dmitry
