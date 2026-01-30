Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7412D23B6
	for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811289; cv=none; b=Vnbz/SnYiqAJ649zDU1aWbOvifyrF9CJw8oj3HDUJtycSJUXHFwfYzhrS/se7lnQtoWACDsQd2Zn+ZrDcxB1tD0utzSujV7iepF2Ew6qZwtVbeVnovEwJ5ZYChlg3D/YRghh5FpDjfVOAQMMhVhLVL5KTEZbHHySQ1Tuaz1CC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811289; c=relaxed/simple;
	bh=kE0+jJLKhz9RvI78lFmovMmo6aMFg/lnrqp7YH9UH9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8C8DmrxnhL9xdrhNtllRD79Nju2O5ozA2fID1gTEAL1tIBJlOrjmfAmujIlPyEm/39mxSACyFRZbCZ3p0m9usUZ9R+NpVTZpnu90wStgIbu1EDJGwgEdnXWDxUjfzf9K+tMVBEoyJLQeGZQOsLxX8BjqiYq44uA2o3u/dJhj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7MvD4me; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r8ehmWpZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7MvD4me";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r8ehmWpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769811287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kE0+jJLKhz9RvI78lFmovMmo6aMFg/lnrqp7YH9UH9A=;
	b=h7MvD4me3IvPitoMma8aTCBm0ui8SSiPEPtYh6GOnXSMQGvJO5ps/hoa9DclCxMzpYpqgn
	97HO/VqzScNgvRA0Y+IXgrA+8YOE31d+leRji3y4r9qi3IBWMyAo2fhQMTcODTAt6KdgHY
	VWpxFWsumXqYOIgUxBpdNV38XMoS9bg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-lwROrSfePqSuqvzd7sxj6A-1; Fri, 30 Jan 2026 17:14:42 -0500
X-MC-Unique: lwROrSfePqSuqvzd7sxj6A-1
X-Mimecast-MFC-AGG-ID: lwROrSfePqSuqvzd7sxj6A_1769811282
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70a62ca32so696336885a.2
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2026 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769811282; x=1770416082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kE0+jJLKhz9RvI78lFmovMmo6aMFg/lnrqp7YH9UH9A=;
        b=r8ehmWpZaFkCbZVgwPI8jTt12yCs0O57p8/TxfRBmVpqBfLHz0/Zw4Rq5hwDDfqT4o
         STHOli1CNxyH94Pz1YyhSSpWMDWjEMTw1KBjiLCk6Ah5S5hrWBq9ghBf0Fbvn14J9L4w
         QojqxnZX/PQbqo2i3nu+e6tt30Msxc28caaL+pxFa330I8GUBrK7BMGsSty26Os/KfpJ
         SOPlyH//5v+qmrACG34dzYUaLRidPbDBuOHkYJYmvGsSVolXTpK9u0PukOINkZu/MUZo
         oDesBJy3BJRsF3axJQP60U/uGDivLaHCDrQA/ZvbeKgStkUFuzbYU1iAKjNHFyDLwqRs
         +TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769811282; x=1770416082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE0+jJLKhz9RvI78lFmovMmo6aMFg/lnrqp7YH9UH9A=;
        b=pLxuaSepdCIHLQKHCtNJPCSH3+Q8T+3H+U7SCdHVHEOww1HWRYA0k3SYMhvwXxyVb4
         X+vjyc0R4lcy1WhU6iVRw/sZlpLVscGPoWv0wJeyR0tX/ShRQ99us3WYV1dGRCDhLrNF
         Ptb9Xx3rB/AZw8Va5KN4B7YYtITWf+ScS6eYRW6SpXWTJhCWOvVnGeaIxz1LTPpMUiXQ
         5ZlB5GVP+D+QL77pAJOmV8dYqqa3drHLH6dLBIeW0u8LF5rSiUKnGzjjbVufICGgZDwL
         M7380woBDhwJvcdUwAvEmgnOBJZFb2A84sU16tNdx39t9nCTDFNqNb9bUmDN+CbE5gfO
         camA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwCtHrFJ5xxeHZ64xHPkfaN8uqZTR63FPZB8ZOpY61dQfnstx+s4ZsSGCSdaVVXNDTDEm0okwZkCURw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27QgVeflLBhi5hSxJniwMIYMx25pyspinVUK3V0jcb6FMu1CG
	XKWEa6KQ9R0zG3VyfX0feUF1eOmsT7+I5wIbjShhFvVxh+h/0bEs5To8rTtZ42XvDqwSM3cwYUt
	LbCsR7YLBKOPFnuUh2ksd84uI8fzzL2q/8ogFWBAu7VeLvWqu5fuyGSnoK/TLI/7Q
