Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB9363C5E
	for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193885; cv=pass; b=Mr6Rtirm9dzdtI8uvsyFVSsDCmnzOfcdWthGOL2gKwdvRnH8Dm4ys/1upMK62PFMIy1lUv2MVxazG1cIPEyZvqtFl6yZUdDmLeRJ9bnm375hkSON7/qEPUMI2BYfwMlUZXNSLq1G79xJ3/L3SbRYOBijET3M413MEb+J0T0A+jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193885; c=relaxed/simple;
	bh=2iyufkCChmK3C3NNI3URbAXDxCjY1XVTVqwNvJiE034=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LValC67BGJsFO/j+dn1fpoyVYW5Qbpr3nkGAbVv6XxUXmRW7whRQkvntkMsgmOLB6/7vJCs2ZkCQXOjHTXreycnHDv0vFBNe7SCLmm4qGDS3ENI/PzEOmNKSdn6e34PqN21El34vTeVK8zJtcjeQ6qL2vDSGulkCj9yTukbjw10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEPDJyAj; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEPDJyAj"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-668e55bd36bso2172908a12.3
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 08:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774193883; cv=none;
        d=google.com; s=arc-20240605;
        b=JLroFJk8nxJSj2LOuV2TEYPR3LQNuhpN67S92K6ZiFHYkq1Q9UbxmEAHM0mTZjehVq
         tWw6EXLExya08KxKDO+un27SjSd33hBOhDEdxB5ymoM3U0mgau4epg61V0iM7c6d/g/e
         RsD9cOJ+shdCbpfeDqSj13Vzboj3REsATyUdnxh1+3jM2S9nW7IR1fo3qEU+WfeAaCXo
         +DO/Md8Ah6R5jPjDWRluMDd0sv87mwZfw3fl1UwBmpa/7paF6Uu8iWnU8kyy1WmwBhgy
         LZo1wS8zu7XwxxqVbMbbFuXbvjlGzQ+GoUL3NJAIo2dPutjSRLTIL2wZrHIrX1+aHbyn
         nc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        fh=g/NP35/TFs87nXGScELnyIK8Ed+4LtPThgBEqZIfN8s=;
        b=YlzrT63Mqc8EzGTCZCnGBa7Cy5WSxFDL/mu/ZkX3NsL1jp9agytJtyRVAPqpnJHbJV
         shAEFyFLG4/MhNm5A1LKxNzd/2EXVd9a8TrJOHvO7WyG5gbCNBpqk5QACUZBqnQm9V0O
         KZXW0fA8DzXRqM/W97wIMln4OdNfdOR3cQcLeLH1nzhFwFvnbBt8aVvH9ICLveyo3s7m
         JZShW7AojEZaQlhlUQuoJEsb1bH1sxYT2B5f6YCnW2N9MwKZiYUm7LjVm9IPFKpuazki
         V2hX1aG1aPjL0JQCDwZNb1+M21cC/vOCwhJfvVZInKmHjipInPVeLc7DBxmpuSJbvQj3
         g4zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193883; x=1774798683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        b=EEPDJyAjOX2+DZ7Pbr1SKyA1l9+dhoijd6tjm7unrdhudc2zruN1x9dd4IZq5wwoMz
         vTd2/634Uw6W1/YLO5U8/C2U+le8xwEPs8fMQ/PrVe7uXQ2pzO37oayyijEG/v+4KM1D
         8RaPCpPQA7lWikIjbPksP/ZswhCPOjdgOBkmhI62r1w4SafEyFx9XwrW2nLYwKpBA+OJ
         t9JNOYQGW2R9fV9WlHePEJMtrfvH3f5dGns11w4+RKKmq1tUUlxgTJK7jQsBtEsozyqL
         p2arTlgjNPpiPxKiPOToVz6WZfViNAK24upd8kY7WNRuH4INxdqX9krbm4lFCm1Gaew0
         bn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193883; x=1774798683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCoJs6JbmGbtI1WN4Udl0z6hLtb+BVAEkUCWkGIOZuk=;
        b=QAhQB7/CXVB0BPj01YgUNLF5NMVafvlFwej5pkAH5LSZjEahxtIGlAf94C7srcDu77
         sJu+gJgpTXAgNqLv4R3YFYAR3dxxFcc6Hb+vHGxqfTNXRfHgbDcGe6MjP2Wu21ieZbAf
         9S/zFXPHVPYXkJQ+C6BxseLYMRwnzxvfesk8i00KJgjdHexFY8aEGUIv9JZEC0Jyz0O8
         T0BBiq8uGMGD81rZmjM0pHItmo2VshjRg1LZ/DqaI8toYzVVr17LRfS0Wu5jHB6dWDta
         iPv2RVrYEgVX3RPAAl79qAvqpbvlZsxqXQWC8yDEa08JCpMWAfUbH/dEsjB3PX60d1F+
         vcvA==
