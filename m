Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7295496D3E
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399468; cv=none; b=pSDspXvXzhoBn6IXb1a25SXUxYKvpr9YVV9r/t6NVXYWzy3Ncakn4WuJf0Tp/Ht0teDVJ3osj5JD72KmgozqZ34NXiHJlR89Mwx0kUJDa1EeYyNUn9SjkFzrYDr8IzNQiO/oxjltH+NZXjZUds6NOziLfInhWWV/KDYprNpx1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399468; c=relaxed/simple;
	bh=Lf2ltc92yGw13+ZIQaEnX84MOqtAvkx0Yz6xmwkEBM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRiObpwNfw7vY9Ww5EM1Nn/pdEy7BFn4vTWRrq/ymfd1qvbk07IWWY/Ll/OffYZBxp03v9C69MNvRi10m42YlxXRvjTsLqbCF7uNhtp1d04RzE+mffp6njYneBCS3PDK4dSu2gxWffJcIUqtT9VaX8QvABhK1gY5h0VOo0gt7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=noTZ1tM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQ/PsV/Q; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="noTZ1tM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQ/PsV/Q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B71447A00B0
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 04:44:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 04:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792399465; x=1792485865; bh=YsVloFkfqa
	hKMtvRLfn5FRI51AxlMq8II2uKnESwYRE=; b=noTZ1tM/7HS+qU1bxdyPoTZNYw
	OKcz4gOUnjn9zSYgCTvuo8oDoeuqnMJp+A1xB0yQdCZXYVhNrWzB/N9MJVJKu4EP
	RV+RoY7Vr3i8wjdbRAoFFIZ8clgL27K/G5TsUEcXkXw+S5jygpg0XZjC55iB34en
	NhDl1ibGxrb2lGja0OJb2aMhyYPThIMXZcKNYvsmndkPsF6OViQydU7i/IOJxpaU
	Fzg2vbRIP3eZlVS49L9B80UHdLqa2CgQjobg8BUlAdTxtAnM2e56pRdA7yrenUU2
	jKBGVc9sFQbm1Vye7mqZqeJ3o5OaapYtN87VLBHbjvxQu+L/M6SnNcoUbLvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792399465; x=1792485865; bh=YsVloFkfqahKMtvRLfn5FRI51AxlMq8II2u
	KnESwYRE=; b=LQ/PsV/QTAfh3KP+93KNf5QP/EOQ1nWDt3yFzjOm/yMlto70Cp/
	WncQeGPYP1+jVbTnTm4SfugdmWCWfj7s8GXLnhg07gbxnbYVSJ6/jGmX/ZQSrF+m
	unNviohg8rQUvuUdPnhKa3f6Q3RO9tdcA3ev87v0j2tzyeDb9D1H4MZcL6GVtgX+
	XLrPIXIsEJqjC43Ef5aM65Foq4EqZBp741uN5AKd0fXRCYMv4QmI0fLzSXtvONgA
	yxGJZAGvyPkraMZyKXbxzFrgaRGybkXS5kNG7/Pq0l/Zv21qT5X5C7HC5xHHjoEB
	Uo4VKm9O/CjNh34ULbR1hAoI2vPBuV94EoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792399465; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:JCWhNpCS+Tlj/A23WUjLht6FQMKl485D2VR7SSTdnHBqi9d
	3QsgE7euV8RKLU3Q9+5l89ERn5OYxKjIsZvKtuxpsRWE4T/ZrJwKTcprS3M+kAM8
	JngRoXSvtfEoEXU0Nt2tqcbDI6FqoqMuQ4nv0LuprBD7zHqXhnHzUiYTdUhaWMMM
	zQtr9XDQYK82hKbTeYt5VhHGQB4eIvernsbF5TL/IyiurCkiStORT/kgdXjGUx6e
	ysfeDL3LCV0OkFGlTaqK+YPGjgKjvubbiqMALDHMWLWXwq6ck7BjafAykupL6NNs
	7rvv3VKZSRwONP8H6JC+RS7E220YhN44pCV0SZw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KM/onkGzTVQhZk+S7ywKdZWa6dBSaTub2Eq20P4k5bU=:Lf2ltc92yGw13+ZIQaEnX84MOqtAvkx0Yz6xmwkEBM0=;
X-ME-Sender: <xms:aNjVajBodmQidyYcVjqk-3nuiSn9S05B2ArSZWRWByrvnsrTuf6JRw>
    <xme:aNjVagkToZQ8iytXAoS31ooMBXBAZ4SDkgB71-U9nrZU03_El0zL3nOw9XoAhts91
    obe5ypkkt6gXsXe041bWNUY6EXPyXj3zWjq8XXaLxgNoiuM3fo>
