Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED50346AC8
	for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810968; cv=none; b=lT2Zqo6tGFIWZNIunzp9l7h6eGP1uTyweZt//v6EnYA+YNFDKslupLUvO+5zRFImXXqbel4fTWdmp0V5AHx5Q1LtipOo1GE8J4mtEbm2gzPREaxFV8qFK1ihgL1bOh7pn/b5zB7GrSwoUR8+o0RFTe3Wxbi1L3F28ZJyuMRjvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810968; c=relaxed/simple;
	bh=8lpfQsDvF4mwzKhC0ITKFu8cLvYqD3dYOKf370vXa+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QB6H/W2L5+AdvYyUITeuJ4La2VqTSKieZRo5DB8ldxmz/eBJoKiOH8UM2iYACy8zmzWh+vbMx2/GjYexwBjuWsWCkpgH7tClblKKeEhgZOCufmgDlRlRUtK/4UxufWdwvHIrVHtLkhbdMQVNTXGZgHVrOgNKa0mSOHke2NNiDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEYWMU5k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hogBFFjo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEYWMU5k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hogBFFjo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769810965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lpfQsDvF4mwzKhC0ITKFu8cLvYqD3dYOKf370vXa+w=;
	b=MEYWMU5k/+Tt376otjFLV/AXmCINBDEYmtqXYueJTEKNOaoSQuYw/NYzS5iuUzsNKBGLpB
	R+wJcN5sIqKyBPw3OG3MuZtoHhJFoBj2ZYX5hvcdAdLXoHaIHkOWoBtbTHCqpokHxJ7lKI
	pe5SliLgNCnTWIPsdR/SfHNjNbyasig=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-sg3SzNuVMgi5Z71QBIz5fw-1; Fri, 30 Jan 2026 17:09:24 -0500
X-MC-Unique: sg3SzNuVMgi5Z71QBIz5fw-1
X-Mimecast-MFC-AGG-ID: sg3SzNuVMgi5Z71QBIz5fw_1769810964
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-503810dba87so130214131cf.1
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769810964; x=1770415764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8lpfQsDvF4mwzKhC0ITKFu8cLvYqD3dYOKf370vXa+w=;
        b=hogBFFjonTOJIHX61sqYVy/qHeK2pK75n0dKjgq1hkYekrrLg/m4mm38ByzmXUqjb7
         o6GtfHcjtxk29j74NGQx3XagZ8EnjxiClGle+zMiId7iJd+v+R2yM27cQIWPZr2KsVDz
         AFB8e42czmB/mNtSSWXTFnjhJ7V8QW0PBP5tnjjz8YKSqBZEQHRcsW4XQmeS/2jOqplS
         aJhqVOkqow0G9e1843SB24YieFr72aRrOiHFbO51NNqDl3VpFOKF+y4/TC8lRwFlIpep
         jbXfZq4UCdqLeELT9XDB9kBQ1cmFo2Qg3m9LzYI01seT48cF/lXUNcuAsZW0SYTJXcd2
         MDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810964; x=1770415764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lpfQsDvF4mwzKhC0ITKFu8cLvYqD3dYOKf370vXa+w=;
        b=lgLRTFF52tL7Kd/p9PdrqwOCiOz4u2UNsyRXwD7tZsjidXQXegGkkDBMmPmFowCGd+
         UPPefJyLZED/ivpmNguZFToisCgqOA4Gzuv89zDokykBfYg1H5VcAUiGyaw+38EtLaST
         GUphC4JgdsCE/L/Dru3Cv3bB9Aer+SC1Dd7eRhtpnqT1H9L60gx1KoVqOvlevF6ukFqo
         0jn8Ni+jEMKjxenpmfDURYUqfR7rDP8V7CVZQ+dtaInk8xLyDfvQpYNUfGw2u/4izGJn
         7M1taDk7iKSgdubqjPePmpPSQPO8HWTjRQ5Ntae/JhnJ+SApEZKKVRRU2PFwh2GWELx2
         DEEA==
