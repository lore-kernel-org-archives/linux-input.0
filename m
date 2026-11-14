Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636005;
	b=Vil6d9TXAqtXs4Fqy6OB3VM/3uLBOJZmBWGUszua59Ref9cSy7Ob31r96zvunBQ41mOy
	 JRlBPLdqCKTCExC73YBh7cn/1HJ607TzbMcA5dgbo/XHG8c1KRB1djd5Zx1bHWICbu+kA
	 6h46nurVPbVMst04T+alI9DWIYpC28SZ56OnHi9tljqUwCLMPR3NvdQjOEKazCDJPl3TS
	 7ET5irxcrQH/zR53U4/A5iJKdrdua92FbKpGdproDho5/8ZWHDG3QbwRrZdjhLAfuV5Me
	 ZWX0Yqf4xw2bBKw6tcSPsjmH1wRNM8GJ7KMPy259QCi/DpLh/ib7o2sL8qxQ/TZgncw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=6dI/LFf00D9l6Dp0VtU5TfEwn+pBwd3ZDZTRVLjXg5I=;
	b=KzVz/8uJ8eLl35VYJ2lDUmZMVJwMzntinufEkRtrqvn3RefJhVcXLN6RyLWEYKL4dEDT
	 6tjjY8PrY7BMWWuFvFN2Zty3AM3twDXXX5A7XCdfFUPM/zmsnok0SzK4DWIOHIMLH5EhB
	 5CUbt063WJKG5xcLtqn4/q8dIBVqk0JHI2vo2mjEESd+yYYkGrpoyp3sC5CvXR7WHCDfX
	 6A6EwRfSCbGwSM+9BvWg1hbmho5m+ayxpy/VR6xXQjWKh5GRmM95kqmcD6Kr4bxkawXXX
	 JiAH/WxHKOUdFsyTCFSSKZxN7VoFN471osF4zfnniwI1uipki6rl0LmTmUsUkWsDfsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMRQfv2B;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC4606A882
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DECC4606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sMRQfv2B
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so2189296c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636004; x=1795240804; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dI/LFf00D9l6Dp0VtU5TfEwn+pBwd3ZDZTRVLjXg5I=;
        b=sMRQfv2BlgTf8PuNd1+mWdpOAge3QsYlqCEvm1dP627o8z9yBr/frCHPVpf+kaxG5/
         WUbtsn5FG56n2IN98tJ8wUI3ZVmHzJLkjX1lUFUSflSdDWodrhzW/FpuTq71eLTSCRni
         b/4NYVlgrjSBX0zckAevN/mt4RqiBRaK0kAh/QrNm44xIpkKbKmVqBl6l2jhu3BTrTBe
         bdLcIP/jTFDS+F2Qy6E+uplGHN8Vq8DUzK2Iwro2/TAYc+RDgp3n9AdNImEMUhfRjlE5
         IJJnVKA5kSNjuxBKWNo2S25f5WY2mtL5nLalMhtCpGI3qJwPrKGlna7xVgmLMJlCnmY+
         qeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636004; x=1795240804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dI/LFf00D9l6Dp0VtU5TfEwn+pBwd3ZDZTRVLjXg5I=;
        b=RPQcq5HTajnPUw4tlm0mvhs1QAZxeNrupTZYwnKZ05AuUCDzeqYcKh2ambAQOOatmR
         fN8x2VdRINSJ1T9DyDa66oR9ZSRKVdWOlb8zHHOvqiYxGFbBdsNpz3oYuokbaswgoGPq
         RZxNxp2k8dl34NdGqU9wyHniDh0oby04hv87TjbhE6OPfuV/yuklkMvqtQREjtiiwEZQ
         +tJPyb2RgzDkHQnpe3u6yAuoCw8KOLakJwejZxFmhMHMAANMawM010EkAHBa5uu9iNkX
         m41I1Xy1IH8xVoNeop0ojirdo1am2rCqBSoLEyf1UgjcGJjwkDKFevCFruDP2Rm6Mid8
         Hj5Q==
X-Gm-Message-State: APuU4Z/gSZk9shgkSFanBWuyS50iKSst4VVFEG5MvtYiyRQo1m+iuwkK
	ckwpI4kWsMaHK8E5bnK5BlYXz5PRoPdq+nsr9H/Yi4VDzu3X9gRpA0bG
