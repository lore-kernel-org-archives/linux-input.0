Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.120.86.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457840;
	b=Mg5NR4SI4iOUeEwKGOEZ6gd2eiR/fcXRDL9ljs1FhiYQ4jtD5ZKEmc6Somq2cAnAKGR/
	 yrVf93Y9xVTFDgWEMEDtxeF763ox4LjyC/FPvIUHITJqqmSl0Z/jQdbqqpAq3/WuJbU1Y
	 LNuiruGoQz9+fzjQjdI7iUOzzBqR3QkBJoixtWA4dG5miRm2hNg1KTw50gdfD1DJt7kbY
	 owlEBA3Y3bzWsKj9Z7XAAd+gJmD0te3F0AXTe1/0MMSOr37ygYKjxSTl39DNv7ARcLzIr
	 hrP+1gnNmhcvgN9JnaXloP9OuoSwHV277zlDymKlZRAJ+RBxx1SXSTEYlS7YSwwzCNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457840;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:
	 X-Report-Abuse:Feedback-ID:X-smtpcorp-track:Date:Message-ID:From:To:
	 Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=;
	b=YlG6kVvWC1MLWisz6yVxq/3jBTkgZxiwY8MXcQmavhKjcPN2liJH/xH1gat2RZsm7Mb3
	 70HWx97j9B8EVYSvREUbESSn+cRfOIog7YVmoNot1fKsSGiLy91rO/tBA9/Ftpu/EMUGn
	 5BYOsDXp9E1mvn7+FWOdsLGj/LeT0ws3rBQQDBqhfe28rKt1kJMu9+qO3B/vtkzCctov0
	 YuxB/6+rUmcxRbaNWyxVT7/CIZcy2dh5pjROZGZiESRFGzkZcRhtWYOKP8xwYQM9OmDuA
	 NzXs0hVBqK415umtXtFlwKzs9O7Eo2idGTCY4q706UsgoWlpKo9nqUmi7NVcdyP+45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fkr.dev;
	spf=pass smtp.mailfrom=em1020969.fkr.dev;
	dkim=pass header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=s1020969 header.b="ba/+S45S";
	dkim=pass header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=default header.b=X5G4kOiQ;
	arc=none smtp.remote-ip=158.120.86.30
Received: from e3i542.smtp2go.com (e3i542.smtp2go.com [158.120.86.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CF606A31C
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 00:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B24CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=s1020969 header.b=ba/+S45S;
	dkim=pass (2048-bit key, unprotected) header.d=fkr.dev header.i=@fkr.dev header.a=rsa-sha256 header.s=default header.b=X5G4kOiQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1792457833; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=;
 b=ba/+S45SqzhG+x+TmOQBgQ8sLpirQC6BSrz0FpnjhyqvIUgFoIZGhfcC3nsHjDDrEDasb
 S2d9YqgPMYpnjX9DbPDtLiN+gFaP7na6+qfnEGsuTOEKLH3yOvzvI9Onu9oSOFwqMRxav4Y
 avDVkBNAba7oiVU9G02QHH0+gPbdmJcUXvrmuk/vYek7+XhArxV7h6zFOmfBWTNuUukxnWp
 yM2XuD4c5YV6iaBvvpysLth9O0APoLVbhwqkxf2yOusn3c3udM7Vs+J/MFFPiG+xOHLDmsv
 4F9olzFSV/UJ8qactRsBwwXfC0VAbXxbRb1B3cEwSUIsP2iVjqTC+mna87Ew==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100.1)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1xIyA6-FnQW0hPvgRA-l4b6;
	Tue, 20 Oct 2026 00:57:06 +0000
DKIM-Signature: a=rsa-sha256; bh=baFTI7feHfHjUs2Z1HfLPGTNQHlNGEUNjb1UhcudQe8=; c=relaxed/relaxed; d=fkr.dev;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@fkr.dev; s=default; t=1792457824; v=1; x=1792889824;
 b=X5G4kOiQaw0oaWEFVOVcN8ACj5el/tE15KiCmx5ZmF7yp1Y1qajbyAJEPkpol0Zi4Sn4Yqfm
 L2HfKgXtNB5ChfTtM1CH5qd5GYisvgI9OSrkbowFKQeVZ1VJHvbEiFgCl8OqYPTMK+08+sxKgEA
 e7rd/f+ZnnyqRl9kNPUOQ26jr5a6XXaAsqqiirg4B3NzcZzWCau74dg97dlR0vE5cFL7qxZ7Y2U
 PBGn3KJRVR8qMQPV80hFuvk2ijpXtIEQZb4CpbNEptimpTHkU3JcNOgd3bQUjwEoDDcJ1JcU41I
 RQ8crMwUucd7sO249fwKG3ugn+c9wOUG9v+hGmYbCY4lg==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id 5b88a664; Tue, 20 Oct 2026 00:57:04 +0000
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969sMMvfpqAzu
X-smtpcorp-track: 1RpAnp-QVQUA.iiFX17iYX0_i.wo7_kg3HW-5
Date: Tue, 20 Oct 2026 02:57:03 +0200
Message-ID: <70f4c4d7f6263385d29ed8baa2106769@fkr.dev>
From: "Florian Krischer" <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	Michał Mirosław <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v12 0/7] mfd: Add support for Asus Transformer embedded controller
In-Reply-To: <20261019100406.103687-1-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
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
Content-Transfer-Encoding: 8bit

I tested the v12 series on an ASUS Eee Pad Slider SL101 running Debian 13
with the 7.0.1 postmarketOS Grate kernel.

The system booted successfully. The EC identified as ASUS-EP102-DOCK,
firmware SL101-0202. I verified keyboard key events from the EC keyboard
and touchscreen contact and coordinate events from the tablet's maXTouch
device.

Tested-by: Florian Krischer <florian.krischer@fkr.dev>
