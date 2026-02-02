Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E7363C64
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032518; cv=none; b=Hn7PIDWQ1SRb1uEkRRWEco2zxk9JnDosr0y8WDkxXNGttLaI/Dng1mhOzBu5l1AhWeSssfhDN77aDK3SSF+gip6mWCie19Yx7WaNryJY3MGiUw2Evj87EPV7WjzF/bcBqlc0nvedTVUnISf67/HuDZYXIIsuPydBmjkfrlokCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032518; c=relaxed/simple;
	bh=Wri3Uh18FbX7ej2fPcSzycrDklCJOhIqGh9Fr6avg5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VyAPKDTK52CMi7LMm4COaFYj016IZkVvjkXXNQfJLj9yMkalXlF+goam7Eo1sA6gil+Cybk3pc+Za9b8wGVp6E/Bv1ccDRtDEw0Edvt6+iXAG/rOu8AFPF1feaitN0GP9pVylI3fWHIEa3WM17bT1xUIQWo+c5f/lqOx3tvroEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCK/e5Fr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCK/e5Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E32C116D0;
	Mon,  2 Feb 2026 11:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770032517;
	bh=Wri3Uh18FbX7ej2fPcSzycrDklCJOhIqGh9Fr6avg5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mCK/e5FrHA+l1JxRai+4eOXTGWsP8MCnbo51RRJXiOaMSzUA/CF17VU2DWUbsNiJD
	 eX1YX/bL4Dwymmj7scx7Rzlp3y2sbPJdTjntV2DV4bf+ZL/dEsRF9Z2d+xRGU+7iGj
	 JGKKYwjzabr9v+Iv4/B5PB1DMp2dofUgL5hoLNef5dtdtW8XdCxst8zU/nUyn794CG
	 DnSmU9bLlG1zbKSuqkifa3CaEYziT+nPZqZji6QzwGrGS3BJAHRq3QwbGmlx0OTOD5
	 kvhQEipNOiMtQWgBsQxe0ZxiDU7GZ0pYW++UVTaR+Vp4yyBdHM7aFMJVwogQ5a48Sl
	 m1W5XoYxVZHVw==
Date: Mon, 2 Feb 2026 12:41:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: lyude@redhat.com
cc: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Bastien Nocera <hadess@hadess.net>
Subject: Re: [Poke?] Re: [PATCH v2 0/1] HID: switch2: Add preliminary Switch
 2 controller driver
In-Reply-To: <721a51815d1cc21aa22e255ce31598035b687592.camel@redhat.com>
Message-ID: <or594565-p59s-784r-494s-82o6qrn9p496@xreary.bet>
References: <20260109034034.565630-1-vi@endrift.com> <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com> <721a51815d1cc21aa22e255ce31598035b687592.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 30 Jan 2026, lyude@redhat.com wrote:

> Bentiss/Jiri, any chance this patch is on your radar?

I've reviewed the driver already, and I was sure I sent out an e-mail 
asking for a minor nit -- better naming of the driver (we usuall name 
drivers by vendors, not specific devices. But I can't find any traces of 
such e-mail, so I probably hallucinated it, sorry.

Vicki, is there any reason not to follow the standard naming, and either 
fold the whole thing into hid-nintendo, or built it separately under e.g. 
hid-nintendo-switch2.c (which might or not might be then linked into 
hid-nintendo proper)?

Thanks,

-- 
Jiri Kosina
SUSE Labs

