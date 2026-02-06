Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B58421A11
	for <linux-input@vger.kernel.org>; Fri,  6 Feb 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389417; cv=none; b=ghrOxzaXar+BhmWd0gMgm5VHs5ih9Mta0mtwLhU5LxUdLHLyA5iWY77fHkOSL1OJTQ3iOiNjMkKHtomJi6XhSF6ouEaLQs1deIFwtot/I2mAdFh9LkujqIF8TCLN4Pdz/oGzX/aOqyhC0VBxHbHZcIn0lh6yKOD6eAbU8Sc21+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389417; c=relaxed/simple;
	bh=u2bassgvQ2gDT0DdqjIs5CJvw3Hi95BQsQ7dUiNDvUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTQvxbx2crTANpQoqkM/kr/ZDdTzw61/hspaw3iWkJdPc11/7xahJW2vrQBq2nMEaQSShJrv2jbarSj2f95begrXDdQHa3XdS71oCmv8UqjtlEJHdx8ekXAF3KmaZv4kLto0UbwOoRvvcLESFkGT3VBNrUdDVwVafjFGzw4F43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1voN9y-0001sv-NF; Fri, 06 Feb 2026 15:50:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1voN9y-004Q92-1f;
	Fri, 06 Feb 2026 15:50:13 +0100
Received: from mtr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1voN9x-002NqK-2N;
	Fri, 06 Feb 2026 15:50:13 +0100
Date: Fri, 6 Feb 2026 15:50:13 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de,
	Khalid Talash <ktalash@topcon.com>
Subject: Re: [PATCH 1/2] Input: st1232 - read firmware version and revision
Message-ID: <aYX_paFYIBycCrf8@pengutronix.de>
References: <20260123-input-st1232-firmware-version-v1-0-32df7eefdafe@pengutronix.de>
 <20260123-input-st1232-firmware-version-v1-1-32df7eefdafe@pengutronix.de>
 <aYRftJPEKEWE7VhK@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYRftJPEKEWE7VhK@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, 05 Feb 2026 01:17:17 -0800, Dmitry Torokhov wrote:
> Hi Michael,
> 
> On Fri, Jan 23, 2026 at 05:28:55PM +0100, Michael Tretter wrote:
> > +static int st1232_ts_read_fw_version(struct st1232_ts_data *ts,
> > +				     u8 *fw_version, u32 *fw_revision)
> > +{
> > +	int error;
> > +
> > +	/* select firmware version register */
> > +	error = st1232_ts_read_data(ts, REG_FIRMWARE_VERSION, 1);
> > +	if (error)
> > +		return error;
> > +	*fw_version = ts->read_buf[0];
> > +
> > +	/* select firmware revision register */
> > +	error = st1232_ts_read_data(ts, REG_FIRMWARE_REVISION_3, 4);
> > +	if (error)
> > +		return error;
> > +	*fw_revision = get_unaligned_le32(ts->read_buf);
> 
> Why unaligned? You are not reading at an offset and allocated memory is
> cache line aligned.

I copied what other touchscreen drivers were doing to read the version,
but missed that they either read at an offset or use a buffer on the
stack.

Should I send a v2 or can you change this to le32_to_cpu() while
applying the patch?

Thanks!

Michael
