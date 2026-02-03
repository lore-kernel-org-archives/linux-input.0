Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC626ED3D;
	Tue,  3 Feb 2026 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145606; cv=none; b=CfkiOk3TKGpwvlrp5XCjg2ffjlWBrFnKp1soiCiAug7NuRNsZgYCVuB3lPZccXOZKseEgMjaQ2b+Eh8LZSLAEk07HUzNH4tUqLj3HX5IV5WxbgeTpDFzg8ecQWWQ5v6Sbrtxmhd0T9xDH3YqnosMINgVEjWfKIWhXec8ZBVYfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145606; c=relaxed/simple;
	bh=TfKUms7FiS8wUoeSqDF3smXCfeZPbzr+CARofFXyjAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QQEYhmMzkN+GCA5+2w+RArn9Fn0bfKt8jkUy5HHJX9w1/EMzSRIH2vtnDAuN5DcT/padLX6VIoreWe6qlroj2PfTMKdn6lSQGIrp+X6JbfFRvf5MV6vKgqTmPOcS/SVfcnrkDGaIO2dwTKPxxtmm48L1c+ZiiJ60VIs6M6pQeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5qu+Bb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5qu+Bb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF20C116D0;
	Tue,  3 Feb 2026 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770145605;
	bh=TfKUms7FiS8wUoeSqDF3smXCfeZPbzr+CARofFXyjAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=g5qu+Bb6xsl4pbeeNG3lyeYT7FEW0/IKQTci4mPUSM3aDeSAebrMjDYM4Q9FSBiwj
	 SUjuynZCWYxzrNzpZNr1eq0I4Pf8wtUA8e9PJSX/RmgdDebPN4rbGw+/A4vrde1xrw
	 lyGjS+kZDUQYemK4ZyuVXypRdsQJ9aHMlnL0G1c+UvUutru35APJ6D7XfX84pcYnzA
	 zFb3mKBO/r12pQ99tnPrKx2HQef57oKa9RpM39FwXa1KsBW0pUaGHbZNjANBEhxI1U
	 bx1lr2sBc057Ck+8ZKkJBKGCan4Gej2WeQtDYv29fqk4igkockmoiZ2UgVKmroD2h+
	 7s4XQbTVp/3Rw==
Date: Tue, 3 Feb 2026 20:06:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>, 
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH v12 00/11] HID: asus: Fix ASUS ROG Laptop's Keyboard
 backlight handling
In-Reply-To: <20260122075044.5070-1-lkml@antheas.dev>
Message-ID: <92095q4o-n2o1-p4or-n238-o1ro83616o37@xreary.bet>
References: <20260122075044.5070-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Jan 2026, Antheas Kapenekakis wrote:

> This is a two part series which does the following:
>   - Clean-up init sequence
>   - Unify backlight handling to happen under asus-wmi so that all Aura
>     devices have synced brightness controls and the backlight button works
>     properly when it is on a USB laptop keyboard instead of one w/ WMI.
> 
> For more context, see cover letter of V1. Since V5, I removed some patches
> to make this easier to merge.

So I see (because of the conflicts in linux-next :) ) that this is now 
sitting in kernel/git/pdx86/platform-drivers-x86.git with Ack from 
Benjamin.

Where did this Ack happen? I don't see it neither in my inbox, nor at 
20260122075044.5070-1-lkml@antheas.dev

Thanks,

-- 
Jiri Kosina
SUSE Labs

