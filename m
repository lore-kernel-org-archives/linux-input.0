Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B82BD5A8
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777180032; cv=none; b=KG5/W/K2TL4MVyT6AS4p/jjZP306gRSfDf361mNFGjEcEaLC4WV+DYAEEo1sv3aXZUBON2Ne4tKlDNiNqq/wLVIgLKjiWHYkhOaeE9EDBiiaif3oZgDQujEjH6Pq1c6ylVJm62jv4WHNhmd1xfGZTNtV0XqlywuRC0+3QFvEcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777180032; c=relaxed/simple;
	bh=PrydE+y26snjne7bTdgpz29EtcT79cYstuG6/6e8H+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YdkKN/oyzqhRPTuR+SQqDBEO6GBPPD61iMoM00GkqN487sHZu6FJ43EQfdsVRsbVR7P6E3BLtMmd8tOT1njbfoxgGJ42ZML/ZH7TzGyE/jPsAWV+wy5eBJnHy8ww8cISAqBlcfj3Tq2mDMP2tQOn7XpvJV/HNufIg36njT1Gh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAkEolPz; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAkEolPz"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c156c4a9efso12496923eec.1
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 22:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777180030; x=1777784830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8qGDvhFge6p1O5v/iCkCdtT21/Uc3WBmLDQiwCw4L0=;
        b=gAkEolPzeMKKlsT7A6f6sfQWUrT5Z9GHvzgSk+SyUu7+UzYAYrpAWzED9bzDyEDGOB
         6wUXrTq3Lm1dYFB0LXWRdipCEGOSLxCTJJV7ovS8bU2w8QO88jW2J9LUy9fJYfQSWmrl
         mqwyuxNank2BlpHc1Qkjxbd2W8QhtkkKmsOF+FWRP+97n2AK8girDJlx5dBQKeIzJ6d3
         WrA+e8L+fUHz/MXUQKEn3zzbHY8QoQ7MxU4ZKkmEA6EWe4PNmMlY2/YkCjoEV0SpY/7x
         Rc82AVFK47bsrhob/nRnsxf4sXi++UlMIXZy++FYxD7T1SX2J7yC9WED+e+r81nsmnN9
         xAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777180030; x=1777784830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8qGDvhFge6p1O5v/iCkCdtT21/Uc3WBmLDQiwCw4L0=;
        b=fYy6pH8GIfwVb49PkeQ+4JiWzt5kfk/LPV0Mc1V2QS1kgGYFKhyf/SiC6UZGf5cGkF
         /ozsrgLlyOP5dvcHA70QWv/fJNQ+JFrslDx+tYq4/H6qU6TVApRf+vdXJcyhn0g0d1jl
         ZANPmLTbiRU4PAKoYAjzXgEr+2plxrAI04KG3YREtLOPhZ99Y6tFV4IHTkdQvD5gzt2k
         kf+W+qEdOjW0erCEnDSOWMXaGFP9h5iuapqEEiAX+SFbVWUXGviIhIookkA4kZQTzyMa
         oeYBtuM8YiNZ8hK7JpFkib3zBTQGAm31K0VDTGoKclAtjaIP799vp3O241uaZxpddGav
         Jh2A==
X-Gm-Message-State: AOJu0YxdS/wP4MEGjDYG3ccnW+SYcDrzhWK4q31v3fYX+Su8x4+7lG08
	Z04nsLjg0V3ogxg7PBUrRfvEGhZNFxKb9FgHU4Dbg0xgIoWDu0yK5vjB4XpXeg==
X-Gm-Gg: AeBDiesxL/aNk4gufKLuRcN8XrEMU4BS4LZI15T3VrC86duq7RyxlP6Z1DmeY2yyBi/
	zLu5h2JG2KmlXr8SAKQSP9KB9QUHrSJ5HfnjszT9NDyoBrXIHj2H0h93ZsBwLTQ9Z1qWYun8Epp
	8dSyYBsn1hW9f88qLBZxolIYjk5XovCQo1XC6pMOk9P9/5NYcdpZpNyqIMA4nF6ekX24o+xlnZ4
	KmSgdHatIwA8vjdsbwu8vnEb4hTO8jzM8ixDgrpyi2rk1pqtRIjzJ/pm8PqPolh6TuPcY2szAGf
	9aDuhFJdAJDTsrK1XnUTUx0Uy7T5sruYGE4J5xQouPHIjYd4l4ocBEbmx/eYyWYHFraMPtn/0yg
	m7wI2JUqz/V4oHDo255FHmAFd8CCNkNVrqbPRT19Ts/mGwER1XzDrXy7Wr93A4n1R57r2XH70CR
	fpseRIg9CAx9kCzTdOL7e6GWGAPLdB9HJuOFo22QvigGT5vvfzmKsBfnhMQaI5UGg22lisDDnYs
	pNv8AEVk4k1MQ==
X-Received: by 2002:a05:7300:72cc:b0:2be:7885:31df with SMTP id 5a478bee46e88-2e478839275mr22966860eec.17.1777180030258;
        Sat, 25 Apr 2026 22:07:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f359:aa0c:530d:9dfd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm37822023eec.22.2026.04.25.22.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 22:07:09 -0700 (PDT)
Date: Sat, 25 Apr 2026 22:07:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, 
	Jingle Wu =?utf-8?B?5ZCz6YeR5ZyL?= <jingle.wu@emc.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: elan_i2c - validate firmware size before use
Message-ID: <ae2dOgiFvXRm4BHo@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ensure that the firmware file is large enough to contain the expected
number of pages and the signature (which resides at the end of the
firmware blob) before accessing them to prevent potential out-of-bounds
reads.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..74f822cd8774 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -645,6 +645,11 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 		return error;
 	}
 
+	if (fw->size < data->fw_signature_address + sizeof(signature)) {
+		dev_err(dev, "firmware file too small\n");
+		return -EBADF;
+	}
+
 	/* Firmware file must match signature data */
 	fw_signature = &fw->data[data->fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) != 0) {
-- 
2.54.0.545.g6539524ca2-goog


-- 
Dmitry
