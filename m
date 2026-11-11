Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434256;
	b=3+A4POzck+DdzHlno0IaoO5FeExp12QAFz96mnehuoMlQFsrh7fmWPxf80lTBXmRqciK
	 G8Jhav0c3Q2QEFF1mJHEaL0/BsEgPphIM9PKgoHSjZi2jPEZnMzV49yjK8vk1Zwkc91S5
	 EV+68QWnGmpMix7DFGQxWG6EBLpWmuKInpeg4rUbXy0wShGC2THoPyUmZOQ6C44L4L8dR
	 X/90SaUTBauAZ2cii8qZNCR9QSIfy9/1Ka9D3LlkdGuLTFpRngW1ssYFpZ/EJSNzZR3/D
	 0VyaZ6jMaBd6y0+mYri+ksfyLYhSTILWElfzD79ysWYPtpALLI7X4KeZcrKtVrQPA/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
	b=isxTB4P/J+dzsi8K9xzORwyuOSDb7ZH9p7r+nq/COl+WbreINl0GeTQN1HZjDy/PkepU
	 IQR016qDccES9hw9yrSzykYH1W5FOUvts0tw2nBMhNBY8Xcqjj42Slzo0fqmxOAAOlGDu
	 DGzd5Ggx+MmvPicl5Fm6VtqfOz2rUd96u3btI85eY6nxyLTQi/V/uFJ3Zc6lOCAF7jrHn
	 qgndscwD6q38xJovCJzX3CP3JsDXWQpi7iwxLYn7ZumO2XqG0dgBVkmBl5GgT4x3zwsrz
	 Lyt7fcFDqvcHxqc/aAekby8SJzAkNezk4nBuktNDQtzSMgSK9RTGUvqHG5JmgtMVVBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEQlVa7S;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDC606A883
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 21:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77EDC606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEQlVa7S
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so7057649eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 13:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434255; x=1795039055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
        b=nEQlVa7SBqq5wJgUoTQc0s6JCfis1TV1le55JeVM4syZGTmNngYzCg3Zyltd0lK+Ox
         XTKKuObijblBkqafA7E8qpcMVg62I77jo49rqLT640mDOr9OUoofzd1h8qsHDMTm0q77
         lNm74rfCLHwzuwDMmZo4D5pXFiPlcA6DA6aDeqhT49PhrCpV7+gkzCbpUmap0O8qbkV3
         /EEwLA9ARHl05MSOrb3woRUXjJkDJMF4Z7gvqMCIKQs6ZehuENwy++kvYFoO3pQxKspH
         j3bwqpvBow2fabNc5eoWT0Y+H90vaRhaLbv9TC9dmouPLwV0a5qzRg4XUeOyodmKItH2
         IYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434255; x=1795039055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SpxeEyGCBIe2pmFodowG7QVxBvAwlFcEp0A+XN+w7cc=;
        b=sUfr9/LkoQqRFfQq0V4JnFnKtwrSXibrOPqmtSRR8MNNwB135mLUxZjbHdrWsz7hkP
         pG3LrKa7rbxhqaUja7HNxrMvVSn3t+1gA7SZQKvCWkBlPNr4b6olLncfrqbX5JR0sgXl
         U4Ksyq23Q5Zov6kvn/cPc6wUnvu9cVeLScYSoHnSH7zbwgj4V5TOURxR/n4wXcgptELe
         jztqlVunmT8mseZ/OoRSRLDkLEeUkp/bbIyS2mCZGdo/TSHCew7uU79PqXjAx/nNPxYD
         KZKu2zyJRbLIcolGp4a9CAgFRDO+Jd7VbIcthrZtgkfNFZr9/0nN+phNXcENmv/g1GPX
         hk0Q==
X-Forwarded-Encrypted: i=1; AL+hErFUwaNrWGjSozB5LoXv9NiRFb7N84DoHCj12XZtlHbQIKDqpOVGHUkuUNKVjCLrPEVYsnqBierE5pcTtQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+SkfRmGFT99XTbcmUKpQ79tpHsbIaEiFY93Pqof7PShwGyl1hm
	Kdh8tbK0GiYzEc14ra9yJiM9fYRr0fe0Vf538IuWq/3N5QGfx9wLpzMd
X-Gm-Gg: AYBFou0JpO7QdIATohBB3LekupA3rsGIgh/JnhbU2c9VMTXgCjd3MwIZkiaHRMQoi+x
	b+OO1dxfXd/Dn8n+YLq8+qJoF4O9xnMvkoBB3RSE2K5LnygvybcPiQWYe1fS2ImjSmp1iKtBPx4
	rIpvcMYPpphJyxkQvF2EwcUxOj+XModahq2exIUREJk/f20sHV7djIpwk/hFcCo/YKewSEPfrjx
	8+HNgdw3/tgsVW98E6wfSMGJEzAMb5c44QnX+3QPraaIKR6unXa4+7v6u2Oc86XU4jYuGNGvg7f
	mPErlpm0eNHeqJookV98Veqrl3T7uLGkz1dj8G3nT/YbK6h7o4rRC3VGba6nzXFV4GFaAGKlP5t
	zxjt8ojFOTgqb06CyiuSSkfYEoY40fo5H+ehBSH498xuzqrWgDz4EQjsAFXgdLb7TwDcwOzAHll
	AToMkhnMASuTcxe5S3ZOrfBLnQwHl+dbMS7s42Yov4KiZbchLTF/KS2fmkcXKdeDl2yLb6WQNb0
	zy/tPwUwZxbMKJbkEgqPP1NQjfpGfdZnOoEPLF8Cdgo5kCkbpluVLeJtP4njnmDgG+L4ODnnGwq
	NQStABToGSgkz/pI48hHPqmwt7RdU1L2mc/RgkC9M69FGsBC/vcWlQ8idWAwkYwueWGhi+ecOIm
	0wqFIRn0QkiKiYI16xQ==
X-Received: by 2002:a05:693c:60cd:b0:369:f18f:3492 with SMTP id 5a478bee46e88-37686d38d9dmr5076667eec.35.1794434254626;
        Wed, 11 Nov 2026 13:57:34 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:eb83:637b:7b26:8dfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm17823523eec.3.2026.11.11.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:57:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Martin Diehl <m-diehl@gmx.de>,
	"Alfred E . Heggestad" <aeh@db.org>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Slawomir Stepien <sst@poczta.fm>,
	Jie Wang <jie.wang@intel.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	usbb2k-api-dev@nongnu.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
Date: Wed, 11 Nov 2026 13:57:22 -0800
Message-ID: <20261111215723.3802209-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
References: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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

The yealink driver is obsolete and being removed. Drop its module
selection from ppc6xx_defconfig.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 8aab229fb909..29acc77573d6 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_INPUT_ATI_REMOTE2=m
 CONFIG_INPUT_KEYSPAN_REMOTE=m
 CONFIG_INPUT_POWERMATE=m
-CONFIG_INPUT_YEALINK=m
 CONFIG_INPUT_CM109=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_SERIO_RAW=m
-- 
2.56.0.567.gdb80ae8cd5-goog

