Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C331C28E
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791253310; cv=none; b=QcgZHE/6b7uYNt0t5Iuo7C4qy9EplhmXv7P3no1ID/ixH3Sh4zoazN9st6/R7nb7nllQK58tAEn1XBmbo0LLYYOrYnSRCM6tQMDPEFXZqsH4x2DQkxwYzBDCbSEYwyYRzIA19W+o3lF8e8TQjnrsBLwCW+X4Di6fnsXGlaNRCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791253310; c=relaxed/simple;
	bh=X+ApK4aJZtFExDbkXvaDoXYcLNfzIgduLawtL28y0aU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hdA8hi+dr+r6C6e3cU0QAN/GctNnpktwrXPwDBacQ003TmOedK7nbGPTbfuz7zd7ju7IdtPrt6agIw14aKpIWeL+53/jA6pCWokV3ppFHbnGL8sW8jDZLLOUOiGh7MjY/pC+ieL1/SBdK7XTzngitIR6cTU0GPIF0LN/yx+R1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URkQY5Q7; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URkQY5Q7"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e497ed2ccbso11575205ad.1
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2026 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791253309; x=1791858109; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yHf9jQyY1fl7nbJNPZDapSRASsYMYa+IT9UPrDjnf0A=;
        b=URkQY5Q7Jua73dZHJIBl14Xsm5VJmY10W2KjRDJGtQKd+LHmX0yNg2JcElqyPN5Wtl
         AVespsUFjIYUvMGjTYxizg3IBqaEwxTQ2fCrMqzxRQIlFQnkLl29z4jN05WLggZLMrTq
         V6f51hEaCPIkhAEMqyaVVKZIaty9e6xA95mhp+pCq+cBO6+2s1xvxriZtQgyZsAxpa12
         UHrsLuBO7LpLNXWQoHyg03rN4JJ3xey3gwiPRkNm+fjpERaAKkwwM6+S+pyxlt6cx16h
         NtUXLxZ6FJwCemWcrzUKT9NF+X/NtNAhMcg2qPhh0MJEKQefQ7YlzgO9z2BznRcq26JR
         82iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791253309; x=1791858109;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHf9jQyY1fl7nbJNPZDapSRASsYMYa+IT9UPrDjnf0A=;
        b=HYqACZXjrg2pGmDsZne0LMvms+qJ37x2lrB3Y/BHRKQQzf+AyFKXKRcqCNMgo1BgPm
         g3STjgF4m2pW+I5itLiVofYqJOCpbkdFYex/FPc5262HHvfiT/XzxCVFAMxBHcpc79qq
         K3JkFjSZTyDShr4tmugBOirl0Ipn7Cxrk/cNrVaQbHzPGl6JXf+jB7EuGJM/hZ3siOzR
         v/GzrlqXPi0FsY9VRQp4ZCMJ+14nIhxNLzt0QwPRYplyB6WwYbldS5R7AtnBGxjGCcC7
         UCXIrOXN3jzyEjiY0WrssCP15M6rrEEj+QZQOjkBgdZivkAKZ8TlqiCoidb+F7pNlz7Q
         V8EQ==
X-Forwarded-Encrypted: i=1; AKwUvByU5KSbPafjzpd6EV1Rs2e2DmLvgviWkrWrCgsNxhoNeZsVio4g8s4ZaeuHLpbNR9leyE8rMs63YcseuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIKEKmUWkM/ikUEzEjKlNSBV8/NizQibK3h9Ikbn6No9SfyfZ6r
	J1vQFNYJRz4ASVOad3m0cjunrHi55agJCZJ1KElA4e6VynGIUmqgWabe
X-Gm-Gg: AYBFou07Wn3swE8Ar29q3Ntmc+unCmwZl7AbI0wH6Lgbb/nTrHIOB8CYlXtuwkLLCdP
	5w2SW0NOYGewQ7J+hopMkxe5Wi8AIA6p9QLFl2o5OBpj5pcA0pjQT0w21jGF5wLsBv3XFwKOCpD
	cmFPBnQxWCnReWKMGS0QReNlBNV8AIJqh5ieIl08q1TDVh6EXNlQWsYmtFLMj4OaBY9S6nF8Qea
	he98OhGTLzNtLPa9S/A6+MAcJCwrqC3PL21n2/CGnqD+LLOGBOwRekTHYemfEVodOA8ft8vb1N1
	C+ActQWzKaQzJgb+igpO92jikPtqRqgDVul67P653pVboc6OQyJIhJCycAvpZaY4P9xp27KT7Wr
	OdpQelJGJ8wOSop63Gpwfw2+uUIlix2B05AGt9neUmT5ipeXiQKr8qLy+Zq/MIhPb2PXELZi08R
	vvUigo7aXjxVMUtSwoYhtntB+LKnLsystOA4JjxzUzyGPvbc2Jd4qN/7G75CnHZqhmsgP6fWDXk
	nfKPC10iRdVvr6eX46EzCuFlfkXLQ7bPHPRH3dRRFMMEcnHbJSSuSK+X8QZe89wVlJ5i8+fSh7A
	Ruo=
X-Received: by 2002:a17:902:ef48:b0:2dd:c100:943e with SMTP id d9443c01a7336-2e5dcdfd37cmr230685ad.60.1791253308790;
        Mon, 05 Oct 2026 19:21:48 -0700 (PDT)
Received: from [192.168.73.37] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5ccdd1f8esm2815245ad.83.2026.10.05.19.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 19:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/4] HID: picolcd: Use min() macro to simplify code
From: Aveline Noir <jm5905938@gmail.com>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: bonbons@linux-vserver.org, jikos@kernel.org, bentiss@kernel.org, 
 srinivas.pandruvada@linux.intel.com, even.xu@intel.com, 
 xinpeng.sun@intel.com, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ccc194101@163.com
In-Reply-To: <20260728025750.48249-4-chenchangcheng@kylinos.cn>
References: <20260728025750.48249-1-chenchangcheng@kylinos.cn>
 <20260728025750.48249-4-chenchangcheng@kylinos.cn>
Date: Tue, 06 Oct 2026 02:59:11 +0800
Message-Id: <179122675117.249704.5624307905971961639.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 28 Jul 2026 10:57:49 +0800, Chen Changcheng <chenchangcheng@kylinos.cn> wrote:

GCC/Clang builds, W=1, sparse and checkpatch passed
with no new warnings. QEMU/UHID EEPROM tests passed;
both versions showed the same existing 
atomic-scheduling warnings.
Makes sense to me.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

-- 
Aveline Noir <jm5905938@gmail.com>
