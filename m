Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E32222AA;
	Tue, 30 Jun 2026 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802441; cv=none; b=Dgma7ox48JUt6PqhtkyyzqLsi4DAGwklzHAJhvmXPrPRjpCyVNqdvCdvI6FcmawJb9iAXvFkWNFPzFwItKUcw97jXPP+3dNAAQkDVLBeFHUNuihFVgrpvnbTnWxIwv2iLx2Y+9kYIBU5IDPTS9E85MPaAZ9V9xxgOCpyY4F9RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802441; c=relaxed/simple;
	bh=krpLUwCmo7k0JQQMK1Axhjyn87Lih/mhoDw3tWbJS9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nu5qGeyZH14yp/PhL6a1/RYz3Vug98s8xWlEjgiLTQmiR9CB2281zOmlt9BO4B0nJlhdZX9cSiH6CT/f/JLdvOTmyDvTtCY+AMCSN9XcNmiZRwEoB0gD3OtWAAbuQZ0WuN5+h//RNy09QxD07z8lGwnxH9ZMw6EzS7Kj6BbRgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0009-Input-usbtouchscreen---validate-Nexio-reply-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHntEFaENqYycjFg--.24231S2;
	Tue, 30 Jun 2026 14:53:57 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] Input: usbtouchscreen - validate Nexio reply length
Date: Tue, 30 Jun 2026 14:52:46 +0800
Message-ID: <2026063007023179.2-ccfa108-0009-Input-usbtouchscreen---vali-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHntEFaENqYycjFg--.24231S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw17Ar13Ww4UJw4kJr1DJrb_yoWDJrg_uF
	W0kFn7Gr4jyFZ2yrnIk3y3uryvgF4kZr97Cw1DJF4ftw1S9rs7Jr93Wan5ArWUWFy7Gr13
	X3yagr1IyayxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbFxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

nexio_init() accepts replies with actual_len == 1 and then reads buf[1]
to compare the embedded length.

Require at least two bytes before checking the embedded reply length.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/input/touchscreen/usbtouchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb5..0e07bcc 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1011,7 +1011,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 		ret = usb_bulk_msg(dev, usb_rcvbulkpipe(dev, input_ep),
 				   buf, NEXIO_BUFSIZE, &actual_len,
 				   NEXIO_TIMEOUT);
-		if (ret < 0 || actual_len < 1 || buf[1] != actual_len)
+		if (ret < 0 || actual_len < 2 || buf[1] != actual_len)
 			continue;
 		switch (buf[0]) {
 		case 0x83:	/* firmware version */

