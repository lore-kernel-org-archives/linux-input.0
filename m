Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896529;
	b=h3KwzkWz45cOYFfC+WdXaj4nd+wyN1uTRX9CzYAuzJHJqItSxKoPzQ55zH57z4i0ulY8
	 +Ar1KaPnCpqeazW/G+1oZqGJz4EX3GJLgmNKuhkWK7246PkxITc1HCpI/3PfFDiSnK8Ke
	 B1VbztMCUnIQL3LTExjY7xV7O0EawqPwjNMDysbCJ+UtrOZsH7ZciH3JShS/GHpBCalcD
	 aNaX2iVyR9Id7tZtnncDJNAlsk9skQnNvKovc7/KMOZrZmMKKuP6WsB9cpGR1Iv+VY6NL
	 q9tV3WBVKINTUjEi/k6CjbOSsypSZUEzFaXgmncJxy6TkaPyNVYCtCYa13UsoXjc7xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
	b=aWqiMp4sMHuXx556tlxtLrEsdz8itB9c8Jk0HeTcg8QIFH7jj0OBmu8X66Hl9/PTujZ6
	 CM1Ba1Xn+/Je1qXBTLKKXgtKHFoDJTjhzw/3n82SKFSQ0397l91UGDGpvXoFKfAyhVYtH
	 vTWHI2EPCLJWI+BTcAfpnraFG6KNmd2424/1lUs3y78EIp8dUnF5gDfrMWkfbcamCNm4l
	 jy5EmqkeGSnaQQBrHnb6d5/T0sUPDd95POQPPBjUBTOVnmbj2TMHOIFSJkjCVfptaujuM
	 hICVBVC510/P5XOeOvtmHKCGuAG9DrRDQ4Os6tQveEsrPTrxzTIwuGa0eXW2H4yUovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D31606A32E
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D31606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TpxwA813
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3867114eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896528; x=1793501328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=TpxwA813+P5znsifZUJ8deji2Cfy3YNYm07xUH+eLP83aZg54OT8spSktYMe6uqGRE
         iQECHez5gjvBbx6xLGeVbfT8DSZ1k8Qt62vdK8EaDhI3b1+wztqIkJbaJlCtnuCA5esL
         QRH/IaQA0IS4/4rwKKtRZShp/VJZY5B2CGAQ4+oQP9868SHQzHcsRMqbIUIJIrKAZ80n
         lruFtXxmDd9FsV8X+PllJ668rF3ZZJTTNnl5/6dcw99NfAg8N0Yo5T4C0J1RuHQYX1ve
         +cFbn2eSkjaZFV55MBT+LCMMz8FPEg4aiNN52QkcwWnlvHZrZ4/6zCg7MfQQ7POzh5gG
         lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896528; x=1793501328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRxwvjYywW2EDj8EBeP8mrgqVWNhsI+cL4nt5lpU7sA=;
        b=1+Ig/GVrMXP/jyqQWasVuJw9Jx6x7Fupu60YVVsKJYFsOJp673GqOy3aLGo3gZmkaW
         thI6G0Bzx0hUbDsgr2Ee9EALBQB4ecyzewu2FkIZXZ7e/hZVXVSnBY7q7UH2nYwIbnGl
         FFHXFWOEandesLQAwcspf75JzFMRVsl1m1qREGOUKJWA5aXokzQhsc2FYrzSkcnXDvya
         yelW449Ml3T/3mk5kok00l7Yhx1BNnQ3OOJbwTjlJaSEDnB0eCmKuNxoKsYzyXV2DmxJ
         B38dlAC9X1KvrxRzc8b3VeVRA3idczx42od9TGVzdZ7sqbnkvsBpG2qRfgPjN7W0NU13
         mI5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzQKlXH6g7rlEUCDgGObCutYg8U3NNK5kowfNYu/glGg5glkj5qS+t9LAPY0bwevi82jkcXOgzEFcuy6Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0KCbRZQtUBJEvw4DpoSPVcx8LBg3x38fi6ZH+lQE1EYz8CQdA
	OlEU+5fRQR8rGD3zMzxkT3Ss7fDK26/0LlTjTEgw8eRh0cflQFKUxHq7
X-Gm-Gg: AYBFou2Vy3732iyt85/Wa1VxvabR79VhV34AAld9dzfmuiyf7Sw7wYvZJcrk+kaT9F0
	gNdM3DnhvB4KKV1rdvGIg37zViZ4UEcdxGZz7zBvFNu+86HMuNUetizdA8hcNfZM0gK4iXzJ/Yd
	MHX2JqDjoC9sPkqFsIEja9I88K0tqaSqNotjwBxP9rT4PV7PhjS966LIt8NjX2bzvq1gnLqFLkQ
	in0Tmec75pwYgGsI1WcT6A78evTYSorCF75SHQ9nOVwx2TpeS2SeNMMi635AJOdiNNexfeQXs6+
	Y7b6Z+07t89kqTdQKwRnc/hknN6A2rIZRgMJR6fP7/rH+Z9KU9RxVyWQnyt/9uHZ6kyk8ITx4t4
	rFmbkkytmtzZE14gg2QShXLKeB9QU8HHeN+2592RgDXlfsg90MzQEMITDfAaW6oQyA4ldoUmakw
	0tgJdG4yeh3oAWNaO/EeesZuoDXR/qIUW/495lR/iTiBMTZAtA4hSRdqbHSWtcnoz6yEz03XMWC
	wy0KcLNZ1hVg+oQQjAktVP/APlAF4kXYJ1dvnQJ7ec2+JACQq4Q+1XojIXTYTvUlfRReCRdqSQP
	AYhMB5LJSAJskRkZVl0Fd3c4WGF3mU6aArYtxmGNwhU=
X-Received: by 2002:a05:7022:1087:b0:17d:7b45:f905 with SMTP id a92af1059eb24-19937025befmr4633321c88.31.1792896528487;
        Sat, 24 Oct 2026 19:48:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:47 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:41 -0700
Subject: [PATCH 1/8] i2c: acpi: use 4-argument i2c_smbus_read_block_data()
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
Message-Id: <20261024-i2c-smbus-read-block-data-v1-1-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass I2C_SMBUS_BLOCK_MAX to i2c_smbus_read_block_data() in
i2c_acpi_space_handler().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-core-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 84841ed13487..4acce685457f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -751,7 +751,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
 		if (action == ACPI_READ) {
 			status = i2c_smbus_read_block_data(client, command,
-					gsb->data);
+					I2C_SMBUS_BLOCK_MAX, gsb->data);
 			if (status >= 0) {
 				gsb->len = status;
 				status = 0;

-- 
2.56.0.257.gf7497c7d27-goog