X-Forwarded-Encrypted: i=1; AJvYcCWUmww+xI2LSm7hNeOHAqGvQfzpcwKI5HSF6adFmiAYDXh3LR0QJjSNZ4N8IkP9/GZxdHA+z0llqxL1IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJsy/pC+3ceOEeRTOiIW3VXmrIDge9yAuAcP2DR0pNutVkXSJ
	aWIM1zBb54/cVlSizHjpw7YqFabxJJ8PU9JxGCjWOZ6/qttZhI2gVzQ+GgO95OlEvhRxX3M2/JS
	PtvvQ34cO3bEu9Tl80SLhWWznmsWngLV3KOwo7qDFAznAKHwxC9c8R+u/XfqrG+7S
X-Gm-Gg: AZuq6aLU+ZFF4fCLOt0bBzu9Mtk6jQ27b2w4K/p/38jYaBV6WRKQfqGgr7IN5lPQdoM
	vxkkuaLrnfjDrgphutiIN+T+KW214S4nwQ7LM9KmtqSI9syFfs7OjdYiuk8oOTHsCthKQIPw9s9
	BJoAqtx20W/eApE9FqorabhQqx286Vmc3tgbdETVKkArtDw0hgkUqqOqIU+LJkXhoc6YOJU5h0u
	RnLCS8Xoaeqv9eXHpb4UlAaoD/5CNzsJd94n99zFEm5DVR0ZMrwl5JZwp8FFlog++Ku0/BhYB11
	QVxWCSJeXKy6YRryI9f3ih6mdBUBPczw7l6zAMhE8v4GIhQsepSIQ/55O/QNKx+c1wGM+cn/pYk
	j6Qbc1A==
X-Received: by 2002:ac8:5d48:0:b0:502:a06a:fe5a with SMTP id d75a77b69052e-505d2289c3emr52699561cf.51.1769810963685;
        Fri, 30 Jan 2026 14:09:23 -0800 (PST)
X-Received: by 2002:ac8:5d48:0:b0:502:a06a:fe5a with SMTP id d75a77b69052e-505d2289c3emr52699251cf.51.1769810963206;
        Fri, 30 Jan 2026 14:09:23 -0800 (PST)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033f0a8466sm52120721cf.18.2026.01.30.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:09:22 -0800 (PST)
Message-ID: <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com>
Subject: [Poke?] Re: [PATCH v2 0/1] HID: switch2: Add preliminary Switch 2
 controller driver
From: lyude@redhat.com
To: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bastien Nocera
	 <hadess@hadess.net>
Date: Fri, 30 Jan 2026 17:09:21 -0500
In-Reply-To: <20260109034034.565630-1-vi@endrift.com>
References: <20260109034034.565630-1-vi@endrift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Dmitry! I'm sure you've got a lot on your plate, I just wanted to
double check that you had this patch series on your radar since it's
nearing 3 weeks (and V1 of this patch has been on the mailing list
since early November with me being the only one responding to it).

Is there anything you need from Vicki still, is there a chance you
might know when you can take a look at this, etc.?

Also, thank you for any help you can provide!

On Thu, 2026-01-08 at 19:40 -0800, Vicki Pfau wrote:
> This is effectively a resubmission of the previous patch with minor
> fixes
> for issues that came up during the first review. Bluetooth support is
> still
> not included, but this will hopefully provide a solid foundation for
> bringing up Bluetooth support once BlueZ is capable of bringing up
> the
> controller. This will probably require a new plugin, but
> investigation is
> still ongoing.
>=20
> Vicki Pfau (1):
> =C2=A0 HID: switch2: Add preliminary Switch 2 controller driver
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/hid/hid-switch2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 975
> +++++++++++++++++++++++++++
> =C2=A0drivers/hid/hid-switch2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 242 +++++++
> =C2=A0drivers/input/joystick/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 8 +
> =C2=A0drivers/input/joystick/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/input/joystick/switch2-usb.c | 353 ++++++++++
> =C2=A09 files changed, 1609 insertions(+)
> =C2=A0create mode 100644 drivers/hid/hid-switch2.c
> =C2=A0create mode 100644 drivers/hid/hid-switch2.h
> =C2=A0create mode 100644 drivers/input/joystick/switch2-usb.c