X-Gm-Gg: AYBFou31e+af2HrN9A3bBMgyxcrzfUwpkw5la1cALXShtFxfi5vWT0AjTPZEqSvJx5f
	xbU7q+H5F0JaIKG9UR8aoiQuDhb0iwYTRcVE2b5Xuu3EskiSM7gs/2mgLShVnWw3t3QdYobjbdy
	cSxNLKUfco48Ue7NynCa1CQ3u5EVfDvq4P86k9fY3QjMn+d3NW8Mc7QtqxWLZnlsnaSGpnYEg7e
	EJLTDsrPzjLvDI095JYqnrTuPxXAeBvzhLCNnrjfkjjZl2gfdzu2ay2y9DgIpB8ZANsuD+OX34K
	vZBYdzfFuAs+gVbzntVp+o12vPvyR884RQ7O8wNDQVRLoU/WukKAyvOzWCnUxXYyjpnKBdCZ1Fv
	/XJHBn8CKs751nvAbn+WYo2IvSlNR0E/G2OghTVKK3iRbqt00p/pIU0vIaHfNMgwJ0r6DZ7pVkb
	0f/IiXqyhM+4Wsxn+U0yqXc7p/yAlM/P38TwlRbD4bpV0QwQW7pXqubwMP7cAjq4Xg+cC684a+O
	ZGA7xqntENj6baRhbYFDNyRkDW+LJYEHmkbdmhmnAp7vtPAUubGACGhEDguBw1S6ieVX316C3re
	2EQQaLBPMUYH2/SWkr/P50anm2EtqMT5IgG4H3AuECLiMJT9n/OLup854qP1H4YBqZYjZKLXKBm
	JbBy43mFRSmGuJWZxTGpSsUtVukMNw1JMua60AA==
X-Received: by 2002:a05:701b:2810:b0:185:8c9f:de82 with SMTP id a92af1059eb24-1b503124f1amr3878829c88.33.1794636003896;
        Fri, 13 Nov 2026 22:00:03 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:52 -0800
Subject: [PATCH 02/12] HID: rmi: only strip trailing 0xff bytes from
 attention reports
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-hid-rmi-v1-2-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

rmi_check_sanity() strips trailing 0xff bytes from incoming HID reports
to work around bus corruption where attention reports are occasionally
filled with 0xff sentinel values. Running this filter on all raw
reports also truncates register read responses that legitimately end
with 0xff bytes, leaving stale data at the end of the read buffer.

Move the sanity check into rmi_input_event() so that only attention
reports are filtered.

Fixes: 5b65c2a02966 ("HID: rmi: check sanity of the incoming report")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index cacf81ed56a7..41676685ce28 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -343,6 +343,22 @@ static void rmi_reset_work(struct work_struct *work)
 	rmi_reset_attn_mode(hdata->hdev);
 }
 
+static int rmi_check_sanity(struct hid_device *hdev, u8 *data, int size)
+{
+	int valid_size = size;
+	/*
+	 * On the Dell XPS 13 9333, the bus sometimes get confused and fills
+	 * the report with a sentinel value "ff". Synaptics told us that such
+	 * behavior does not comes from the touchpad itself, so we filter out
+	 * such reports here.
+	 */
+
+	while (valid_size > 0 && data[valid_size - 1] == 0xff)
+		valid_size--;
+
+	return valid_size;
+}
+
 static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 {
 	struct rmi_data *hdata = hid_get_drvdata(hdev);
@@ -352,6 +368,10 @@ static int rmi_input_event(struct hid_device *hdev, u8 *data, int size)
 	if (!(test_bit(RMI_STARTED, &hdata->flags)))
 		return 0;
 
+	size = rmi_check_sanity(hdev, data, size);
+	if (size < 2)
+		return 0;
+
 	pm_wakeup_event(hdev->dev.parent, 0);
 
 	local_irq_save(flags);
@@ -381,22 +401,6 @@ static int rmi_read_data_event(struct hid_device *hdev, u8 *data, int size)
 	return 1;
 }
 
-static int rmi_check_sanity(struct hid_device *hdev, u8 *data, int size)
-{
-	int valid_size = size;
-	/*
-	 * On the Dell XPS 13 9333, the bus sometimes get confused and fills
-	 * the report with a sentinel value "ff". Synaptics told us that such
-	 * behavior does not comes from the touchpad itself, so we filter out
-	 * such reports here.
-	 */
-
-	while (valid_size > 0 && data[valid_size - 1] == 0xff)
-		valid_size--;
-
-	return valid_size;
-}
-
 static int rmi_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
@@ -405,7 +409,6 @@ static int rmi_raw_event(struct hid_device *hdev,
 	if (!(hdata->device_flags & RMI_DEVICE))
 		return 0;
 
-	size = rmi_check_sanity(hdev, data, size);
 	if (size < 2)
 		return 0;
 

-- 
2.56.0.679.gc527c65306-goog

