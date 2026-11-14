Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636017;
	b=hsZPYvaX3zGR40WNotKCTpvXwIV+76Z85C0qLlT2SNlTehioOhG02DJo4MGVc6haxP66
	 0n4ag3m9aiHs0cqTNizfSqoI8cZT2+yju8Mnq0pWo++f7ugzXllBAlfxVdAlO9gMm1iVV
	 Ibt7jFSuV78IN715lAhZ7qpG73n9zJ0IpAtVUB0LErG47c9l+vz78CHqQHf+dOvau3vzM
	 S041SNg70I6W746pJLnh751BbPW6BH4s3D5lJC8i+dDveimpqSnQdyBR+wWnfg0fS0WHJ
	 VSYQnAl9hc0pwPFtTYdIXsmKOb13JnGLaYFm/BpASAJX3XH/p7v67iEtI7tuazIbc2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=OpOmixRiwcWOV6oet1pcrkpXrQVB14M4zfrm/VGzsgs=;
	b=q95eTWSQ/5hgBpPb19OOuTbnqEIoy8jMr4uD4WG8PTNnaGflWVpLksE6Jq0NEo/Nhu8R
	 xXtMWDgunvECF7LRTp1j0QTpDqn5efjZnTmUWzaV9QPZorDla3w1YakgpZBr1WniMvlNe
	 jZ0KLyMAgGYWH+FzWVsa4THM/0lIWtUUFkVOzp4FX5+7/hBJF4RwhqdjhPDVTllNRmCXI
	 h3a2mIvzy4qeiIs8DQTq/CjzHjCSk3WTgx4qyenDwIcvQPCW7Stn9E49b0E48SN8EamtW
	 k4M6ikWU6V+HFexpOX7i7sS8xLHfHW6vPaVqqNCSJEfuGZEINxvM2LNx2f2aPyWHfWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXYm7JB9;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8E960A3828
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8E960A3828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXYm7JB9
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3ada81853so1625183c88.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636016; x=1795240816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpOmixRiwcWOV6oet1pcrkpXrQVB14M4zfrm/VGzsgs=;
        b=QXYm7JB9+nyEKGUIWheLLk3QH9+4fBUUxvVazo3wAWbkaH92vceQlohwJjbCrBvr3M
         inssWaZ633HaD7z+CEAk+lyJQUxT8tEwKUebMAhC+EL7Qt2o77DyQ+KdF8i7s6F2NjnN
         mcJtyyN10WMVdPSfXHfGXrJUED5yJl0oNHuXbHSNcNFDamB8/sW/kAqn9t4lKoBF0uTC
         zLq+PoC0itnvxoyIDpnCEqnN3BwHxaz65rwmHtdEiznYhak73pgkXWjBGEUaCyIfTcAF
         xwaeU6zeUTOsXsT3juPOo7bVfFTAoSjzkdMCYOW3uQ5L4LOBgsjlEtOjHJ5HTR9lUcWm
         7StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636016; x=1795240816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OpOmixRiwcWOV6oet1pcrkpXrQVB14M4zfrm/VGzsgs=;
        b=OD/zYbwgjH5OiJ1JgjEaWcRgnjoTJyUqFj6xJyi+9I1vSd64yUaYvTJQiYEiJUJU5m
         gJS7MtRaZ7Qi4iCHtKtwu0pAn6dZd5CzzsoSQpmc/TxB/uFvGa4JdkmrtMbW4d+cE09y
         6zatMUxfSrkd2o57FmMzNnnA3Kle9ilek4FjUNeCyZoPODdIoK3xxMSLFAxoRrXPqIkM
         8nEKD1wj5pkh0tMHLLIDTRAG4ctskjPH3Tp8Dpm7ajk9CBJtI/5xpOncVIoRSRU9HJBk
         9lhHpDDOmIygcoWxFfF20nWmJgHSTAFboFCeYEhwV8pxVxKPA+fOEBkULUjPd+ORObeG
         C/OA==
X-Gm-Message-State: APuU4Z9JNMAtxLDQBNx7W2vdION2JmkysxyXefEEcySPIcBnWMrDgOg/
	6hctsurA4Qiq4zauiCHSlC+elPFtV+V9TtgHRFaw+zS6AYSO7og7K4z9
