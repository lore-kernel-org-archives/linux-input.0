Received: from mail.teplosmart.kz (mail.teplosmart.kz [109.248.152.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3951B166;
	Thu, 15 Oct 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.248.152.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064031; cv=none; b=RDrrFICXCwbyWZl7lChSTKFMh+aQzkKOmTfADEb4Sc2esBy1P7KAzip05defDDMyuFOZsqE89JBHAzcbJtGBo+LnFBXGwNShM7Hblc2oCVoA+He6j7hiv195ZihNkBvPxiSZYBqTDgRK72L3jrHksCqnJPUxBIsVhB3J67czVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064031; c=relaxed/simple;
	bh=4C/AZXi9grtRt3mBsT54Kv9HZu2he0XxzoSI6bWEJSY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fefuxPaMdshnnGBAqwMcgRXbMSGyoqlB6Uf8L3AXYy7BPCrGLO5hlrgJsq9yJyvEtblu3WHqob5Dxq+W+bub63wKVUK3o58whVi+v5kOyHu8BmVQdUiFcrQRUKRZhZ+vwiugeaZ/JuW+X9x48hzxGdFOg+l0w4HB7L6saMQVuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=teplosmart.kz; dkim=pass (2048-bit key) header.d=teplosmart.kz header.i=@teplosmart.kz header.b=mG7L1IjR; arc=none smtp.client-ip=109.248.152.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teplosmart.kz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teplosmart.kz header.i=@teplosmart.kz header.b="mG7L1IjR"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE65E665B7B;
	Thu, 15 Oct 2026 16:33:37 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=teplosmart.kz;
	s=dkim; t=1792064020;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3uqW+09n5FTefnsRmZrO2GQEJUaCUJKldwLRYEBXOGA=;
	b=mG7L1IjRLu+uGG2EfQLuqUGWZfJb0Tk1I2nFK8w005sUdo9SL+/Xho4ehmBKsxpXP2O0XY
	eFZlFSfoLpUH2xW3Ztk09o5P4ft1Por3cwUr82zVaYyCfc9YFba6kVi6eGexJfem3cDvHG
	/PwI+vNn5V6W3d4TQUVFv/DNyh+SSFXxZACzbFYDXr0bz3Cd0Mg3HTJsccpVdxKJBLNWak
	sS79RaB9EeOr2SBp3AwP0jCDTfqMhr3bBzyw+hhaEUXIhqMYIeQlyiFX5+EZIozSrX3xdc
	NPT3CI2uBvwM1xcAPJKZFSTsh2nUacvKlgxgcS78u2g19ELdplpktGAUB07LPA==
Subject: Re: [PATCH] HID: usbhid: add HID_QUIRK_SKIP_FEATURE_REPORT_ID
From: Fedor Gubenkov <writesfaster@gmail.com>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, writesfaster@gmail.com
Date: Thu, 15 Oct 2026 16:33:35 +0500
Message-ID: <179206401538.18141.5875548091082581632@teplosmart.kz>
In-Reply-To: <20261015102601.1235724-1-writesfaster@gmail.com>
References: <20261015102601.1235724-1-writesfaster@gmail.com>
X-Mailer: git-send-email style (smtplib)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Please drop this patch; I'm NAK-ing my own submission.

After further testing against the actual device, the premise of this
patch is wrong. The dongle (3689:8762) *requires* the report ID byte in
the SET_REPORT(Feature) payload. Captured at the USB level:

  - SET_REPORT(Feature) with the report ID present (21 bytes): the device
    returns a valid, challenge-dependent response.
  - SET_REPORT(Feature) with the report ID stripped (20 bytes) - exactly
    what HID_QUIRK_SKIP_FEATURE_REPORT_ID produces - the device returns a
    single constant byte (0xe7) for every challenge, i.e. an invalid
    reply.

So the unmodified usbhid behaviour (report ID included, as mandated by
the HID spec for numbered reports) is already correct for this device,
and the quirk breaks the only device it targets. My earlier "the 20-byte
transfer works" observation was a flawed comparison that used a different
challenge and never actually elicited a valid response.

Sorry for the noise.

Thanks,
Fedor
