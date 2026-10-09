Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA64DEC3E
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546580; cv=none; b=XealAEisySjooQy75aeq3LKSY+UkqeorE+Zpntb6e+tkm+y0tatwWSz3rqb02vert/Vo7ETfD+xRWgNZkAMdrSvMsmhf1yEkZhbunKbV1ox9AeE6TJ0MFUFb7njqlrZXiBqxJJiFStb/0Fns2B7dua1pHr4DI7Z3EToI40t6h8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546580; c=relaxed/simple;
	bh=enIApucpcWJltIl6KtVfvTPviU7qOoTkYGNdO7+VSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUM/tfPqKIL7EidKGLxKGcO6MFr1sW9vXQnpv7Zda6FI28IgE0fcyCEnTi1wylt5LVIefzsHklN2r8rerN/T7yZd1AYGYon6UVkaUFXjUfNBlSS0gxaE+R0/jhN0vWeMDovNSypjhz+CoBG8vuUrHVsYRWAAeQ/L0EupQfNjOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4a3uYaO; arc=none smtp.client-ip=95.215.58.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4a3uYaO"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=enIApucpcWJltIl6KtVfvTPviU7qOoTkYGNdO7+VSrE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791546566; v=1; x=1792151366;
 b=w4a3uYaO+Pgp0n/eCxIf0t+F8eLZnZbno2jPpY8w2ikwAtpWxlcOafecxfNoywPkAJ/YIxYi
 G9ShuCtocgvNbHv4fJXDWS3I7G80RJFSPhZNhcY5qDy8jJMFYJRxiyA3OH4VWhRvML0G0LIEfZr
 ItAcMlYnY3UivnkB87iVTOXQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be8d6ac0e782d348;
	Fri, 09 Oct 2026 11:49:26 +0000
X-Mizu-Trace-ID: be8d6ac0e782d348
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v2 0/3] HID: asus: improve the driver support for laptops
Date: Fri,  9 Oct 2026 11:49:18 +0000
Message-ID: <20261009114921.5242-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Antheas has requested reviewing the XG mobile patch on this cycle so
I am re-submotting a modified version that is a bit cleaner because
it uses LED_CORE_SUSPENDRESUME instead of re-sending the LED state
manually on resume, but it's functionally equivalent.

I also included a patch to fix a pre-existing issue that was flagged
by sashiko-bot, albeit I'm not entirely sure if it can really happen
in practice, though it is safer to handle it correctly given the
actual code change is so small and leaving it documented helps future
changes.

I also moved some code to reduce nesting and improve the resume path
on ROG ally and other N-KEY devices.

Best regards,
Denis Benato

Link v1: https://lore.kernel.org/all/20260813144736.2477941-1-denis.benato@linux.dev/

Changelog:

-v2
  - HID: asus: add support for xgm led
    - Solve an impossible error reported by sashiko-bot regarding teardown on error

Denis Benato (3):
  HID: asus: document and harden the worker teardown
  HID: asus: reinitialize the device after exiting a sleep state
  HID: asus: add support for xgm led

 drivers/hid/hid-asus.c | 148 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 10 deletions(-)

-- 
2.47.3

