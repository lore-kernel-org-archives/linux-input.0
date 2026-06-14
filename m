Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68D70809;
	Sun, 14 Jun 2026 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781405936; cv=none; b=VwwkL4qArhyEc4G1bQbkPOw2ZG/yYqZ4cK2HkdKPHFFrpmMwxQKjq4JB4RGq6LLKOcMCtvZ72fxS1gNtPIYz+avVaKVhe+38eLRqzdO3ysPZnQ54ClvmwNADpxNOha/emKsBNn55csPqttp5Fszp+Vn63uZ3E4RSqTo8yhByH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781405936; c=relaxed/simple;
	bh=VfB/QgC+O+HYthaGAhj1UHdmvcGokeNfmN9MXsRHHpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Erd2DsSBEMTKbmSV1QmlCnnK90aVmhBToE1HZpYN4Xr9FKOokQEt6WL2gBUeEkR+/VWX4Xa/E4mwnbCPcluB9F3sBK7PWsEKx65P9tSzbqnxZHj12qRjMgo4Z12sqDTHExiVkyxuzViGtF11zX+xtrJ7B/z++8fdfYqovosuT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSeAmnTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSeAmnTT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06CEBC19425;
	Sun, 14 Jun 2026 02:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781405936;
	bh=VfB/QgC+O+HYthaGAhj1UHdmvcGokeNfmN9MXsRHHpg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pSeAmnTTVtDr2WThYdqQtLs4ER5h6O0D2Wc/XxWcXKuXZkYClBtqX1cNL220jicQG
	 Ac92lTlZBAgteoS+GLSU0ZEGG3iEbCNFo4YrfDGEr6WFvbl1GPCpTnBPCy48JcFIDl
	 +8gPAoXJ4hXwG5jBmVJK6t/nkPB3jP++pD8muoSqPTb3bUpNl/B2NIT+OxmnV+DIME
	 8uN17OlMDcFEX96jiT3Z97NvAfEb49T3qz0PoFHAQn/N9ZqB6GCQ8nfO5tyrvQITQC
	 TkQasKWbOs2+QQGeGCY1TmxLX+jqxF9pVrwsiPEB1kssjBl4a61l1fZNTvhw1vugs2
	 ZqZpxx9bwdPMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD2FCD98CF;
	Sun, 14 Jun 2026 02:58:55 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Sat, 13 Jun 2026 21:58:55 -0500
Subject: [PATCH] Input: iforce - bound the device-reported force-feedback
 effect index
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-b4-disp-4828d263-v1-1-02320e1a89dd@proton.me>
X-B4-Tracking: v=1; b=H4sIAO4YLmoC/x3MQQqAIBBA0avErBvI0Uy6SrQoHWs2FQoRSHdPW
 r7F/wUyJ+EMY1Mg8S1ZzqNCtQ34fTk2RgnVQB3ZziqNq8Eg+ULjyAWyGvvoVrUMnrSxULMrcZT
 nX07z+34R3CGWYgAAAA==
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781405934; l=5020;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=XxpIXCh7ffZCmu2CG+KPf3GOhwCkdR6xHHjQDVV3JFg=;
 b=oJrxY931L5MvoILgDK06XxvKv8KFwMA0IjyZM+N1uCuzhn3i54GLfqPIpZIpfi17F7buM8BBv
 4/4ldZM6M6oCZBF2wmASg3zEV4+6OekNaWnHT12qJm0yjyH4nDg1kZH
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

iforce_process_packet() handles a status report (packet id 0x02) by
taking a force-feedback effect index straight from the device wire and
using it to address the per-effect state array:

	i = data[1] & 0x7f;
	if (data[1] & 0x80) {
		if (!test_and_set_bit(FF_CORE_IS_PLAYED,
				      iforce->core_effects[i].flags))
			...
	} else if (test_and_clear_bit(FF_CORE_IS_PLAYED,
				      iforce->core_effects[i].flags)) {
		...
	}

