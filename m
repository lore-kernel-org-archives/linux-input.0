Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738C40DFB6
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459539; cv=none; b=DI3cDQ0DNoTLVlGGCmEPZs2CQU+yHrkeIhOrg5QOwkwBdmmd0J4yr2HkyX5wBDYzf1Ysl69D/BcqzZNjJ54WpuDq/kxKaEHP5sfuD77HXVa3GfnFj7pcW8Zzez/bQsT1k1Zv+DVItAplb+jz6OUUyln5IquUGAR8nNjg33DJtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459539; c=relaxed/simple;
	bh=ASFzXL6w2WsZgAplOOGx1hYziv4X3kzl0wx5Cv3/sh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVwGSHAhGmgk5ChUge7D2t6UpXMzVHkf93xA8YQ12RyAoF+5nksVNzpH/unevPxbhy8lH1qyAeDJQZnmzbSkQae79ioO02c37UcM2oNUaWhCvc8M35/tn7YbJPceboagFgokI4C0iTsoFgZPSm82KwRIutFZoZl1nhPjvSeCVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=tA6dB+Aa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="tA6dB+Aa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso18580025e9.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779459530; x=1780064330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfsIKTGCS0ycxbVDfoGzWt9VpeQHek+d1SqeKmsJmic=;
        b=tA6dB+Aa/V7LbZHltOhL3gbDI9PI/mEvBKl5MnHmR3MQT6cmW69D54+wdbKIAhvLIE
         8d+CAhlD+mPJR00SP1IOEs18B482srXaMmh3zMZMCh+t+0NtUMRlpFNQdqOXw8EGlxLJ
         ONWqccBaZjJqYno7jZCbHvDNciqHJFFWysyFJAVuCcdGDyi1tY2LdXSZ2hCywkALaK/O
         /IgJZlYDny06pe+5c1yNyhVEcVhAFH5QD5oleglRtYumf9kmDkikLUdBts1H7iQFQoik
         oD8nDDm+1TYmmHpBDRlVzThaN5toEK7HsHNLAyDEcY6kEd+Ayi1Gaqo5d189M0Eo0IPL
         BTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459530; x=1780064330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfsIKTGCS0ycxbVDfoGzWt9VpeQHek+d1SqeKmsJmic=;
        b=EsSRqL4RcrH/eZPbNF2CnJ6oJ/dg1mz2JjOd50OlMyR+ULgcp62fCfpJcq6OwFyfTh
         eTSSzqd1SRTkuT5KpvFIi0QmYGtNsBBvXwc0cgX8682KiPPuqwrPsTTRhBu4UPEOmYrL
         9InXtslKfzKPrAuygRK0R/+l2gYZovd7H7aeKYfzdec0dZX8TY1UHVHHC45Krjlr7Vsy
         Fc86G260vLC1/QneYxiKb+0PplJdOPFHDPl7usPWQnfIpT1FFTmftU/XsPfzXo++bitt
         33VL/2DvV3J0pz5jjE6u/ciEsS+uVbhe74HV0mU9GqsuE3CVy3w1/E03PQyzVUl0VudZ
         h1KA==
X-Forwarded-Encrypted: i=1; AFNElJ8JjHYScWQ4EkDP4ddADQhQmhSWOX+jnPkkQhGTugL2WUrkq7CWsVancFrd5lkjbfuTlMm1mEWxS3Db6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4BXutgMPCHvS3fBBMvYC4NqNRnmiBJkW+yuK2EetPlxuhkcoK
	/IiBekGgKjzayqA8CTuVBR54kc4il+cpjBTDhQmnkEZZu4OjoQvQWyQqEsag/NDOOMQ=
