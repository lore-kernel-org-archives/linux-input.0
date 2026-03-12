Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C03FBEA6
	for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334495; cv=none; b=coFyar9Qij3bUl9W13NRjyKmCpYAl5nzJUjCNUUp5nriSZdPngLUtXNGU4aBogmdOItBQCOIHEqnywG8uMR6gPU2O4sI2L90iwt+Ldmqywf7EPkAsHuOnQh4vKa7KQF1NnC6nxH+EV3QHecsvAZOknaqVYpygmBaAi8Tqj+a2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334495; c=relaxed/simple;
	bh=ENv0+4bH9YdpFLGeURNwJ3+rEUsnNn74RNCtOl26SEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw7xzWmzbU4e1BSqAP3f9KPmVNpZlSjt0nAvxcMf7cJmaH/c+8JjXmwGf16KZplDnRV7dRpn/IaJYC8yOrvNboR8xjhnun++VEjot5TpwXfHxhIpGIvBDwihcC3gC+Rrp6KxpjpF40MvZDyuOGcCWff8uydXVR59LTDm9GDhNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TCUycPJz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TCUycPJz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509164dce91so11154661cf.1
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773334491; x=1773939291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=TCUycPJzE2fI+UEqk7FktReSuNB+qmtoLxCPQIhObf2GoM3FGGUoUzmOL4EcJ8nqrV
         31wLWw0iuRrm5q/A3vl9oGJab4nkcB5GgE9L87TaBE5zWVhGKUEWMOYZrC4hQkz7+K+y
         MdSN9PZxg9+VlLOffdwRmQphGTW7UoGABbBRu3CtgROAhKqAusDMmmrNFgCXGsGgS+um
         4b3n9KF8H9mgZuxtPx/c84lVtPd3kX8R2XT1vLZ+RjANCZT5FGS44RpBGA5cN1JRJXTn
         oCOtB2FnqO56y3+c6Fos0prISIneHSMHrQ7vAs2p/teTVBOn2DfneDCxuRpkTU9D9cja
         6IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334491; x=1773939291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=YuEpo+jcdWjbH2dgvLleiZDnVbg+mr5nhDKS5HXy2ClbycdK9uuScDEZw09Wvx9aF7
         ehoRBq7HYJ46rsA2Hks88aEY2LoFTQVHAYMznM+tjtG34PP8dXHxN7GEKutXGwvwaqV7
         NQucC3X6D3qyUB3A97aHq5bEO2vqir6hIXlk7LIL6grb/1+oHnGSaTZ/GQBtIDmG/Zzq
         2xDQkK/7hoWTaE4daoUPN/tvKBsU1O6uNoX5QlKzEiV/MM9L2obCPyZlmaYAn1f1hgC4
         IBgw6kcGNdr+on/CdtbZ+7C7kVC/X2NsgWhIG15JsXtsdw5rRBz00VRQpdgyn8c6kq7I
         o2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQME87KBWrumjUlq3VYbDnSaagXuppw8vn4tunIv0DDynQ5ZrKkG1jqQdS+X3+mpqIufTrkUawlnR7+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVp3I1ZyXCC42WqOqgE2EeVEGtX9JMtnFbC5WXFJpbNIegwZ2Q
	LaNQ3oM0kRL+Ksv8WXV1AB9p2A3FKsluEShrKzFNBxAgiaYE8xSOh5vIAHjZMqK/OtQ=
X-Gm-Gg: ATEYQzwqMf8xjzXlW2HmTDhhVubiPZ5S6x8I+gRQo+kc+GqVnxjPTZAIQGR0lYb1cA7
	yPT+n6TGXvfewdrgdBppIucUHU8wcZDoEwP0daMztet1rm83v7P3puI77/Q/rA8Qe1ZxZsXuoSQ
	8Q1yYDe9TkRnqyWpdsGIXvWVaOcGMeA0+blnS29sP08YAEbXGX2RaT0dPvxhOXM1WehFM3z1Bbs
	eJpjeDzsatV9wMXn/T4WpU8ngSp9V0ZpYHnIs6U5kiYOQv1WaC/zX4MKXHbsYNJNU4OYKClO26G
	iBqLr7rVEWMkQi4wD8GOZ6/9rYE4m9fDmv7RqPOKUfqpvCi7cMcB24rVdHGmXOqhNBit1hzW3bb
	eHD0pL+QFq30B7L++OqeCliHWRLz/fQhlOzPOOUoCpawzFGM7tvohUThgWebOW1mOvnwMj0XRyG
	yFDfF3pYXFLn2MZTjg1BPU3SUKeei21jL0TQv+f8EtjRbcu/ftTOxSDDirnQU4MV4ItHKhrvAXO
	LpXM7q+pPhhY/UfPuw=
X-Received: by 2002:a05:622a:289:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50957e10673mr1403911cf.52.1773334490530;
        Thu, 12 Mar 2026 09:54:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a119602sm36658181cf.28.2026.03.12.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:54:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0jJA-00000006i8N-40X9;
	Thu, 12 Mar 2026 13:54:48 -0300
Date: Thu, 12 Mar 2026 13:54:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
	amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312165448.GN1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
 <20260312125730.GI1469476@ziepe.ca>
 <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>

On Thu, Mar 12, 2026 at 11:32:37AM -0400, James Bottomley wrote:
> On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
> > 
> > > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > > confusing or flawed API design. It usually implies that the caller
> > > is unsure whether a failure results in an error pointer or a NULL
> > > pointer. 
> > 
> > +1
> > 
> > IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> > little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> > pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> > implies ERR and NULL are semanticly the same, so fix the things to
> > always use ERR.
> 
> Not in any way supporting the original patch.  However, the pattern
> ERR, NULL, PTR is used extensively in the dentry code of filesystems. 
> See the try_lookup..() set of functions in fs/namei.c
> 
> The meaning is
> 
> PTR - I found it
> NULL - It definitely doesn't exist
> ERR - something went wrong during the lookup.
> 
> So I don't think you can blanket say this pattern is wrong.

Lots of places also would return ENOENT, I'd argue that is easier to
use..

But yes, I did use the word "suspicion" not blanket wrong :)

Jason
