Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7E37F01D
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271428; cv=none; b=OVgnxHYfgSNnJ/GC+pOh1HXfzMr2x75WBEWZDPHU90ii+qvDoJapgyFEscIgtE/CwECrTH2eBqf7TzOGRheprzuMdZuNNOy+hULN3ZeH8Byg52gUBTZ3UtBVuHjgJxteeVttNhEoJzrVSi9HjaA/D3hF6Y7gN05c3g8Nyou/Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271428; c=relaxed/simple;
	bh=xeduSlkh5F/g1QDxornBkeh3jnYm61LoxT+eaLcg9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuXaS2abjO3Dm36H/Ctd9NgWjS+PmokbDUYQhBnBfvdlJ+uQFeT5kVR9TBwENDKp1drWI3o3s5cOwCvcuubhhVqa5vQvKfg6CNhjj/OvdcB2jEPOIKZ6GtLT2EAuWdmpiRIXPDdWbq1cQnr1escuD+A1rkiyBazRpMiMRIHWJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQuF09hU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQuF09hU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381b831d535so1598654a91.0
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271426; x=1788876226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxoZFsWluIEGR9m2/BmFPDYm372qjUJBFtS59WloRzM=;
        b=QQuF09hUGxQniiltnGO3fq03rWIJ0Oi/MHiOLGRg4mG8N8bWgL4068qbjSonMzVhVi
         hIT13YKCrd5b8fNcXROz0IPR9/0AbLdT486aGX+1eks4jdVhIvsITQ449Z+LWoV0RbCE
         0lkUCkX9q4O9MFqXoUWav+ywlctabLHMDLdlalKH0a1m2/zzcolOswXwndhbewL75cTL
         8vvCfi+xaWSzeWlawyg9I9LlpsUpP4cB3Ocbfrn7EteI0w+ib+uQlokBSsy5Ihip7Hza
         XwavEV4YgW0KbnC51Wci742OiGzr2ymZvyj2GyyYwRPgDiYD0v1k94c9jVF9zqoUHJBx
         I2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271426; x=1788876226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxoZFsWluIEGR9m2/BmFPDYm372qjUJBFtS59WloRzM=;
        b=ZoHzbpuszt6iawYGHfxt2N493CccIZs36Vl9odwV5qMYVu7/1Xflkpe6UDOQPJXa28
         F/gS5Ke3C1u2x8R8PSqovvbHmRqlEoB4YOStiicAjVDzj3rOewrYaBmLTWCUCY4yHE1D
         ubxzzfkEPcvNOO9DGHMVaSdH/ddl+tCGiS/kGHQiaS9u07zBjiX1DkrE7Xg8XcrmjVu4
         JrD/INQdvrrn27kBjDIJrzrfV8m5FYnj8zl4blo2yJVJIrmo4RbXIXd5quKLoMivZX0F
         tJQbjmPlEl/RBUSMYvRS/zzwp/HaqFIgjjJBy+UuVF2KOcKzj13AwD8PBYb18q5NCbBG
         wHbg==
X-Gm-Message-State: AFuF++nlWQeQ4nxBfEQByA8n+UAfsJQX3ajLZ74JdusQO0OEb8KTuUgm
	Z1wwPp6h5Zuu5onpOJZ+lfq7/mj8hjpVrY4h3fHbObLordcsHhhF0EHvyfonUYACrJbJDU59O7k
	=
X-Gm-Gg: AYBFou1e7qkuLjwt5jMeSGr0yPXdVfvy/VTrwyt+bd8RtWyNQdw3atN3dO2Uqms2cao
	LHOvonlbrRGDo3CQBgA2rG+WSyiB+f8mGt+edKWbGWaCAhCDjBigeL46bi9bcTaCQ1hwWdDCrWy
	5J+2fSfdhZsqRz5KIG4GEje/xev7itgqa4/bdSIT1l3a1qDtBJBSYiNpSDpun/OPwtq7Hyun7f4
	QDtbrx++FAZhLC1FGnohjV2Ug8oHiP42ZDHveqTX7DCEvV4xuXkkS1hQiYc4mc/KLA3BO3jtFHq
	av8Bk5yPfSFC/vK9WcHha1gtHENo72zm2uSLgWpTSjuB7EFZ8CZJk//b/sJVbIUqjIX75maBFJA
	ZdJuVjDrQQERIvZCLtABv1hbWA0h2ORTFSJ+55H3zsE96bUE9GaOLvSxU5/Wy4r2EgZRZomheLx
	npAUKSQQ/Usk3BWmld1tXxSJwl6EXyBzICKFcTopWp
X-Received: by 2002:a17:90b:164b:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-396d1007e54mr50590119a91.15.1788271426092;
        Tue, 01 Sep 2026 07:03:46 -0700 (PDT)
Received: from ArchLinux ([185.244.208.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bcf8079sm6872467a91.1.2026.09.01.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:03:45 -0700 (PDT)
From: Tao juncheng <tjc1437@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao juncheng <tjc1437@gmail.com>,
	stable@kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for HONOR NWB-G's internal keyboard
Date: Tue,  1 Sep 2026 14:03:36 +0000
Message-ID: <20260901140336.10568-1-tjc1437@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
NWB-G, aka HONOR WIN Gaming H7's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR NWB-G/NWB-G-PCB, BIOS 1.10

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Cc: stable@kernel.org
Tested-by: Tao juncheng <tjc1437@gmail.com>
Signed-off-by: Tao juncheng <tjc1437@gmail.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c8ad55f26ea8..de8edab3cb0f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1923,6 +1923,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* HONOR WIN Gaming H7 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "NWB-G"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
-- 
2.47.0
