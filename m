Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACF4AAC7A
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685708; cv=none; b=eUrsv28369BNSUuEUg1x2KzHY84EC01cwZhJUY7YePfh/5KSZOmdmkY8HRGlZHGzEJT7jAxwcnXDKyzqffivBUZbm4BqRU9aIhyQAU0DQtawoi2MznYuoJCb04coa2WaBmll8h1PyOCV98GskQz8H7DM0xGnMmVg3cq74+LdhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685708; c=relaxed/simple;
	bh=x8dJutPCFqdfkx8N765ADRUz9RAxSutdjnlXtXVNKjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdMBJ+rEjHyuiXcx7xL3GqNem1/CogHWs67AUEx8E8QMZ17TOlfF6fHv6SlE+0JeyfHD84oIVuzDE4i0Yge3dkzXOgSbYfbSPM1Cx9nlHdlQ6KhhtDMifm1x+H9+9p7ZuSQA8Kt+7UwkjSaZHWJG/XH53Lgbt50f3vXGISKPoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=oH+zfmQK; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="oH+zfmQK"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 0AD3CBC40B
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 01:55:04 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 37F1EBC40F
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 01:55:03 +0300 (EEST)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A272E20055E
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 01:55:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1789685702;
	bh=x8dJutPCFqdfkx8N765ADRUz9RAxSutdjnlXtXVNKjQ=;
	h=Received:From:Subject:To;
	b=oH+zfmQK8nSj51G8iumazYR1e/iUqVqzWIfREH2MYXjoBgFUF7DeEEuWbCRMZls8L
	 Fwo8HgaVqUga/VLHXWvR9NGFtWEewWk78oDWH8pJ5sB207mh+bGp9OCryXP9TQAWmF
	 HIh1hRrkgz8mIvRNHT69GHJNlR3UBmvLxMb6F8u6gt7IVLzEIApyEohXJy766PSlMa
	 I/0+rUG9pmo31nnj98rG61ACDhGucImJ7omyErD7T6zctoR963xLjRwL0uQkIM5aat
	 WlqycvJMGCbUSTU+HV9/Nn+InlrFMsfQZPdZCGwgNW2mG4asWROpwKYteY7gTu5JZc
	 0stod2cIxb4Wg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 74.125.230.205) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-qk2-f13.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-qk2-f13.google.com with SMTP id
 d75a77b69052e-5311edbc154so811371cf.3
        for <linux-input@vger.kernel.org>;
 Thu, 17 Sep 2026 15:55:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzcPZsTXkq19kAxeewIffCQ02ObR0XqR4OXnBz1ujR6ahEO/pLwhsSfbMe/iHoabKv5ulXDAagNvVQJQA==@vger.kernel.org
X-Gm-Message-State: AFuF++nVETyOMrwBHzscQcbfPtnqCu5yig0ve6+PqBimbOMFrXlJHOVi
	XHqVgqc8eGj/K7E3+/uWz7vHgxNWjXoHDt7jio/VfHJ+JyOYNqK8DMyGFjvwTwq9YAI3JjL19P7
	b0PwghNH3U0my1lsqHkJjRfieSm/+T34=
X-Received: by 2002:a05:622a:4d0f:b0:532:9adc:63bb with SMTP id
 d75a77b69052e-5329e54b1demr12161021cf.76.1789685700622; Thu, 17 Sep 2026
 15:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwEkgP9-VwhW81=WEvJOac5iD+PFO4tA4eVrFP_qDVaiWA@mail.gmail.com>
 <20260917222327.63999-1-hello@matias.me>
In-Reply-To: <20260917222327.63999-1-hello@matias.me>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 18 Sep 2026 00:54:47 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGykWJFovoT3wEaTn54tpW-5Fo=Dym=RxtTg_Vk+DJgYg@mail.gmail.com>
X-Gm-Features: AcwNN1VlQ546YbCygXwHhHsOnspKTvi6jbSQJqY6vuSHmUt0pgiHTXxpe-6M698
Message-ID: 
 <CAGwozwGykWJFovoT3wEaTn54tpW-5Fo=Dym=RxtTg_Vk+DJgYg@mail.gmail.com>
