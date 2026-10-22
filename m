Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651755;
	b=FexPr6egl7LoohfQkPVxsGLVhCVxv8WuDvwZVSUVR8gxmcWf92eSuvuf/9LpfXuI+BfQ
	 FGTgWfjn61WvNQsjeyF9RYkjISheo19CDsMPW3a6rMwH69KWkZ5/a/1hY0cBm3CY5+GFB
	 x17ahWr4/iCB1WKve7RU3AwucA61IVP23ughb/uo8qOecrhdNiE33zVLesRH3iIoQm6hi
	 akT9Lb+582EZJI1WGurkHLbw6WH+7+AYMMUZdeMLHJ0dBtq6Ct4lQ48GOMFHqV8MmLESW
	 j8aO927S4cgh+GMgSikPP0ZBBRimLAsnImlSOXjxBOtuSQMWlVVLyuDS6IvhbbLAq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
	b=zfJsq0LCzAUfXie4eb4+cASJsFPY8w208k5vXb0NJk4XYHsO+GUeCFfVmpJ/o5QmRt7z
	 RBZ7Lu51/+7RTzOMi4KkdTiYUh4fSSs3J2y63LJ5SNs0ccrP0iU1lN/aUPXAGT4FAKPKQ
	 SQ0eiCTa3qRDHzkhOgl1lKLtkLcIhq+SzprfQW+Blh5O7zIDgkb7q/gEX/EsKgnlqHAQJ
	 9lklIaBozcomkRHw5ozB5Ir7rdqzC2EL5hOd4ZlpiOAqon2HyPk6njmlIzfDTWTakx0A7
	 FP1tYGCJk2SZP45yZKQVMbiwoQU76DM4MV6POjhrc3AmmOXZos8ZqpPggi+z3P+vqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0MWwbYm;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24D606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 06:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A24D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D0MWwbYm
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ada6c66964so123082a91.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651755; x=1793256555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
        b=D0MWwbYmQfuUWSye7rIUiVQ9YWomoQdyoRDN9rrFjnN6XHjz+UIgna9JlH9IBcAYMh
         rUUqjtC3qFMre85uij61NrdbkTAZEKQf5tPylE5P++bkOSlYpCctsQ1G4I00M19inpZF
         e6MPOIDcqmm84ygIFvHV2zMS1l8o1Z5DDrAwdtkjXK9xiIZU3/SJuKUadtlMZCHB8Jdl
         SyZeTze1oZiWYqtjfh2HUdYq0uqwT4nOLh12ZQRrNvp0at+WkR6SuB4Lu7Ml/3cBvd29
         K5tkvBDpSzU40DIKRzfVXDE/iFFCAH5upLK0fBtZPmQrK32W7lq001wJmChnm6OMnDd7
         dzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651755; x=1793256555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aOnKxbhQNH1eTmeBnjETvVZlJB22FsVUKhxUnQp3P/Q=;
        b=NszMFJlqECSoVt2apRWIPuGsY+Mg8yXcO2dHBo6Q8pOLhwS4NWxBPTbeht0svXylZC
         fazTPnMVttHx3gN5bNWIq9ZOMt6HU+g6SU9HPnod5GZDugrqvEqx+9oeHZAmy7oHgA/N
         j4KKbIQCwTUCtJyrMBrlFLFzH8GsW1S8+qX9NVxHvwpYx+7YuTLoAvgp6e+buSJ3B+eJ
         +mZwf7oI/Ij25NlyqriM4cj0VZRjDdfVBf6EDSNj2ZW5zfrVd4d0m/WGpEuEWWTqSimT
         f/bH05QN6suuMgMY3YCRbK1524zzghnQ5mkqGxRzJ9QUHFUDo7+FQSpFX+Suqgplai7i
         SYSw==
X-Gm-Message-State: AFq9FYJiRoApDzIifuqYLEKs/d3F4t6ZhbTCROHwXC2dmBaEcQDqLO2R
	Yp6PyzJaRSjwd+NdQ5rOKZ+gj8TwHQYLd+Hpm+j3CY3KUzycq0nvk54S
X-Gm-Gg: AYBFou1Pggq8WowBRcNM3O1QzY7orn+YhfadEiUEEBr9D3+/Pwi8KgR0iNF5sDGSbhN
	hX+0RoAwm3Qxahz2kcyvWX4eamaUuzPT1jwpOBLHmtsgqqjl4qpkzG0Ttc2VKiqzRXOnUfs87FW
	6E8qfYhWzgykrA6oLBq741qJdpI753QRvv8MQccQekE11qLWAeX12JuTBEAcNVhtp4iAmpwlqud
	aYntyMn7DXZVjkhmMHofsAfWKPKLcu7C4HeLnpGA8uOC7jlCuNvbks46KtteGF2yaHdjG78Pq1U
	RMvUbFaPVKORSosGpwyqP0WPlrEqFqCF69dmQxc5JFtsI4zLk0femQPnUT7NAcDTQnSkbkppNjH
	FRM8IkFowWbuR5+djAoW2uWLNXKDF1nWotYeMozxV8opby8QCzWQL44M3vB52LVZB7F9hFIu/NG
	r7SRNkIye88ER2nfQFiGnrB78SzIxVjvvNCcjJ6Cd/oYIkMZcPJEm9jsZtxKKG0ewx7nPHVZ88W
	wGH0WCFTCf1AWgx6N4Tf3dnyKwm2cq2UX9t7M2PMB0TPYfYFr0wYGz0lxGXFtQZNuCeLzq7zp+9
	kRYj0Fw=
X-Received: by 2002:a17:90a:f944:b0:3ad:1b0b:1246 with SMTP id 98e67ed59e1d1-3ad86d5238fmr3509934a91.32.1792651754537;
        Wed, 21 Oct 2026 23:49:14 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49314besm2707437a91.11.2026.10.21.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:49:13 -0700 (PDT)
Date: Thu, 22 Oct 2026 14:49:08 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <gih6jsfknkjemuk5ahmmpxtzp6ymyynergxckpmxfbbybzpdc4@me7k7j472mdu>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <2026102104-audition-unbraided-05d1@gregkh>
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
In-Reply-To: <2026102104-audition-unbraided-05d1@gregkh>

On Wed, Oct 21, 2026 at 05:20:31PM +0200, Greg KH wrote:
> On Wed, Oct 21, 2026 at 08:31:41PM +0800, Shihuang Liu wrote:
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> 
> Did you forget to use get_maintainer.pl for this?
> 

Sorry about that. I'll resend the series with the proper Cc list.

Thanks
Shihuang
