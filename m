Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC62F3C3D
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225206; cv=none; b=WJwoMOCAJV1RTSXYK2fAUlcDFJZtHim7iKfTepGY48eM0qx8lDl4djFmyV7EvSF/6UuKl4x1w1BtcGEeK0gVV4INSoYcfYJM4NWj/wu6d/eNiQJ9YhdK1TXHeiJ+zXpnkSeUgwTzJNvu9TiKkaWQiKh3VljnibH2wbINzQGF5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225206; c=relaxed/simple;
	bh=kfQirt5/V5irqBqWK6m0/+9DnlTkyuhFBZRgFv9zR9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COWA/u9vZeG+quGBevVPx2xxLsgr6SYzg4WAl175PNSmYvgPmU1QKT6d8ovPN9KBjyFkZZX78ZfR7BE1HDW/bHtyuObBFpgQ4yJ2/+K12BBBsLxAotwbtWhzZi1zKbbQm20NhQOWe2d4FHkRg/Bj0Ont0Pu15VQra2VRmE4d5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=k0R5b75q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DxX19Z3/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="k0R5b75q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DxX19Z3/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 013551D000AB
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 04:20:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 17 Oct 2026 04:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792225203; x=1792311603; bh=TVlLFZ5Bk/
	TOe/zP+5Hk9LeRtdW1KI4Rn7LpzgcvM0A=; b=k0R5b75qfO6+GwTC4r+n6ONXrB
	qZQz77ueAVMwB0GjKhbnTwiIqHOFtPkMe73Mz9VPlVJCO3L4Qrc6pnZ7/g3EqhHb
	Rku29P4LMa1JIINwBXDF3quqZVxiazQ5lV3kqZhzX3XMzcCUEPulmKN2ec/xtB2P
	FWCvkqSmpIAagvQsoul4nuSIEKvuQtV3HiKP9tSouvkywjkIJJZZdo2KczF/sck2
	doMq+O2oAsYsKtnm6S1514TCYX1Ip7E/xDRD5yK95QcCmQPFhC66CsvKmIOKFEFG
	8vLp6HbetH23y0cR3K1YCEti6buXXdXvPj0BPpFSshVHO88zSld/edbQ/MHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792225203; x=1792311603; bh=TVlLFZ5Bk/TOe/zP+5Hk9LeRtdW1KI4Rn7L
	pzgcvM0A=; b=DxX19Z3/5I8eJMoDOEL5/PXCkcJUr5ceoTtPxJiePQKuZx+SPKh
	LxfVAnKpTUirNhftcXaH9du1s05PI1k/rlzoviUjaYoyXZR7A1kyZ8DGy3xLWXIv
	W04kpJTg/R1J11BI1UU/KOCQDlf8Ed7p8v0wgp1YRauF1Ix2+Zihs83DZj7BJvw5
	3sC12ufjuaWxQNKnzAPRWom8qOZuiBagClPHHMSJriRsVLwFVmPcTxiA1Gmxkb/f
	TgWEwxNVPI/0Wd13E+z3YKsX+FEy0Sa7H3YAopb/Y45wA2dUVXDtw1Hsv7BWyiaX
	aptZqgtcDFNVEkbX2Wh2W1AqSjmq69TK6ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792225203; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:WMo66EE0Zvb98nvqDYHwh9BfGyS4AFUSMOAqHdn9YC3Ro6k
	WBKgJC9B2iYAMQDmWIJ/cwjUa8u1agt72G61aNNNKHzJ0iMWwNfH/lbSh6o7o2Go
	wix13bnVg+5sgqrYKr/zfnTiR+lo/JPpzMyQWoJkWShJhy6hE2Z+lto13biBcHvW
	bzDIiyJXlBpBG9hokPwe19FkjlenpRzBqUOdG7CkygHzwNKKaKKN744q3VxLhrp8
	i2le14qEcwstp9yU1F8g1/BzilNZnZYTFuyY0+Y/SsB36wOTy4dd164FGqHzRrlX
	gGIQ/63fm6J28ytnU+kSRwo9aU8M3SyCdbj0h6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sWshfQDbrCtRafseqcmNryRSV7DsnF92al96hJnrxGE=:kfQirt5/V5irqBqWK6m0/+9DnlTkyuhFBZRgFv9zR9c=;
X-ME-Sender: <xms:sy_Tall117CF-q3nlS2XfufChhE-exH0HmvcdbEWpV-lVqWe3qJMIA>
    <xme:sy_TaoyjLT__WUiTlKoGEiejw652CbqGiRCMha6C0AUuo1WftzMTFVO2JJLKz6QC7
    z0K317n9xnho84xlinAETdNDva9pTqSg8yGbzsYa3OJXM8eX3I>
