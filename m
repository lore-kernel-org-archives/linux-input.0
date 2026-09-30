Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2C4C042D
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804391; cv=none; b=SXSxIL+OHjkejqlTXhFMrR8Ky3QBGAIiHwyerq3zLitnrq5jWHRHxwSjF4opRVi643NOoZspMvmye4b42Uh8W1IS75indAiIT793FWnncsbm0JVzsqdY9k6D5Dntrfn7ey3R35JOPp0RKGrNi4inp+fiW7fnOpkqUoTKFgxOLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804391; c=relaxed/simple;
	bh=JT7E2GXTUWhDiSl+QkrrkNuobSDJ9IQpSuHHW+1IieE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4Gjl4PJ6tA2OYbDTjHMQ1dX65MwRh+kvrjc6liY3d8E8KAb9HAvhU7tDaj4FMXKH0UkquWyOZoUCUqIbbO2akP0iLfudEXMtGmPo+Zl5x1cbiEjTMBVxvL1cFKe9akCI9C7AXXES4j0tYzgwGJ83Jagrw/98OLzE5i+mlah+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adrianistan.eu; spf=pass smtp.mailfrom=adrianistan.eu; dkim=pass (2048-bit key) header.d=adrianistan.eu header.i=@adrianistan.eu header.b=kEoUC34W; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=uIQIijej; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adrianistan.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adrianistan.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adrianistan.eu header.i=@adrianistan.eu header.b="kEoUC34W";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="uIQIijej"
DKIM-Signature: a=rsa-sha256; b=kEoUC34W1OKyHFL4lqsffpY9Gyp4e+grd6Q6piBj4wskNxT39RcuFbAPoc0NNlXFRA89AgVTHybhsTgk34/RtVP86gQBQ9IkTRZ63YWAfVdRVra8ZdShl7kplLF8PCf9FaRTDvvDyCn4gICCx2IbtEk3gxxSn/ULKJ5zxiSWKrNQTUQ3gAzA4mdA+yrD10wkP6oIC7PqapWlN8MIhr0c/Flt9fxufNCPi38VidVAcxWaNWkzkUWPyhrRrJmWWrCGgRJYwpd/BOqViIAR7GfMBCaiJtXg2uzw0aXwjh7MhqfRwY9YxeB3pv5VaxUU5zmqTraqlj7+Nw1I4AvPP10N0w==; s=purelymail3; d=adrianistan.eu; v=1; bh=JT7E2GXTUWhDiSl+QkrrkNuobSDJ9IQpSuHHW+1IieE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=uIQIijejECtvtjLV6S6cISbmTuM0wXRQAEapkIrIT0Am5w5rem4lLlqZY+0VS0l6PKF6qybURAQeMcj5sDo1x0/214MBlErMQ4wvA448G9scwk+hHa8xrwW020oaSv84DSo4CfOHfmUEUoPmkHAXJp0fAa/1XMglD1W3doYm8N/tky1kcetaDVBjKz88SllUugQK1tA9wtKJacjjBqR4x1MQ991tujRMWIKOM0tEFCoaQlzqtqHAEKx5Cwr9PJ5VyUSTMvoMj5/r1CoMoP7g1ZuxVZOCVzeW9FsORHMZEXOgV4MonokrWKEpLOgBDQ5rh8Ek7HxiQ3C1SIrkhUY7sQ==; s=purelymail3; d=purelymail.com; v=1; bh=JT7E2GXTUWhDiSl+QkrrkNuobSDJ9IQpSuHHW+1IieE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 18789:3513:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 546470788;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 30 Sep 2026 21:39:44 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Arroyo=20Calle?= <aarroyoc@adrianistan.eu>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Arroyo=20Calle?= <aarroyoc@adrianistan.eu>
Subject: [PATCH] HID: apple: Add Lofree Flow Lite84 keyboard to non-apple list
Date: Wed, 30 Sep 2026 23:39:20 +0200
Message-ID: <20260930213920.46867-1-aarroyoc@adrianistan.eu>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

The Lofree Flow Lite84 presents itself as an apple keyboard,
but applied fnmode (auto=3D3) makes the F1-F12 keys not work.

Signed-off-by: Adri=C3=A1n Arroyo Calle <aarroyoc@adrianistan.eu>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f6134c5820ff..5356e80f5664 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -373,6 +373,7 @@ static const struct apple_non_apple_keyboard non_apple_=
keyboards[] =3D {
 =09{ "2.4G Wireless Receiver" },=09/* EPOMAKER TH87 dongle */
 =09{ "Thock TKL Wireless" },=09/* ENDORFY THOCK TKL BT mode */
 =09{ "USB Dongle" },=09=09/* ENDORFY THOCK TKL dongle */
+=09{ "Compx Air84@Lofree" },       /* Lofree Flow Lite 84 */
 };
=20
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
--=20
2.55.0

