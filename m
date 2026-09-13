Received: from mail-vs2-f9.google.com (mail-vs2-f9.google.com [74.125.227.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA525782D
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266538; cv=pass; b=Tl5E1XvTbC0mQ7LIAGn1l6s7Mn/ifuZUEeq3za9QMyEfscWPYirUjc+t/SVoe8qimmpGSiM5OgZfdTJRkC1FT6K8eswm6X9IUhYxRqknO6Ry0mXd+8RlRwsM47y7kYBjncjuxWF6GhQD4V5qPwcCfbTNmS2BsYCf4SxZNzsuGsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266538; c=relaxed/simple;
	bh=Je3un76FN0GkyAppP8SDWyHHjnKMnJzgH3Apj/eDhN8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bu8zTLTIbQ3AY0JahLwQLJS3KEKBXIHyihu9bykWUkejQDhF3dHz4O0JOYlP3+XUsm8eSJAkXBVfKtuga19FpG8yV1JUIBuvexGe7zxGC2pBRKbdWD5Y4bJB3OjgoHhQbxM9mdiWIXR00HWT3mkmMm0a5CkC2mkPA3+A2pRtWlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/7CH0uf; arc=pass smtp.client-ip=74.125.227.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/7CH0uf"
Received: by mail-vs2-f9.google.com with SMTP id ada2fe7eead31-78ff83b1be7so486225137.1
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 19:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789266536; cv=none;
        d=google.com; s=arc-20260327;
        b=Yz/tk7CXvCd1pLqijFPP1VCdbO1vGArH4vXlfvdcGJBGWhtTvfSqDYPMiNXiM46//c
         qIs47zrhaKtYnmE0r4EDcwkfYzCDHwXcw+sFpWjXBewqqqMqScYLkPMUd2t57e4gbobV
         jo36C/kwaVzMAg1gLmZjqskyR2PJ55HOEboNedOuoZyq24Y6L9pPYuXIerUaxYOIJlzg
         12OTH9uWFrAeqhnz+oTitvfrqKXpXDxPzeEnbpD+9hM18GVBFXxSspHRqlzh5MglvwIt
         1eljNIYpWkNav7qzdWPMHwdjRSLVJYZmb116n+TowkycE7zvaZe9SbAk1r/55LDHuBsR
         NRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qv2MLB0Xyieedx1sv+nnNDg8XZ1pBWqskhszMj0GAHE=;
        fh=c+Vru0HWvJkxLTILpOQlHDSUgzB1bF+hHn8BGy7zo8E=;
        b=RIo0oVNMq9HcAFtyidOFfN439rEJ8pkNYJVyEJLNN0CXLQDK9TMsGsvhsluxP5/WgY
         brH782eJnJJT9AxAqS3WIUrGLRFNpdCR6PimuJXgAVNXzDZBHINvjNDeJqBkQo2ugxhG
         20W2/fZz3Qo4A0Yq6+PRbQxoGpYmMXdYuD1IoYfO0aFIyLe4D8wsm8kgucwypis9dS4N
         ele/e/7h7PwE2vgClrkgj9Nhxf3zn8wE2hyVqon1Yc9Z7rFl1qKiF7hkLGlv9AdPhkD4
         +WfwLzQTrVKpeVDeADqOTW6isdbtQHS+uMq4+BskrzE1z3V+nrsOK8FqD5ikhfNoXolj
         4Afg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789266536; x=1789871336; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qv2MLB0Xyieedx1sv+nnNDg8XZ1pBWqskhszMj0GAHE=;
        b=H/7CH0ufghSrxcPvnR3N+Zzl8vD5naZWHw0Aq5yyXKkeUrOrmtVyvTOzRAK9i9r21K
         HDu2BqCyzlAvh7Le1JiWdBGbwmjrScQ9WA31P94JbAKAbX0r2/ixLMJM71+AbAjwhDJA
         zprSiZPQM7RXCtVRb92DZOOCyPk65DnNu/0dR5UpU/6jWu+87G65iMHxjsvVNVTcfP6S
         7p4sT29mpu4r/yBtaOxoGduyCAg9OUMHm1v1nVTdZEW9RB4qJIXijLk3CkATI25ZRNIP
         UXpKHzOvL/TSabw/oo1TxW2ngeLENRCIkZZlHbBPGw7JOHTfn3rNjDRAcO11OoclgxPm
         RVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789266536; x=1789871336;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qv2MLB0Xyieedx1sv+nnNDg8XZ1pBWqskhszMj0GAHE=;
        b=CWPAVJJc5pcwfrTUBYp+q/w/ve/wWZv2SiGihZkFU46KAB7PZbcBHwiqkaGqVMUeSt
         WE2pguSQLuKp5DPxkaG892XyLtu0oeIUhmmNxH2wEkiXhnaEimDClMxxmU+z2we8ZzMb
         E6+z4KskAaNyKD28iQT3VFLeOfmOg9WUufwMZHv0qR2OloJrSqAvqn9DvqOpmFBo54tk
         KayuWaVl0gSrnmPHK6Xm9Ydxl1+87Cb3x1zl3a0sch0D9qUfZm88l6N9Zy/5Ghp8cXd2
         y2VRD7AtPB27V54akEzG8LCTW85HX5cLQErWh+mHvvISbwx7hMEgVqpPM4TBL2i1rNHR
         ozpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxinIjVLBZd5MPU3RtrwZ6AGSFv+2+rDzhTTeGcS+S6T9RIn8d8bwVY7rsfK4rGO80yGXvqJiGQ0ayxEw==@vger.kernel.org
X-Gm-Message-State: AFuF++m1PZ7B3MzaQx3XCucyoHkDuebAxkJCZuJ+gQx+W9sZsFE2fCHk
	cE0KvgnuwItYZtzB0kjtD5U7UOyxaZqRhM5uoM8CmQx5yNTVe7bcu28UscPUxM2qUDtt1TrlKIM
	sZhy658Y+mWpklE1eLp0y60YYoOe4xrDZDnU69DYpBw==
X-Gm-Gg: AYBFou2scXj2g/jZljxosnPN5GR1l6TV6T6nlcjA4VSd080nBYKIPKg5JF4+f8QkmZA
	q9o5SrlDkMMeD2KzYN6CRKeCRXf3KXI46tUm7NqBPmc+Y/He+mGwYvPULGlEsv79NEX0nePpdQx
	ZnYCEFJfQD+ymirmeUm07R+VbSzffSH/lj8uLcs+ognq0bbjFPpgTYwZiq86qlFI8vl1u6nHdbA
	fy0MowHmEWzST5bEDLHl2EOScJFzNA+pjL0lgVQFa/q58kHfnxCWO/BRzdbYpq10c0U09SirHw8
	dBA6KOIP71IYafAseyy2UEDe7qB9Tpv6NY+9NgIqV3rHBUSUaixKNCxswqC1f9qZVkEppNWqeLf
	oZtYAKrVggZA=
X-Received: by 2002:a05:6102:5493:b0:77a:d089:3dd8 with SMTP id
 ada2fe7eead31-792aa86054emr10597379137.12.1789266535836; Sat, 12 Sep 2026
 19:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jj jj <fdr41303@gmail.com>
Date: Sat, 12 Sep 2026 22:28:45 -0400
X-Gm-Features: AcwNN1VJo3v34RPdg0dJbHKEtl6KSBNIr6ZzcldhD4H-bjG9L23AmKFLHZdOjpA
Message-ID: <CAMwVT_QRGnTRVbCVaUSS+3+9R=os59DGU5AzSZVqd9_jpLBV4Q@mail.gmail.com>
Subject: [PATCH] Input: sur40: prevent polling loop from stalling
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the SUR40 driver receives a packet with no blobs while blobs are
still expected, packet_blobs remains zero and need_blobs is never
decremented.

This causes the polling loop to make no progress.

Return from the polling operation when no blobs are received while
blobs are still expected.

Tested in a VM by reproducing the condition and verifying that the
driver no longer remains in the polling loop.

Fixes: bdb5c57f209c ("Input: add sur40 driver for Samsung SUR40 (aka
MS Surface 2.0/Pixelsense)")

Signed-off-by: Fartman42121cool <fdr41303@gmail.com>

---
 drivers/input/touchscreen/sur40.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/sur40.c
b/drivers/input/touchscreen/sur40.c
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -510,6 +510,13 @@ static void sur40_poll(struct input_dev *input)
  if (packet_blobs > need_blobs)
  packet_blobs = need_blobs;

+ if (!packet_blobs && need_blobs) {
+ dev_err(sur40->dev, "received no blobs while %d are still expected\n",
+ need_blobs);
+ return;
+ }
+
+
  for (i = 0; i < packet_blobs; i++) {
  need_blobs--;
  dev_dbg(sur40->dev, "processing blob\n");
  sur40_report_blob(&(inblob[i]), input);
