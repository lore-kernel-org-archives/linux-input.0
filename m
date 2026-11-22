Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795384948;
	b=OtJNA8EryhzhYW/sNFZFS+BdM4j7QdGib1kMzT4FumdE/FcYXQ9NmlAcLM3CEcdMZzfY
	 P18xuj5CEI866gCFlKDqXxWy3eBbg9gqddcR/x2njDoe9kK044xdwzW54xKXTY1bIt8jG
	 FuiDxaHLkOHJjAsBHrfnvCJX30GnIJ1pzgg/eR68/Gt+WhYZ48aVyfvzn8njClHrZc1aF
	 AVwGU+4kXr4gn6Q+yqS4Q+KqzFW1w89YO3MejEPg6MWGIRIeJ8VhrYtJJieUA7illntwb
	 nqYshzMsnwdTOqchsgVFNZZL+sPTrBCz/anR8LmFUSa+vBIr02gDoHFEhAK+Sd87jpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795384948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4UxiOydDwa3I67Iaoew4LDFIsocWQ9uqy+MKnlF8rqM=;
	b=1bo2Yu+Rj9LY1bChkOaUvKkCw8EiCk0MS9x4PjwzjRD7CHLUasM7Iu3FnakFtS7oXxXu
	 ybFIK6gjvEOT9j1vokxkUniZQaCD3mi2SXP7biCv+KzBPgY8S1/C+NQLZLOdfFE4smO/b
	 lDz+RVw/827LqqAVdwtsqRlCJm/h9Lmsu4MFBYWzXICs6ZLZ9R3GPdrT3cZKihAlNwtZ1
	 0I3oxgwLJ3B9MgavyaLC/j/SHnkZEvuofcapMefrMB1nIyySPQbIUVVpOyQ++tU+m91n1
	 cj7vNNlsU29LlbfgO44KFiyaZmuYuQXA2qW8tfw4wPz2ScHdFsVCqv9kELnRaYxvtXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzzwumsk;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6510606A330
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6510606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzzwumsk
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb606491faso14597395e9.3
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795384946; x=1795989746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4UxiOydDwa3I67Iaoew4LDFIsocWQ9uqy+MKnlF8rqM=;
        b=nzzwumskbK3DA1kPojxI22aHsM2COpjXjLFnBJuYrFk/0c63YJwNaGpbrKmcnE74pT
         eAEJ/umE5HL/9r9XOiZen2xUSPR/A3boXva0K9D04xfZwoM4hPEBWzodL1yiKvgDV23H
         AlBRos+7VDWwK07OAvBHmlj8OlbUhF2uHl5hNmKOBf370uXiMhxyV6WiIS30kw3SeT9d
         n3VL2jNJlxmEXhs8XAE9M63xj+iJOX4uCWCMlXhpuhJA8Ssjvqqy8GT/HSlecQ+oEMRN
         UliV0idfmxBlSPPG2nkh0fPO2DvFq568oCdQZKyO5mNPQgJ2v5PwYThsuSHy0p69jSqb
         46mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795384946; x=1795989746;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UxiOydDwa3I67Iaoew4LDFIsocWQ9uqy+MKnlF8rqM=;
        b=SMa/QmpINWOCc7L5maUap7BTUEkwA6KTYwjs6N0co14X+FaUYFjzK1cVy5ScpFw37r
         z/5hQp2AgJG49zITlRK1ygxBaRsEwRSjzyFwjkHa56KXexcxpjw95IdYWt4LAeYk7nL/
         6VFR1q+xxS9DWEkbLkVeLS4fbj5boodNoqWRbLuw9jdngBDmq+s2TzdZuqzog0nUfIBC
         6xMLt3108b3HkFGfgqdgxiaBlOYjEOO7OrnMuVWdJNCvtDkF4fvj8mkP4FrSWtJCE22f
         dO/ighvgqnEhZkU0uYl6DlpX95XY2gC0TgBWcu5QSn6/GslSH6ECef5QauAc7JvES4UJ
         wyVg==
