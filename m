Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4619D3093DF
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467236; cv=none; b=NM9eCqhcwxJksAySH3Upe+nHtnLAkfMMo368ypaD73enrNJ/4jBsOFN6Tc/Tk24pHH8T0BmhXt79HIel/qMEc7T2KvaMHco0zMOqSRYcokkTVrjLLriNwOeH+8Wcq55DP0fThZFVIWSp/lPNZnElJazbFj3bX5DTkkqU0RKhcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467236; c=relaxed/simple;
	bh=MvGx/AiHfsLFWHsaBqSCWu4yn1VWSlxCKsbdlu+7Tow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6zEWzSgHL0JM52/Gt9OMNK2PvFGQ7jOKlHQhK4Bo2Np3vO3O8tRSsy0Dy1LRlyZUl6k3m2dxokSatUCwARK7ddG8HzdjXxqBDxKCwohQEA7jnqmsEFyVJgbqOfMerAzIxd4V0vBZWVQOciA6sIELyIh6igAtbdTy4Nvs4OtFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=kfUmBS8r; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="kfUmBS8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783467234; bh=MvGx/AiHfsLFWHsaBqSCWu4yn1VWSlxCKsbdlu+7Tow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfUmBS8rTiiNcIeFYpq1nHDGafcgieUU33cAoDW1sZziAX1mJdpE+SZHTiftR/oga
	 CuOOn9P8F3YY5RNcR3hG2if3dZ/NffI7rgXb6YzVDP6KKMlo8678JSs+2E11VwYcM5
	 JB0Lpifmaf2AQ7PgiihqVSyJOXMF9VYs2L2ZOJtsJnOjh7Shg24SbLrDaOEdMFWe5m
	 UM0LH9rMNf7VyIT04TBhbpwEs2FLs/d9gA+/ZeRHyuTXNT+Lz71Mh9EFhtPS416wPj
	 bY4Ad/lXPVbz5QU71QpGrAk+DTT1X1COBps15Kd0cScKl5kHX5IIiMkomvvl0Vj4vd
	 yw+ZNA7cYOi7w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 7603CA148;
	Tue, 07 Jul 2026 16:33:54 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2 10/10] HID: steam: Retry send/recv reports if stale
Date: Tue,  7 Jul 2026 16:32:30 -0700
Message-ID: <20260707233241.2644971-11-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707233241.2644971-1-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
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
index 49f6733d8935..ba2dd40a7976 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -497,6 +497,43 @@ static int steam_write_settings(struct steam_device *steam,
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
@@ -507,15 +544,10 @@ static int steam_get_serial(struct steam_device *steam)
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
 	u8 reply[3 + STEAM_SERIAL_LEN + 1];
 
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
@@ -534,14 +566,10 @@ static int steam_get_attributes(struct steam_device *steam)
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

