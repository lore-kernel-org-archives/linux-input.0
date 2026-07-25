Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990923321C2
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784967003; cv=none; b=mSi/cBpf1qgtp19TyfX9ZJHOypkUf0Pis3rBDps1FeCkrJWcNLZWvjtibwVB/XRtpVheJRMiKWeBiZfnSpjfeYCo7Z35DISQ6A7d9XB93SqTMmoRbEfdg56oaqT+e1MYRHxmSAJ9mHja5m7z9pz9OGQyrwdWts0mWHUhk2fT5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784967003; c=relaxed/simple;
	bh=J4ubHfAG14RsKXJlUSfmRcTuEjOmQ/zOrQeO3Pc5iUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d0/qlYWihJdm0mL5UHz5QwXKyHtNOx7W8rkN2jXGKQn9k88hCoNgoiRgYepbH6qHKuYAJ4kL7TAjC7FAVlAYp+b5LhMNDt0fj/U2NSR5KnNPBh/Iwek2yDYqrwbEBdSrJCO2JW1u1Bz8n4+9MExRCNy+TtHGADWfhquOrckkFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVEmJ22o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVEmJ22o"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so1145167b3a.1
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784967001; x=1785571801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4J2s2FhuNzF6m2XUI8QthmE7XnJnr0cmxqqYW9+XQCk=;
        b=MVEmJ22o7MyrMX1GywGlwJ5XAB4vLJFIm1IWgh8JkYuXfGfoq0aW79iOg2U4ozLM5i
         ztYEz9t0Ddg5YTsqWFX17dS81GTA3Qwy6bvHZxCh7TvWfGqaeK4j0PYplFVMcs9wFCpg
         PKTr+tOqHlQ67K7PK7FYqMFgx0mkvg1DaBG/1vrZBZ2qkxtsxBRihQGicKRHK41c0M41
         wt6TrC7INAASKN9Nj0//EVAzQUaLRsBmFqOHqHwztq6iXz9XoJ9UuqXy5qjNAcxGf40h
         HhIsF594VFn2GAuoyJGM54KdMDqONVFpfw6MhnNR62LPKZQh/KFwx4/+2T82DMREGe6L
         cdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784967001; x=1785571801;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4J2s2FhuNzF6m2XUI8QthmE7XnJnr0cmxqqYW9+XQCk=;
        b=J6xc42Gs4vdnjvQJB8OE5IAWxilEmhpK7mC7J+Zb1rTWxhV7JRj5WU3+/+i+jYSE/T
         qR3tXeERJDudN5zOFSQdGIMCv93niNpYlPWOzIlfb/8Fr/yMPzKChcNZFcU9aqmx06fu
         n9NCfp00dGcojpYvd6TiGy65ya8B23tM2CVffa/9ENBfzDmDKF7yYI1gBLFEw/LmLTHK
         nDKBEaiw0riEpyMo4C0IUpzYd2EJcZXmp5Mn4op16JE1X9YlMknFulJprYYwdJNWxp1g
         ogC1td+S3EuspIcCdP75IhQ3EQJGvv9WMo7nlhPGmm1Jf4NCI3OnkpmH5Dui4B7XSWEE
         194Q==
X-Gm-Message-State: AOJu0YxlTVQwnK4iOduq3qove5Mx8GmGZ2a28WK9IGwraVPv6iltOIdi
	athkesFi+cXA3e7oJAQas2vMHeVE0TY3tj7VpauOe0ZeLm0np74GjEvL
