Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655183822A3
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201210; cv=none; b=kNe1VIbChDeLgo5ToCzPtoawVYHPYQSNT7BqZg/WsWM/kkr7DFSF74BslCWGTROLInIDLUpT4yGKbxmJp3id08r6NwjoWkDk9CTEo1T9Vkn32h3Ke9/lTlDqRjCg336xhtRKrEVEwRhQSQVx0c22DbVVLIOwwJjotZ02gOULU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201210; c=relaxed/simple;
	bh=B5NcsJqiM6ca6zoKCCSiRnmiGiK51EUO/f+42QeBqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5CMk0aMz3+nyfeZJt1qTG2cJ35SuP3yBF7LUCS7QDfccQ7cPPkdS0VPZ2rEU8aLzODYqHUTznrx4t0TOIh+RuaLhLVqPu18OcznZx5swgLVxdmrB0ZDKERQik+BaHKfw8bPGbi8OSMHrwemRuAvHrMwzQqrXKO4ZEzPCO8BfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBqIxRNB; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBqIxRNB"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30b6dad2382so1345889eec.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201208; x=1792806008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=WBqIxRNBUqBRRhN6b7EfvbJPWt6hwGRIlRYS9Qf57HMtBDdB7YOqqF7LSkXOZ272cb
         Y4Ur9MaxHuCDIjGl95MejJfqlwhOH6DNbNrSiFW/lUQsqW3kQHjIc4AsYUvIAEdR1Kv6
         qs5o7XJqW2gv1rCEhbo60Nu0/+UPO97Qf3FRErUP3VUBx5Xekknkn7tBOhOhlWCF+fj1
         pED7QO7Udl2PBu3HbMtqK7r9IP8ltoc3bnQurCc6LAWdJQYHS/MGaj//5XJVX4umkEcc
         /8iV9933xXySzoTwS9m56dFDaLVXiuGVPillMcKWuJ2FhdQxSahzVd0ixF9YHMyQ+ok7
         csOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201208; x=1792806008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=BKivGTLkmOtxk/NOahkvIpAfLmyFP6I8lyxUs6n+FupbibjEo9TK0cqM5VU3eoBuDe
         cSHAIES7Bh5iLVzj5IY8H+oElfr+kmu5/dlt4KVtn4F9NaVbtbJMEa1FViu/yYTPAnu8
         BYVSPmBOSwNxARA/2HX06QNTDr6IYnSIUTI4CbH0+S9fG7IPE9MzVJHQvsX43ynYXCZR
         ujmvn3R0QQ90FdKDAUvm/N2as0MkQKk20ECiIXQGJvETOe+OVNHsr7IEgWc/dE+WEy1z
         FeqgfJfwS1pDXpJ28Wvve+bTHgAfh5PLCAtB2tvVnGoogJWqQz6DwlAcGZXbGB38pfCk
         hjGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuCc3ZsMgwrYJihIVsn1GpxeM1xYJNDB6VDlb0pIaOf/gEvcddzQlKTzIJYtII+nv+FhxjmuEA5xfmyA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLK1DizGUMr6/coRVpYBVmOdhsGSzMpY5C30xGQDzKubMDOkyGW
	0HyuNUO7Dn5xHHyNKkfHXzCDJJC5HDsV8D3bPlXIScIbFfFrW2s82GCZ
X-Gm-Gg: AYBFou1E2OHsFlcfh5aI2VDly9ilCaqt/06hEe/P2yvYdxwXs6P8x3NGv8s1NFS0ZFT
	KG6N4TpvIqc9uZkJ8i//QRbpVHw/xfPBV75cWzmzClpWjdGY//akx/eJUFoezr7Ut97qvAdcuMv
	XdGo73DKsF0ZaKeciHRJNKsPqbLQde4f1Oh8J1OJqGRdg3/+bAPOrW4QIiQqL+fNY373TTR55UW
	Da+XcBIsPnaGzo2b1QNWthpUodWljLQs73eDbJ7HGj0kR0nCBRvPhZ5bYcwh11V6l/AV3/sJVEg
	vjDDLWxtU8LsE5SXjmjOBOJ6SBqOk9SLcouoWxDyTHHaOC9RMzh7jqDHa5NtpQGc0bNnGnxUQhl
	WT7j50/KqP/EpaRCJOOWlx4FS1SeDFCAqihCqbJo70o/R51+J2O9sFMqeAFPWHoe40gFgFcxLcz
	WoSlwHKA/syrIl48mNr+dIVLHBo56gte0iATcaU6tbDQRt/uzSf8xB0gRQWE6Gbui0LkdrzVPi0
	5LLZQNDcosqq1+VAOY9c80CQUgnbBFurTZ99hRUP1g9aIYReo2LYo3Hr8I4Qv3iYeUJZflHxBE=
X-Received: by 2002:a05:701a:c951:b0:156:3684:96db with SMTP id a92af1059eb24-18515e402d1mr2235374c88.45.1792201208381;
        Fri, 16 Oct 2026 18:40:08 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:07 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 01/11] HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
Date: Fri, 16 Oct 2026 18:39:46 -0700
Message-ID: <20261017013956.2440130-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mcu_property_out() blanket returns 0, discarding the ret
value and any errors with it. Wait completion returns a positive value
when it is not timed out, which would error on all successes, so if it
is positive return the ret value from the raw event handler. Only if
it is 0 set it to -EBUSY, otherwise pass the actual error.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a72f7f748cb5..68301d4c762a 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -38,6 +38,7 @@ static struct hid_gos_cfg {
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -435,7 +436,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_S_PACKET_SIZE, data);
 
+	drvdata.cmd_status = ret;
 	complete(&drvdata.send_cmd_complete);
+
 	return ret;
 }
 
@@ -474,12 +477,10 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	timeout = (command == GET_PL_TEST) ? 200 : 5;
 	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
 							msecs_to_jiffies(timeout));
-
-	if (ret == 0) /* timeout occurred */
-		ret = -EBUSY;
+	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
 
 	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+	return ret;
 }
 
 static ssize_t gamepad_property_store(struct device *dev,
-- 
2.55.0