X-Gm-Gg: AZuq6aKLBvzcOBPMMBUTkQZQMCsnEo/DGD7KJM/SOS2kS094MDdxkwNbq5TQqHW68Tb
	O1GCp/4DsRzasCy7NI7d6H+KYEMU3qP+M2dKz7DhKeYFqXScgvCoGLc9FCQw77YGv0eka/2sAha
	g8p5VR+6ex6uS4gKuk4nlULZZugnSPAcX/9++GaRwNtUIb3tVtnXPzktqx4h97kGRCeE5PWynYz
	AlyEYfd0oHf9tH4oSoGvAA2su/HV3gxUxHEJ+Si/rFRFbItIbvszZgrChWSecAuhQXFjI98nFvV
	KkO5iHOCh89BnyC0TiCOigrKZ5MopLlKQgj8/TVVdELYvFQ786qqL7VdiGI9bKXcNWG794FjLrC
	PPbjfRw==
X-Received: by 2002:a05:620a:4103:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8c9eb24c782mr627567285a.22.1769811282374;
        Fri, 30 Jan 2026 14:14:42 -0800 (PST)
X-Received: by 2002:a05:620a:4103:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8c9eb24c782mr627564085a.22.1769811282022;
        Fri, 30 Jan 2026 14:14:42 -0800 (PST)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894dae83f1fsm54163916d6.38.2026.01.30.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:14:41 -0800 (PST)
Message-ID: <721a51815d1cc21aa22e255ce31598035b687592.camel@redhat.com>
Subject: Re: [Poke?] Re: [PATCH v2 0/1] HID: switch2: Add preliminary Switch
 2 controller driver
From: lyude@redhat.com
To: Vicki Pfau <vi@endrift.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bastien Nocera
	 <hadess@hadess.net>
Date: Fri, 30 Jan 2026 17:14:41 -0500
In-Reply-To: <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com>
References: <20260109034034.565630-1-vi@endrift.com>
	 <e66735b6e1b0ac4db3dfd2aaddadcc9ff052beb0.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

aaaaand whoops. Sorry! I had gotten asked for help getting attention on
this but I realized I just poked the wrong subsystem maintainer - I am
going for HID, not Input. You're off the hook Dmitry :P, sorry for the
misunderstanding.

Bentiss/Jiri, any chance this patch is on your radar?

On Fri, 2026-01-30 at 17:09 -0500, lyude@redhat.com wrote:
> Hey Dmitry! I'm sure you've got a lot on your plate, I just wanted to
> double check that you had this patch series on your radar since it's
> nearing 3 weeks (and V1 of this patch has been on the mailing list
> since early November with me being the only one responding to it).
>=20
> Is there anything you need from Vicki still, is there a chance you
> might know when you can take a look at this, etc.?
>=20
> Also, thank you for any help you can provide!
>=20
> On Thu, 2026-01-08 at 19:40 -0800, Vicki Pfau wrote:
> > This is effectively a resubmission of the previous patch with minor
> > fixes
> > for issues that came up during the first review. Bluetooth support
> > is
> > still
> > not included, but this will hopefully provide a solid foundation
> > for
> > bringing up Bluetooth support once BlueZ is capable of bringing up
> > the
> > controller. This will probably require a new plugin, but
> > investigation is
> > still ongoing.
> >=20
> > Vicki Pfau (1):
> > =C2=A0 HID: switch2: Add preliminary Switch 2 controller driver
> >=20
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
> > =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/hid/hid-ids.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0drivers/hid/hid-switch2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 975
> > +++++++++++++++++++++++++++
> > =C2=A0drivers/hid/hid-switch2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 242 +++++++
> > =C2=A0drivers/input/joystick/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0drivers/input/joystick/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> > =C2=A0drivers/input/joystick/switch2-usb.c | 353 ++++++++++
> > =C2=A09 files changed, 1609 insertions(+)
> > =C2=A0create mode 100644 drivers/hid/hid-switch2.c
> > =C2=A0create mode 100644 drivers/hid/hid-switch2.h
> > =C2=A0create mode 100644 drivers/input/joystick/switch2-usb.c

