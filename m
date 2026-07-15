Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E482356D9
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131882; cv=none; b=hSVlFT6IMvmmFI81XqkC8/ibNvB2hjCsO/Wfr9PqJKgnaO0NWP5+qRCmRGxTEZcnWa3kw8A/Zd+NgWD3yZzPO6d2HNkn/2V7EaqaLnvzutPJL5b4twJStuPAiVr8D0PYNvz9B+74TyHJOien49NfuMd2gcO9ewWA57a2nKM44NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131882; c=relaxed/simple;
	bh=CgCDTCWRSJkLOMyNqmIyUWLC21lERecNvLqhW68S8k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPY5qvyxqYpjG7Cz76wlJ7A0FvfXnot1axftUw/2YFsTj/gfLsxl8NnyY8LpWpYE6YRNDoQir2i9U/I6XYY3vWewtWDpatXm56WViCzWUCflJw7C4GBtAUXuLby2tUoNGkuMLZ1l3SvqRfPv3V37CGiXqZAzwMU8iiQiHX20rIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JA2kVIyk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfwkAb8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA2kVIyk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfwkAb8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784131880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u018p3vyJrvV+UM2lycGYWrJgbwr8WQB52QeOVOHYUg=;
	b=JA2kVIykoOh5/6/33a7cK0/Mthps3gv36spCOtMOC2xvIs7IjfwnoxdiNLSlprYP4x/dlQ
	ZQsYukeujkZB1pfMGQ09oCeML26mRBUZyZRPNVESGlUmHm6Mev6e964xb4LHo4kg0qP2c9
	aLrZ0jLjzj2h3gNaMOYgFStwfvCbFNU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-DglMVsTqOfCxVmqj54dH4Q-1; Wed, 15 Jul 2026 12:11:18 -0400
X-MC-Unique: DglMVsTqOfCxVmqj54dH4Q-1
X-Mimecast-MFC-AGG-ID: DglMVsTqOfCxVmqj54dH4Q_1784131876
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so50906495e9.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784131876; x=1784736676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u018p3vyJrvV+UM2lycGYWrJgbwr8WQB52QeOVOHYUg=;
        b=GfwkAb8zs3O1zW+Z1SLtQZgEYt/4ozs7FVOtlT4DHWDkQD0EwgWRFVeBhSAv5wtzLm
         mSylsG0/gZNoIIRtLiry9TYwT+GmF8P4y30/63wz/lxSDjf9ZbwVEb+jKC3ADRPf4edK
         yiSFQKNAXNWkHeQ8yy3Oybf6q57acng4foxFQ7B14qCDUJUzGCPXJIp+hiB+MxWbGWmR
         /1C3tvezga/xp4SbpZVBfzoOiOa7SCjr2/XNgjku6u6FeziSdp1UWZXwj1ANwVaqZw9d
         LtLngsnem7kMs08ZbuEbUt/Kem/oov3mJKUz9r0TBoYX0PtVPSQxKGNDxakMr6ftL8hk
         smkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131876; x=1784736676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u018p3vyJrvV+UM2lycGYWrJgbwr8WQB52QeOVOHYUg=;
        b=rBb63M1ERa1cPaqlobobOFD0J+yiz1Z4Jv1eC3X5eQipSPU2LRNfvIE0X3cI/LdBq3
         80p6lQ+swJlrBjqFD0C/IhKCzUZxfNNybnWciE33gTRnseaaf3/ZHRKSt1pK3gh+R1so
         q4TWsNw0BILCQXA8y/JMiUNUrb6dWn8xMI/G5jvlohrN25gSZN/GQRpCcvIIzQ7CctBJ
         F1qjX4cTqn5JZwSiF0MRUezlvtssNqSRTrl68CSHS1orkrgfPztKs5nBx3VrRTw2/gMP
         b8sitgwS3aq4W0aNlpHXnDGbDw8Fu8BiQBlV+PFQsEHGdP8hFIvYkX6NEpNGvlvFhRAX
         Cj3w==
X-Forwarded-Encrypted: i=1; AHgh+RreESQqFzzczAqECa80kv0nv+WgQukQ0Hpsp7Lg0G+R7nmrNjP8ua1Cc9MUK37+VFTa2u1OwIcmSh8w7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTzWZ/fpfh0lgp6ZA8vI+LH/N1S00klWn2it5mu1fHQ6pLQbB
	ZCDBvZRZFkxIp4bjIMRIyDgMzGrHLOwGj79QWJ7+3TE+BkQeEQjm6LPmGCkNL7EvJuEON6qFt98
	jXKd3CFgGg/ThXY26fd+JCPD7VfptuNSZh00tUNR72JJQxmy0iHg3Fnox6pwgWbfZ
X-Gm-Gg: AfdE7cma+TPrvVH3tI3CIITj+LWFeko3gqTek73HzFW/w/KydEQNPAkL3qXSgy7pUcp
	/PtMrEPdyX9oS6Djgc6pNlMRIshMgeURWKUVa9Jivvu7kHX/n1VKbxPsvxvbCUClqOOKZ/h3q7v
	FMbv1qFueoLVYyP0hFqWow/NvTLDWeulVY3rAKBMY6GzR20psucdZezRtoNzRmagVO6w0O183h6
	AKC9KxfwbAjrt+Z7ruM3EGyc266SdLA+nDSu4yZkrJeyIVeqL1GyjV4heEDcxwwDja2hZDYBvs/
	p1YljKrBzB8bkvj8aH7GP+EdOInQVVxpey8bd3ygkRBa+sgNARqFRcyEVha4H8n+eJt7lApM7dT
	Ei6vFS5CD5JzTaBv8hmv6/ltzecvWz/ICW04=
X-Received: by 2002:a05:600c:6207:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-495389731b5mr84415795e9.0.1784131876345;
        Wed, 15 Jul 2026 09:11:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6207:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-495389731b5mr84415185e9.0.1784131875797;
        Wed, 15 Jul 2026 09:11:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c710facsm39394605e9.2.2026.07.15.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:11:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:11:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20260715120911-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>

On Wed, Jul 15, 2026 at 06:07:56PM +0200, Hari Mishal wrote:
> On Wed, Jul 15, 2026 at 5:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > > virtio device. A device could report a bogus maximum (e.g. -1)
> > > making nslots = 0, which input_mt_init_slots() does not reject;
> > > it returns success without allocating any slot storage, silently
> > > leaving the device registered as multitouch capable with no
> > > backing state.
> >
> > So let's disable multitouch instead?
> >
> 
> So rather than failing the whole probe, just warn and clear
> ABS_MT_SLOT from absbit in that case, so the rest of the device
> still registers? I took my lead from input_mt_init_slots(), which
> has its own internal cap and returns -EINVAL when the device
> reports more than 1024 slots.
> Shall I modify that case to get the same "warn and disable
> multitouch" for consistency, or is a hard failure better there since
> it's a different type of bad device data?

I don't really know enough for sure but generally if the device can
kinda work it's better than not working, and adding
a capability to a device that driver can't use should
generally just ignore the capability, not fail probe.

> Happy to fix it either way! Just want to confirm before sending V2.
> 
> Cheers,
> Hari