X-ME-Received: <xmr:sy_Tai10FComG9vukr_7jDox8Z83-IK-OWJxZZ3n-xQ0sApN6u4lRuEz9Dgga1GTzYpnCsk2Bh2VEdq-1RJ2ZCRt3kecyyomu-dm-fH0eTA>
X-ME-Proxy-Cause: dmFkZTEOBF6uPh5KnUc3xg4n/rf5z2ERtpq2mGq5cXLR+TV1/cWaoEc0T5qRp7ZANh6Fhx
    VE/5qHOZofd/nqK/kj1TDPU6JpZUT4Zsw3zcrpcJplDj89Ol82gSnK2qGMfsGeuMKdq4IY
    8ClU2AbC7TF6br9SmPmSMtKbHvcNLTEMwbh5mNqfaDgW6dzbifkIH32vCgKAQ5qZNakp0F
    HK9hVon23PvbNvo8jVHvK5axq6/dS9ZPRNGpz50JrSgHRRdTo0x5wA0P50nse/bnc2kC3F
    CLVPNkCndszc0l881N34AOrdSTblLe0wJn752Dsd6+23GAAjGhF0kC4Rjt/v+hAuiHSksA
    DEWdv9qPR3p0ROsSAZGAedoACHPW/He1/jNW8L0Q7ZVvJzb5cjFwLaqegrez041GqeMgKT
    DXiQwlRm0cexicMluXdomvfEZWKtSI1a4pzPvKE87GvuGqmhTPi7yq6nOgq1PIBLZTM1Zm
    WFKLizoQd2GwEfeOWNxL9R0AWwoEvcatq8B0uQ/ZkgaZh+74fWgcpy/uhCxPgaA9AcwmnD
    jwqlkycPEIzGda1QBmZ0lMpjWYTrjaPacsarID3+Tpt3mRud+V70A6Y4zp1744ZarM4mtR
    007dOfAy0VjbfjQHwjhrczj6mICUbhwlNqdk5bYM1gcTIir1k+BffcRS+OGw
X-ME-Proxy: <xmx:sy_TasBCdX8GBJnWwvD26q9nrWGFWRxK0_fgJfszMByRMyTODU-5Lw>
    <xmx:sy_Tav891VkNrXEnn-r-xiGa0WIKVkhYkLAE_yCna6k6HBo7cDYTpg>
    <xmx:sy_Taq-3SEM2VdWf2GFGrf30TFUo3gaZJM-IKhWGOXmf_EZaykCzIw>
    <xmx:sy_Tav1jsCyc45KH1SNwApNHu5jbUk_3Vf2LMQbEqAjKu8gnefo_tw>
    <xmx:sy_TaoWtwf7bnI70Ofplv5Ut-RhNL_vOvRrJe1POoTXMSxsCIR7rjdxz>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 04:20:01 -0400 (EDT)
Date: Sat, 17 Oct 2026 10:19:59 +0200
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <2026101727-ebay-five-72f8@gregkh>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bc6e07072076b0591fd416f50f4fc3@gmail.com>

On Fri, Oct 16, 2026 at 12:17:05PM -0700, Dmitry Torokhov wrote:
> Hi Shihuang,
> 
> On Sat, Oct 17, 2026 at 01:04:07AM +0800, Shihuang Liu wrote:
> > The pxrc and xpad drivers build the physical path by appending a
> > constant "/input0" suffix with strlcat() after usb_make_path().
> >
> > In preparation for removing the deprecated strlcat() API[1],
> > replace it with strnlen() followed by strscpy() into the remainder
> > of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> > strlcat with better alternatives") did for the usbhid drivers.
> ...
> >  	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > +	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
> > +	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
> 
> I really dislike this conversion pattern, and I do not want to see it
> open-coded across 18 drivers in this series.
> 
> usb_make_path() is just a trivial wrapper around snprintf() that already
> returns the length of the formatted string. Calling usb_make_path(),
> ignoring its return value, rescanning the buffer with strnlen(), and
> then open-coding pointer and size arithmetic for strscpy() (along with
> an extra local variable in every probe function) makes the code much
> uglier and harder to read than what we had before.
> 
> All of these USB input drivers already include <linux/usb/input.h>, and
> drivers across other subsystems (drivers/hid/usbhid/, drivers/media/rc/,
> drivers/media/usb/, sound/usb/caiaq/, drivers/usb/storage/onetouch.c)
> all use the exact same usb_make_path() + suffix pattern ("/input0",
> "/input%d", "/ir0", "/button", etc.).
> 
> If we want to get rid of strlcat() here, please introduce a generic
> helper in include/linux/usb.h (or a USB input helper in
> include/linux/usb/input.h) that formats the USB path together with the
> subpath in a single pass, for example:
> 
> __printf(4, 5)
> int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> 		     const char *fmt, ...);
> 
> (or a simple const char *suffix variant if formatting is not needed).
> Then each driver can do:
> 
> 	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> 
> and even drivers/hid/usbhid/hid-core.c can simply do:
> 
> 	usb_make_subpath(dev, hid->phys, sizeof(hid->phys),
> 			 "input%d", intf->altsetting[0].desc.bInterfaceNumber);
> 
> instead of repeating this strnlen() + strscpy() boilerplate everywhere.

I'm all for that too, and putting it in the USB core for everyone to use
would be great.

thanks,

greg k-h
