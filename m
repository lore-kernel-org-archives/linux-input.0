Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782256FC3;
	Wed,  3 Jun 2026 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446068; cv=none; b=kcELkPDBXW8JHZIEittlrq6s7IvCjmtF2ods/DhxLNeT+GECGIeAwQLUwD0ACySBhTfBMGN8QuD9u3j7hlcJjMViKave0mK+wI8HjXKsyfcMBNYh0WOKE/HxG8XsxTPBVEp15rYdYpjszWhYslEEYgYnvbV/vhDN9/QK8a15xRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446068; c=relaxed/simple;
	bh=PCeG6nffNpMPTsmMEhlmU6I/TNZgwnzOocl+RHMAAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLREjTt02acQ5F7RZ9ecSrSp4ESgf2tY5TmQpEjl0Ujqr3ObQQaTTcTeM6v9aI5iY4467XdI3wB3tMJ3Y4F6VWzQPLw4wVZI3O6/3viqo7U/NH1JZIoJWOKgxbU752rGMyw27+J8Gco+vnax9FN6AmZx3SUgFzqyEwvU5g6tH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SDYQh/XZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SDYQh/XZ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0088F2709B;
	Wed,  3 Jun 2026 02:20:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bv1jD9UKNYp4; Wed,  3 Jun 2026 02:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780446057; bh=PCeG6nffNpMPTsmMEhlmU6I/TNZgwnzOocl+RHMAAtk=;
	h=From:To:Cc:Subject:Date;
	b=SDYQh/XZtOeO8hWd02T98oflRgVmNUhGmWkkbwS+9yxjy0NmVIfw1YdiyEIib7TE0
	 m8drIse7ya5148+1BzALTW08m22dLS8tvgISwBIHxffEltiGWeu2tlE7jBb77V8+i6
	 MKjfBhT3mx/02CLL/+fpMUYSrqqTjXPBrjVIbb7brL4qLsCcQ4cD5O8pdwReaAJc+6
	 HfxYtUSPF6SC2CilrqtmDS94F0JboE0O62YK4iFBI2V219El9F4ljro0xcyRL8qsUD
	 cDzyY9EtF91QOuA2oPKTDt8vSGebEeS+/JRV5kVtbtnjrLCvqIx8DmbmATYx73D+O8
	 EPbg78OcUtbMA==
From: =?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Larocque?= <rlarocque@disroot.org>
Subject: [PATCH] Input: synaptics - retry SMBus intertouch setup when companion is not ready
Date: Tue,  2 Jun 2026 20:20:46 -0400
Message-ID: <20260603002046.10697-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some machines (here: Lenovo ThinkPad T440p 20AWS0H800),
the SMBus companion device is not ready
by the time psmouse probes the Synaptics touchpad
during early boot.  synaptics_setup_intertouch() returns -EAGAIN in
this situation, but synaptics_init() previously treated this the same
as any other error and fell through immediately to PS/2 mode.  As a
result, the touchpad and TrackPoint were unresponsive for several
minutes after a cold boot, until an internal reconnect cycle (which
already carries retry logic in synaptics_reconnect()) eventually
succeeded.

Fix this by adding an exponential back-off retry loop in synaptics_init()
when synaptics_setup_intertouch() returns -EAGAIN: clean up the failed
state, sleep for 500 ms on the first attempt doubling each time up to
4000 ms, then retry.  The worst-case added latency at boot is ~7.5 s
(500 + 1000 + 2000 + 4000 ms), and only for hardware that actually
reports SYN_CAP_INTERTOUCH.  The pattern mirrors what
synaptics_reconnect() already does after resume.

Tested-by: Raphaël Larocque <rlarocque@disroot.org>
Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>
---
 drivers/input/mouse/synaptics.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c70502e24031..5c1bfff2b16c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1918,6 +1918,23 @@ int synaptics_init(struct psmouse *psmouse)
 		}
 
 		error = synaptics_setup_intertouch(psmouse, &info, true);
+		if (error == -EAGAIN) {
+			/*
+			 * On some systems (e.g. ThinkPad T440p) the SMBus
+			 * companion device is not yet ready at boot time.
+			 * Clean up and retry with exponential back-off,
+			 * mirroring synaptics_reconnect().
+			 */
+			unsigned int delay = 500;
+
+			do {
+				psmouse_smbus_cleanup(psmouse);
+				msleep(delay);
+				error = synaptics_setup_intertouch(psmouse, &info, true);
+				delay *= 2;
+			} while (error == -EAGAIN && delay <= 4000);
+		}
+
 		if (!error)
 			return PSMOUSE_SYNAPTICS_SMBUS;
 	}
-- 
2.53.0

