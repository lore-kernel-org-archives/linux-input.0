Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420964;
	b=Fz1IU08BRADLzmdX/OuOqAlRh59nh+VVZ2iQDwODJiZVgoDZN19yx0d8w589rdyr7FGZ
	 Dxe5Bj03vr1SxyyzpQ0rsxfTtI2mbOVnI2hdjvpAwW76ijLYEI/oTiq1zGwaElbWNwCSO
	 xTGG+sKJKf3IHV9847xZdNWIegzDGcALu394wh3XXQP3qNMzr8l+IydDWD6epr324CDJ0
	 nREhHfscMToFCdXV3EYakdFYlOXIBbLIeH5Oaa9+ZafPEXLfgY7dP6WvZQxOtGVHoPIW+
	 7L72tUqqjO5WHWm0opdBxUEvktD7y/JIySNJfJs0fQ5QGFjR+4YTOhXv6oXpjU9MprA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420964;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=PpB+IlzC2I0salUqY3bQLVy+rNJiGEYJgXOcoIKLYco=;
	b=OIiV/cH9JCxw7eqrWUG+rqmU+qhj3HpPoUHoaT9y7RGtl1U5+P8aLzu18mvwhAcnjOMf
	 rmNgYQP5SdoSJ2qjE7NAX6/+Cc25FMuWNCGuRw4kLQp+KL4/Oya55nz3Woxow7LorCkiq
	 RTrS17wL6ZArl/Ic1xBpxWAyQ4+Nf2moV7ybbKuJEknt7AhG//jKOJ9o5Grw97njGFDSC
	 bPFI8uL35FoOQUW0pwbRxexFp7Fs++Vl5AT9ucktbBGSf+5WVQG8UK7qG+8qOT8q0qTa3
	 mrlVmIUlkP5DFYlLjQWpC1wFZ2p+IpquRF3cxNOr2rmzUJtKe/IPz9EO5rct09BhO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=IAA5jtKd;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA9606C14F
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 18:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CA9606C14F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=henri.ommer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=IAA5jtKd
DKIM2-Signature:  i=1; m=1; t=1794420961;
 mf=PGhlbnJpLm9tbWVyQGdteC5uZXQ+;
 rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.net;
 s=s31663417:rsa-sha256:VDe5oft5AfwM35L2ljku06PGjOp7
   igPuhIaeTA+tbjLnSult4K3vuXMr7Wyl25TXWfsPz9k7ZDhnajjZT4xvMj/Zuv0jha34jL53+MG
   yEqJq6q05JE6szxhZD+w06IDKZvIkMcCstquGzuh+DxMkS8JEy7bHc+JgEgWHNyc+nC+zZkzSI2
   eyPmKMayDogQ9kp9PY3KSpvBPNl0+CYZHjyPbiehsebo+jRXWP4dPVmq2/W21cVbjF1uVl4q07X
   w63ohFkgME/9GL3TXGMzy1zy+OI3QSaJO3Tg4MWvZHsgcZUBlCNXswPnnHv93lSHk7SYt3izQRp
   fo0Ld/HZzJGjSA==;
Message-Instance:  m=1;
 h=sha256:
   W2ViEYTnD9oPOtTcK+oD8IuAqQUwCRJr3lZ+6nTBVds=:
   npzu2hJ9spIEn7F6bumq/OyyIATt5Wh6U/XYUz+70q4=,
  sha512:
   qvGHZVMcwfU3os2+E3oUd3al1Vin++2uR5Qr4tlR498YmljyORXZuAxD56wuJMsK/bCYdmQDH0Ki/NUUiFsRbg==:
   swniK1MMwD+ahbIkeILxIKe92zXyKdCCkGhzANwqLQyQxOs6MozxVpeUOrqw4o2L09MqsMaRhToIL7LTLzWWMA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794420961; x=1795025761; i=henri.ommer@gmx.net;
	bh=PpB+IlzC2I0salUqY3bQLVy+rNJiGEYJgXOcoIKLYco=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IAA5jtKdBu4pKJ4pvOwyEd8E6Pe89//UqlmH3xQKipB0r/J/pF50olaDPHly0Hcm
	 EEeefjx6qP+AiLvR2N4rhS261Zqy7wxTFYZtsZysB4vQaWjcIQhAHnNSlLJ655qqW
	 Syz7HJLkGh1/mRmaEN+XXDUeWR2VPWoordpowsWBd8Mv+yL7ladXREk5Unp6w3Exe
	 Akmk8HeA6nwdXp1m4xNQGJNMd8QDR8RpfcBj3tbuAOaeh21hadbl0JAw2qdXzQzTC
	 nh+HMKeStxLvauX200+cKzT2WB25clwevsWdn1x3+Uh5z3zZGbJtLc2BFM+NiiCGM
	 2ybU/C98pQjcPCNFqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1wlWNk0dw1-00erHV; Wed, 11
 Nov 2026 19:16:01 +0100
From: Henri Ommer <henri.ommer@gmx.net>
To: job@noorman.info,
	dmitry.torokhov@gmail.com
Cc: phone-devel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henri Ommer <henri.ommer@gmx.net>
Subject: [PATCH RESEND 0/2] Add himax hx83102d touchscreen support
Date: Wed, 11 Nov 2026 19:15:50 +0100
Message-ID: <20261111181550.2400-1-henri.ommer@gmx.net>
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
X-Provags-ID: V03:K1:AXw8G96c8+Ze0W1lCQ4x+QxFP2UfsrmmajT/RkdKopvmYReSH2w
 N61m09+oEghpE76RQ//xArBIUmwhg+SMIC6t3A71P1hqzokUZGlfo8Eq5gUmVe2qi6ABigz
 rJTmnK7N8RMH2fnMwmq9cUAffYbpSJzZdtVAOOVk8C4PYONNEtnQZ8aUNAcpUqy1zBHuuWu
 urYO5qZ/nKKl/TCDZ5oDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+QYp5i1oni4=;DGmJHGJEcd1Nq9FGXTVXGgZP2kq
 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
 n749PFu0pZVHR+vJeUicxf7DqQ+SM4oKlJ0w==

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
Sorry for the resend, I had issues with my email provider and some emails =
were sent with missing addresses to the mailing lists
Best regards,
=2D-
Henri Ommer <henri.ommer@gmx.net>

