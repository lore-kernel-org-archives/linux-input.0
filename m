Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259493;
	b=g8Zf17K+Oe2+ziwPGQu03FjqJjZFFXdp1hWvsTeQ/trnsZhoEAfKZCy7vg90KHGF5vJ7
	 nG8/jZ92BQrQwlhv/JcFZJCtRsicnn1pXUeacmS7tPsApXa2sjbW9BIhZpzF9hN6FE/MI
	 bkSUlJzKAuDO1q/1jazmNBiX6xYtC7Dd8dwQ8ix7AajIMSo/yvBti0ljo+aemgEBP22r8
	 S0eDfZTiHzc5DqhsUZQ9pFLz4IW2JFu6Wk8bMrxnxM8X156Y7m3SUmlSDhjnCJYjGTyjS
	 EEZ4GJ3Ni/8oyjMduEKVGofS1xyU8RuipNDZIJtnW/zbvTwlyCyhORV3hYExkqWOzzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+M0BZeuDrsVXzAn7sBMCGNL00597p0WjyKrrf1Dm54I=;
	b=n+UuaVNf9x4BaK/Pf6tj3F0nAhxlHA0L6Q34Yp0buEJQp9dRX8YuiG1pr6MSqmWCd83d
	 SFWbZ+yN9UkosAKhH9WUd9e5O7Mi14G8X3aYiGP2AwCTjtP6hhBgs3QFG1Vam5fW7e9E+
	 IJy7Xq8CywXUh69E5mCCyX5PAUTxmVE/Nx7aRDJtNqeFTAWb7Tm3mDYn8o0KcWHXJVDnN
	 +XRZf89MWAG2tdwbGf3eAPSlGovS77yn/sPvQahVVt+904Sy6b8H+VdVCiG8mFzcrnAzd
	 O82F/OdMUkSRANzRq/4VODX1vJCnNSodz1P8DCKvg9blV01pjBXTxZ+eTJtt/Ew4oOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FxGLxh35;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319F606A32C
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 11:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9319F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FxGLxh35
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1093556f8f.2
        for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 03:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795259491; x=1795864291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+M0BZeuDrsVXzAn7sBMCGNL00597p0WjyKrrf1Dm54I=;
        b=FxGLxh351WyjFkOoMVbkDKCQLWMAD7Lu0G+6KFKnqN3h8YP5fbYQ5bloHntHWlom6z
         63v7MEH5nctjOJkIz7ROIMvYhDP2w4SqemDG2gy0PmQM439U7WNjZf/SwzSSL2PuroLY
         VIEe/O4MFzWKsDSKZVYar7L0y04HRevYGQw1Gd213AtYyUkN3/D0gLBlUNualmnZ9q8n
         Nr8LyRhlRNyeMEhS32PV6uagq5q6cdgJv2htzDz4VmQstY86yF6D/1wxQ1lsOwfyUIM2
         Pd7GFOJopdCpatj3MWkJJQKNwWvBi+O+6/Rye7YyYrrxqtD5J4U1dHwI4DpmAjSf8bTZ
         hohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795259491; x=1795864291;
        h=content-transfer-encoding:content-type:mime-version:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+M0BZeuDrsVXzAn7sBMCGNL00597p0WjyKrrf1Dm54I=;
        b=Ie/csFq70wHhghiXuuC/6Fj2XtueMpIl/5CmbeW3JOwmeTfsKpsEtHuGy02Fx66sRc
         DffBeW0jTGYp3D9g6xJtXL6z/g++kEVitgwuEJgdrFYnyvAKvC/uu/7Qtwd+qqSkiMNX
         1hK7++Mn1/oQZMOVQjSQiA7GHgRiHUoUcY5MfgOuWuorvjQzDsoTGl7WNP+9jmejaN4S
         Cf1llm3ACzH6AzYzn7McwOv00CxDDpMoXmTYdRQTKxxBRJpC3ZwwAjeQ9XoRAAe/SYkN
         KaDPYrMoudWvqXA/tSiAhiOJdEzAkPo6yCJqxvttU+z+hdDfjnQp5ZjkbR2TlgdrL5yy
         H5iQ==
X-Gm-Message-State: APuU4Z8masS+MPijrGkApG092lR9sfGZUXgt+HE7zayHsg01PczrUA0W
	hG4hQfCq9qJLWgBM/WWGzatmfkLxrpfefKb8e84TiahjX/txh5GV1ykH
X-Gm-Gg: AZFdTZc3COAXWxkVVFOz8yqmBsUTsFHdsVTf6td0J2BdXHaIVP5FiOJyIKdhTwscQFK
	QMSKfBEWrL9kwuAP6m60BT9KQsJ4cR43cMsGtR7d/1htwz58coWNyY46iz9KuNJuXIo0nat9Ezl
	ZYsrikaOHRD2rJo+8MwLL1TiQU+L8bY/Bc44EVcPNXHXhJz4RVJwUHLjBvanQcmOsd9CzegpQ5L
	uuDhGsoiQVcvVQoqF+uEms1v7n+jw3nJeWGa4laIFCr4oUHbV21mGhxfMaz2j3pRE+aBZvpfsgP
	lKQcOERdx4ABSFKcO3Xrune8dES/ajO5Of6aIa5DghPX9Y16utokviaE7e5GjweI8vkLEVisO/s
	Ke2V6SgFS0ph1j1AGcoFVJgXkvtHHrjj6PwuQiZhqJl+E3XTc85draTthJeF4D5x6YDE+cdvdsc
	zGivfuLd2lgVGKmNM+VNYwWTkQiRn+v7xIcygfv14CXf7mDESakp6cKnryBur3wBhl+YeR9W7ON
	+8LFEoyW749rH2M5n8ImitvaU9AU7Hh86Ur7/bGGKD4gnn53ZmuK0fmgX785NqKsbQNwfUQR3jT
	Jpe1h0hzhLA72D+jtTSfBc2EJb0YqqX3hLgUNu2l5MNH1aC/av8kBQMIEpNrHGQ=
X-Received: by 2002:a05:600c:3b0e:b0:4a1:efba:511 with SMTP id 5b1f17b1804b1-4bb8882508emr139998355e9.35.1795259491414;
        Sat, 21 Nov 2026 03:11:31 -0800 (PST)
Received: from foxbook (bfh118.neoplus.adsl.tpnet.pl. [83.28.45.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm10697281f8f.40.2026.11.21.03.11.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 21 Nov 2026 03:11:31 -0800 (PST)
Date: Sat, 21 Nov 2026 12:11:29 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: erikhakan@gmail.com, bentiss@kernel.org, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 7 (2018)
Message-ID: <20261121121129.2a1d3013.michal.pecio@gmail.com>
In-Reply-To: <20260901203044.459972-1-erikhakan@gmail.com>
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

> The headset reports connection and battery status on HID interface
> 5. When the device is disconnected, ignore incoming battery
> reports as they will incorrectly report battery level 0.
>=20
> Clamp overreported battery values to 100% and add USB ID 1038:12ad
> to the driver's device tables.
>=20
> Signed-off-by: Erik H=C3=A5kansson <erikhakan@gmail.com>
> ---
> Information available online suggests that at least two other Arctis 7
> revisions (2017 and 2019) exist, with different device IDs.  Without
> access to those devices, their protocol compatibility cannot be
> verified, so this patch only adds support for the 2018 model.

Hi,

It seems that adding this ID here (or some other change?) has caused
regression on some hardware, reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=3D222298

URB status -75 is -EOVERFLOW: URB buffer too small for data returned
by the device or the device babbled (exceeded wMaxPacketSize).

Regards,
Michal
