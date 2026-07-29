Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8131E826
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290053; cv=none; b=lgqiXv+NJIeAWEgTxua1hjtCABmcu/OVnbrBs9DOSGMPUqFHwDMpEsNENoOP/dbxFBxDgMUzDjVcN5kgXjjHbJ9jkVgSeNF/Qms4nkPsGfXShYnPvbgnx0xOWA1eQowVhGZb5Qtalo+nlpwo/H4NwcIHRZBNnjgbH1qTuB6mlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290053; c=relaxed/simple;
	bh=6G2Hsf/SSHwE0bV8ZBA8J6y796YEAE8fOZC1tgZNDLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxteXcYpt+sYXGdCsax5LYubBF//DVlyYcPbLYXp/xJRZKXGm05zDaHccotTJFp2URi1vn4JbiQKUQQrKHao7LY0bS/XLLU6f1ThcK16Z0XvsPY8CwAHOiFFPnyJuLgLhNN0iGElPqzRHZH76h6OKbH5XKPHIJyD3az7PTsUIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=GEMCuGLL; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="GEMCuGLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290048; bh=6G2Hsf/SSHwE0bV8ZBA8J6y796YEAE8fOZC1tgZNDLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEMCuGLLDShK8UqFaxzPKWIhPl01jt8XqP1Haf69giXiukWI/NhBgHNrreUiodgHs
	 3HT1U/vu6Vtpew1rvqP3n8yRsCOSpp5J5r83UJDDgBbzccpmZqhAVZZOOV7bsEDEDn
	 poSgOiKsSLGNyIrXnAbI/nL0R5BXNXWWtfZ1z20aiKzuczd4njjaOr6JUrxraYBaYz
	 UVa9tu41Wdpdbf+F14mLnciY8hnXpbPEj0JM7gebNb57/jH0UJdA/PqEB5/dgCrAjm
	 g6pdRXczS8QtmG/vBUB0NjfV0kmutwPUfnlX7D0oiZ0uOtTUgnlT68Wv/VXmf1ivaG
	 BkHK0Ypq1FqNQ==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 170BBA2A4;
	Tue, 28 Jul 2026 18:54:08 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 11/11] HID: steam: Retry send/recv reports if stale
Date: Tue, 28 Jul 2026 18:52:33 -0700
Message-ID: <20260729015243.1170573-12-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes recv report will reply with a stale result from a previous send
report. Instead of failing out, we should retry them, as they generally
reply correctly after three tries, give or take.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 54 +++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 7c100d61495a..3c7776aae6bf 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -501,6 +501,43 @@ static int steam_write_settings(struct steam_device *steam,
 	return steam_recv_report(steam, cmd, 2 + cmd[1]);
 }
 
+static int steam_exchange_report(struct steam_device *steam, u8 *cmd, int csize,
+		u8 *reply, int rsize)
+{
+	unsigned int retries = 5;
+	int ret;
+
+	guard(mutex)(&steam->report_mutex);
+	do {
+		ret = steam_send_report(steam, cmd, csize);
+		if (ret < 0)
+			return ret;
+		ret = steam_recv_report(steam, reply, rsize);
+		/*
+		 * Sometimes this can fail on the first few tries on the Steam
+		 * Controller (2015). It appears to be a firmware bug, and Steam
+		 * itself just retries, so we should also retry a few times to
+		 * see if we get it.
+		 */
+		if (ret == -EPROTO)
+			continue;
+		if (ret < 0) {
+			hid_err(steam->hdev, "%s: error reading reply (%*ph)\n",
+					__func__, csize, cmd);
+			return ret;
+		}
+		if (reply[0] == cmd[0] && reply[1] >= 1)
+			break;
+		if (retries > 0)
+			continue;
+		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
+				rsize, reply);
+		return -EPROTO;
+	} while (retries--);
+
+	return ret;
+}
+
 static int steam_get_serial(struct steam_device *steam)
 {
 	/*
@@ -511,15 +548,10 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1] = {0};
 
-	guard(mutex)(&steam->report_mutex);
-	ret = steam_send_report(steam, cmd, sizeof(cmd));
+	ret = steam_exchange_report(steam, cmd, sizeof(cmd), reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
-	ret = steam_recv_report(steam, reply, sizeof(reply));
-	if (ret < 0)
-		return ret;
-	if (reply[0] != ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
-	    reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
+	if (reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
 		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
 				(int)sizeof(reply), reply);
 		return -EIO;
@@ -537,14 +569,10 @@ static int steam_get_attributes(struct steam_device *steam)
 	int i;
 	struct steam_controller_attribute *attr;
 
-	guard(mutex)(&steam->report_mutex);
-	ret = steam_send_report(steam, cmd, sizeof(cmd));
-	if (ret < 0)
-		return ret;
-	ret = steam_recv_report(steam, reply, sizeof(reply));
+	ret = steam_exchange_report(steam, cmd, sizeof(cmd), reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
-	if (reply[0] != ID_GET_ATTRIBUTES_VALUES || reply[1] < 2) {
+	if (reply[1] < 2) {
 		hid_err(steam->hdev, "%s: invalid reply (%*ph)\n", __func__,
 				(int)sizeof(reply), reply);
 		return -EIO;
-- 
2.54.0

