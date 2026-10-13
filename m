Received: from e234-54.smtp-out.ap-northeast-1.amazonses.com (e234-54.smtp-out.ap-northeast-1.amazonses.com [23.251.234.54])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347A374E5A;
	Tue, 13 Oct 2026 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861063; cv=none; b=AY4VdUOhms6BHXkrUqp+pWMkVfY4Wxdnx/52B5bBh4D+dDHhcg+HeOvPm1FXOG/JEHrNQUq3EL+SqRb8X1xaWvfBOEbY97gLqSn+2kddl9ig+0AA6OmaoFdDGRMMSa/9T8ApZzr1HxHwTtB4WFwdhRThyj6KeqviwIEPdcRfU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861063; c=relaxed/simple;
	bh=ArAoV1s5bJIJTPhX+4wmFPiP94Fs/vkvWppAMKAYUR0=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rwBPbzVml6E/6sXuVc7XRwPmmqk6kwT9/1FtXGO2PI/AdG8EdW3o+F2s6v0rNpS+QXVJId1tUgs21DX/d7USAOwgrBkz1c3kt22usep5aTQhbM7BoKJmjz3t2otdBABPvCIiR0EsQH0bhI0P0tTS64TWzKdiq+dPy/x9MMBqXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=uEyH8/u/; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=slxNnCMM; arc=none smtp.client-ip=23.251.234.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="uEyH8/u/";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="slxNnCMM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791861060;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ArAoV1s5bJIJTPhX+4wmFPiP94Fs/vkvWppAMKAYUR0=;
	b=uEyH8/u/0F4o4p3c/uJs7ZMo70IaPfnT/u/svK1ZpC6RLv1U38iwDn5Jongh/3z+
	rH2F0gOYjLeH90FA4kATXQwuwL/UFeSrkYjD+kJcPzc++Lt2EXRRlmmXN9qWUSHIS7Z
	9hsyJkg34+itwWYHoL+w2K8ctdAP9UIIlUIPcaWY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791861060;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ArAoV1s5bJIJTPhX+4wmFPiP94Fs/vkvWppAMKAYUR0=;
	b=slxNnCMMxVjkWClbEYx+oDQWEV3liCDqMfAQvpN2O3cs8nOfNehqcpsmmmCJhBNP
	dmHD4gTRw/8LKJJ9PNHfbw7JkjU1xkGYn8ZJYGKBNJi8WWbnWltpig/HYCwHSidJ2Hg
	HU93BkOeZDTTF5Wc3P6GdL8k9htOSDpA1TV34G7g=
In-Reply-To:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] HID: spi-hid: propagate reset assertion errors
 during initialization
Message-ID: <010601a1333df3f1-5c4b90ef-5f51-47f5-8cf2-ddd81d007a09-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:11:00 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.54

Stop initialization if the platform cannot assert reset. Powering up and
enabling the IRQ after a failed reset assertion can leave the device in
an unknown state while probe reports success.

Return the platform error =
unchanged from spi_hid_dev_init(). The
non-panel-follower probe path =
propagates it through spi_hid_core_probe()
to the OF or ACPI frontend, =
failing probe before power-up or IRQ
enablement.

Signed-off-by: Jizhou =
Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-hid-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git =
a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 106e92b71ffb62c05a1c10b975759d71440b47b0..1aae7863e87de766444e7eae392=
335e4b1daa85e 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -1524,7 +1524,11 @@ static int =
spi_hid_dev_init(struct spi_hid *shid)
=20
 	guard(mutex)(&shid->power_lock=
);
=20
-	shid->ops->assert_reset(shid->ops);
+	error =3D =
shid->ops->assert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "failed =
to assert reset: %d\n", error);
+		return error;
+	}
=20
 	shid->ops->sleep_minimal_reset_delay(shid->ops);
=20
--=20
2.53.0