The index is masked only with 0x7f, so it ranges 0..127, but
core_effects[] holds only IFORCE_EFFECTS_MAX (32) entries.  For an index
of 32..127 the test_and_set_bit()/test_and_clear_bit() is an
out-of-bounds single-bit read-modify-write past the array.  core_effects[]
is the second-to-last member of struct iforce, so the write lands in the
trailing members and beyond the embedding kzalloc()'d iforce_serio /
iforce_usb object.

data[1] is unvalidated device payload on both transports (the USB
interrupt endpoint and serio), and the status path is not gated on force
feedback being present, so a malicious or counterfeit device can set or
clear a bit at an attacker-chosen offset past the object.

Reject an out-of-range index instead of indexing with it.  Bound against
the array dimension IFORCE_EFFECTS_MAX rather than dev->ff->max_effects so
the check guarantees memory safety regardless of how many effects the
device registered.  A legitimate "effect started/stopped" status always
carries an index below IFORCE_EFFECTS_MAX, so well-formed devices are
unaffected; the neighbouring mark_core_as_ready() loop is already bounded
and is left untouched.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reachable from a malicious, malfunctioning or counterfeit iforce
force-feedback device on either transport: a USB device matching the
iforce id table (iforce-usb.c forwards the interrupt-IN buffer as
iforce_process_packet(.., data_in[0], data_in + 1, ..)) or an RS232
iforce peripheral bound via inputattach (iforce-serio.c forwards data_in).
data[1] is never validated on the path, and the 0x02 status block runs
regardless of packet length or whether force feedback was created.

struct iforce embeds core_effects[32] as its second-to-last member and is
itself the first member of the kzalloc()'d iforce_serio / iforce_usb
object (~4.8 KB, kmalloc-8k).  A status report with data[1] = 0x80 | idx
sets bit FF_CORE_IS_PLAYED in core_effects[idx].flags; for idx up to 127
that is about 13 KB past the end of the array.

Verified with a faithful in-kernel KASAN litmus (the verbatim struct
iforce / iforce_serio layout and the case-0x02 effect-index block),
Linux 7.1.0-rc5, CONFIG_KASAN=y, kasan.fault=panic, x86_64:

  Arm A, status report effect index 57 (chosen to clear the kmalloc-8k
  bucket; KASAN's kmalloc redzone already trips from index 32):
    BUG: KASAN: slab-out-of-bounds in ... Write of size 8
    located 3440 bytes to the right of the allocated 4840-byte region
    ... cache kmalloc-8k of size 8192
    Kernel panic - not syncing: kasan.fault=panic set
  Arm B, with this patch (index bounded): clean
  Arm C, benign in-range index: clean

  AddressSanitizer (x86_64 and i386): heap-buffer-overflow WRITE, both ABIs.

The "Write of size 8" is the test_and_set_bit() read-modify-write on the
flags long.  Reproducer and full logs available on request.
---
 drivers/input/joystick/iforce/iforce-packets.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index fd1cd731d781..ff266568d586 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -186,14 +186,18 @@ void iforce_process_packet(struct iforce *iforce,
 
 		/* Check if an effect was just started or stopped */
 		i = data[1] & 0x7f;
-		if (data[1] & 0x80) {
-			if (!test_and_set_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-				/* Report play event */
-				input_report_ff_status(dev, i, FF_STATUS_PLAYING);
+		if (i < IFORCE_EFFECTS_MAX) {
+			unsigned long *flags = iforce->core_effects[i].flags;
+
+			if (data[1] & 0x80) {
+				if (!test_and_set_bit(FF_CORE_IS_PLAYED, flags)) {
+					/* Report play event */
+					input_report_ff_status(dev, i, FF_STATUS_PLAYING);
+				}
+			} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, flags)) {
+				/* Report stop event */
+				input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 			}
-		} else if (test_and_clear_bit(FF_CORE_IS_PLAYED, iforce->core_effects[i].flags)) {
-			/* Report stop event */
-			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
 
 		for (j = 3; j < len; j += 2)

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260613-b4-disp-4828d263-5f8b1a7c2346

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


