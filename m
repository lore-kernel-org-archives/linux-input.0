Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470C39C657
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345555; cv=none; b=Uqr/gEFN94t5jL56SORu1HphmV+ImmZB2ogrS0Vj+CvtkrHHtHEFVqePrDrcek5rbmzpwtEZE5+/zleQkCi8pmHGnyuZtayLSoELQc1ijhMrgpVUw3BaKf5C5iyubjUEKJfzCLr72QNLBMfsgmNDaAUKl9kwd87a8cPCXFRahyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345555; c=relaxed/simple;
	bh=KiYTJr6ciY41S0faZ/K7ky6D53SOLmHv6iAAKkbh7HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtiU4FlEE7+N++l0932950QgUPEg4+Y3uxNPrCTR0apUCnux3NSd5C6dp3d8B1n6MXqAjf/5ysVjCE7zBhnphH03QiVLo+Po45DR54cdfs4PnP0z2rZ+kvNJUX6m00+EWZAGvbKO6hET5fnau/YwMyIoGQHZfQDH2+EyGbGf5iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da0s6Tiw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKy8TVbR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da0s6Tiw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKy8TVbR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786345552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vr3vIYuq7lla3+ZHZmoYb7uvd3kFa0mXYvvwO+akg2g=;
	b=da0s6TiwCuxF+W/ODYcWscNxlXl+aERkYPOm7DV9715dENw1lwFz+TRMtnmC6zRMqsgHLJ
	pzwqQ5zLfvM1zJ8u5WO3qpVBKPmoUEXT6fDdDJRGKx2Ow+6XI9bKd2Cvbpa9Ie4Ywz6Z+V
	OBT5oOZyXvPLBLDSmNGUZbJekkF6FzM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-6O1khr0cPVG4qycOU3U_zA-1; Mon, 10 Aug 2026 03:05:51 -0400
X-MC-Unique: 6O1khr0cPVG4qycOU3U_zA-1
X-Mimecast-MFC-AGG-ID: 6O1khr0cPVG4qycOU3U_zA_1786345550
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso14769225e9.1
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786345550; x=1786950350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vr3vIYuq7lla3+ZHZmoYb7uvd3kFa0mXYvvwO+akg2g=;
        b=XKy8TVbR8+mJ6B8l5YnrSdxuACPKqSIcBBXgZWhy5XOXn/32+mEu8YMeg0fgIxXqiM
         CV4I79q4zhceEXXpdFJbvNAXdaGHSoQxaMBDNxsm7UDVRqUTXqc9lu1PbcVhSj4ltR9W
         chb/ken5S6j4N0S33Kze2BrNYCTAB4ELVFlnqPcQ1Q8dFtjJmht3tgCZb7i4WL+sYzMk
         LkstPJYzlYk7n9/Lgya79nZpHAaKt4Cr/9ySM0V0A2GEpHPMFmBLfcwpyjKRp9PXhDi7
         7GJJ3w1A1EKQGVs0J3IzCn5ePQRVoZYlrcmTYR/N6q6F3PemR+spvzRjyeAu7p9HiTWP
         LKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786345550; x=1786950350;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vr3vIYuq7lla3+ZHZmoYb7uvd3kFa0mXYvvwO+akg2g=;
        b=ZtLO7nngef5iri02ZL+VFjH71tlzliSXbkiM7jQ2wI9dp//UKXKz9G/cf6+ZKaMUY5
         OuEwTLa9tBE1rFTKaioOpeIcF1WttdzIOIwW/3izQUW8z0aeAdJCi+3IT3kRpsWmpXoB
         szXRQG2worPDbJrMxEDiXLcHaErKUnDOwc+KG3hTearR3vvrP/bVhVVBHDQStnHMRXM6
         xxbqzbw4Ffae95i13ItFbyyqJ/z/2TVGad40KLnbhBPdjJmW0FLswwXTodwo3+SOcCwu
         KLTCCc7x02GcvisXWQUfuHxI074F7iGRHchoJI+UxW5e/QbM7CISFai9D8xyivPUdGOX
         dQBA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1mXeaS1SpYag53M31sJMR7uZ3tBXlIOn3tVtIvSM9bFIb6Mlj48/ZJq5qP98zhin0ikg9SVnAod2uDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62BavS3AfIqWYrpPFOz7Lu8tJayKAqVG9XzOQkYf0YeN89Ukk
	77pc5wA4pE7Wz30yoSgWHKzSG8XLmYKi9CTAIT4oEBO4X4ZPUaYFReN1RQ1G7a7H10sfgWemXJF
	yx0mc3E1sCQV0KHKEFxPmUPTvR7l4A5CykUTvmm+RAP+4UanpxGBTKRoTPYRGVB3u
