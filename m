Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66430175A68
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827913; cv=none; b=JQ81Jg1ZslKk9Oecd406q0IFNvhXsb9kEhH+eB1KupwSxgEvSfUo5OgwhY5TgUy0r5pniBBshOjGt8om9Seev4pzO+u0+84yleZ2pzIJZQdL30R3W96B7hoyJjhIog0ZllxoEbr/OgjHAD4V0mytkh+HvWRzyGwI+q6woPNL1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827913; c=relaxed/simple;
	bh=8ARz2B2ZA+gpPF8e0RnONtjuX9awqi9wxE5lMy3En80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=euzFwimuBbbddxevEUjAAYxp+kFIxOCJCBi/Q5Q+BumFYPGGFUEyYhiMeQWltTFhcna4wVjoObX+MMrjWU8N7ELwKr3Cxr0rWb6yeyyJ9dr4sQJ/mbo5QHrPHUjpJYeeRUdpGaGAFuGWsiro+w3Vd/oHqv4HWoAW5l3e4wPrG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gr15Olp4; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gr15Olp4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781827900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HO2KvNoJUj5nHgSO9EbcQdzLT4udkBP7UhGGKtpDeDs=;
	b=Gr15Olp4NzoA91URrqROFOyoj8Fyv1hKILU+jtMifV8WIZ0RV75govDM1ogQqL42whMpN+
	nxb/cqiXd6i9BZpEUyJYrbPibPYtaFeT9hJH4uYsZRdjRFEPJmEv2Q4e2hQgxL0namBNew
	HXPRe+UbYjwTanKgYEzaqwMecZ0ij7A=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>
Subject: [PATCH v5 0/5] HID: asus: security fixes and more hardware support
Date: Fri, 19 Jun 2026 00:10:58 +0000
Message-ID: <20260619001103.1189200-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all,

I have added support for controlling the (way too bright) XG mobile
LEDs in hid-asus and added the i2c version of already supported
hardware that was probed only when it's a USB: these are two separate
features changes and are the only two that are not fixes for
pre-existing issue (see below).

Auto-review bot has spotted a bunch of pre-existing problems alongside
problems in my own code therefore at this point I am going to fix the
more problems I can and including those fixes and improvements in this
patchset.

For v4 I decided to follow Antheas' suggestion of reusing the existing
workqueue and by making it more generic I solved a good bunch of issues.

The v5 iteration is simply me fixing a bunch of bugs in new code spotted
by the bot. Thanks for providing such a useful tool!

On a side node this patchset has a few more warnings: specifically
"WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
positive as that would introduce sleeping calls in atomic contexts.

Link: https://lore.kernel.org/all/20260612124830.984592-1-denis.benato@linux.dev/
Link: https://lore.kernel.org/all/30258f28-4036-4e99-9494-031212544dc2@linux.dev/

Best regards,
Denis Benato

Link v2: https://lore.kernel.org/all/20260612142326.1704858-1-denis.benato@linux.dev/
Link v3: https://lore.kernel.org/all/20260613153029.2559774-1-denis.benato@linux.dev/
Link v4: https://lore.kernel.org/all/20260615165058.3845-1-denis.benato@linux.dev/

Changelog:
  - v1
    - Initial submission (as separate patches)
  - v2
    - HID: asus: add i2c entry for FA808UM and other TUFs
      - Joined to the patchset
    - HID: asus: add support for xgm led
      - Use the correct callback set_brightness_blocking
      - Stop hardcoding the cled name
    - HID: asus: prevent wrong pointer cast
      - Added
    - HID: asus: mitigate possible use-after-free
      - Added
  - v3
    - HID: asus: add support for xgm led
      - check devm_kasprintf result
    - HID: asus: prevent a late KEY_FN_ESC to trigger a use-after-free
      - Added
    - HID: asus: avoid sleeping calls in atomic context
      - Added
    - HID: asus: cleanup keyboard listener on failure: avoid use-after-free
      - Added
  - v4
    - HID: asus: refactor the two workqueues and init sequence
      - Added to replace previous patches in a clearer way
    - HID: asus: add support for xgm led
      - Simplify cled interface allocation and registration
  - v5
    - HID: asus: refactor the two workqueues and init sequence
      - replace kzalloc_obj in atomix context with kzalloc(..., GFP_ATOMIC/NOWAIT)
      - better destroy the queue on _probe in case of errors
      - Fix a data race for deferred asus_kbd_wmi_fan()
    - HID: asus: add support for xgm led
      - improve teardown of the cled interface

Denis Benato (5):
  HID: asus: refactor the two workqueues and init sequence
  HID: asus: remove extraneous OOM error
  HID: asus: fix a off-by-one in mcu_parse_version_string() validation
  HID: asus: add support for xgm led
  HID: asus: add i2c entry for FA808UM and other TUFs

 drivers/hid/hid-asus.c | 491 ++++++++++++++++++++++++++++++++---------
 1 file changed, 382 insertions(+), 109 deletions(-)

-- 
2.47.3

