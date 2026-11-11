Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418662;
	b=dDh/vD1Ma/Qa1ZLMqlpwj86LAC/EgrTQ/wiZtwgLM8U2+0XhOQeEj46kxnQ/ufVkLgNL
	 9epxZO1fcl+9LavX3/YHqSIHMTWI4VmVitxMUj/2ky5MNHYEyOMEY1Elt5hSuxS3EqC4e
	 mzfaIjsw6/ebjkun5JVY1kd6hL9Xb2eq8CcqiM2Nc7Uh6sZroA6fp7/d+CJMUMAU1Adru
	 EOo3VtNeHre7pguglibhhqykmupSRElc1SIkwbyMQhZXmQkKKJTRslo8/eJp/YrKLyCmP
	 /sZpct//pyC6yYQzA4t1Iv3c21Fau4cChDpbBMUAnt6pJucrlzsEebrV0gvzArlYF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418662;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=aqk0S43USCOG9Sp2A2hjLU27no6gm2+WNSu/ljelgBw=;
	b=zdbRdmWSn8ZGw2khkt7xkZUx/pDs8fnhcIAkhpv0nhGe3HynI/DpZ9QeG1UMlg8nSG6Y
	 p9Sm07KOacR8xvWTqiKUwLRjUibeGBmirOGveVLaFMxfCeB/SCl5jnj/BToE1CYCAMV/q
	 LxY6p+KwXgtkoG72I25CbRmHpKu1F/XQbeDJP2bBBa7mN9aVwuo46V4aXVcMAI+p35GjK
	 ReL0a1vDo7fTpEl0XT4979x+I1BV2GLyD2L4Df0iwqwMiN0kRaOExz7XfFRybyWA/cJxT
	 8o+vPe5poZ6oYCWNlijM2aQRabwVY9fVdt/kbCARZZPUtvKVmgNqeIRVyprSjACVmiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=SjWIGoze;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF819606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF819606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=SjWIGoze
DKIM2-Signature:  i=1; m=1; t=1794418659;
 mf=PGhlbnJpLm9tbWVyQGdteC5uZXQ+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.net;
 s=s31663417:rsa-sha256:ElnRTc8GgYoxZNRPL5NZiEVFg4dA
   EERtzMZ1zaIeiOkQOoxbutW/29AVmAaGSos8tmNYDWO+f0s3FLECP4ARVEait00hXtZPIwuFz74
   BeZm7pgfkDZEZTS10gDWEVRaHxnrv32IIEA3p47td6oMIOGPEu3qKmnehS+FzQwkucbat/4gwO6
   5IntljzEYa3fEWOb+UNMR59IiFL/1Wd6yaFrh6Grw5zczLwWxYhxFeZBKS5yhWwj0QndoT7+V2H
   FRgZ3ay9vaXTZc+2K9nu3GzFCDrglsIm1Syk1YcHe/c4XHzE0jhPYdLkol+thxQsOUbzX1PZAje
   IFsZphxwZiQtzA==;
Message-Instance:  m=1;
 h=sha256:
   JFEZ1fYmRy8qRi0vdZs7dS73BuLQW5fl6NtI9NaY2fw=:
   L6/ug3bRHsmU7QQ/R45mljP1eOgt/ekacKnKpw4KnHA=,
  sha512:
   8sO37PnrzylHdPsNQNrybtyGqZsjxADEZC8vijOpV0wBGv+y0aiMf8CWuAkn20eKQyzXfTRnigYNj8/Aah3dMA==:
   ddHGmz0wSV3WiIDdyNOKVRed+ZyneyCzee42ynpOZEFMetFmTQxWJMApCjTH1joxZgLscabCh3Hl7wijR7zqLA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794418659; x=1795023459; i=henri.ommer@gmx.net;
	bh=aqk0S43USCOG9Sp2A2hjLU27no6gm2+WNSu/ljelgBw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SjWIGozeoGw08f/2M5GYCzuD/hGen0t581+6UoArnDVGYpI2rhp58mEH4XkLiqFS
	 m0Y6N1BuXSnSiO5STGmMsJFmBDJwb632qx/HdzLSTWQN7jtbfRfsZFFFoC0qMOEyp
	 esjEx5ZdFDiv7LQ+X0oW6WrJTSYg0/pH1pB3LWK+POfADbcf+J9eHL/iVPRAN0mCa
	 dLeonEMdCfQbONIU121lD9xWpcp090UcNMrK2Ll6SOMmIgT4ouS79KE4qZgKUtdn3
	 Oj6L5xZyRSrgM+8dCwP7j8zDSd8xqq/XwK9/X71ZrxTqawGSZVpwBHbnxS6HyF0Ld
	 Jo0CiUMCTMcx+AJRmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1wdXZH2LtU-00bviI; Wed, 11
 Nov 2026 18:37:39 +0100
From: Henri Ommer <henri.ommer@gmx.net>
To: linux-input@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri.ommer@gmx.net>
Subject: [PATCH 0/2] Add himax hx83102d touchscreen support
Date: Wed, 11 Nov 2026 18:37:37 +0100
Message-ID: <20261111173737.5721-1-henri.ommer@gmx.net>
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
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jiarYsjMXvkGHoSOudpw3HglufuvfbMWCU23rpQKWNlQhId7tsL
 TEMU5WbhDENEKv1KCHzvDg/ECokuGVOeC4jSuvNi+JHpROPsh1JqNEZBVMoQ7I+M/v5BKUQ
 TEwTtGLXxuoxfxGNMFS5Rz9W12J9WMNsV7GM4DODyVmtWTCLSue7EdEksxVAeibRqJ0Za1K
 MCy6Zx2sann7GG53UDwZw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MglUbTiTCaY=;T3olKCwTbeMhZSS1ezJ1+pIfq6E
 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

Adds bindings and driver modifications to support the himax hx83102d
touchscreen used for example in the Samsung Galaxy A20e and Motorola moto
e7 plus.

Tested on: Samsung Galaxy A20e

Signed-off-by: Henri Ommer <henri.ommer@gmx.net>

Henri Ommer (2):
  input: himax_hx83112b: Add hx83102d support
  dt-bindings: touchscreen: trivial-touch: Add hx83102d

 .../input/touchscreen/trivial-touch.yaml      |  4 ++--
 drivers/input/touchscreen/himax_hx83112b.c    | 21 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

=2D-=20
Best regards,
=2D-
Henri Ommer <henri.ommer@gmx.net>