X-Gm-Gg: AR+sD11/ScqlUDUnTpWeUyaW0ED2lWZoUMjp3vplTzdSn6fTEUYykoTuDMtbBcaaKAZ
	/IHWPLyYwXBboWdU+x+VmwRiZcG9iGHZeT0KufzSxtASV3bB+tTUTiN+2aRh1wFdYkiQpIhhftZ
	94pfHJAK/isG8CWQXdTD3H1MIoOsp0wSCnWrEXIt3pJ3GemsUDC1HMDVQ7dl97vzSj2CcPtxo+1
	r3RFA8gcGZcVZdLA13PxnPgbhmEo6To2Pw3CZTy6dKd1fLKeA2tK8RVXO6fITqyIiouk+gauMIn
	Yi/9CcTuUdVN+Waa71W5xRpKHwDHgJuhmSGljWykESmrfkWL5J8Dr3eebd9CgYqvrYXRPVKwPPD
	vEKVDCfXemkBzp8uAvdx9sA==
X-Received: by 2002:a05:600c:3b88:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4996194e24bmr260255035e9.1.1786345550232;
        Mon, 10 Aug 2026 00:05:50 -0700 (PDT)
X-Received: by 2002:a05:600c:3b88:b0:499:52ab:a50c with SMTP id 5b1f17b1804b1-4996194e24bmr260254165e9.1.1786345549684;
        Mon, 10 Aug 2026 00:05:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm395892805e9.3.2026.08.10.00.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 00:05:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 03:05:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hari Mishal <harimishal1@gmail.com>, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <20260810030400-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
 <alfPcWKMGL-S9BRl@google.com>
 <CAMmC+=DXS=xs0CZyf+N-71NT8D51xQYatBv=dfVQC1aBohDdmA@mail.gmail.com>
 <alkTnRb9qhgcMGGi@google.com>
 <alkU66ViqO8pnjQQ@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkU66ViqO8pnjQQ@google.com>

On Thu, Jul 16, 2026 at 10:33:04AM -0700, Dmitry Torokhov wrote:
> [ Just realized that CC was dropped in the email I was replying to, so
>   restoring and resending... ]
> 
> On Thu, Jul 16, 2026 at 10:28:36AM -0700, Dmitry Torokhov wrote:
> > On Thu, Jul 16, 2026 at 12:34:57PM +0200, Hari Mishal wrote:
> > > > What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
> > > > kernel crash? And if this can cause crash then we should fix
> > > > input_mt_init_slots() to reject requests for 0 slots with -EINVAL.
> > > >
> > > 
> > > No, it doesn't crash. I think every place in the input core that touches
> > > dev->mt guards against it being NULL: input_handle_abs_event() and
> > > the mt_slots check in input.c, and evdev's EVIOCGMTSLOTS ioctl
> > > handler all explicitly check for NULL and degrade cleanly instead of
> > > dereferencing. From my understanding, the worst case is what the
> > > original commit message already covers: the device advertises
> > > multitouch support it can't back.
> > 
> > So what? I still do not see the problem. Let's say I have a device that
> > properly supports multitouch and has slots, but then never sends any
> > events because firmware is buggy. How would that affect anything?
> > 
> > If there is no crash that I would leave the driver alone.
> > 
> > And we need to remember that we are dealing with a hypervisor here that
> > normally had higher level of trust than the VM. If it messes up we do
> > not have to clean up after it. This scenario is different from user
> > attaching a malicious USB device to their system and getting owned.


This last part isn't always true, while hypervisors are generally
more trusted than a random usb device, the level of trust isn't
always higher level than the VM.

Still if it's a theoretical misconfiguration that leads to
nothing bad, not worth special casing it.


> > Thanks.
> > 
> 
> -- 
> Dmitry

