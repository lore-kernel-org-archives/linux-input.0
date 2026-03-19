Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770373ACEFB;
	Thu, 19 Mar 2026 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773909919; cv=none; b=WQyaLzL/YzIFF6eUInFlAc4W/qvW/L3ouMtCrPDVR9t5Kr00iQAPZNv/GHJ/MprbZILc+XQdzaur6rRQm17VSJ3lEE36mLzt/fvscCDQbJ7NzWxNrEOlQc7QsFt0Q8osjOMLsnZKtGs7f7lBWc3NbqK4E9BOU/h0XLs8aTEA5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773909919; c=relaxed/simple;
	bh=onAojMnQzXXQ0+oHeMvJ03cICakINRGDb3mu4asFd00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrxcTtjZXA0YVX7DTFwyoQO1Ohkf8IYPVEvPMzrt+RSwQDT/KaZn4HUVymN5Q/Wwu6rKpZ/dFD34OREdxKzdnxYM+7w0fDSH+U1ZTcNUg5cvv3ol3G6zndGnA+ffXTwRXMTI0Ke2Ag/gwcFa3FpWQvK+PWYX6cL33IdW64NUxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzcZiP4f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzcZiP4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D82DC19424;
	Thu, 19 Mar 2026 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773909919;
	bh=onAojMnQzXXQ0+oHeMvJ03cICakINRGDb3mu4asFd00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzcZiP4fQ6vnBINbhjrTCk5ZpW7GeWY/VW3DmstKi1SiiM3gmIBddTXkLaMyijxbW
	 wFCK8WKbek25QETqxvKJGoIrAq4yM+Z0WAbh1onHjmUs7bcbdMhPMswPp6Awc4VweI
	 +N9NEtTPjObzaZ5Q2olOam7MwcmtSV621BH4HG/tM3mQVFybIV9/GjmqORR/qHyO5W
	 cL2Wyf+YTp5sFqQDnFPlw32HMz9kGq54/HiAJX5HbmSF6A8L8NZRyOuVrVM0awPGa9
	 LE2j6piz6gAP1Cl1zxBsLJEM94QcAizHLlRJ1yj5UA2nitrScRSATxeLa/jhkhJU3e
	 pc3/Tr7lUWYog==
Date: Thu, 19 Mar 2026 08:45:11 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related
 user initiated OOB write
Message-ID: <20260319084511.GG554736@google.com>
References: <20260317162426.1533573-1-lee@kernel.org>
 <abmEJJ9vWz5fiZy6@beelink>
 <20260317172052.GF554736@google.com>
 <o5n60785-0900-7869-sn47-7977p8so17nq@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o5n60785-0900-7869-sn47-7977p8so17nq@xreary.bet>

On Tue, 17 Mar 2026, Jiri Kosina wrote:

> On Tue, 17 Mar 2026, Lee Jones wrote:
> 
> > > > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > > > index 44b716697510..885b986c7a12 100644
> > > > --- a/drivers/hid/hid-logitech-dj.c
> > > > +++ b/drivers/hid/hid-logitech-dj.c
> > > > @@ -1282,6 +1282,12 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
> > > >  		return -ENODEV;
> > > >  	}
> > > >  
> > > > +	if (report->maxfield < 1 || report->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
> > > 
> > > This is all static information. So this should be checked in the
> > > .probe(), once the device has been parsed, not for every single call of
> > > logi_dj_recv_send_report().
> > 
> > Doesn't report_count come from the device?
> 
> The point is -- maxfield and report_count can't change once parsed unless 
> the report descriptor would be re-read and re-parsed (which doesn't happen 
> in runtime, only during probe).
> 
> So checking during probe/parse time just once should be sufficient, 
> instead of checking it upon every received report.

Okay, thanks for the explanation.  I'll give it a shot.

-- 
Lee Jones [李琼斯]
