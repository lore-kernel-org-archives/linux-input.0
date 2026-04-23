Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A83DDDD5
	for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928217; cv=none; b=WvI8ntSl2DnKilCxA3OruXlDFmEn7aglBuqhfVeThN5DUx1zuQQY+ZA8fYYssD7E1kO7ldEe8tiJKYLLWKjPM/iIxqW0Dmo7FS2Nm7IAdedeZXGK26c8Qkocpw85CNg3k73JrQv53I4thscRO9pPDdAy5SAnAG4gOjnva3nFI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928217; c=relaxed/simple;
	bh=oj7GrHRmjs29INUhFGrdrkc4xKU3Ve/5HLGLk4ZEng8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oTVDEo4ioApaVd3dJIsQUHIeLHre4cJsIih6dwT85m2UfikEZPmnXG5TG3BpsgMAOjYbJXni4yx0WuYQudiuHYcSFZ0DoCmvAl1F1n6P4c2NMrREvVeyKfWZhDunYxzkK9q2vr9yWhBz/vuhchCvwVRQCn71gwWSnZWaAgMpbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3vwJE63; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3vwJE63"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79827d28fc4so63206527b3.1
        for <linux-input@vger.kernel.org>; Thu, 23 Apr 2026 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776928211; x=1777533011; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dWClNakSEY5hBwD72lRuG1Vsfz+1unzwEOw8r3KM3M=;
        b=o3vwJE63VcRl8607IWjHCig74eV9NngfB9E1KGFeg3noDTAdL//rrbLtDfOZKpRd4U
         XuLlBP03ak6w1IAz2emC/OcYL5kiQ7njdPzZDV8M3Yzd4BmxeRGxtw0vLVz3TcOhimnr
         5LRMZht3UtxZh2a1xujmEb/UP6lEKjizG+E3xMUXEh8AKlOA403bmBpAc8rC1ePeuUgK
         wxnxxWMrIW+pH76QWGo4jZUVF6cmEygdEcXOtvs6EaNQGCW8xZLxaBBwW2+IKFU40mmW
         TJTJXtAd+rdYbIreUYr7peyEsswNEQnziExE+XkZhwGdM5EW/OkDgBTsGNmsbMQmcIgm
         rV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928211; x=1777533011;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dWClNakSEY5hBwD72lRuG1Vsfz+1unzwEOw8r3KM3M=;
        b=hw3wY/RSPvDavpTl+8mOEWe49PtvkAAJ/rvuALzto2u24ApOOgUUTTUspfRaKmziRo
         y69u8Nn7to/ww/VXhpPdZFNb+p5U6W0ZLlGRz5kxTmAXnCpbDdQ3Z/utVgj4TWjxVJoG
         zi4v2HQE4oWOGVTyx2Y2QDEwi8jrU4fMC5ZIECiTbScSE4qzyoNhxyC1rsch2Q8AGstW
         gXWi3KMuT4P6Yc0lYXAjEFHbRFbHZsWaSzcrNFK5qtiZmUXPeHyK//gurbCro5xMk4JV
         s5y5udnfmcWf0ThDch97OcNWWYx6FhqT5gDImc9GLrBiyKvsSYfRVY0MOFeSps3LF76w
         hLTw==
X-Forwarded-Encrypted: i=1; AFNElJ91FGJwbuYmoTSJNk9BNXrSleqKmvWuNst5pjlpOC9YSqlFUlstxExDIG755bHAlK4Zmb0SaUaq57MNlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DW+mDMxgRbwd8x+0JzsHIY5j3cWL5c8zwQ11D8HYoeme5t1L
	w72GidwWPdDAkC7CpQMNfBky1BUDxBH82VXp++rMn64XfEpkFgPuHyhp
X-Gm-Gg: AeBDietoR2kbP0MTI4fo8w0ZR19fRKElpK4FolVWV6OJbZSkQisKyJpCFFUEfdzViiI
	lqWKP3unOF/+eyAjGOF1B4fn1jlueaqTsrjlKWaJeyDkWYaWkwaJWixsA5D0CU9Ewqn9B31n6vJ
	X271lEqcYilWLT5jZzoZKDXrqNnf3a5ehLzhJTGWqjfLvAzBRwlhQq3U7CBmfmC+OPVXq+AZ8T4
	FAzWdEmvQ+9467UGjWa/TpWmkcvCC2+YAnstUK4nFuTPCF6HUPN0sSzN4nfn/1W9unALMELu5s4
	HjtPBSFQbx4jRMgyZl6BjXJvdC/a8Gs9yO/isq7PQ3u+kP+56pqAIMXPdfe2A7c4/1bMb6RWZWX
	gEcjTgSzgZdJ5HwlToBZcSNXsIXVthITzD9kIOPqhx9nnwgOXThefRc87bnoELDaSMAg0WZ1o64
	luiAL8G0jUHu4ISPzNTu9/htjzqVyBEe2o5+Z0+Wg=
X-Received: by 2002:a05:690c:1e:b0:7b3:401f:2e45 with SMTP id 00721157ae682-7b9ecffdf2bmr300566197b3.44.1776928210850;
        Thu, 23 Apr 2026 00:10:10 -0700 (PDT)
Received: from localhost ([172.216.252.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8be8e4sm80530277b3.14.2026.04.23.00.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:10:09 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:10:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Even Xu <even.xu@intel.com>
Cc: Xinpeng Sun <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Message-ID: <aenFyk36rTnrD9s3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If we have a partial read that is supposed to be treated as failure but
in this code we forgot to set the error code.  Return -EINVAL.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 16f780bc879b..cb19057f1191 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -94,7 +94,7 @@ static int quickspi_get_device_descriptor(struct quickspi_device *qsdev)
 		dev_err_once(qsdev->dev, "Read DEVICE_DESCRIPTOR failed, ret = %d\n", ret);
 		dev_err_once(qsdev->dev, "DEVICE_DESCRIPTOR expected len = %u, actual read = %u\n",
 			     input_len, read_len);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	input_rep_type = ((struct input_report_body_header *)read_buf)->input_report_type;
@@ -318,7 +318,7 @@ int reset_tic(struct quickspi_device *qsdev)
 		dev_err_once(qsdev->dev, "Read RESET_RESPONSE body failed, ret = %d\n", ret);
 		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected len = %u, actual = %u\n",
 			     read_len, actual_read_len);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	input_rep_type = FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE, reset_response);
-- 
2.53.0