X-Forwarded-Encrypted: i=1; AJvYcCXHtB8Fl1d7xJ2lOiE6MAMrkpS5jUzGFisfZE8vB8cNKmDVjeUzJupXGImYaJcbpA39pklGzgVWrLbi/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKcDU/TmVZQ5J5+plg9vTCucCkNY7HDLrK0M3NSQkFfiOPbcE
	POw4xNBrrGikhAUdN0KQjEdetd6NHFr5UEg6PlRjeG8yrwSVv8ylln53bsvup83HBNVigUw2NXO
	Odk7ek6VvfUVkSvP/ubgmXBX1k4iECbs=
X-Gm-Gg: ATEYQzyFubXtZx5CBUdkHg0IQhAEAJjEc7LLCn/g44Be46IVFRvR5mk2WxpU/A/eN6J
	MPACGp3xbfWAIdU9nTMHpp0+CW2FsrXdi6ga+uLHylYm6vigGiO0sPpvAMII5UIx6OSB05yD4SD
	F11yAM6/4iHYzIvxQrl57xqI/cWKybPHOco1tIDoSFtb19Ju4Mh91KAdn4XfsXQtOK5XGRm7hd2
	TR1532TPOBFCa7vEBHnhihmHCfgHW5T6m/Xo1z/+kftlgurjUWkifhNfGL/76OTrOTeujQIhc49
	f7zSeSGd6NNdTxdShw/9EbeuBRy4dkKcq0f5XqE=
X-Received: by 2002:a05:6402:1ecc:b0:668:368b:38d7 with SMTP id
 4fb4d7f45d1cf-668c93239dfmr6585165a12.8.1774193882341; Sun, 22 Mar 2026
 08:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+9Z8Yd9mRhgz0N9kSSvLR-6euPf9CRA1Sop_D8zV8wqQ@mail.gmail.com>
 <20260228172657.53040-1-ericterminal@gmail.com> <ee5fc583c7d6dad138db759cddd84e409190d1ae.camel@hadess.net>
 <abFA9nm_fBqw8mNS@beelink>
In-Reply-To: <abFA9nm_fBqw8mNS@beelink>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Sun, 22 Mar 2026 23:37:50 +0800
X-Gm-Features: AQROBzBauQzm29du9pe-bkZS9i4dd3Z3Buwh7em_P0ixOAlN6NN3EOpYsbqh59Q
Message-ID: <CAKNPVZCm9joG7szVjMa2VZuqF_oY5nBqWjjLYa8rqReqWeZ0tg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: HIDP: cap report descriptor size in HID setup
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, marcel@holtmann.org, johan.hedberg@gmail.com, 
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Just a gentle ping on this patch.

Since Benjamin reviewed it from the input side and concluded it should
be safe, I was wondering if there are any further comments from the
Bluetooth side, or if anything else is needed from me for this to be
merged?

Thanks,
Yufan

On Wed, Mar 11, 2026 at 6:19=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Mar 01 2026, Bastien Nocera wrote:
> > On Sun, 2026-03-01 at 01:26 +0800, Eric-Terminal wrote:
> > > From: Yufan Chen <ericterminal@gmail.com>
> > >
> > > hidp_setup_hid() duplicates the report descriptor from userspace
> > > based on
> > > req->rd_size. Large values can trigger oversized copies.
> > >
> > > Do not reject the connection when rd_size exceeds
> > > HID_MAX_DESCRIPTOR_SIZE. Instead, cap rd_size in hidp_setup_hid()
> > > and use the capped value for memdup_user() and session->rd_size.
> > >
> > > This keeps compatibility with existing userspace behavior while
> > > bounding memory usage in the HID setup path.
> >
> > Cross-sending this to linux-input@ for review, they would know the best
> > way to deal with oversized HID descriptors.
>
> AFAICT the hid-core code would be fine with it (it would parse it), but
> there will be some issues (hidraw will not be able to export the entire
> rdesc, so is the sysfs).
>
> For reference, usbhid just returns -EINVAL for oversize report
> descriptors.
>
> Anyway, if the report descriptor is truncated, like in this patch, the
> hid core parse will fail if the data is not correct, so I thing this
> should be safe.
>
> Cheers,
> Benjamin
>
> >
> > >
> > > Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> > > ---
> > >  net/bluetooth/hidp/core.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > > index 6fe815241..31aeffa39 100644
> > > --- a/net/bluetooth/hidp/core.c
> > > +++ b/net/bluetooth/hidp/core.c
> > > @@ -755,13 +755,16 @@ static int hidp_setup_hid(struct hidp_session
> > > *session,
> > >                             const struct hidp_connadd_req *req)
> > >  {
> > >     struct hid_device *hid;
> > > +   unsigned int rd_size;
> > >     int err;
> > >
> > > -   session->rd_data =3D memdup_user(req->rd_data, req->rd_size);
> > > +   rd_size =3D min_t(unsigned int, req->rd_size,
> > > HID_MAX_DESCRIPTOR_SIZE);
> > > +
> > > +   session->rd_data =3D memdup_user(req->rd_data, rd_size);
> > >     if (IS_ERR(session->rd_data))
> > >             return PTR_ERR(session->rd_data);
> > >
> > > -   session->rd_size =3D req->rd_size;
> > > +   session->rd_size =3D rd_size;
> > >
> > >     hid =3D hid_allocate_device();
> > >     if (IS_ERR(hid)) {
> >
