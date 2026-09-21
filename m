Received: from e3i491.smtp2go.com (e3i491.smtp2go.com [158.120.85.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4E4A0142
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013171; cv=none; b=trfY8Rb5Gm9aC3bkG0KhKXHgg2ICOnvTAWXiTzQ+8Zvv1QGBu6oQdk0/fvEnUmiuGrxemwcwKEjS/Xq+Y/Q4N3I0QiyJytdJjNfPhGVZUROZ5C2ULxkL8B+kHx+3jdDoiZTdCkpZks2+QwWfXp6kx2qBEmfXI/G9xsa9UVi0RE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013171; c=relaxed/simple;
	bh=tCJWX0WracxP8pjI4qmQXvWmBQDBN66OmCnP+zwr9Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU7/ik0GX6WnaOEa8O3KQzQDlnUajKqqKz7GlGnm7ivfXGZ/DmP1vU4Au96HH86SKG9iBqcqSYv6ZWwIv22zxAZwUS7Ek8dDBdvnuMXyjYXaNzt/RSNJHXLDWVAyzbS9wLQw+V0dzHTfXbJ0wfj3/Ow4nnyJwf6jtFKlx5NTYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev; spf=pass smtp.mailfrom=em1020969.fkr.dev; arc=none smtp.client-ip=158.120.85.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fkr.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1020969.fkr.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fkr.dev;
 i=@fkr.dev; q=dns/txt; s=s1020969; t=1790013166; h=from : subject : to
 : message-id : date : list-unsubscribe : list-unsubscribe-post;
 bh=TZwFOmmSArQRPmf1NzL9L+rXlgVE8BdwjiePmWC50vc=;
 b=fOUXqnQpAa6WlFIBWtR/qy+jnCHsPUqy/AMVIorzmSIwiwDCi44ubLWfoi5+i7HvBVKrW
 WeOcaQ4seB+rMXSg9Qm4D/4U4tXwj/4cFvta78QYQ7x24DgSKLHJpkumXo0dFew1p7YUoey
 hs0DGngWu1nLL32igIipbx4RQEx8QWsq5kWRcjeueAYoI5rfwQ1x05KW60Sksm2dejnuAoT
 fickss0K7EWWcebqsDP1a2lh/dtIBTSu1AJveoRpR7d2URsJtxd/9HLRg2zzvjKXpnUKoIm
 gZJh95HjvhuQbtsdmwqxFRo6nT07OGgLGXnDfrSUJXOEsfsxoy84asC4LwBg==
Received: from [10.244.246.9] (helo=fkr.dev)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
	(Exim 4.100)
	(envelope-from <florian.krischer@fkr.dev>)
	id 1x8iC0-AIkwcC8xzRd-KFlS;
	Mon, 21 Sep 2026 17:52:40 +0000
DKIM-Signature: a=rsa-sha256; bh=TZwFOmmSArQRPmf1NzL9L+rXlgVE8BdwjiePmWC50vc=; c=relaxed/relaxed; d=fkr.dev; 
 =?utf-8?q?h=3DSubject=3ASubject=3ASender=3ATo=3ATo=3ACc=3ACc=3AFrom=3AFrom=3ADate=3ADate=3AMIME-Version=3AMIME-Versio?=
 =?utf-8?q?n=3AContent-Type=3AContent-Type=3AContent-Transfer-Encoding=3AContent-Transfer-Encoding=3AReply-To=3AIn-Rep?=
 =?utf-8?q?ly-To=3AIn-Reply-To=3AMessage-Id=3AMessage-Id=3AReferences=3AReferences=3AAutocrypt=3AOpenpgp=3B?=
 i=@fkr.dev; s=default; t=1790013160; v=1; x=1790445160;
 b=XuGCYailnBbZD/UGHg7YJlvMD/Kby+WybgBcT5klDwtFPGfSWGmBs8V25uZSc14vOW9xn0jW
 aTJAsryXpWIiShjsxUGfhlsoFD4Eeh+kzh4ifY8oYckKi0Eb5kFsiP+atMLRrYfMZFfWic2lSbN
 p5gcNMAYKV4LpQkSqmeFyYZMb4qkb4FcvcnjoIrWQ5JHd2/tETZVATvuL6N5Or9jM1n1XUOheAV
 I/z/+Ajrtl+O7KjCfyMX51WP9xR60j1IjCVlgu/RhxaqL0cDGwSzNeGBY9y7GDWCeGA70MHUrvS
 FZU6rKnrMdW11mO5yLyuxS97G8/QlXe5dkbhGd018DMaA==
Received: by fkr.dev (envelope-sender <florian.krischer@fkr.dev>) with
 ESMTPS id dfda7693; Mon, 21 Sep 2026 17:52:40 +0000
From: Florian Krischer <florian.krischer@fkr.dev>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Krischer <florian.krischer@fkr.dev>
Subject: [PATCH v10 fixup 2/2] input: serio: asus-transformer-ec: fix keyboard
 response framing
Date: Mon, 21 Sep 2026 19:52:38 +0200
Message-ID: <20260921175234.3137985-3-florian.krischer@fkr.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1020969m:1020969amTSgpp:1020969shEazlBhSv
X-smtpcorp-track: VZW9wmGjX92k.2S_B0ft5poKe.o7M76gFdIAV

Real SL101 hardware exposes two issues in the v10 keyboard response
handling.

First, keyboard command responses may carry OBF without KEY or KBC.
The downstream ASUS driver treats valid non-AUX OBF responses as
keyboard data. Dropping these packets prevents PS/2 ACK responses from
reaching atkbd.

Second, the EC count byte is the number of bytes following the count
byte, not the total packet size. For example, the SL101 returns the
keyboard reset response:

  03 09 fa aa

where 03 counts status 09, ACK fa and BAT-success aa.

v9 used data[0] - 1 after skipping the count and status bytes. v10
changed this to data[0] - 2 while tightening the packet bound, which
drops the final payload byte. Keep the v10 bound but restore the
correct payload count.

Tested on an ASUS Eee Pad Slider SL101 with EC firmware SL101-0202.
Together with the SL101 8-byte event-read fixup, the physical sliding
keyboard completes atkbd initialization and works.

Signed-off-by: Florian Krischer <florian.krischer@fkr.dev>
---
 drivers/input/serio/asus-transformer-ec-kbc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/input/serio/asus-transformer-ec-kbc.c
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -26,20 +26,26 @@
 		return NOTIFY_DONE;
 	else if (action & ASUSEC_AUX_MASK)
 		port_idx = 1;
-	else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
+	else if (action & ASUSEC_OBF_MASK)
+		/*
+		 * Keyboard command responses can carry only OBF, without KEY or
+		 * KBC set. The original SL101 driver treated every valid non-AUX,
+		 * non-SMI/SCI OBF packet as keyboard data, including PS/2 ACKs.
+		 */
 		port_idx = 0;
 	else
 		return NOTIFY_DONE;

 	/*
-	 * The data[0] is the length of the packet including itself. The data[]
-	 * buffer has to be at least 3 bytes (length + ctrl + 1 data byte) and
-	 * must not exceed the EC entry size.
+	 * data[0] is the number of bytes following the count byte: one status
+	 * byte plus the payload. The SL101 EC, for example, reports keyboard
+	 * reset as 03 09 fa aa (status 09, ACK fa, BAT aa). Skip the count and
+	 * status bytes and forward every payload byte to serio.
 	 */
 	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_SIZE)
 		return NOTIFY_BAD;

-	n = data[0] - 2;
+	n = data[0] - 1;
 	data += 2;

 	if (port_idx == 0) {
--