X-Gm-Gg: AYBFou2poJ/Tlds0q8v3aRXw7y0cLXeA+50mWp/Ky6Zm/2x0F5WUTV49jKSBk9xE2bP
	qdr66Y92du1UuM590xycgyAiQ5Yt8MsxbSktqgmo9MkwKpn38NSfpEhWZ7rpQQBgvttFl54D6t7
	QFE7+9m6ZmeEw+Cc6A3B2kLeoFc0gPMniBDm23OVAFacJ4WSt0ASH5g1KcYPsquxJVW9TPRPmdc
	ISsLEf98hGqoChHXLVOYlUXH71p1E35L/I87Pe7AEGpkkyFFogHTek/H1lxQ5/SH8Y/aCNxp/5h
	4AbDkwmfKKMyZ71dVnRVIC+AZrQS7QCAjX57JzvVGqtrbzvjIW2gA7AIRw+TJdCIB5Bto7Ax4AS
	8xBh2ChNRr+gbli0EaohYnZVx+8irX6hR6as1w5/QkyRH6hW8SvfwjQe1NOMg3KEMwEL1Qrgyb9
	ral8mSxEGIVRM7AzEqXOERBAg9zfr/c23jFZryBGWU32u6/I7cs2b7SQc/G14JjMWuiRg0YD5tM
	2vJuu362d2Dt8PdQsj2cvXSoaeyZcEGbMKrBIAnU/haF5zp9YqlXC/OT/ZTpsmAXmFBMfXoKZYX
	xxol24aVaYkxmkLiJAXr2YF2X6Z0XWQNso48hb7NUpo7ZSBHRNKzzquWE3YvJlKdYszGspagLhe
	YKw3aNZGRwhUPJKNX
X-Received: by 2002:a05:701b:4301:b0:14f:4b01:40a1 with SMTP id a92af1059eb24-1b502fe374dmr4308208c88.0.1794636015748;
        Fri, 13 Nov 2026 22:00:15 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:15 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 22:00:00 -0800
Subject: [PATCH 10/12] HID: rmi: switch to scoped mutex guards
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
Message-Id: <20261113-hid-rmi-v1-10-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Manual mutex acquisition and release complicates error handling and
early exits.

Convert page mutex locking to automatic scope-based mutex guards.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index f1d52d55fe0d..ec0d18cb06f6 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -205,12 +205,12 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 	if (len > U16_MAX)
 		return -EINVAL;
 
-	mutex_lock(&data->page_mutex);
+	guard(mutex)(&data->page_mutex);
 
 	if (RMI_PAGE(addr) != data->page) {
 		ret = rmi_set_page(hdev, RMI_PAGE(addr));
-		if (ret < 0)
-			goto exit;
+		if (ret)
+			return ret;
 	}
 
 	for (retries = 5; retries > 0; retries--) {
@@ -227,7 +227,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 			dev_err(&hdev->dev,
 				"failed to write request output report (%d)\n",
 				ret);
-			goto exit;
+			break;
 		}
 
 		bytes_read = 0;
@@ -264,9 +264,7 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 		}
 	}
 
-exit:
 	clear_bit(RMI_READ_REQUEST_PENDING, &data->flags);
-	mutex_unlock(&data->page_mutex);
 	return ret;
 }
 
@@ -280,12 +278,12 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 	if (len > data->output_report_size - 4 || len > U8_MAX)
 		return -EINVAL;
 
-	mutex_lock(&data->page_mutex);
+	guard(mutex)(&data->page_mutex);
 
 	if (RMI_PAGE(addr) != data->page) {
 		ret = rmi_set_page(hdev, RMI_PAGE(addr));
 		if (ret < 0)
-			goto exit;
+			return ret;
 	}
 
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
@@ -299,12 +297,10 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 		dev_err(&hdev->dev,
 			"failed to write request output report (%d)\n",
 			ret);
-		goto exit;
+		return ret;
 	}
 
-exit:
-	mutex_unlock(&data->page_mutex);
-	return ret;
+	return 0;
 }
 
 static int rmi_reset_attn_mode(struct hid_device *hdev)
@@ -317,11 +313,11 @@ static int rmi_reset_attn_mode(struct hid_device *hdev)
 	if (ret)
 		return ret;
 
-	mutex_lock(&data->page_mutex);
-	ret = rmi_set_page(hdev, 0);
-	mutex_unlock(&data->page_mutex);
-	if (ret)
-		return ret;
+	scoped_guard(mutex, &data->page_mutex) {
+		ret = rmi_set_page(hdev, 0);
+		if (ret)
+			return ret;
+	}
 
 	if (test_bit(RMI_STARTED, &data->flags))
 		ret = rmi_dev->driver->reset_handler(rmi_dev);

-- 
2.56.0.679.gc527c65306-goog

