Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922675;
	b=JohpvLaq1QJjQj1JvkYrZyVVKO1NZ6AhE5eiM6EGk3sbjkKjdBDFLPPZYbS4ExvLu1Zw
	 TtRe4rKW5FhWqVFuwxKPBrWrbg9PsrAX/oiD5CUsQCEQBo2N+u8mv+Hx3EM1iTbGM8SJZ
	 MoeotuvrNlafMB89uUSOdY2/0WkQL1Nvphln0AUpLBSKp+cH/woaP0kq4gppTDKrJP95o
	 hgEzE3NPS/OZMcrzu0SReIaF2IBwU+UPE3n9qkglccrnvbafyVqP6dIOjWvZeDE46Z+Eg
	 q679ZeGFbScw8w30Z68jcNsoz9A/S53Y1jarhso+QMD98cFLHGQpgzmJ1B2OWKDnQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922675;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=owDhv5cncT7WVNxsj6QYBYU0v4NgIJI+dxhLA8AYmKc=;
	b=sJ7x8b1Zj3+0rlghJ2RaRxjwrt26WRrQvPOfKMQexO9AoE5VFAk4VP7TjLQn8tdReqcP
	 m5Ie9Dh+Y496sStuJTaJAa2zx4W4+YesFMCgzSnAIaZAvEZrJ9GWU4aLORm0hPTP+CsRZ
	 uZR+NJXZ41x9DnF0LT4yKNemELsA85wwBwMx/Aq8lsUwajkeXNRbdSVFefFflVPRzIDbl
	 9ZqoXWtMahSEG57rYfeA8dKUq+QRwpf4NKUKpQPv5T9DpIQ36y6Nc6HV4EepGbJSSeSMH
	 j6YadyUJmmq81Sog++dubc5cZpM6sSsK7cevW5ktS9aob1O0PKNE0FHHSXN0epkhDVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=msh.ge;
	spf=pass smtp.mailfrom=msh.ge;
	dkim=pass header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b=CSKB2O4O;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3F606A326
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 23:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97A3F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=msh.ge
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msh.ge
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b=CSKB2O4O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msh.ge;
	s=protonmail2; t=1793922669; x=1794181869;
	bh=owDhv5cncT7WVNxsj6QYBYU0v4NgIJI+dxhLA8AYmKc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CSKB2O4OJTHABtUrIv/Y2DEwNVdgsrZMyeJtIixledhu05/Wo1UmIujyg6oo/95bH
	 T0OIbn5KypIFTRNU0+YWYSho+aThUsZ9EHPiaeC0F+4V8SQGm6O5KsLhhqUtYh5KiW
	 Pty+eRwpZFfckwkVuRpO/bvbchLEJ3AuL6L3VPIshVRpQYr6Jh3MCs2gIWONbCI4bp
	 tbKfNjU6K/Iq+fxkhayy/QgOrk0sfLeUIchub2cnEWqmt7c318try2AX8A81n8t8Vb
	 aMBK/irwbX8OU9OVatW6XR43HLWulke4l0jk0zsECZfW3e9TOV9xtknh5il51eWpmZ
	 KmiU13AAFSulw==
Date: Thu, 05 Nov 2026 23:51:06 +0000
To: Denis Benato <denis.benato@linux.dev>, 'Jiri Kosina' <jikos@kernel.org>
From: MIrian Shilakadze <mirian@msh.ge>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v5 0/2] HID: flydigi: add support for vader 5 pro
Message-ID: <befcd715-ecc8-463d-9617-a269dc7c62cf@msh.ge>
Feedback-ID: 170041685:user:proton
X-Pm-Message-ID: 9c77bc220c5279a8d2e22da21910cc814179f471
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 9/15/26 9:14 PM, Denis Benato wrote:
> To make optimal use of this device the xpad driver should not
> bind to the controller, and this is the case for more than just
> this controller as Derek told me, so I added some basic infrastructure
> to use the best available driver for the device.

Hi Denis,

I gave v5 a try with a Flydigi Apex 5 (37d7:2501, wired, firmware
0x7045). It uses the same protocol as the Vader 5 Pro, as far as I can
tell. The difference I found is the report ID: 0x03 for output and 0x04
for input. SDL already handles this.

One thing came up that probably affects the Vader too. The driver
ignores the third-party flag in the status reply (the "Allow third-party
apps to take over mappings" setting in Space Station). SDL checks it for
all V2 pads, the Vader 5 Pro included. On my Apex 5, with the flag off,
acquire is ACKed but no 0xef reports come and nothing tells the user
why. After setting it with 0x11 (ff ff ff ff 01), the stream starts and
M1-M4 work. It stays on after a USB replug. I tested this by hand over
hidraw.

Should the driver check the flag and warn or turn it on itself with 0x11?

Supporting the Apex 5 looks small from what I have seen so far.
raw_event already skips the report ID. The descriptor check would need
to learn this layout (output ID 0x03), plus the ID in the hid and xpad
tables. Would you like that as part of this series or as a separate
patch later? I'm happy to write and test it.

Thanks,
Mirian Shilakadze

