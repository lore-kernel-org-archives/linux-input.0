Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8A29B78D;
	Sun,  1 Mar 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328671; cv=none; b=D/w1OWe/5hyNT+eqj/lR/wb6TpZXjGA5RxY1/4VGgJbvSPGTk0DcKyJEaKjcEJ2aAqRZH01Oa4FmAKd5iPjSvewzfyxiCGTXSwIyADtoPWlJQn7izvfzewgrwibITMisJTHAMFgJA7VUh6kfHdQY7Dou3IJ86x2lv3yIZZU1voM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328671; c=relaxed/simple;
	bh=oyt4n26oLdEd9gsPiANr1kTo8HLspctmf7dvQAvRCTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaR8Q5ml/dy8NnCmGeyIzK0wDcSdFih4Jmfn8kpaDoSTRHXgnzAKgOz6PGuVv64BQ/LCviMy6tHZl7dqIlCxbMQcmwYnJWX78f82mp1UFIpfjW6BeB2oirodvqaqePzuiux2Eh4nFMljy1TrJWm0fxNmr3lr8s1eb6fbX7PGmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5UHaJuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5UHaJuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EADC19421;
	Sun,  1 Mar 2026 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328670;
	bh=oyt4n26oLdEd9gsPiANr1kTo8HLspctmf7dvQAvRCTE=;
	h=From:To:Cc:Subject:Date:From;
	b=k5UHaJuWFJXSymbpIn5aCGjqV8SuQn+MB/8HiUo76sUMnWFYK4Rf0hFWq3u+DSbmc
	 mzhANhNp6pZxjEr879Or0udIaVM2RbPwJVxGRcMdJM/hIq5oqVMgEgoYxwHPYZQ/PD
	 2wTLzzH4OksDYJ1ZjlD/BB6Et+dLfSW2KAP3kLT0rgS8tigdlxECO+4hgxy4w/ttnG
	 w3SfVS0slcj+EluIU/LT5TJzljPb/rx6vsXSC6yNOhS+7eQK3RONaWAYQN6iLkwZSE
	 T0fNZ+FHACYG6Y3SfIAJTMmELVXRk9yDPpL6lW5l954O82lXMKQY/oxjDgQ50W4KY9
	 thdPQI+Mr4mhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gnoack@google.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: prodikeys: Check presence of pm->input_ep82" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:31:08 -0500
Message-ID: <20260301013109.1689544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cee8337e1bad168136aecfe6416ecd7d3aa7529a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Date: Fri, 9 Jan 2026 11:58:08 +0100
Subject: [PATCH] HID: prodikeys: Check presence of pm->input_ep82
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, pm->input_ep82 stays
NULL, which leads to a crash later.

This does not happen with the real device, but can be provoked by imposing as
one.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 74bddb2c3e82e..6e413df38358a 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -378,6 +378,10 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm, u8 *data)
 	bit_mask = (bit_mask << 8) | data[2];
 	bit_mask = (bit_mask << 8) | data[3];
 
+	/* robustness in case input_mapping hook does not get called */
+	if (!pm->input_ep82)
+		return 0;
+
 	/* break keys */
 	for (bit_index = 0; bit_index < 24; bit_index++) {
 		if (!((0x01 << bit_index) & bit_mask)) {
-- 
2.51.0




