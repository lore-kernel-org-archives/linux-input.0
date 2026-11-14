Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636010;
	b=Am/vYVhgAzlniCHOlMxf5HhZLyHZvHnwZMH9ebsU4/EcL2YaXe9gOOmNvoI3l8fomJjs
	 d4eTo8oLQiEH+U+pDzBLKZ5bN2cy0t1cuIVz1Jz6Xa+7TOpqj5cBQ05TYjj2Qm5p0fqAF
	 Zqk4IzMB1Iuz4eZdfDnuJQmtcD6ZfLLUIUrmGFiEkzcxqOickgUP9P/wVLfNK0g9RO77v
	 pu+x1qEZ8vhhQMYTKNDjU88QjRbFBORaVLwqOOLG2/o6IZtsgAM0bqnEoWDLWpu7H/Emq
	 hB0DQgBxr7UeoA1WXMLLmkf//8H7bfIMk1tOeVwMryUKvSBmCW7c34N1FxA8JwxKGFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=+EEWNkE1a7hRMhlPQgcCbRa773ygILlEL18jSB5SYvY=;
	b=YIiXf0e5SpEaWVtz/tauA6VKrHJ3WQmfssiwtQ7hPRR5QOsknFNRn83+2sJ/hXP08CYM
	 ZCBePXCa6grHNce3686kcOjUUXv+Ysv5yDQSFIebUypn+VzcmwzBMv/Btx3iZ5tYEhTYZ
	 09XRMoYgBwprKfUrSQKR2viFU6qCD+98j7vxfz2PvJ+2YK/PmeK0baehcPQVfGvwd/9nD
	 6hOB+Jp0QAzpFHcvQJNlXYfA2YCxBrWjbgurtbgLnwMu1Vudd9dh0J3n6dWoQt6gZPo2I
	 2bvnRPW4FH1eyYWgz/YMtxIIxKdxp2/AKjoSrnmjxK2h4JW4nyuU8l+F3hYwHlfDx6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oym8Q4iL;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F560A260F
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 259F560A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oym8Q4iL
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37628596783so2992682eec.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636009; x=1795240809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+EEWNkE1a7hRMhlPQgcCbRa773ygILlEL18jSB5SYvY=;
        b=oym8Q4iLseLDNoJ9gzRphRVkN5f2H/VqXyf6TcJh8o2j66G4TA8atN7qgJeLOtbrmS
         l9U9+c35mNZUn/u+QfnmMWfUpAN032Jam3YxC+rQ8IIbQBhtoShn8t9gAugOQuIthkSp
         o9L0FIIVcyPMM5sP/Vo1J27ynOVqF7hzkgT5brWML/FSoUWlw/1i/tTzHaUkJmR10BlT
         bVoqqURhruIM4H8p2ynZ4Ll5s4BN5NBmqi7fsijNj/hbQo81QHrEioQPwcE8jZuyYre+
         oIjtZHCRaT3jvDNXRJbX/X9PGlyZ5ALRsE+xqUHSKP+27ofcRr2Qnx2K+gZC49K8f4xu
         oYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636009; x=1795240809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EEWNkE1a7hRMhlPQgcCbRa773ygILlEL18jSB5SYvY=;
        b=daWCZWrT4QvnEtNUV2VUUhwnbm1qjjOcFVqrIhIEBzbw+FVoBMk/N+wQeX1QEQo6op
         pwJko0aho1z+6/aW2PZhGJw3TBTYcVhGiKWBsxsUWkdCoeewqhWvyHA0T49zIotmuumk
         ZKS8yRmRBu2687woeIkJp9kArpvXQzxtjMX9nJD+KXhD+hiiPIQkUPv86dp+EJtD/QYO
         YF8PSCOEMMX9d3IxqKug5UZ5sqtayfcY6T2gB0xT7nxbUK8xqjETP0vRfo0apq3KENuH
         K9Mk9uJBYOLF+UqTx5cS/qK/oSEXSetxwLsr6NsMCvazbFHbUwvv9pSR7h+CS0+sQVBY
         Q/hw==
X-Gm-Message-State: APuU4Z+4lgtyLGKTg+paEq2v57n8Cio9t2gqV6iMdXtQ2rUKNKB9dF4z
	brgsNP2kBbbe4fHOicun3RmoIY5uv7p1Zaajr/Ev46DnRCrqNdIXbZaU
X-Gm-Gg: AYBFou3mqgsfER9aX6MpdJ6cITxydMuaPvi7q6hcHhTW/+0iPRdZp14TgGllsbbvY0a
	x99C0bCU3t6S1EvKe1AaPIc4YrtdPAtcOX5V24cUVnvq55XGvEKfpx5M3V4w8p8vgYe2/pNAx0f
	ukSoy7uoQcRtJJIYJERnBTj7IDFkXRNB9Tkf+bhYzJShHKxKhjWav9jA6ZfpMSnXScrrZn/Qj8e
	uicBpo/9EElJIc0zjdItpFzm14SFKgoS7QJiHZPAZFL6YtqoizIZnTkUVn95bb1iWdYrxpKDnE/
	DcdBa8n3iBreeNeduQqgz3P83Mqqiz91R9vx4xTM0sD0NxnsikaXuKpm2YBoWQ5K5epIkp52X0D
	QC3X3SLGEuP4OobW6RKlyWYUIZ22zfcTDiDyCnxwlCSWCOiXnaNLSMrE0PB/iZUukZOIxT+qUnl
	tJzYpD6NOWlK4jirfhONsbUuBfjykrOJMjvGTyZxQ1UY6rpG7jdIKsQBLCUdxmNXAYy7TUA1xno
	wCgnpWnPoUuuvp93XB47mpxUp/BS8GPwggTyTsjGK4DPTPg1vSYeSoORcbI61D3mfX/xiiyfHpb
	cscxY7CrblVcaBkbdjWxail9BKiCPceXu63TR/MXMACEc5BxUabFmSwG/cshfN2otj6H5GLGZYM
	O1qw7UeQU2EC/q8o/
X-Received: by 2002:a05:701b:4507:20b0:168:e942:4e62 with SMTP id a92af1059eb24-1b503150bccmr3965798c88.40.1794636008600;
        Fri, 13 Nov 2026 22:00:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:07 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:55 -0800
Subject: [PATCH 05/12] HID: rmi: re-select page 0 across device resets
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
Message-Id: <20261113-hid-rmi-v1-5-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Hardware resets its page select register to page 0 across resets and
power transitions while the driver cache still retains the previous
non-zero page, causing subsequent register accesses to address the wrong
page.

Explicitly re-select page 0 when resetting device attention mode.

Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 8783edb7fd6a..d3e4ee0f62f0 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -321,6 +321,12 @@ static int rmi_reset_attn_mode(struct hid_device *hdev)
 	if (ret)
 		return ret;
 
+	mutex_lock(&data->page_mutex);
+	ret = rmi_set_page(hdev, 0);
+	mutex_unlock(&data->page_mutex);
+	if (ret)
+		return ret;
+
 	if (test_bit(RMI_STARTED, &data->flags))
 		ret = rmi_dev->driver->reset_handler(rmi_dev);
 

-- 
2.56.0.679.gc527c65306-goog