X-ME-Received: <xmr:aNjVamRSxWO7d6fxHZvdczTYWoQqZQuA81EBtnsVAFT1e_NUTQTGmWsQItXg2dcha7jT-1coSBbX-uL3JnA>
X-ME-Proxy-Cause: dmFkZTEkBrlER9gv1SSiXl3a5G+9YMsw4jDITFGP2VBd+KvdxqHmoUbVDlMyOPmA+6YbLb
    0TQ53Qc1KawKKjfxM19/nJmt8C5YdRXKEDMOsa7stBFWSOZiGfci6SuTJdTNTLxFG7TwI+
    d09Tel9027sqnDVtSf3YnmIaai4NVI62lI8EJCQ6MseyJe9eGeWOrZ989o6D0LJAQJqmya
    prcWIneOaj40wF+INA1IxSiRDFraAIsQVKuN5aL95KVjFuUKIzv1Zs383ed8GamX0+30rB
    N8bTQ/OQJb/qf/+BG/+X6BumpkN8GmCNWnq4vjEN53bH4SQdejHYVZyehbfHlSzP4NV8OI
    69yC6Ny0YcCzPAMPxzd/tPLZo6TC57hDdwL23Kj/cPiTKvIiqdXYza+sGaq+7KZHuoz7OD
    43+LUfFta7CuW20pCFO1UM5+slvWOqTxIROp/bu926sNzJz9mbHRQEZD1LC+Iu7gIoV9+t
    HT8lyq12i16qeUCqODq2mYhqngbkSFSFkSFlwH645zBWUzSSJ82KvztJAsSE98oU8ArhdL
    ecZaTbV8TF/1MIcwWMUhk2bSOHBWEQfxXDgFwApos7s4U4huugfXd0epOh3NqY2Jepv05a
    MxNP6whmRP7XNpdGp5MPgaIy36EeFZ7R8hmHkQzmo+SWSAQ7gDL2IrM9IIWw
X-ME-Proxy: <xmx:aNjVasKgSDl0xtHcf-vZVYJ0tAwvZb1cZVxFDsiyzgDouQlduNF5RA>
    <xmx:aNjVak_M7JGnEHf-OKpeH-mkVgkfHEbYNPw3tFhkMR18TXFvTOG5AA>
    <xmx:aNjVauCoB1q_sxiHEsiPQCoi_ETCkonCrikBB9x9L1oQB7HtpzukbA>
    <xmx:aNjVauorq8Bc89AOgqRtGniLdTiV5LNSBR8d4XnHjKfiYbL5XXQkQA>
    <xmx:adjVapC80_U4tq3E3U1QIX_FJ1QjdboWTlX_VJDBdnTGRr9tZuitd2FU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 04:44:24 -0400 (EDT)
Date: Mon, 19 Oct 2026 10:44:22 +0200
From: Greg KH <greg@kroah.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <2026101951-undusted-laziness-d40f@gregkh>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
 <atXLrTZYBazVZVHr@debian>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atXLrTZYBazVZVHr@debian>

On Mon, Oct 19, 2026 at 09:51:37AM +0200, Alejandro Colomar wrote:
> Hi Greg,
> 
> > Date: 2026-10-17 10:19:59+0200
> > From: Greg KH <greg@kroah.com>
> >
> > On Fri, Oct 16, 2026 at 12:17:05PM -0700, Dmitry Torokhov wrote:
> > > Hi Shihuang,
> > > 
> > > On Sat, Oct 17, 2026 at 01:04:07AM +0800, Shihuang Liu wrote:
> > > > The pxrc and xpad drivers build the physical path by appending a
> > > > constant "/input0" suffix with strlcat() after usb_make_path().
> > > >
> > > > In preparation for removing the deprecated strlcat() API[1],
> > > > replace it with strnlen() followed by strscpy() into the remainder
> > > > of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> > > > strlcat with better alternatives") did for the usbhid drivers.
> > > ...
> > > >  	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > > > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > > > +	len = strnlen(pxrc->phys, sizeof(pxrc->phys));
> > > > +	strscpy(pxrc->phys + len, "/input0", sizeof(pxrc->phys) - len);
> > > 
> > > I really dislike this conversion pattern, and I do not want to see it
> > > open-coded across 18 drivers in this series.
> > > 
> > > usb_make_path() is just a trivial wrapper around snprintf() that already
> > > returns the length of the formatted string. Calling usb_make_path(),
> > > ignoring its return value, rescanning the buffer with strnlen(), and
> > > then open-coding pointer and size arithmetic for strscpy() (along with
> > > an extra local variable in every probe function) makes the code much
> > > uglier and harder to read than what we had before.
> > > 
> > > All of these USB input drivers already include <linux/usb/input.h>, and
> > > drivers across other subsystems (drivers/hid/usbhid/, drivers/media/rc/,
> > > drivers/media/usb/, sound/usb/caiaq/, drivers/usb/storage/onetouch.c)
> > > all use the exact same usb_make_path() + suffix pattern ("/input0",
> > > "/input%d", "/ir0", "/button", etc.).
> > > 
> > > If we want to get rid of strlcat() here, please introduce a generic
> > > helper in include/linux/usb.h (or a USB input helper in
> > > include/linux/usb/input.h) that formats the USB path together with the
> > > subpath in a single pass, for example:
> > > 
> > > __printf(4, 5)
> > > int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > > 		     const char *fmt, ...);
> > > 
> > > (or a simple const char *suffix variant if formatting is not needed).
> > > Then each driver can do:
> > > 
> > > 	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> > > 
> > > and even drivers/hid/usbhid/hid-core.c can simply do:
> > > 
> > > 	usb_make_subpath(dev, hid->phys, sizeof(hid->phys),
> > > 			 "input%d", intf->altsetting[0].desc.bInterfaceNumber);
> > > 
> > > instead of repeating this strnlen() + strscpy() boilerplate everywhere.
> > 
> > I'm all for that too, and putting it in the USB core for everyone to use
> > would be great.
> 
> You might be interested in <https://lore.kernel.org/linux-hardening/cover.1751747518.git.alx@kernel.org/>.
> I was working on something like that, but actually much simpler.
> It is meant to replace strscpy()/snprintf() by versions more similar to
> Plan9's strecpy(2)/seprint(2), but without some important flaw that the
> Plan9 APIs have (about handling NULL).

Look at the patches from Kees on the hardening list for the seqbuf
stuff, that ideally will replace these types of string functions
entirely over time.

thanks,

greg k-h
