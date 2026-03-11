Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA23C8714;
	Wed, 11 Mar 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224340; cv=none; b=fR/+MkHV+JArbx12LwrrFL8FHqlFnD8G63gvsxNX4DAm9FLbWgT1DEQptnL0waWzudboF5dj2Bx3GvOk7+4vxQqmyeqa3ARLc7mZz2p0EW4k9X4kNDXagdhlhhWw4VP7f/hjGqKd2E2NURHABx9ku0c5X6ItQ/LlNI6vx5i1ytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224340; c=relaxed/simple;
	bh=LO2VOvF1JlLCFxrelSPybMAGAFqWDl+KQZmD1Nb+jIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzKpOoDVnv3B7svYE/1u2Zfg1DOQ4umMlGdPFhv2t406yRWeuJUplbOsedC0FAaWwTARULhj7Ou2eywebuufivoYIxImbm6HTL21w4R5lBmJoiAovoAPR41WoBenaeVfK8HapaPC7N4Ip1V5SdqW8biB4t67ch/EjGVnqQ5RfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1wvr1+r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1wvr1+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B27C4CEF7;
	Wed, 11 Mar 2026 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773224340;
	bh=LO2VOvF1JlLCFxrelSPybMAGAFqWDl+KQZmD1Nb+jIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1wvr1+rtBne8iqFrgnqwJzLowdvA6bEy/oMfWVeMCnUlLB9YDXfDrtjYbS6hVhsE
	 /JmA7krlaTKBv/jCl2tVQs5v7dtUQOtHcwccVNSYRB2XjTJgj+oNlb2NzqG5oBGBVi
	 taMRFRhjP4AqClhXJ7h6BYeDvH5HRHVw2B3qvyedEVy/1R6jf79ZE4cYU41Kj6OwOe
	 ahbxJLr0e2Ouq+aOL+tBnqfybyLEaWinTpNtBsn8JSP4zKyp8tZW8sznP/0Z119zPE
	 fPpTjabUQg4HXY/2iQDBtRdKXfVxRTrIHiclm6wyQXUbsVLabpHEkiVDzmSQ54ahn2
	 Ub/zbmEJ//f7w==
Date: Wed, 11 Mar 2026 11:18:22 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Eric-Terminal <ericterminal@gmail.com>, marcel@holtmann.org, 
	johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: HIDP: cap report descriptor size in HID
 setup
Message-ID: <abFA9nm_fBqw8mNS@beelink>
References: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
 <20260228172657.53040-1-ericterminal@gmail.com>
 <ee5fc583c7d6dad138db759cddd84e409190d1ae.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee5fc583c7d6dad138db759cddd84e409190d1ae.camel@hadess.net>

On Mar 01 2026, Bastien Nocera wrote:
> On Sun, 2026-03-01 at 01:26 +0800, Eric-Terminal wrote:
> > From: Yufan Chen <ericterminal@gmail.com>
> > 
> > hidp_setup_hid() duplicates the report descriptor from userspace
> > based on
> > req->rd_size. Large values can trigger oversized copies.
> > 
> > Do not reject the connection when rd_size exceeds
> > HID_MAX_DESCRIPTOR_SIZE. Instead, cap rd_size in hidp_setup_hid()
> > and use the capped value for memdup_user() and session->rd_size.
> > 
> > This keeps compatibility with existing userspace behavior while
> > bounding memory usage in the HID setup path.
> 
> Cross-sending this to linux-input@ for review, they would know the best
> way to deal with oversized HID descriptors.

AFAICT the hid-core code would be fine with it (it would parse it), but
there will be some issues (hidraw will not be able to export the entire
rdesc, so is the sysfs).

For reference, usbhid just returns -EINVAL for oversize report
descriptors.

Anyway, if the report descriptor is truncated, like in this patch, the
hid core parse will fail if the data is not correct, so I thing this
should be safe.

Cheers,
Benjamin

> 
> > 
> > Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> > ---
> >  net/bluetooth/hidp/core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index 6fe815241..31aeffa39 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
> > @@ -755,13 +755,16 @@ static int hidp_setup_hid(struct hidp_session
> > *session,
> >  				const struct hidp_connadd_req *req)
> >  {
> >  	struct hid_device *hid;
> > +	unsigned int rd_size;
> >  	int err;
> >  
> > -	session->rd_data = memdup_user(req->rd_data, req->rd_size);
> > +	rd_size = min_t(unsigned int, req->rd_size,
> > HID_MAX_DESCRIPTOR_SIZE);
> > +
> > +	session->rd_data = memdup_user(req->rd_data, rd_size);
> >  	if (IS_ERR(session->rd_data))
> >  		return PTR_ERR(session->rd_data);
> >  
> > -	session->rd_size = req->rd_size;
> > +	session->rd_size = rd_size;
> >  
> >  	hid = hid_allocate_device();
> >  	if (IS_ERR(hid)) {
> 
