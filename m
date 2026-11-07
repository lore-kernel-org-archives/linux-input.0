Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073667;
	b=CUMyys/XAqBw3nDhPzkGy4+x/gVTnjRe6rdgnI9hNFB2djgFt3eQ/qK0VGohfWa+uJu4
	 rhV5pCCOtD8clh5nhDOjIOS7+b4z1o4lQc0qDmZY8irGiFsrottkqkRSurreKvO4b+J6l
	 bRJznMuHD++npXLt4+FksuEgc7444Q5lagMMfEL84Y4q56MZJk7uIc8r46DdA77DNMO5z
	 f0/kGuLI7tyVT/acJwWCVw9ST453uJSBf4NrRlyRQd0jY9uAg8Sm6+aUHw8nrR8A1uge7
	 xCLbMe2Iu6XsReRUztqK0Uu5ibpPeA6ec+iduSRdyrWwjnSJNnlS6/Ler/kTldl5o6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=vARIb/eUKST3+AmBEI7Cuzd0dCLfvGmpPb1wpV4o+6k=;
	b=1c0wp6B9L8TqFJDx5EjiybTR1Np46vJPBzvUFF2kCIfmgR3c4lrx1m3fJDrOeLUKzbzt
	 SPhFyot/Jdb7k4eYFyJEBpyUz7v8ZoU599Y8Nnbhamlmh/0xn/aC2BbvwYm/7X4Y36kIk
	 FQhJWTj59RnKOcmSWPbSZi01pHQflLFDDgZGoBk+KXpLomsQ47w376GoFWdsHuemEb9wz
	 vcfqxr7nINjfiIF9T0wMAAScXGyxUlvyMpyA3oqmWezufhDvr1KXAtKTfO7dY8Y1mgzrG
	 eUXF/Hx+jhL9V9pPvLQG1BkI1KPCtOgsjdqxhtikyZroDPJlhGmoVQ9es+s2rJD63Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzqnSwiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06604606A326;
	Sat,  7 Nov 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzqnSwiX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671901F0089F;
	Sat,  7 Nov 2026 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073666;
	bh=vARIb/eUKST3+AmBEI7Cuzd0dCLfvGmpPb1wpV4o+6k=;
	h=From:To:Cc:Subject:Date;
	b=lzqnSwiXkim+1Xd1t0PWLgS7AuyrWPWNL/NLI5UQjgULjiMFOwDlKgiX7jJXe6TRY
	 61oFhppC5Jb1+mo2StblOOFDxwjtjLv+TAuLwuLBOEzjWWOIqv1tuXU7h+Q784nIKQ
	 hepyoRvvC+Pj/+eNSObGbzw2jBn9o77KGdN2iU7XnRoSxXGhdZKjeEyHK3SGjEDlDm
	 0p+yhqLMpC0FK0BjBdRX226hJAjs94DI7NGtqnLaV/Znhz1/5t8RtjxzD+7STY/mw9
	 A45DNqrYl/OasnA3k1/RH8Sbnxvkt2XYClVBp+bYU1wgLoCRfYWrtX+CL/pyuYPA7Y
	 lHZP3ujP0Gt2Q==
From: Thorsten Blum <blum@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: amijoy - mark amijoy_phys as __initconst
Date: Sat,  7 Nov 2026 18:47:38 +0100
Message-ID: <20261107174739.369375-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=blum@kernel.org; h=from:subject; bh=qVvadY324JelskwzKrqx0tuoGJDDKPjZ/UEtcmuv/Ug=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnvU6x5ZSwlVifmLPg88w3npVPZh3+9ZfvQO+Fm4H2ZX ddW+0T+6yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJFN9jZNhgkMDAI6g++crT klTnLwsuNInExzJ+/Ht/bZ6f95JW/T2MDLM+Lbf92e92bl/G4kMi7kszJjRfrZ2hsefK0ueLOL/ +dmMDAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

amijoy_phys is only read by the __init function amijoy_init().

Also declare amijoy_phys as const.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/input/joystick/amijoy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index 3752dc2a2086..cdb2b8f15348 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -30,7 +30,10 @@ MODULE_PARM_DESC(map, "Map of attached joysticks in form of <a>,<b> (default is
 static int amijoy_used;
 static DEFINE_MUTEX(amijoy_mutex);
 static struct input_dev *amijoy_dev[2];
-static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
+static const char * const amijoy_phys[2] __initconst = {
+	"amijoy/input0",
+	"amijoy/input1",
+};
 
 static irqreturn_t amijoy_interrupt(int irq, void *dummy)
 {
