Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65E27CCF0;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781415371; cv=none; b=u+pdC8NKd/uIZwtZouBd2tzjusd+AGvYvcivEKD2VXFtDu6hNll9cVMscdYvSEE38ZHjdckAuZkBCMmu5I7+JCozM0+jySa+8R4OcOc00KYyQsHyOWH0eMJhY/HJM6YlUEoCUdt7GLO1bwMqrML3AApR1nPmpLf4/d7wgCJIAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781415371; c=relaxed/simple;
	bh=oWzqgZ7CL6oPYCU6oE8l+W2cIUxxJetbxweA08XVCxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IbjzbFFTNByxJnwbaBY3XxQ+z7T1xEAs9OL1eLE+I/33Bjr8IEdq0mLtSxXGhwQTyVLZAJKwn6MMCKWhjGUELcA7vobcbYRNAqX8sAp6ttg9aUP8ngW9qZli6H2bsc+x5NLlVbtCGpDVm4ZgenElkvwjntJT/uce2ocfPgl0EVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv1OGsS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv1OGsS1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4792EC2BCB0;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781415371;
	bh=oWzqgZ7CL6oPYCU6oE8l+W2cIUxxJetbxweA08XVCxU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Uv1OGsS1/P9c5vyBlZO0d91HiaPjPWwXy1RW4bwgyNrfxcYTuQveCrUX9tOd4q3n3
	 4te7H+YHn0Ip1p8baYWNOugJJ82c7a/gJYq6014KYtyVezuDbsS+3J+eAXkscCa3vJ
	 78MlcrevhljrXQhpQ21UbFLftYb10X51QxMtBa9M76lgYfqU28FbIioj9pSrwTdH7c
	 VQeDVPPfEudwJuYznyDVF+1FH+lQJaTLv6HIK/hr2t6Zx4XSLpOkZHpQhDZxnlPsRg
	 LzOpvaILkUQdj/29SWh/yS4Q9SHgy59oAdujLm4QVGJW+uOkXlnchZun3MwVVis/a9
	 PyiHrjkMjCOyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F0CD98D2;
	Sun, 14 Jun 2026 05:36:11 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH 0/2] (no cover subject)
Date: Sun, 14 Jun 2026 00:36:10 -0500
Message-Id: <20260614-b4-disp-818d6bda-v1-0-cf39a3615085@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMo9LmoC/x3MQQqAIBBA0avIrBtQCbOuEi3UmWo2FQoRSHdPW
 r7F/xUKZ+ECk6qQ+ZYi59FgOgVpD8fGKNQMVlunnekx9khSLvTGk4sU0NM66nGwIbGDll2ZV3n
 +5by87wfU3PWSYgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, linux-input@vger.kernel.org, 
 Andrew Duggan <aduggan@synaptics.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781415370; l=3216;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=oWzqgZ7CL6oPYCU6oE8l+W2cIUxxJetbxweA08XVCxU=;
 b=lHKBMfkDxuxX/3b3+4HtYPWm9RtM+VUakuNJwAPq3f6QI0Uk1pOwzv5dU8dElshbkTp06B9X3
 letACR/8LJCDu1cQdHcn8ouzFQcissLWjZn3dnobXCP1Hw6UPOHKgMH
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From be2c4843f6145374f28edd25cef43c9373542874 Mon Sep 17 00:00:00 2001
Message-ID: <cover.1781415009.git.hexlabsecurity@proton.me>
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Sun, 14 Jun 2026 00:30:09 -0500
Subject: [PATCH 0/2] Input: synaptics-rmi4 - fix out-of-bounds keymap access on large GPIO counts

The RMI4 F3A and F30 function handlers size their GPIO/LED key map to
min(device_gpio_count, TRACKSTICK_RANGE_END) == at most 6 entries, but
then consume that map with the full, unclamped device-reported count in
two places: the attention-interrupt report loop, and input->keycodemax
(while input->keycode points at the small allocation).

A device that reports a GPIO/LED count greater than 6 therefore yields a
key map of at most 12 bytes that is indexed up to count-1:

  - rmi_f3a_attention() / rmi_f30_attention() read gpio[led]_key_map[i]
    out of bounds on every attention interrupt (device-triggered), and

  - the input core's default keymap ioctls bound the index only against
    keycodemax, so EVIOCGKEYCODE reads adjacent slab memory back to user
    space and EVIOCSKEYCODE writes a caller-controlled u16 past the
    allocation -- a controlled out-of-bounds heap write reachable by any
    process that can open the evdev node.

Both handlers have the same shape; F3A was copied from F30. Patch 1 fixes
F3A, patch 2 fixes F30. The one-line fix in each sizes the key map to the
full device count; the mapping loop is unchanged (it still populates only
the first min(count, 6) entries, the rest stay KEY_RESERVED and are
skipped on report), and keycodemax now matches the allocation, closing
the interrupt and both ioctl paths.

Reproduced with KASAN on a faithful in-kernel model of each handler
(kmalloc-16 bucket, 12-byte request, reported count = 127):

  # without the patch -- attention read path
  BUG: KASAN: slab-out-of-bounds in rmi_f3a_attention
  Read of size 2 ... 0 bytes to the right of allocated 12-byte region
    ... cache kmalloc-16

  # without the patch -- EVIOCSKEYCODE write path
  BUG: KASAN: slab-out-of-bounds ...
  Write of size 2 ... 0 bytes to the right of allocated 12-byte region

  # with the patch (key map sized to the full count): clean
  # benign device (reported count <= 6): clean

The full read and write splats and a 32/64-bit ASan model of the same
geometry are available on request.

Bryam Vargas (2):
  Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count
  Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count

 drivers/input/rmi4/rmi_f30.c | 2 +-
 drivers/input/rmi4/rmi_f3a.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
---
Bryam Vargas (2):
      Input: synaptics-rmi4 - bound the F3A keymap to the GPIO count
      Input: synaptics-rmi4 - bound the F30 keymap to the GPIO/LED count

 drivers/input/rmi4/rmi_f30.c | 2 +-
 drivers/input/rmi4/rmi_f3a.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260614-b4-disp-818d6bda-8df90972ace6

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


