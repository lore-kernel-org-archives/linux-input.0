Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446893E1737;
	Tue, 12 May 2026 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595168; cv=none; b=dkFv3TPtiYnWS5MJIRuc/VCPVNN+BNLjqUZbehCxqcMocLWvnH4yM4s/MFIQSMjZsftLNBVGB+RMkdErdVaGro6YqGWC4LiB+K1FYdU5lCriOByGmYU0WQFJfdRlYrYJuUXH4fW3g/XGEXuQtCuDqsdrAEDew/W4SJKCWfioVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595168; c=relaxed/simple;
	bh=B6uFFKDPzxb1EnLNbahZuQNNPv+O32wyp/noeJIB2EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbcPt/dE+iQYZmN9ZzqQQllvWoliEKhCMCfscUlemXoOE30dPOs5tiGStB1xF8BpPFAafjXmLKkpLX59vd42u4h5Ypmc1DhdtxxEyOJUrhhuWkmeEzHZ5Iy6bjykJmH5Xjq4s0LDAQJ5ra1U/0S+9Ip0dzmhRu+1q67QR5cON6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ksS8zI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ksS8zI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC720C2BCF5;
	Tue, 12 May 2026 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778595168;
	bh=B6uFFKDPzxb1EnLNbahZuQNNPv+O32wyp/noeJIB2EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9ksS8zIeFzWqQYUPwKFUab1U/aim+ew/q+yFvW3WG7kCffS0O8VGZZLoAcLC7GKs
	 e+LEXrtEJF7v0PX0xIeRLi+cqx6neb0nS8bjFCrc1jNP1iQ/YsHJCwdyEHZWLu1Pot
	 ardEKZ5RXDce+Bp4njc/xvZcy4BcTt6WOL7EAO69xhXxjdomgkwfTAFOBsQfCp4x2C
	 uO8ropFRYKcJ39TiMx2cWPXx4oA0qRoH3RPTS/Y7cGD6b9g4/1fs4usFao7+zqTajF
	 ygVI6mMd1uws4tyDlm4x1mDaNwUn2X+TWIHfH3Om2jsXUsQFqvMxdZYVWdGkP0Yczw
	 lIfb2TyLunH2g==
Date: Tue, 12 May 2026 15:12:43 +0100
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read
 during DOUBLE_REPORT_ID
Message-ID: <20260512141243.GV305027@google.com>
References: <20260416131655.2279756-1-lee@kernel.org>
 <aeDwkQ-S6QQuK_RL@google.com>
 <20260430140148.GJ1806155@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430140148.GJ1806155@google.com>

On Thu, 30 Apr 2026, Lee Jones wrote:

> On Thu, 16 Apr 2026, Günther Noack wrote:
> 
> > On Thu, Apr 16, 2026 at 02:16:54PM +0100, Lee Jones wrote:
> > > It is currently possible for a malicious or misconfigured USB device to
> > > cause an out-of-bounds (OOB) read when submitting reports using
> > > DOUBLE_REPORT_ID by specifying a large report length and providing a
> > > smaller one.
> > > 
> > > Let's prevent that by comparing the specified report length with the
> > > actual size of the data read in from userspace.  If the actual data
> > > length ends up being smaller than specified, we'll politely warn the
> > > user and prevent any further processing.
> > > 
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > > v1 => v2: Add more size checks to protect against issues during recursion
> > > 
> > >  drivers/hid/hid-magicmouse.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> > > index 91f621ceb924..e84e6b21d113 100644
> > > --- a/drivers/hid/hid-magicmouse.c
> > > +++ b/drivers/hid/hid-magicmouse.c
> > > @@ -390,6 +390,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
> > >  	struct input_dev *input = msc->input;
> > >  	int x = 0, y = 0, ii, clicks = 0, npoints;
> > >  
> > > +	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
> > > +	if (size < 1)
> > > +		return 0;
> > > +
> > >  	switch (data[0]) {
> > >  	case TRACKPAD_REPORT_ID:
> > >  	case TRACKPAD2_BT_REPORT_ID:
> > > @@ -490,6 +494,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
> > >  		/* Sometimes the trackpad sends two touch reports in one
> > >  		 * packet.
> > >  		 */
> > > +
> > > +		/* Ensure that we have at least 2 elements (report type and size) */
> > > +		if (size < 2)
> > > +			return 0;
> > > +
> > > +		if (size < data[1] + 2) {
> > > +			hid_warn(hdev,
> > > +				 "received report length (%d) was smaller than specified (%d)",
> > > +				 size, data[1] + 2);
> > > +			return 0;
> > > +		}
> > > +
> > >  		magicmouse_raw_event(hdev, report, data + 2, data[1]);
> > >  		magicmouse_raw_event(hdev, report, data + 2 + data[1],
> > >  			size - 2 - data[1]);
> > > -- 
> > > 2.54.0.rc1.513.gad8abe7a5a-goog
> > > 
> > 
> > Thank you! This looks correct now.
> > 
> > Reviewed-by: Günther Noack <gnoack@google.com>
> 
> Contentless ping. =:-)

Biweekly ping on this please - if you'd prefer a [RESEND], let me know.

-- 
Lee Jones
