Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA42DAFCB;
	Mon, 20 Apr 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672121; cv=none; b=HHMub3LhNAmvTgpu3fdNj7wrbe3BW/D2iOCR1tTk/omABU+cfC9A8abpAJXf1D2P3JluZj/K57swHi1Pwqv0Vbi1y4VSN5rYEw0mD58NgvGfUsqW+bts/RtTwQapySP6aXc75fRnqIqgbBKpQAENkJOxHNw1UriKIrPkRgC9gf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672121; c=relaxed/simple;
	bh=iDBvIru/tesedpbSi6rP/YlULqPhxZRplQYFZ9Je2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOQYaWfME0s3w/EMy5Jf3OaiLB6ne8wXB+G3QHDSKjrYh4MwWNpbrZBLpJ5b/3KALQhO4wccKjdNKmPQL2YbbzsVtPDY2c0D/Utvb3wKsdQoehaMnNIr2XwlVEviVED3CKZNltMTIwSYWiYalC96VW3wBWfcGaXcviHnYWpS4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9ORtTHc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9ORtTHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEABC19425;
	Mon, 20 Apr 2026 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776672121;
	bh=iDBvIru/tesedpbSi6rP/YlULqPhxZRplQYFZ9Je2fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9ORtTHcmeeW1ldGdfVssTVlaTvgTh5Tpv2wS1moFGJR8ett0fzPWyx6pZf9OLYfu
	 hANmhY0gzaxIZwQZndP7wjNlo0Z+If63EMCGOKPdX2O5XLaAcYs5CBlxX3+whFIROB
	 5Z2mNX4TzPNE/7R45AblYs17ben9spn0RwztRrQDapS7pkiQg91FEaUtbyKKbxBjj/
	 z4mLziUwTCuBoPHVZwd7+HHEtUv8NXd3s1ei5x9i4F3V3vBD/Mn89a92t63fOUonve
	 TZ6ryAlrpDK1rcTZ2+zbchpxnANLS8Id88GlneU/FHK3nMxDDIYjnEhi7Lbbzh8U7P
	 zvCr73X5+v6Ow==
Date: Mon, 20 Apr 2026 10:01:55 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: pass the buffer size to hid_report_raw_event
Message-ID: <aeXdKFJe8JyatqLR@beelink>
References: <20260416-wip-fix-core-v2-0-be92570e5627@kernel.org>
 <20260416-wip-fix-core-v2-1-be92570e5627@kernel.org>
 <938e8afadcbf2d7b9f0397e24926224985d9c385.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <938e8afadcbf2d7b9f0397e24926224985d9c385.camel@icenowy.me>

On Apr 20 2026, Icenowy Zheng wrote:
> 在 2026-04-16四的 16:48 +0200，Benjamin Tissoires写道：
> > commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > bogus memset()") enforced the provided data to be at least the size
> > of
> > the declared buffer in the report descriptor to prevent a buffer
> > overflow. However, we can try to be smarter by providing both the
> > buffer
> > size and the data size, meaning that hid_report_raw_event() can make
> > better decision whether we should plaining reject the buffer (buffer
> > overflow attempt) or if we can safely memset it to 0 and pass it to
> > the
> > rest of the stack.
> > 
> > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > bogus memset()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++++--
> >  drivers/hid/hid-core.c             | 42 +++++++++++++++++++++++++---
> > ----------
> >  drivers/hid/hid-gfrm.c             |  4 ++--
> >  drivers/hid/hid-logitech-hidpp.c   |  2 +-
> >  drivers/hid/hid-multitouch.c       |  2 +-
> >  drivers/hid/hid-primax.c           |  2 +-
> >  drivers/hid/hid-vivaldi-common.c   |  2 +-
> >  drivers/hid/wacom_sys.c            |  6 +++---
> >  drivers/staging/greybus/hid.c      |  2 +-
> >  include/linux/hid.h                |  4 ++--
> >  include/linux/hid_bpf.h            | 14 ++++++++-----
> >  11 files changed, 53 insertions(+), 33 deletions(-)
> 
> ============ 8< ===================
> 
> > diff --git a/drivers/staging/greybus/hid.c
> > b/drivers/staging/greybus/hid.c
> > index 1f58c907c036..37e8605c6767 100644
> > --- a/drivers/staging/greybus/hid.c
> > +++ b/drivers/staging/greybus/hid.c
> > @@ -201,7 +201,7 @@ static void gb_hid_init_report(struct gb_hid
> > *ghid, struct hid_report *report)
> >  	 * we just need to setup the input fields, so using
> >  	 * hid_report_raw_event is safe.
> >  	 */
> > -	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf,
> > size, 1);
> > +	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf,
> > ghib->bufsize, size, 1);
> 
> Oops, "ghid" is misspelled here...

Damn, you're correct. Sorry.

Jiri, do you want me to send v3? Or can you fix it while applying?

> 
> Found this when building some gaint kernel with this patchset.

Thanks a lot for spotting this.

Cheers,
Benjamin

> 
> Thanks,
> Icenowy
> 
> >  }
> >  
> >  static void gb_hid_init_reports(struct gb_hid *ghid)
> 
