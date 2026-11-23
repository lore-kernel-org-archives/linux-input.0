Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407663;
	b=zVbbr7eZjLcSfa9yp8k1ePPiMtwpIz34M/9ZVWL9ZhloVRLoduP33jIbK6kt66H+kYlz
	 qUhLrDujeTK4VHlCj7IpwLrXPcJIagMGLuD6ikBIgh9jImz3sfdSK+MEupMvAymHj4FwT
	 Vi9rYWfqPEZ4ztDywA/t5Of5unFcN0rhgPLZYkb0Tk0MIjFnhc87qn0c6+OlTDillmBPx
	 jqIF1vK8rK6GOU+k+WyCsQYYsaVjS4SLJm8IfXHO61DUIIbdz0OYthn0jMs68LX1rF7Y2
	 J8FPbJxo8BJsHSILlVr1e4vOLVUYktqOINPKQHvZwwn43EBxpYCcoJOEv3/fRPj67HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
	b=hrZsl/Yc6V6OvZVF4K922oN0ETZrAaFc1WNV8KwPGkmVrSIPrqGGValxln5C2dhnsY9E
	 kfGxUkBqv6vkc0wj3HRA+BAzh4gZ2fDaRX1Amai3OgPZ3LSeW4Fk6CSuFXQuWpM2KFz0y
	 LS2RsL6zzO0oVhVbBGL6SFw6O0ntcTM3sIX6KdL9My/a3SAQxDTaWs2jygkL7MxUHIk6W
	 mBhwB7hkCZCe0GcAnQ/vjlQMsWh1QPpgTW6nS2xO7zU/X8NC46oM7B92u6QZBABsbJc0o
	 ak5CUhOWQC31oKqlFCtelaJ9wFqeOrntHztkLlZK7KbcmcnvrVudtjgVlgVtJdC1nSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgSKbUeW;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A873606A333
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A873606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xgSKbUeW
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso6306676eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407663; x=1796012463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
        b=xgSKbUeW26WHi5TH0F2XJfhO+bPd4rfB7Ka0bBEdAokxE5ALhDRZQRCs23BnK+TB4+
         B9RHuwDpg7cvN906V9B/9JSxaViPIhXqvIUiy8dw5udSGi0Jy8eBT20fp62KgRTxavnK
         /+fo/FyJVNuIgpdknYbXBJNpx2tUOZaZUChFBqMGeUqydDRyNKAwTzBVufCHnVPDMNX3
         B/jVFAzpfBhjjrvXHD/mQTmd2esv8dqVZIvo4apefaMKbH+NP8wWFs6ZAcasHEpqaBs9
         5B6RmjizrQ+lDQJFhhx0qhOaRIMcxCIOyu4hjYv6oNlP8PsyVqUgasLKRBxTJ6CJ9MBV
         hXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407663; x=1796012463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QM77UDij6XwSYk3JC8OYB2FX+P8AANH4ekRQtOvst7s=;
        b=iKC92qkjBM29BKc2PNtP8eNcB/Nwkzfz/hO5eVgRxuVLWhaRL5/dVAjtkcgXN6EWeS
         Czdx0dfEE4cy2/FoD/XcHMeLMEBn4wJLa36yn5PkQRIutTZOG5BSSpQsjIH9HguwCDJW
         xBYLLwDdOrn42a9rHXDCpFXNwNUgmaVAC4amd2sXpRHUCyFBzTi4yJ0JQSObi19dm84b
         t5st0ii53GL9srnE1vpBD78mY9rMMpiCKSvnVg3r663B54WvOB4sIStbtOYSqJqfXCck
         Cf5b8wEINYUo7GCkyKtFRC8GN5Gs3EuX6HiXE40I3oZPMTvLNcX0fnxXLL8pJ2jTpwEw
         +vhQ==
X-Forwarded-Encrypted: i=1; AL+hErFCMH5Rl5VO1gfsBFmTkqpWzp/CB30tOqi/0jjkT9nV6wMMDd17y4SvVJu09XCzlkzQa2a+bW5afEBSow==@vger.kernel.org
X-Gm-Message-State: APuU4Z8g+RvOTFvuHSdYFjKJKzNiU/zqWzNNv46YE1Arh7YojEmk0cdf
	GhGA1+udc0XdtZkchW3s4FwB4VZLR1+rleGwK0znVHNJBvT3x6S1l48QxosIh6/85M8=
