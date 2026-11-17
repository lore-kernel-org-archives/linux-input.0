Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794921972;
	b=OPsB2yxMIYEl7Op2m0YV93nyGVo7LUpIpF+dZyOYphc/b8RdqtlvXD9PtPgiRjV2+EAX
	 gsWYGzfEfkJhhvqGrcifg1HSm8HqdWWc7jG1GQmNsad3g6Ps2SRASGCA0y0e88/NgP55Y
	 1/Hm01q3QWBhU9NihVdBk3WePl5stNmTOPOacMowgg7SEaienDAOeBWw/NE1DkUcioaBG
	 5XTYv/1OLsxWMHH6cS329KOaFD1PP8USJCnxo1wXwJJlYAm2owgDmPtxqTRIsy1yo/TIm
	 ykwWyRlZ6CG845PjiafO2cG1Z+jYrtIHjHN1EPkIU8DvN53N8m5tjYCr4Zzekpt9dcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921972;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=p4vrw8s3NMYgTpsOMB83VZK3t2Fq4wxlG8L1umjJ0s0=;
	b=Vtum1mDlkBf9iRqq82G62pz3SNzEh6s+HmKaQZOneb0up2G0n4g6JE4PPIOsrsx1OfFi
	 +hzzAG1iSH8buQ4VuGLRcMhEl8l0O3liEoj1v2zn42rvtOj23yesH/LL2EuyS+5TpzPDo
	 AdmrVqrFl4kYXBZbBgRJar8t1dPAT9mD6fXpbDW6v6cLJeRmSBGZHKZa14Qkl9FQi1Q3Q
	 B1KM/O1Ys8uKG6K6cv+/MgqAGJD8GFurF8L8/GuJuB3d38iC0ZrDwjXKA3qpAdKFNOnXL
	 gltqUC8RP811SMqIqR86l2eiACHAcb+yFbOJE76aE88WfGCwAl7+1uQo5Ta9UuzIM+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ommer.net;
	spf=fail smtp.mailfrom=ommer.net;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mg4MOIeQ;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=YIT4Y44n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57198606A31C;
	Tue, 17 Nov 2026 13:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57198606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ommer.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ommer.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ommer.net header.i=@ommer.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mg4MOIeQ;
	dkim=pass header.d=ommer.net header.i=@ommer.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=YIT4Y44n
ARC-Seal: i=1; a=rsa-sha256; t=1794921963; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fTPDUceiLxG0LCWduPKi0zI00oIhUJD/qVHk59ix2Wfcqg/tuo9l37Ep9Mkaw931X4
    ErlMK3zMewg/zUcjNVpCF/XzTUk+zXfq+kwLjXwYDddjpE9+r/TsuN5r1b3feGJVY3N8
    2Fn8Rt8xPl2eKxCqOQZB/7MQYQBb2d3rY3IhLbpsyPY4uFspHII5aPhQWsY6zLm2nO8Q
    Y76Fsy3G7Z5nGwFDL48/kF68GijfuwkmkOElXu711F5K7QSLx4osHoBig7V5TG+jGzib
    2p+RUFwGckLFmz7S0ykPgt7o0E1BH6AUdh3vBJXFxWrAPxp2KN9g/+umn/OS7sXGPVmT
    uaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921963;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=p4vrw8s3NMYgTpsOMB83VZK3t2Fq4wxlG8L1umjJ0s0=;
    b=H4wsJf9a3KLl+3tZbAIOUGi+BGKzlL6hC/vMftzoh2m2MOueNKfLwg2H9m/aUTKKLz
    WJtQ45bfm3a36bQGkrx9hzs/F0HZZ1UpGX0IsQ6JWfXLykrB2X5yGyf0bVNQj1Pm99mV
    cPTEJz9L1EhFkQDaCpIqYhIv02r/r6vqawcWkLVxNt0sjYvDMcTHlyG42Rbtte+520id
    nS6ZshKIwwPfby+UHDCcrZ29HN2lpeffjYw8RhqWZCNb3TyLTj683lvfD0HUsGfeJApA
    ogC1+LyB2Eo4xr1JJhSpz9Ogk0oNdmdAhfAcs3qJX4IAEUIEyTmCQxqtjne2SM1/H3rO
    anlw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794921963;
    s=strato-dkim-0002; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=p4vrw8s3NMYgTpsOMB83VZK3t2Fq4wxlG8L1umjJ0s0=;
    b=mg4MOIeQMrWztn0j316tXCHZSMeB+Nfyf8CAFcT8+tjFpc7f/bTjanEqHAS3BlCIEZ
    0ZdTbZ21curdgYKCpV3cNuVPbZQQR9e7fMVZCB2PXcpRsuPV85O085KbxV7zjsyMK+6v
    selh9gM3Z74ugwHopuMQ3oTu1ylNMDanuyhg44ltThnmE2gy7SFzWuEQlbYtGzZn3Qey
    8xKn3gjqxlANupb8+BszUP2Y8E44/M2wSmyGYCDLym0wpzgfZcUhglbuVyNo44FjI+aE
    oPMvVWCRs+bQtYN02ecKDHHEmVqvXZRIXrSOveKtkUz2mHzgyqhhEqCgowr7KrtWY9Wj
    qURQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794921963;
    s=strato-dkim-0003; d=ommer.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=p4vrw8s3NMYgTpsOMB83VZK3t2Fq4wxlG8L1umjJ0s0=;
    b=YIT4Y44nks5XCWnqmXOo6VcjSagPv5cmh+O2FrOXEQl4AG7ga8cfGhlXUVViPBClNc
    Q0a0CQaKJBIfLbtEv5Bw==
X-RZG-AUTH: ":JGkKZ0mIdPJLfj3rk5MOrv6kH/tvwFubxUqMvsWOyVXJkOABZnPqvKUstHY8FQgnq3rT6NoXCyjULwIut1Tf8meVypGj6A=="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id n2f42d2AHDQ3vuK
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 14:26:03 +0100 (CET)
From: Henri Ommer <henri@ommer.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri@ommer.net>
Subject: [PATCH v2 0/3] Add himax hx83102d touchscreen support
Date: Tue, 17 Nov 2026 14:25:46 +0100
Message-ID: <20261117132546.12041-1-henri@ommer.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Adds bindings and driver modifications to support the himax hx83102d
touchscreen used for example in the Samsung Galaxy A20e and Motorola moto
e7 plus. Also adds support for himax touchscreens without a reset GPIO.

Tested on: Samsung Galaxy A20e

Signed-off-by: Henri Ommer <henri@ommer.net>

Henri Ommer (3):
  input: himax_hx83112b: Make reset optional
  input: himax_hx83112b: Add hx83102d support
  dt-bindings: touchscreen: trivial-touch: Add hx83102d

 .../input/touchscreen/trivial-touch.yaml      |  4 ++--
 drivers/input/touchscreen/himax_hx83112b.c    | 21 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
I had to switch email provider because my old one didn't let me send multiple emails in a row.
Best regards,
--
Henri