Subject: Re: [PATCH v3] HID: ayaneo: Add AYANEO 3 detachable controller driver
To: =?UTF-8?B?TWF0w61hcyBNYXJ0w61uZXo=?= <hello@matias.me>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <178968570254.328918.5800545622500331345@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 18 Sept 2026 at 00:23, Mat=C3=ADas Mart=C3=ADnez <hello@matias.me> =
wrote:
>
> On Thu, 17 Sept 2026 at 23:48, Antheas Kapenekakis <lkml@antheas.dev> wro=
te:
>
> Hi Antheas,
>
> Thanks for going through v3, and for all the help along the way. This
> driver exists because of your protocol work in Handheld Daemon and
> your reviews of every revision here.
>
> > After you submitted your patch series to the lore, why didn't the
> > review take place here and take place downstream?
>
> Sequencing rather than intent. The OGC kernel folks wanted the driver
> submitted and tested in their tree first, and their maintainer's
> review landed on the already-merged downstream PR after v1 and v2
> were on the list. I folded it into v3 rather than ignoring it. Agreed
> that from here on review belongs on the list.
>
> > The rby Denis should not be added by you. It should be added by
> > denis by replying to the mailing list and then you carry it forward
> > on future revisions (for provenance).
>
> Understood, I carried it over from his downstream review round.
> Denis, if you are still fine with the driver as of v3, could you
> confirm your Reviewed-by here? Otherwise I will drop the tag in v4.

As I said, none of this is your responsibility.

> > Consider exploring similar ABIs in e.g., Legion Go S hid and
> > mirroring their ABI. Then remove this file. This is not the only
> > breathing device. Moreover, delta_t values are ignored and you are
> > introducing an ABI for them?
>
> The delta_t point is fair: hw_pattern accepts timing values this
> firmware cannot honor, and the sc27xx precedent does use them. For
> context, hw_pattern was my reading of your v1 suggestion to find an
> accepted ABI for the pulsing mode, and the downstream review
> preferred the generic trigger ABI over adding a custom effect
> attribute, so the two reviews point in opposite directions here.
> hid-lenovo-go-s documents its effect/effect_index attributes in its
> own ABI file, so a doc file exists on that path too, though shared
> with a second driver it could become a common one. I am happy to
> switch to effect/effect_index mirroring hid-lenovo-go-s (values
> monocolor and breathe) if that is the preferred direction. Jiri,
> Benjamin, a preference either way would settle this.

If there is an existing ABI, you shouldnt add a new sysfs doc file.

https://github.com/torvalds/linux/blob/b5a051f6b840d48f159166ef073d3021989b=
fb50/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go#L1-L13

There is an existing class of device in the same space with a new ABI
that does exactly what this device needs. I am really not sure why you
were guided on a LED PWM interface by the author of that ABI.

You need to modify that sysfs file in a separate patch to make it
generic by removing go.

> > I am not sure of the struct naming or whether a struct is needed in
> > this case. if you do not use most of the report, consider
> > documenting it somewhere else and doing direct accesses to the
> > appropriate bytes.
>
> The packed structs came from the downstream review, mirroring
> hid-lenovo-go; they replaced a set of byte-offset defines and the
> static_asserts pin the wire sizes. I would mildly prefer to keep
> them, but I am fine either way if the maintainers have a preference.

I am also fine either way. I'd prefer what is simpler.

> > If you set vibration, you need to expose it to userspace. Otherwise
> > this driver degrades functionality over userspace implementations.
>
> Agreed. v4 adds an attribute for the vibration level (the firmware
> takes three) plus an index listing the options, instead of writing a
> hardcoded default.
>
> > Prefer removing semicolons; they have a particular smell ;)
>
> Will reword the comment.

All occurances.

Thanks,
Antheas

> > Consider dropping the hid_device ... check block unless it is
> > necessary. it seems like a premature test that can go wrong and you
> > touch the device. Particularly, hid_device_io_start is a bit
> > unconventional.
>
> Agreed, v4 drops the probe-time status check and with it the
> hid_device_io_start call. Every sysfs read already talks to the
> device live, so the check adds nothing, and without it the driver
> generates no traffic unless userspace asks, which also keeps it inert
> next to userspace implementations like yours.
>
> > I'd suggest waiting a week before the next revision and up to two
> > weeks for jiri/Benjamin to reply with some comments as I think I
> > was the only one that reviewed the previous revision.
>
> Will do. v4 waits for Jiri and Benjamin, and goes out as a fresh
> thread.
>
> Thanks again,
> Mat=C3=ADas
>

