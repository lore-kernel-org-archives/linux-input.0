Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99D35E930
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021875; cv=none; b=pSiK+VZYMqIPC2u6qYRhTcDBgw2w/Qu4hTIMqg2Gghi8YcFS6A9DAw8mRde+khVC015f3Xw9w30SzKGKp3y1pXc854G3kpc424zBytlniRTffL4zs/QkvCROWNNl8lmE887kEDfSSvB5bOY/r1vvNAZl2e8xpID5Ow10mgd8F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021875; c=relaxed/simple;
	bh=t/ovtFrISDktBvngN1BFezgR29OO5wT7f3gkFho/p6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJ94QhmmjP/l9064D1vQKvTWOJ42IkLnqf4hAJhlvGvdQvg5a1sFTENLSKS6Zmgjg+hcobe3e3yyddqPbdXknm+3qteGe+lSRZ82vupWUVxI8n6WNjAhQC+vnuOhFT8AJIpL9UsBgc/sMiXAxIc7Ae02xi5/lFzBFX/aS5X+Sf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNrNfNC9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNrNfNC9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso64217395e9.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789021870; x=1789626670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gk/nJeJxwPg2pq5tNRM4eCstoAGF0TBlM4pNX6SM0kY=;
        b=iNrNfNC9cTcOPf73Bu4NWCktp4uMi/GEHfZIUF9uhx6CrOyzSI8ghXjSr3+Akdo3Fv
         QnLwwzuur8bDe+8LwJMyVKKP7syhPAPmqYPun8j82LsXVRArdQTDHkZCrGbJZI56Ds3j
         vo8c115Uc5PsB4fVt4z/q0mMP7+1LroH0/AF3pF3v07YfIGhQKjJ90vhQzKZU+4qtTkF
         ltte5PL/WpX5DEk5DzOAsXyjr9utkGB4J6Xoa0YeCEdo/e/9hWQHDngIaM4xnjArb/IQ
         WMO0JR5kucFBQroVmG36s1Xvpq8WpQ/2pRYZBDZ5XPyAlLdMqc0HzJHUfk9PxMVBWm9M
         xS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789021870; x=1789626670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gk/nJeJxwPg2pq5tNRM4eCstoAGF0TBlM4pNX6SM0kY=;
        b=Md8N5N4rDCiQ1ig9YItfMoDGArXODTzRMb/G0QKyfuLIv+uiD9syk3CeW4L7MoEeE4
         rPu4enWsMRFwQLEVtVgI5hev/I1/kR3ocffNMhYfxXpyGJ6b1CE0GKeKJskGXworply4
         un5ehcKTvMZuOYjyQzpvyU7tIydfz2svpRqDXUja/SwA5QHdg/XgVcAFtUIMeKbXXKid
         LZXNL1MOpekRek2amqIkLzYvrwfXqW2b6FIDOXAteKz8RuGvHSyWxRnb9hCdiKpDV13Z
         VpC3rEahgcwC0zeK9C1Y1IzKLtQjXhsWX1mlwcg3UaPrKy/BUL1vWpNlNet+hIIkd3DD
         78TA==
X-Gm-Message-State: AFuF++nUV49kFrFKxe1LVgTOnGwSA1tBvrIKrcV6v14nPj+R2LaZDkWO
	uvodV/mL10yCwBzSEfPZb8iJeOhyNc0wxPIHWd+lKGbEZqQYxDSsd0zP
X-Gm-Gg: AYBFou2PdJ4lzMmFSi6PMbVfoPUyn2UmEQxwBmsG7CWJdywhWmbow2ycYHhcz/W8q3u
	gVoCnkUbJ7AoI+woJyguLGJtO4a0zII2xXnXLunNz/zZqpv85rl7Bw4yH3avfruI+hhbmtVIlfd
	M8ZoGKj+69QDs0/qLemwmu5z/++8VJKZRvnKF1toPn6XAkbSEoi5z9KjfPJh1pO4JxIkpkSTD5O
	SCw4FjiwO7yW4oQB0LGz6WmBEi+JKrR6UZd5vP3zlctuzgWILibSAO45St0vsshqKSjXAzcuyM+
	wHkAYxD1msiU+dVRFA5Y6rVpRY+qHgXTKSjAbNQaWYTPhX9oN24wIoejt/xDzaORMt8oY5vXH+o
	aK7yMxZMidIBijNOHnUS3nLPcwWWm3XGAmrrNXSye0ZyxKGmVpM1LCMpen8g3t1yDGVhkS7odTg
	VBNFzhEXfbNd8ix7radntF7HoFY4bbeUos1S5zTrcVEsDTkanv33oiFs/UonjIZxVk4MHZUMjFY
	vi6etla+YMH1Y3xBYQ7Za3MBY/hM8gaR+SV5dWtXZc=
X-Received: by 2002:a05:600c:4693:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49d00399d19mr308998655e9.3.1789021869734;
        Wed, 09 Sep 2026 23:31:09 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-103-238.net.vodafone.it. [31.26.103.238])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d26bfdb4asm47441825e9.11.2026.09.09.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:31:08 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11
Date: Thu, 10 Sep 2026 08:30:51 +0200
Message-ID: <20260910063051.4556-3-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063051.4556-1-okerixx@gmail.com>
References: <20260910063051.4556-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE keyboard controller (048d:83db) declares a Wireless Radio Controls
application collection, which hid-input registers as a second input device
advertising KEY_RFKILL. That collection never reports anything: the
airplane mode key is wired to the embedded controller and reaches the host
as EC event 0x19, where the platform driver emits the key.

Map the collection to nothing so hidinput_has_been_populated() discards it
and userspace is left with a single, real KEY_RFKILL source.

Signed-off-by: Oleg Keri <okerixx@gmail.com>
---
 drivers/hid/hid-lenovo.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 3976d7b53b14..617bba662659 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -476,6 +476,16 @@ static int lenovo_input_mapping_x1_tab_kbd(struct hid_device *hdev,
 	return 0;
 }
 
+static int lenovo_input_mapping_yoga7x_g11_kbd(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (field->application == HID_GD_WIRELESS_RADIO_CTLS)
+		return -1;
+
+	return 0;
+}
+
 static int lenovo_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -510,6 +520,8 @@ static int lenovo_input_mapping(struct hid_device *hdev,
 	case USB_DEVICE_ID_LENOVO_X1_TAB2:
 	case USB_DEVICE_ID_LENOVO_X1_TAB3:
 		return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, max);
+	case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:
+		return lenovo_input_mapping_yoga7x_g11_kbd(hdev, hi, field, usage, bit, max);
 	default:
 		return 0;
 	}
@@ -1568,6 +1580,8 @@ static const struct hid_device_id lenovo_devices[] = {
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X13_TAB) },
 	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD) },
+	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD) },
 	{ }
 };
 
-- 
2.55.0

