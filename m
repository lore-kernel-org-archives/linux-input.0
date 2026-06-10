Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1952F5337
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132567; cv=none; b=g9VwSGS14V93DK/Ynbd2BII0HAIDB+ijXCRWQsm06dG4uazh1butZjNMe+4ZycFRaG32AYcyvw3yuBuQ/CpLq6J1RjCpyy6Yb8kR+USGXR6MMjastFPbaHTFAeXOmKzoH4F5jgOFhbksbT31DWb0U8xwF3WePOhwIfSjb9eppr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132567; c=relaxed/simple;
	bh=FY+hzf3BZGi0ZBJvsMwM8zNI5xbnzKjtTDA80VuV1TU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ru0oUqbbBtcss7pHrXk8C0kH7mJdV3r8YsNzeIzNNTCUJvrs4L9k1PnBkL1StZuvsDFPHeOcNDZ6jzKcVMGLYE+4W12ujHmBtQKvCOhGH2BCpooGGJL753SckomOXMnp9LQWffM+1GkrONervv9d23dFKhjqDABgLDJczMqDgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6RX4JIt; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6RX4JIt"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304ec41197bso7460993eec.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781132565; x=1781737365; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpMAtBSnWgE7oBqDrrz1DO0t9MzMdOOWfKDJgnppP0U=;
        b=A6RX4JItdJtEVleu+hVgRlv7ifCJZe4WNjO8M/92y2Hu95/CXeu29iI4m3vLUdY8jF
         Rq9Sx+FohF6brTEWooGD3+9WLrD6I9bcHr6zxaMt8pOKJNYosEAyqHibkRrMQk3hd8Nc
         PPQq/4iPdQBVielSGhH4q0Rzf6VcusVQsPeKHuwMWqopWXP2kSijHCgBCyMomPrfv+Yw
         QBLffK3AXbBlEyU/qbKA8PP3esNcw6R9jovkQRri9oK77PAhdro0axYiA0rJxcIaGOUr
         xowdeiVMQOqcH1v1bZrWKf4h69wEjvsvREkCXtlxeO+xToEhMb+VqVep3PfovJg+W5rJ
         0/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132565; x=1781737365;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpMAtBSnWgE7oBqDrrz1DO0t9MzMdOOWfKDJgnppP0U=;
        b=o6zuFxbd3zAbPr4ETgFZeaR7+EU6XrvnpmgHpfVerMYi94FYrbiACODM8ecuNOztJS
         ZQpODEIq5ap14QeQ1jS1dlyZmOHlaBaTwMlJfJdniolz3XWgQmivuVKmXQ1FfMKikhrE
         5BMB4eD5oj4SPWG+vSazJWETxGiw6vS9X46zCFJPH5MC0VNkDYytR2kjV3BPkIiR0eAj
         Z3s84tKqUBZxBRBfFklsJ8qW6373aSxbD3TKrxlDdBeJ36gMF9KTq1RudQEO7foYboYl
         TIEZl6q0Gp5yPyTdlB8m8aZBcHm/cq2tzNOMNjjKEZkWMw4vvA3DWnNM29qQsZ3h09PZ
         TPQA==
X-Gm-Message-State: AOJu0YxvztdcmddE6aaKdZv8EduEdSI9QwyR3U1FWTWLs0NPdIOjVJNi
	7MKXRaj52O1YwBc6YBk4+smYBlaJL+urJ86FPAWwiHWKBfdpqQUWoqutvT373g==
X-Gm-Gg: Acq92OHamH8iwP0vESVvtq/vhFx9LDv5SlD8um9l58LLMaB05lLWplkyyMQ+8uAez8n
	RKru/P37MaQT+BqIFx2vstxQcRkA4cGPbqr92MXTOi+lZJ2c6M///o5mzI40MYK1EOuFBkiCP+4
	Ye55zMiPApgKEYZb3tfoItggT+kWY6Hxbl/NZTBNSQdG8BmVdz8WtYiBPF3p2JGxTvdLaTkCmws
	JTsh2lz/XANh0axXiKfl453u7p9GnJGGqiPDWSur99ddcn6efQiXUsW0d7IYNViNtObWTxbc9el
	JfR8ZMKtOkFxQVvyBdIa23ISpqJ3NJr69E/s0WTcQXLQVWupjYbDMPsUhdfv7FNrNFNz9WiCt7F
	71iRdAXtJBwQ6dFgQa2beOasOZUAT3UznP93Kat6N777MM6xKJ6E7Q4IjelH42ArjStYeH+LiuX
	JdRboOYQ7+ntZh9+23UOzdFJTiwUGJFJ7fRXxI7cAKDPeGzSA0dWML2PBVcp/e7Fex/n6rLnOlI
	XY=
X-Received: by 2002:a05:7300:4784:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-3080464dddemr243481eec.9.1781132565235;
        Wed, 10 Jun 2026 16:02:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85e10sm27009687eec.7.2026.06.10.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:02:44 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:02:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ipaq-micro-keys - add length check in
 micro_key_receive
Message-ID: <aintAvTyw4CVb5hG@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver accesses the message payload (msg[0]) without checking if
the length is greater than zero. The parent MFD driver can produce a
payload with a length of 0, in which case msg[0] would be uninitialized
or stale.

Add a check to return early if len is less than 1.

Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/ipaq-micro-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 3c7d6aa0fe29..ebd991de70f8 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -43,6 +43,9 @@ static void micro_key_receive(void *data, int len, unsigned char *msg)
 	struct ipaq_micro_keys *keys = data;
 	int key, down;
 
+	if (len < 1)
+		return;
+
 	down = 0x80 & msg[0];
 	key  = 0x7f & msg[0];
 
-- 
2.54.0.1099.g489fc7bff1-goog


-- 
Dmitry
