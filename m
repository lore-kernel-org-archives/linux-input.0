Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148F2D7DEE;
	Mon, 16 Mar 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672358; cv=none; b=ATDpKb5oVaxFAq6Ro9JzHkZMDefod4l6fpooUjhoU1Niq31DhcYb3eCZXz9Y0ko8IfKnizk7xgZdqDGZUsc6mu+sbh4jjLkEFQeaIkUfWBF1vPa+Qih1w4Zvakc+Y4YIu2oFWz3qgDnx4apAt1JuP93cZgU5kGvNupn5Dgekj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672358; c=relaxed/simple;
	bh=XjmyN7Fz+nD0Y1tiQLQtLVt0z4sGKxR1wG/uHCd00rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mxf0rWd+7yi7KKAgEj7XFF2b66baKctX4aPtdtWy4PR62o5jTQCn5UECCMWAJ7er2LAd5ksq+LNnogAwmoVF/bPq06MdRbFQd9wIOg/DEiYHV75T/zyOBOafQgDI+yLf9iXBVd30SSUYyv5E041wyRt0IOb7rjpHFgxPfW9DxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aez7njnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aez7njnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DF38C19425;
	Mon, 16 Mar 2026 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773672358;
	bh=XjmyN7Fz+nD0Y1tiQLQtLVt0z4sGKxR1wG/uHCd00rI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Aez7njnJnONm6a5j4xX7Tc4dlhsw44MuCtDiM36QY/OpcPckk/r3wwlbX3gjDAWZ6
	 sna3+/krZYaov07sJMLVw/rmwhU4dEod8aRf1DLwh6z5Zt/ninkkQ+Y5vzOyTAaUF1
	 i23gx8vwHQlL8kz2ErYX3bvOZhvBT6Xa3KRVahX/Cop0KgYmkfTUakO3waCy/7z35L
	 t52+DIwPXZS+LCoeCLKdNM22FgXtMhhpRvpEe6FqrOacPEP7np6Ox4CdyRT0qU8H3T
	 TGLes1Blhj2BV2rk/gxcWtIdzlzQjbaNUlWo4GXd4H5pcqWRweLEiWv4T780SJtkW7
	 W4j0YCzuMuvdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29640F506E1;
	Mon, 16 Mar 2026 14:45:58 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Mon, 16 Mar 2026 15:45:53 +0100
Subject: [PATCH] HID: wiimote: Fix table layout in comment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260316-wiimod-table-v1-1-c1f91be05137@posteo.net>
X-B4-Tracking: v=1; b=H4sIAKAXuGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mz3fLMzNz8FN2SxKScVN3kFMvEpGSDRKNESwsloJaCotS0zAqwcdG
 xtbUASkamMV4AAAA=
X-Change-ID: 20260316-wiimod-table-cd9abc0a2a98
To: David Rheinsberg <david@readahead.eu>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773672357; l=2872;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=DEDA+lED2vdDSlKY8TBL6dFV7luPreEtxbUEEFq+ZVg=;
 b=2WZbUhgFfRufnmPK7P+mhItvlc144t0bDO+De5Cfb0VUzeUqDaL/CDDUcnbXsGJPZWtxaeXPd
 prgfCVUqQilDii/VLHEPH9C1mADJe/o3xqZRWz2QmWHm3+DWkxcBYAz
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Some tab characters snuck into the data layout table for turntable
extensions, which resulted in the table only looking right at a tabstop
of 4, which is uncommon in the kernel. Change them to the equivalent
amount of spaces, which should look correct in any editor.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 drivers/hid/hid-wiimote-modules.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index dbccdfa6391672..d9e1b4313d6465 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -2442,12 +2442,12 @@ static void wiimod_turntable_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	/* 
 	 * Byte |  7   |  6  |  5  |  4  |  3  |  2   |  1   |  0     |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
-	 *   0  | RTT<4:3>   | 		      	  SX <5:0> 			      |
-	 *   1  | RTT<2:1>   |				  SY <5:0>			      |
+	 *   0  | RTT<4:3>   |                SX <5:0>                |
+	 *   1  | RTT<2:1>   |                SY <5:0>                |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
 	 *   2  |RTT<0>|  ED<4:3>  |          CS<3:0>        | RTT<5> |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
-	 *   3  |     ED<2:0> 	   | 			 LTT<4:0>			  |
+	 *   3  |     ED<2:0>      |             LTT<4:0>             |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
 	 *   4  |  0   |  0  | LBR |  B- |  0  |  B+  |  RBR | LTT<5> |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
@@ -2458,12 +2458,12 @@ static void wiimod_turntable_in_ext(struct wiimote_data *wdata, const __u8 *ext)
 	 * With Motion+ enabled, it will look like this:
 	 * Byte |  8   |  7  |  6  |  5  |  4  |  3   |  2   |  1     |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
-	 *   1  | RTT<4:3>   | 		      	  SX <5:1> 		 |	  0   |
-	 *   2  | RTT<2:1>   |				  SY <5:1>		 |	  0   |
+	 *   1  | RTT<4:3>   |                SX <5:1>       |    0   |
+	 *   2  | RTT<2:1>   |                SY <5:1>       |    0   |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
 	 *   3  |RTT<0>|  ED<4:3>  |          CS<3:0>        | RTT<5> |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
-	 *   4  |     ED<2:0> 	   | 			 LTT<4:0>			  |
+	 *   4  |     ED<2:0>      |             LTT<4:0>             |
 	 *------+------+-----+-----+-----+-----+------+------+--------+
 	 *   5  |  0   |  0  | LBR |  B- |  0  |  B+  | RBR  |  XXXX  |
 	 *------+------+-----+-----+-----+-----+------+------+--------+

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260316-wiimod-table-cd9abc0a2a98

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


