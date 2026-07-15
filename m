Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4827400984
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139942; cv=none; b=ZyJ09KcnGvw9jnEVQFe/wbzLq+L0ODbAlu7fU5ZhnfPJa5jY7EMAb215l9eG8RGDhT7cXZUyJIbK3hwRk84PIb6P8pjT9e4Ns7sKa58K7KzJvnDuDtfh9vX6eEL2unDZKyHhVZw4epJl1OTzwa5TeB7UQKQqFN8FsYDnnfXeCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139942; c=relaxed/simple;
	bh=DRwysxMywiK5ujH9sdqFUZ+KdT3HQ5nuOGYd5rSddew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+ZNyTuFzc7m9ZKXZiZy8keYmoDyneE8U2xlsv5cud6WREGjYZcqEKvrFDBqN8Ca0It0tJ4W31CYZmqziukqDDGo+h8R1Dcfb+6LbiPXzkYuxV81GA+fLk2FBPO+G55aIu/FZcOR8HLfJ4aLd4BSQBmRD8TV0rG9lwvOUr0pNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwz5TbjM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwz5TbjM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceab75934dso53965135ad.2
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139931; x=1784744731; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EObXVbLcL4fdK7Ek+PIS7uUxJgkB9+Ku7XE2jyg9/4A=;
        b=Bwz5TbjMado1C6A6RRI/Vur9RaCSAVQEPGN1137/KqNGbcNJ92biwnBMRDcjcNDyrd
         Autx45oxMjSzUniOSpH4OKb9xkR7a8MV/iHoZizBt6J96EucFdbIonxFMwBT9XGDYoyj
         OLoVu88mnl+inND12Yj5/6yeoQgQy7IPTYPvIs+x0j4oNBHUGpIJ9x8sHiaHUlA9paz5
         QjkSfC+6z6QNPMX1O6nek1lekhMSiiPeNNG9ltTMXTauprRd6C8WL5sLkA43aGGscnWk
         cU+4Ssnd3jlC/jNutlYM8sIKg1Es/czmiOwINBroBFcyybD3uTwNlprOEH4iWWrpE5QK
         FULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139931; x=1784744731;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EObXVbLcL4fdK7Ek+PIS7uUxJgkB9+Ku7XE2jyg9/4A=;
        b=KsOK/OoFeY71iqX/BoHG2lqQEqzUx16Idy3pDRKn1mlf6GBG8uOC+/FloJd5XJVfpA
         99zVEmLhXIxfkceYik/G78bRAVI4HL+fmuueMTaI5Gq2ia+Eq4/q/lCkX8IeA+EpEUOu
         AX/E7jjZDMmYvFbOPaHNWpzPLWPs2rnQpAXddsJGnd55sf/XwT04o7CyYToURaU2cf8h
         hgNDv46cYZ2LRuZ2YEC8zIaELorsrmfpn0fs13+ZWPOhgm0Eru1frY/i3UzYJar0692y
         uHfkcAoChcqynKXuv0r2sv7trK/RR0IhTIYbblYBl6R4otunSEr+NkFDVDgrtMflNeHv
         OQ+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr1qIukwhk/rjKpbcQ0H6IQBKS4lXkmKa/RPzUfifwaFN24RKY0zXWsDvXkt8V8s0jfJVW6n5TGKeAriA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNZOt7HDtFmCwJbVxx29WsfK49LPF+cihbJqFzmX1+u4tZM3v
	5FK9X82Rhxqm/wuHlleT5e78zcUHxKjRlwikH2+Etqad62fm+9HrZrC8
X-Gm-Gg: AfdE7cmrTyccjh2ndBSLE7gxT/DVHmLvG3DF2tr+K4iXzp6sKh+HgwxWANdvSfuU4Lu
	MB6MTTAAo/wBtaLCOXIkVsk4SUWrtDGA78wd7MunfjBRHJnml61yoM4oGnWFMqX28FJ7aYbFzMM
	4kq8Fh7Y6ehcoS/BdmYn1LMe86aijz0+bnCGMR1HnEN5i7LvPYfhOB6bEyzOBaiIrG4mCdmEX+j
	VDPgUz9ijZ/DTo0hMjpluNxYUS/tFlwLPdwcf6E/keVDsNGCCdGPVH4/8Um8fkw2hkWgjIf03+s
	qbWVvG9+Z2YIgOG/rQvmUdiFPGSYBfGvtHR5aWjbAgVpH9mzBQpKFHNkN7Jsejq1rP+EXCujeZT
	FOgVv75ZK9zT6txzQ7QTphQUZStJKLPjLj5Q8cAFo6VbCiU4WUNt2t225L68eEM7CyO4l+pA9u/
	lJyOhvhKMqLJe9r7JblgjOa8UyYN950TbKnOgOthmCSIlhnLS+b9nj
X-Received: by 2002:a05:6a20:c793:b0:39f:24a5:3065 with SMTP id adf61e73a8af0-3c36c0f8f74mr3900110637.7.1784139931134;
        Wed, 15 Jul 2026 11:25:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd26sm3077101eec.5.2026.07.15.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:25:29 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:25:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hari Mishal <harimishal1@gmail.com>, Amit Shah <amit@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <alfPcWKMGL-S9BRl@google.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
 <20260715115018-mutt-send-email-mst@kernel.org>
 <CAMmC+=AnE-p7B=DbBPYeNzJdcdiBf7q=5bfcuV0VQrPRK+pmug@mail.gmail.com>
 <20260715120911-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715120911-mutt-send-email-mst@kernel.org>

On Wed, Jul 15, 2026 at 12:11:12PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2026 at 06:07:56PM +0200, Hari Mishal wrote:
> > On Wed, Jul 15, 2026 at 5:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> > > > nslots is derived from the ABS_MT_SLOT maximum reported by the
> > > > virtio device. A device could report a bogus maximum (e.g. -1)
> > > > making nslots = 0, which input_mt_init_slots() does not reject;
> > > > it returns success without allocating any slot storage, silently
> > > > leaving the device registered as multitouch capable with no
> > > > backing state.
> > >
> > > So let's disable multitouch instead?
> > >
> > 
> > So rather than failing the whole probe, just warn and clear
> > ABS_MT_SLOT from absbit in that case, so the rest of the device
> > still registers? I took my lead from input_mt_init_slots(), which
> > has its own internal cap and returns -EINVAL when the device
> > reports more than 1024 slots.
> > Shall I modify that case to get the same "warn and disable
> > multitouch" for consistency, or is a hard failure better there since
> > it's a different type of bad device data?
> 
> I don't really know enough for sure but generally if the device can
> kinda work it's better than not working, and adding
> a capability to a device that driver can't use should
> generally just ignore the capability, not fail probe.

What is the failure mode if we keep the ABS_MT_SLOT capability? Does the
kernel crash? And if this can cause crash then we should fix
input_mt_init_slots() to reject requests for 0 slots with -EINVAL.

Thanks.

-- 
Dmitry
