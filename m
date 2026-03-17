Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C51AA7A6;
	Tue, 17 Mar 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768057; cv=none; b=VphojAMpTXlC1XiI6QsqBKs9BegZ0AosJAMHOsE814EbMAXGh2aSPBZk7RnEC2rHsS8qTVR6zVMTB2YHv/GU1RLtAMA7yPXDVP8HYabhVDNN9MYTxKSzPu8kCTm15cJzOP0g/XoEQQhnCMnCJYOWjct4GzsanhH0GKWw0ftugTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768057; c=relaxed/simple;
	bh=HA8S5FPJaQlCmNzH9EOc6wZ/6EIt7evnQbI3jDpHaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMJojlbId1E62YyMx0oEcROBC0FtSPkSBAw3PJQcyf5hp1378N+6qwv7zuXolVUrTxlChlWTnimNx17WNokac4EP3DSjtsdoT3/qXPOohhCb1qU86UdNNx7gghn7IWVjzYhEMg5WyNq8ua8EoRXaCwyW178pQQ8qmsInRf13MuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGtwbH7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGtwbH7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90027C2BC86;
	Tue, 17 Mar 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768056;
	bh=HA8S5FPJaQlCmNzH9EOc6wZ/6EIt7evnQbI3jDpHaA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGtwbH7IXoXwlobnQPihd9c9U4dSvbho1RUAx11gbARjG/xX2edDT0/5PAJ+FE0N5
	 3N34er9/pvtOiu5zDZvj/YMiElCJn7T2bCa0T5x5Xv8/mNoYhtDh4ShPXQRm3J1l2v
	 WTrscVULCPV6Ej0UIaWCefWTeAut+rorGbVr13v331/H6FUK6oPzxwN/dBO6lTx1/V
	 C7Hn2TbG2Wg3Rm4r+nmOBzC/bXods0hdFd1Xu+GJuN6gerg0T+MjpQytnYjw7Rqy5F
	 7QxP2slVhp7xR5DeRW+2GH6VuENDlnBMYUKOyqsJpiCuOs07RlkmKUhRF0I9fnZfu3
	 ZgcGK9s8Ddvkg==
Date: Tue, 17 Mar 2026 17:20:52 +0000
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related
 user initiated OOB write
Message-ID: <20260317172052.GF554736@google.com>
References: <20260317162426.1533573-1-lee@kernel.org>
 <abmEJJ9vWz5fiZy6@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abmEJJ9vWz5fiZy6@beelink>

On Tue, 17 Mar 2026, Benjamin Tissoires wrote:

> On Mar 17 2026, Lee Jones wrote:
> > logi_dj_recv_send_report() assumes that all incoming REPORT_ID_DJ_SHORT
> > reports are 14 Bytes (DJREPORT_SHORT_LENGTH - 1) long.  It uses that
> > assumption to load the associated field's 'value' array with 14 Bytes of
> > data.  However, if a malicious user only sends say 1 Byte of data,
> > 'report_count' will be 1 and only 1 Byte of memory will be allocated to
> > the 'value' Byte array.  When we come to populate 'value[1-13]' we will
> > experience an OOB write.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/hid/hid-logitech-dj.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> > index 44b716697510..885b986c7a12 100644
> > --- a/drivers/hid/hid-logitech-dj.c
> > +++ b/drivers/hid/hid-logitech-dj.c
> > @@ -1282,6 +1282,12 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
> >  		return -ENODEV;
> >  	}
> >  
> > +	if (report->maxfield < 1 || report->field[0]->report_count != DJREPORT_SHORT_LENGTH - 1) {
> 
> This is all static information. So this should be checked in the
> .probe(), once the device has been parsed, not for every single call of
> logi_dj_recv_send_report().

Doesn't report_count come from the device?

I can manipulate it with my user app.

-- 
Lee Jones [李琼斯]