X-Gm-Gg: Acq92OGaJL1tC0/XtVlSM+Pg4Xn1bnt/BTzEO+8Sb2Wclt3dVSbbJMPG54ZEgE9L4eV
	8kHHa2+PlHrRrp0oCCpgiSGZi+my0EUEfsOypEZ+gKvnAjtTPipMlWrxsGaWpbvXq4yZN9/hQxO
	PaNJqlTh2f8hSFj/Km29psBKo6DeuiP+Cjc82k6yJ6JJ+zkT0bLp6xuzEdywnyzAPPSb3Sj9Er+
	jAMgjbsIqAo5RT9RaKWc12j6LIc2zdPiSyCFDWgfAsai+zQVWU4nfjOSmETWCCU7uqAn8InOp72
	UDgbS9+nM58zvyG/0VrdhUA901qkKPJL8Jgrjkdr9LYAId3wsu0dEnAzVB2u+4lV2e8BsmxDP+C
	omwKW173xzyTjYbbol4FHL+GZVW5kKT12HB9hHqD2EyjLflFPXoz8cU3AyUC3vdguauidMoUQQS
	OCQCwquZP14i2AjeSZVazfCS+3qBmrK7pc1Qel4N8=
X-Received: by 2002:a05:600c:c0c3:10b0:48d:361:4df6 with SMTP id 5b1f17b1804b1-4904249af22mr42475985e9.9.1779459530342;
        Fri, 22 May 2026 07:18:50 -0700 (PDT)
Received: from commodore64 ([2a00:23c7:1d1a:9c01:af03:b912:2ed:4baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b9asm45143055e9.11.2026.05.22.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:18:49 -0700 (PDT)
Date: Fri, 22 May 2026 15:18:48 +0100
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH 00/11] HID: storing pointers in
 'hid_device_id::driver_data'
Message-ID: <ahBgYbMWR4VwFAy3@commodore64>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
 <ag8bARsGNVqA8xbQ@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag8bARsGNVqA8xbQ@beelink>

> I would agree with sashiko that the series introduces an anti-pattern by
> allowing .driver_data to be an arbitrary pointer. The reason is that we
> can dynamically set driver_data through the kernel command line, and
> when it's used as a pointer, bad things will happen.

I have not considered the command line override ! This indeed would not
be a good case for having a pointer at all in there - in the current
form of the codebase.

The series does not introduce this anti-pattern - this is already the
current status quo in the codebase and the problem predates the patch
series itself. The series makes the problem more visible and validates
the existing status quo - agreed on this.

> I would think we should fix the 2 offenders to enforce not using a
> direct pointer but an offset in a table of pointers.
>
> How does that sound for you?

That could work, probably via a named enum (so that the idx is bounded
and validated to avoid out of bounds memory access) with its items mapped
into a table of const pointers. That way the command line override still
works as before and my goals set out in the series are met as well.

Perhaps an alternative solution would be to sanitize the user-input instead in
the 'hid-core::new_id_store' function, such that only 'driver_data' values
that match an existing entry in the driver's 'id_table' are accepted, this
is how it is done currently in the PCI subsystem in 'pci-driver::new_id_store',
so it would be consistent as well.

The bonus here is that all other drivers in the  HID subsystem benefit from
this aproach as opposed to just the two current offenders, as providing
'driver_data' from the command line is now mandatory and must match the
existing table entry - which is what we want ?

So something among the lines of:

@hid-core::new_id_store

```
struct hid_driver *hdrv = to_hid_driver(drv);
const struct hid_device_id *ids = hdrv->id_table;

(...)

/* Only accept driver_data values that match an existing id_table
    entry */
if (ids) {
        ret = -EINVAL;
        while (ids->vendor || ids->product) {
                if (driver_data == ids->driver_data) {
                        ret = 0;
                        break;
                }
                ids++;
        }
        if (ret)        /* No match */
                return ret;
}
```

Would that approach work for you ? Do help in what is the correct
termination for the while loop - for this demo I went with 'ids->vendor'
and 'ids->product' fields as common-sense would indicate that quirks need
to be device-specific by definition but that was without any actual research.

The downside is that 'new_id' drivers that actually use a pointer for the
'driver_data' will be rejected - which would be actually covered by the
solution that you have proposed in the first place. To think of it the
input sanitizer could work additionaly in tandem with the enum-based
solution if this fact is an issue, so it might not be an alternative
actually but a complement for it.

In the meantime I think that patches 1-8 can be reviewed regardless
without any changes (as they predate patch 9 that adds the union and the
commit messages does not mention anything about it).

Best regards,
Pawel