X-Gm-Gg: AR+sD137JbRh+zGOBpV9L9gZMF5tE/yASN30/jBPQADxM79xl5vzwjGq/QqNsiURdXc
	RvZCEoCm9V2Z7Nvdm9wE44Kl+AUA0H+fkaow73uy/7IpRTJgV6ZcR3/TG2ytu48mJBNoIqErkkQ
	c391FNoFkofr+CugOlt31OglDOSToTKTXjFGLlktz0KbMT6sGE/u72VOc31ShnRmfrk9UmDtaKn
	QytgOt1uf0HYY7rGyfulUXaPSckQ0rRDB8k0cjgsAc2Fl4vpro9fGWR2oNxsyrW+omK2HzbYxZo
	E4R7usjTHPirmtYWwwhb03KT7KSaUmr51UVf8R854qX4MGmxBom9ur3fEK6kOC/OfBk3Hd7N5e5
	RnWHc2AdImrXF0ZI3fp7zApklwgfBg8qgth7QzhafJGpTUNXRUHGwNDJh/ueUqqtho+/6/bZvK0
	0tVKRv0qN4SO61HJORHaUMcPr2yxMi7UNnM4D9LtFc
X-Received: by 2002:a05:6a00:f96:b0:84c:2d22:7307 with SMTP id d2e1a72fcca58-84e5945035cmr1043472b3a.13.1784967000762;
        Sat, 25 Jul 2026 01:10:00 -0700 (PDT)
Received: from [192.168.216.190] ([120.236.174.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533ce1f7sm863654b3a.34.2026.07.25.01.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 01:10:00 -0700 (PDT)
Message-ID: <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com>
Date: Sat, 25 Jul 2026 16:09:47 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] Input: tca8418_keypad - fix potential infinite loop and
 OOB access on invalid keycodes
From: Liang Zhan <liangzhan5dev@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
In-Reply-To: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The current code checks the raw register value against zero to detect an 
empty FIFO. However, the TCA8418 datasheet defines key code 0 as the 
empty-FIFO condition. If the hardware returns garbage data, the loop may 
never terminate and the extracted keycode can cause an out-of-bounds 
access on keymap[].

Move the empty-FIFO check to operate on the extracted key code so that
the loop terminates correctly. Additionally, validate row/column indices
against the configured matrix dimensions before indexing into the
keymap array, skipping invalid events.

Cc: stable@vger.kernel.org
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
changes in v2:
- Moved empty-FIFO check to operate on extracted key code instead of
   raw register value.
- Added row/col validation against configured matrix dimensions.
- Dropped explicit 0xFF check as requested.
---
  drivers/input/keyboard/tca8418_keypad.c | 19 ++++++++++++++++---
  1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/tca8418_keypad.c 
b/drivers/input/keyboard/tca8418_keypad.c
index b124e576feca..36d4a7c38bb1 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -114,6 +114,8 @@ struct tca8418_keypad {
  	struct input_dev *input;

  	unsigned int row_shift;
+	unsigned int rows;
+	unsigned int cols;
  };

  /*
@@ -171,19 +173,28 @@ static void tca8418_read_keypad(struct 
tca8418_keypad *keypad_data)
  			break;
  		}

-		/* Assume that key code 0 signifies empty FIFO */
-		if (reg <= 0)
-			break;

  		state = reg & KEY_EVENT_VALUE;
  		code  = reg & KEY_EVENT_CODE;

+		/* Key code 0 signifies empty FIFO */
+		if (!code)
+			break;
+
  		row = code / TCA8418_MAX_COLS;
  		col = code % TCA8418_MAX_COLS;

  		row = (col) ? row : row - 1;
  		col = (col) ? col - 1 : TCA8418_MAX_COLS - 1;

+		/* Validate against configured matrix size */
+		if (row >= keypad_data->rows || col >= keypad_data->cols) {
+			dev_err(&keypad_data->client->dev,
+				"invalid key code %d (row %d, col %d)\n",
+				code, row, col);
+			continue;
+		}
+
  		code = MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
  		input_event(input, EV_MSC, MSC_SCAN, code);
  		input_report_key(input, keymap[code], state);
@@ -298,6 +309,8 @@ static int tca8418_keypad_probe(struct i2c_client 
*client)

  	keypad_data->client = client;
  	keypad_data->row_shift = row_shift;
+	keypad_data->rows = rows;
+	keypad_data->cols = cols;

  	/* Read key lock register, if this fails assume device not present */
  	error = tca8418_read_byte(keypad_data, REG_KEY_LCK_EC, &reg);
-- 
2.34.1

