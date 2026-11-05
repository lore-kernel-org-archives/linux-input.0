Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906158;
	b=sEqoSGn+wm6u/7eRwxecY/T+iQDFZPxHEvCjL4GsncTcgrejOzmIYJYGOvY5w+NubCx6
	 83c/ayu1rbvIoBO2lG8UeisAc5Jyb96RqVVdvEsTS3/QKGAjvUAS3obDJYE/ROiF2hNAK
	 raJmmBLieyHNmsjXNCKeJegzMcZKRODLpZr3DLr33/jSlJai4WKK3E7OHkvbXXW+MSr3K
	 aX/oux+P9WIU6Jc1XOmcfGoeclTSGfRIZwsmY1uXZE8agkLJuUIRW2w0IE11vQIEiqRez
	 BhkZzojL3rHHuQcqPJEIS47Obu6kaG2+BrrO7cU5Nu2kwHTjVWQv29+q50MAOJ90VzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906158;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=aQrmpbsg39RJZHsj8bCxeHyZoqHs5GXsCVBSVz32+gY=;
	b=VCuDwVVR90Gxlct6sI/K8xoXmlUDipc6XfI+f1GmivyDrK/SeGV1wrWSoyUvG1RtwJJx
	 71aB/0pcsZR1XLs3rCAeTkQJR/3LpstzZTUe+eLE/hvLnL3dgyLfTzog19/+kTEC+rCUS
	 9UoT2MNeKH3+q8dEfdN0M8FvgUEBzYWaUs96q5XqzbPD7z9gC9O/sd+xztNnqXtGa32G/
	 IxN4e7K4footI/3JHppHwF5/HuynVckDYls2VJnTE05YIdTPahVHF503QuxV+efTNORw2
	 lY3hh5RNeFenM/CnV1/FerPVEi0iYSGdQGp758V6PYv3zVx3W+a7W5cQGL87sep4+8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=l359l905;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=bljm+K07;
	arc=none smtp.remote-ip=23.251.234.55
Received: from e234-55.smtp-out.ap-northeast-1.amazonses.com (e234-55.smtp-out.ap-northeast-1.amazonses.com [23.251.234.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB2606A326;
	Thu,  5 Nov 2026 19:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABB2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=l359l905;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=bljm+K07
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906156;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=7vtZbDvC8eB+jsWyFc0BvHDStt32S/c2OAorEvLzFoY=;
	b=l359l905UEnZpTxVPT5JEgw2EhO+otwgxiBxy1i2AvlOFGVhB2FWNHU8NF7UtTD7
	Gpb0dqYjj5gwnZkfqlV9levwrRKhQOYShQHQv9JRVE16sOR+lHUGt2b2MRvr1jz7Tai
	DcDx9jWbVjaHMy6tW2EzQq6mNJmjuDrbUZ+/D6Uw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906156;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=7vtZbDvC8eB+jsWyFc0BvHDStt32S/c2OAorEvLzFoY=;
	b=bljm+K072iOhMh/0NPMy55AxUg+4VigIVaeKaUkfZnfBB0Az/aCkzpyrNLeUoSwZ
	430K7+kNAfd/pH3lvPPwAwFOacXvkodtk2OdQomVbfcEsV2vf60Uuqik4+Olt1lrSGz
	/iSbeaQoPG1iZ6FtKQYgN5/OAua0u3egFSBzIjZg=
In-Reply-To:
 <010601a1ad16c6ff-c0275058-3f89-4341-81eb-ca26372f8d70-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1ad16c6ff-c0275058-3f89-4341-81eb-ca26372f8d70-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] HID: spi-hid: propagate reset assertion errors
 during initialization
Message-ID: <010601a1ad23a3f0-6052d99b-28c6-4649-a70d-e2ea74c1822d-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:15:56 +0000
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
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.05-23.251.234.55

Stop initialization before power-up or IRQ enablement if asserting reset
fails. Return the platform error through the core probe and frontend.
This initialization path still ignores the assertion error in v7.

Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
---
 drivers/hid/spi-hid/spi-h=
id-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-h=
id-core.c
index 496b33cdf3..fd64d2d2cb 100644
--- a/drivers/hid/spi-hid/spi=
-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -1468,7 +1468,11 @@ static int spi_hid_dev_init(struct spi_hid *shid)
=20
 	guard(mutex)(&shid->power_lock);
=20
-	shid->ops->assert_reset(shid->=
ops);
+	error =3D shid->ops->assert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "failed to assert reset: %d\n", error);
+		return error;
+	}
=20
 	shid->ops->sleep_minimal_reset_delay(shid->ops);
=20
