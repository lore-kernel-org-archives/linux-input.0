Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC421465B4
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771029509; cv=none; b=DjntdqwS2q5HczMJhk45/b2aC2qKwfYooKJI9/ein6Ue8VT86ctVKl5e47XMQP0aJA85If60Z7abefdSpyY6sLImHGxn6mKOx/b+JYbp9oVf/QOF/JRVSQcfvEqsNIRO22/VVdoJmgVnAjEpi8wWoXzuVjLmndCQqH7H2lcF8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771029509; c=relaxed/simple;
	bh=s3EcFswAlwyaMDihfcI4hmXUcZ7mBpTZ+EFgpl6HbxI=;
	h=Date:To:From:Subject:Message-Id; b=kVP6b4PHkSm1LC+o3oQat7CSEdTCR2bMSdqIZzlcA5vEvFVHGm1g/HJ+/guRycuSS9rrJcmq189i8fQVNb9Bzpg9Cj2+s18wassEQmnF5X7G+z9hoOlfIPyrQACjMUZcJcqMNQB4BEikPKwX4MBkb8Xn5IM/8EY6bZEaLJB7u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Upw1nlCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Upw1nlCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1A5C116C6;
	Sat, 14 Feb 2026 00:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771029508;
	bh=s3EcFswAlwyaMDihfcI4hmXUcZ7mBpTZ+EFgpl6HbxI=;
	h=Date:To:From:Subject:From;
	b=Upw1nlCqANkOA3asEfYv84KOhad5hmj5hb3h7YIPeu4l+uGmkaXUAXTUsAl/Pdzz2
	 rCgC33mGG0IvljOoLUkVZiS12AqMzV42altZdYkV2L+qyFAItOt/tQm0ms2vxFtL/N
	 gg3FEdiWbs38iZ6gFzi0/TP65LNe9WyJZMXLLJ+I=
Date: Fri, 13 Feb 2026 16:38:28 -0800
To: sean@geanix.com,Frank.Li@nxp.com,akpm@linux-foundation.org,linux-input@vger.kernel.org,samuel.kayode@savoirfairelinux.com,dmitry.torokhov@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] drivers/input/misc/pf1550-onkey.c: fix build with CONFIG_PM_SLEEP=n
Message-Id: <20260214003828.BD1A5C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

From: Andrew Morton <akpm@linux-foundation.org>
Subject: drivers/input/misc/pf1550-onkey.c: fix build with CONFIG_PM_SLEEP=n
Date: Fri Feb 13 02:39:04 PM PST 2026

riscv randconfig:

drivers/input/misc/pf1550-onkey.c:154:12: error: 'pf1550_onkey_resume' defined but not used [-Werror=unused-function]
  154 | static int pf1550_onkey_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~
drivers/input/misc/pf1550-onkey.c:133:12: error: 'pf1550_onkey_suspend' defined but not used [-Werror=unused-function]
  133 | static int pf1550_onkey_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Cc: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/misc/pf1550-onkey.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/misc/pf1550-onkey.c~drivers-input-misc-pf1550-onkeyc-fix-build-with-config_pm_sleep=n
+++ a/drivers/input/misc/pf1550-onkey.c
@@ -130,6 +130,7 @@ static int pf1550_onkey_probe(struct pla
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int pf1550_onkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -175,6 +176,7 @@ static int pf1550_onkey_resume(struct de
 
 static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
 			 pf1550_onkey_resume);
+#endif CONFIG_PM_SLEEP
 
 static const struct platform_device_id pf1550_onkey_id[] = {
 	{ "pf1550-onkey", },
_