X-Forwarded-Encrypted: i=1; AL+hErEfRLAoxSQweTCBQmNpN5P5I5UKw0I336Ei56vtyUG+/t66cQhB/PjDhzZEFfj0olKa1UU1QM0e6pdGzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Gytj+733FpNsXQVAme99H6m2UWlCYCLdMjSqZd+9kacksot++
	p948JSzeeRSD0mHE7rcbuYAilfa+j6houdz2x1mM12GxHjxaJ/DmNWXL
X-Gm-Gg: AZFdTZfcTl83hg4BK2rGve6NFeT4XpB+KbGkjjcFpLouqrZsQhqKY5p8DnOQSXX2or8
	a9C2K4WQzN6uys9Bbfxv5ebPmWOSPeEIJPM6/OyFb6Xf/MKOljVDSftJAjk9k4fatKeHsYxfdbv
	Z0pDuEbidg5T7Bto07VQSHeouxH2OfCYav5+vHdqLlvGGRz5tt8bkvHUR2BSleTjtzMk+fMJ6Qa
	iYayEqZZnxaWhnEwKNvsN7P1YY+d0+3pUZtwdjstBCxq54DBikZdHQngw4PvPxCFs9kjtJvJRWx
	k7CtpDvJ1xpVpn5E9LDTDYs7fsMfzUlBlH1Oycrp5c+ESCkA0lelPlSJWMo4P7KhkXGeXu1S2Ch
	7E3boHsQCQDZypKcy3L2MRB4HMSrXVMgBCdejTzKNPxfjH3RH0xyfZ7XPZI7kCIw1Cl6sppoGtp
	Z70zryXJCllExd4hP0D32hfoFpkzGY3o0s1X1qf0qx7qTw2XwcWJZMDRqD87CSRDHRzpq2ekdwc
	vgltZa2NwViaO/T65eOO2bEe9k0P/TEecBiO2uW8hrWzvIiGZx9SQs0iwfcMYZeCiIFROGSyYML
	n2ulIfQYh1frswZPM7iZPO/DwL2AfByjF8Gcsnx4
X-Received: by 2002:a05:600c:1c1c:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4bb8892ac4amr217905975e9.35.1795384946093;
        Sun, 22 Nov 2026 14:02:26 -0800 (PST)
Received: from foxbook (bfh118.neoplus.adsl.tpnet.pl. [83.28.45.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm19676778f8f.11.2026.11.22.14.02.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2026 14:02:25 -0800 (PST)
Date: Sun, 22 Nov 2026 23:02:29 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 7 (2018)
Message-ID: <20261122230229.1bdc3bd0.michal.pecio@gmail.com>
In-Reply-To: <Rv7nePC3RfOSidIKv_K-KQ@gmail.com>
References: <20261121121129.2a1d3013.michal.pecio@gmail.com>
	<Rv7nePC3RfOSidIKv_K-KQ@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Nov 2026 19:32:53 +0100, Erik H=C3=A5kansson wrote:
> > URB status -75 is -EOVERFLOW: URB buffer too small for data returned
> > by the device or the device babbled (exceeded wMaxPacketSize). =20
>=20
> I can't reproduce this locally, neither with or without USB hub.
>=20
> But it seems someone else is reporting the same on Bazzite:
> https://github.com/ublue-os/bazzite/issues/6344
>=20
> It seems the hub itself reports that the port is disabled, both in
> this report and in the bazzite report:
>=20
> "Nov 19 20:47:58 [REDACTED HOSTNAME] kernel: usb 4-1-port4: disabled
> by hub (EMI?), re-enabling..."
>=20
> "Nov 15 16:05:59 [REDACTED HOSTNAME] kernel: usb usb1-port2: disabled
> by hub (EMI?), re-enabling..."

Per USB2 8.7.4 and 11.2.5, hubs are supposed to disable downstream
ports which are still receiving packet near the end of frame. So it
might be that the device (at some point) never terminates a packet
at all, or its packets are too long and occasionally reach EOF.

I suppose the latter could happen because the host schedules the
transfer near EOF believing that it will be shorter and complete
sooner. Scheduling may depend on host controller type and on other
periodic traffic to low/full-speed devices behind the same hub.

Or maybe you are missing some other detail. Just guessing.

Regards,
Michal
