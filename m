Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F159343889;
	Thu, 24 Sep 2026 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215837; cv=none; b=HRKP3u++M8f++Cb2krzNLkSi73Djtz/dlHdGo3CSX2Zu0XwhxS/jXJPwIUIKq1ytydYJjNzcJ/EcK9ds7kGZLT2pveo7BYQs+7p2GkahKrCCR5rND6qMzbfcJcbfn65hfxU4BwsZcAsifDW55thVzHEBykr2sl5dgXb+iZ0+alM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215837; c=relaxed/simple;
	bh=4rv9Kx0rC+FVLfBdpdmEFHBso4E8jpakmuDMXWnWw3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8qAhe3u6kX5jG0l+4v02AIGP922n+E4T5VyrHkgDyEIvynyMq6RQ/HrwcQU5KmpuL28+xEqlR5y0efYMcTxCMStMbWyd0r0Q0XSnkciqlIqWQEjTMXKh3XeY8ow1FLzW4/PCcC0tRsvyEAuBnHHotH/YT5GEpuMmyxMf5ZQggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=W2zC9ZhO; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="W2zC9ZhO"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [186.210.93.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 4418C1210F8;
	Wed, 23 Sep 2026 23:10:21 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1790215822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XgkFr9aIeQmKp3BGoq8H7V/9NQzNQlNM3IAHK/HlDDI=;
	b=W2zC9ZhOqsBeAEiZC2XidbyJk7NZ2nCNtum/hPsFU06s50T/7etLgPrgr4QUX0zK06pCWr
	AOPKawu5ei8fTO3jl3Fh9TycTteY48TVlTocrWYoc0lhw9IFT72s8QfAwYRaiyb43wPNwO
	IGbhmAGLv6jzFleCs1vbedm9sj6U5355JjEm1aCfiYhONYVdL5EbAX9S8OdE0pGNz1mGPg
	ejvFciP6+ToKXsA7agCYs/WWkLwVQbLPZz7pktkMg/l4iOkyovTnvwlzYVqxZFillHLeTC
	Z2WJaoKJUMHHuL52HqqRQgedShcizvxmX2NjgxMCggb4/PB1hc3sOJITRrnp6w==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>,
	syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
Subject: [PATCH] HID: wacom: fix wacom_intuos_irq NULL pen_input deref
Date: Wed, 23 Sep 2026 23:09:36 -0300
Message-ID: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, wacom_intuos_irq() passes the parent of wacom_wac's
pen_input to the dev_dbg() in the unknown report path. However,
pen_input can be NULL on interfaces without a pen, causing a
NULL pointer dereference.

Get the HID device from the enclosing struct wacom and use hid_dbg()
instead.

Fixes: eb71d1bb270e ("Input: wacom - use dev_xxx() instead of naked printk()s and dbg()s")
Reported-by: syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5a7cd83622c747977de
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 drivers/hid/wacom_wac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8feb8027b..5b2f65ea4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1019,10 +1019,10 @@ static int wacom_intuos_general(struct wacom_wac *wacom)
 	return 2;
 }
 
-static int wacom_intuos_irq(struct wacom_wac *wacom)
+static int wacom_intuos_irq(struct wacom_wac *wacom_wac)
 {
-	unsigned char *data = wacom->data;
-	struct input_dev *input = wacom->pen_input;
+	unsigned char *data = wacom_wac->data;
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	int result;
 
 	if (data[0] != WACOM_REPORT_PENABLED &&
@@ -1033,23 +1033,23 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	    data[0] != WACOM_REPORT_CINTIQ &&
 	    data[0] != WACOM_REPORT_CINTIQPAD &&
 	    data[0] != WACOM_REPORT_INTUOS5PAD) {
-		dev_dbg(input->dev.parent,
+		hid_dbg(wacom->hdev,
 			"%s: received unknown report #%d\n", __func__, data[0]);
                 return 0;
 	}
 
 	/* process pad events */
-	result = wacom_intuos_pad(wacom);
+	result = wacom_intuos_pad(wacom_wac);
 	if (result)
 		return result;
 
 	/* process in/out prox events */
-	result = wacom_intuos_inout(wacom);
+	result = wacom_intuos_inout(wacom_wac);
 	if (result)
 		return result - 1;
 
 	/* process general packets */
-	result = wacom_intuos_general(wacom);
+	result = wacom_intuos_general(wacom_wac);
 	if (result)
 		return result - 1;
 
-- 
2.43.0

