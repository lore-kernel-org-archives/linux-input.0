Received: from e234-58.smtp-out.ap-northeast-1.amazonses.com (e234-58.smtp-out.ap-northeast-1.amazonses.com [23.251.234.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6DF40097A;
	Sat, 10 Oct 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651459; cv=none; b=WEaR0ehU2GjHsp/FPvXm0v7Lnr1lhpVi68ExzYI3o6nJOx8PNdc7L4JP+CdmMYYMjZK0VMQEgQOecLOy3sMBRjxePP/zP6zp6QuryB/9HIo1KTSxoGXXiYUnUgu5Ire3L/MJxRRABF8qOVGQ438YA5sAEZz1WA5nOaEDxgkaAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651459; c=relaxed/simple;
	bh=NdWPRdZagq3J9R50nRXIZoMXGmEGLhLhSaQtooDqtJk=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=qmkk9TeRIbQfaN5t5KeQ9dz6jyoIR87qmDknXhqjej4CbVTwGCNTzINnzFh0Ie3vC+uZ5UiYcx71KU3Wrl9mS5p9Qqo0BycsmX2B9kr6ggCY4vKf9mdGG9u0XdXd/la/48e00GIQeUkGa81rPAktPtc+ynNv58fZi6e8zz6jafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=ATTYXJ54; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=csFB+gDu; arc=none smtp.client-ip=23.251.234.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="ATTYXJ54";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="csFB+gDu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651457;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=NdWPRdZagq3J9R50nRXIZoMXGmEGLhLhSaQtooDqtJk=;
	b=ATTYXJ54FXXqut8AEoCF60EcmbIfEBNdPSoRWwTWiXUMvx1sfRCgFaCHsljABjp/
	hV1esTF5RqjQzv4pKx11m4mI4FRTppsWDc1sMN4UCnzDK3krjfakdSIyQor+MD9otmW
	JwqxV7dAmKvMbH07OJ9U3U2d3aoE6JOTWBvpiXuU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651457;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=NdWPRdZagq3J9R50nRXIZoMXGmEGLhLhSaQtooDqtJk=;
	b=csFB+gDudXTJ+17Hvc1IvWvOE6QuaPLXFut7qVqweupInMInDjqgI682A0lQ+xFM
	H8h5yXVz5njmRVWzwnu/Vb65OkivkFJbojA7gAquo7EDWA+DU6UPgzuh/L/FbCSPGtp
	7De3AIwNNq7rliCJdBPFWDX7Z/2fAzidYmRV+bAA=
In-Reply-To: <20261010165718.43433-1-fqwqf@fqwqf.xyz>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HID: spi-hid: propagate reset assertion errors during
 initialization
Message-ID: <010601a126bfa872-172abc78-b916-4128-a4d3-a76cdd61eee6-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.58

Stop initialization if the platform cannot assert reset. Powering up and
enabling the IRQ after a failed reset assertion can leave the device in
an unknown state while probe reports success.

Signed-off-by: Jizhou Tong =
<fqwqf@fqwqf.xyz>
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