X-Gm-Gg: AZFdTZdcqwf4d2l+U6/d0CjLCpK3+ymOLXVAr08rv4pEGjDmjhyWTvPX1XAI+x+K9Gf
	IwRKP+QE4DZ1DI3x6n+IPsAhWd39x6cjGa0GW0vIuRJZvMHGSFkMQhsbmgt236PFSMwKnNlIzk3
	e8IJBdmFGEiWloS7doE2+3EIgxBcvSTD5kN1fFt9hD1P4e/33vwF6xqKT3CmoD4ueUmFgCrYHDn
	y4p/Zo/73hUi42PkDine3zxv0aYyqFKyhewbzk6YAejW/Mh5oOGBI3kgo/g9FCn0h+L5z5g3IaM
	+HHl4Q/x5IBAgJuf997EXbZXgDPeSeYNLVasYTe7MGPn2+8C8kt2bo/SMblCx7lqHLun72uLHJV
	I0mxLMpC6/9obSHOFd7f0R0JjTAwpYzTrvz/c+DpXWjKPZLh0C94qMj3qZ6qAa/bXi0u2aAbBRA
	zQqZzNd5+R432QLz6yzbOS0fjTA+JEXob97Nh7XYxQ10/gENDnchK6L0dbcTLXJChjky5IzxK2r
	BA2gEggihVyMDZ/104WdkKjPkTGihSHYPdYAHHypk9gQvifKipQOZzg3U4GsR0zRgVWQ3gBAL87
	IdOmB5K8RI9B1WfBgUXNFAE6dUoI7uhq+hd5+wAccsiYhOCHKmT9spzmcow+0EpwgyX4mxs1Ora
	oyg4U5hs/cOjWb3WBWz55/trS+0lgHqtjltMO/VsD6AxI2WE=
X-Received: by 2002:a05:7301:c005:b0:386:a0c0:5e59 with SMTP id 5a478bee46e88-386a0c0757fmr6668638eec.20.1795407662629;
        Sun, 22 Nov 2026 20:21:02 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:02 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 2/6] HID: wacom: check the input devices in the legacy irq handlers
Date: Mon, 23 Nov 2026 04:20:11 +0000
Message-ID: <1dd28b561f3380cf3b76bfe096ba676a83f33229.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() dereference
pen_input and, for the latter two, pad_input without checking them.

As described in "HID: wacom: check the input device in the shared
report helpers", a partial interface leaves one or two of the three
input devices NULL on a fully successful probe, and wacom_wac_irq()
still dispatches to these handlers. Seven locations fault, each
reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
device plus a single UHID_INPUT2 write.

For wacom_dtus_irq() and wacom_graphire_irq(), all hardware served by
these handlers is expected to have both pen and pad on a single
interface, with two exceptions: GRAPHIRE (pen-only) and DTUSX (pen-only,
no pad buttons). Guard the expected input devices at function entry,
skipping the pad_input requirement for those two types. For DTUSX, also
guard the DTUSPAD branch in case a spoofed device sends a pad report
anyway.

wacom_dtu_irq() gets a check too. Its only dereference is in a
dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=n, but it is
unconditional in the source.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c7bf0e5988e5..d5c2efcc09b8 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -128,6 +128,12 @@ static int wacom_penpartner_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 1:
 		if (data[5] & 0x80) {
@@ -174,6 +180,12 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox, pressure;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -233,6 +245,12 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -263,6 +281,12 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int prox = data[1] & 0x20;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	dev_dbg(input->dev.parent,
 		"%s: received report #%d", __func__, data[0]);
 
@@ -289,16 +313,26 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 
 static int wacom_dtus_irq(struct wacom_wac *wacom)
 {
+	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
 	struct input_dev *input = wacom->pen_input;
 	unsigned short prox, pressure = 0;
 
+	if (!input || (!wacom->pad_input && features->type != DTUSX)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n",
+			      __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d", __func__, data[0]);
 		return 0;
 	} else if (data[0] == WACOM_REPORT_DTUSPAD) {
 		input = wacom->pad_input;
+		if (!input)
+			return 0;
 		input_report_key(input, BTN_0, (data[1] & 0x01));
 		input_report_key(input, BTN_1, (data[1] & 0x02));
 		input_report_key(input, BTN_2, (data[1] & 0x04));
@@ -349,6 +383,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	int rw = 0;
 	int retval = 0;
 
+	if (!input || (!pad_input && features->type != GRAPHIRE)) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: missing input device(s)\n", __func__);
+		return 0;
+	}
+
 	if (features->type == GRAPHIRE_BT) {
 		if (data[0] != WACOM_REPORT_PENABLED_BT) {
 			dev_dbg(input->dev.parent,
-- 
2.43.0

