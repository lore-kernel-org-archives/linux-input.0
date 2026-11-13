Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605757;
	b=0ei97MmMDLG7w+jMdN283By+vY9DMAdIejOvqZt3wYJJqsB3q/MuuWTaIBuYo7dKuSYg
	 VRlLwfsgE2GW0P57jzwfjyQ+ISNaV1sqrPT9VcWcnvUJu8CgrLVct1Sq21+kvx7xCELtE
	 GxpCr7n6OPdscdTOw/UCc9/svj65dh7X9Tv1XmdGJC9TqrfjiEdwFj++hjfhGuUTeDR4o
	 Fq6xp1XxEgYmr43rQdibZJAzUbuIbMti+yolGSiCdk/6TiJPF4wob2VI0BG01TM8J58GI
	 xdSJw8gL7NFpf5GH6muIP5VnVTqIIXEn/h0VaTuKD4OroVyKFKJrmty7o7cIrC1p/TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wWqjB/0nYVOH43r228nD5yUwpZdUjEPDhzW96fN5h3c=;
	b=Tog+Gp9vGalZNQKimSDDAl4jn7hX9J/HU5jqjfHXkF/Ds9bxuQq0/xD4ANycWjDF1f5I
	 a5PF8y6nzowEynLjCyqs5QgoVfNoSvNkKxUECLjoDIbStXn7WrHjhXI5cOOznB90kWHHA
	 S0m+cTIKau26X3VeiFi31qjSmqLt52N+gk0eFwFCdXYhFhtOAgwve86iA84LSXJk6r9EL
	 1jq/oZ6BHTHDj1s8lTGRSQHsdikJDajG2AbN21Pe4umLKei0MK032OmnZXbE1zzGLsLRu
	 qS6xZqjTZ6088jtnEvzBIK18xR31hQsHIZCSPgWbksUKd2NlaC8zofAtWhm3QFCoa4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTYXYUcu;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D67606A8A2
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D67606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTYXYUcu
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1854714eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605753; x=1795210553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWqjB/0nYVOH43r228nD5yUwpZdUjEPDhzW96fN5h3c=;
        b=ZTYXYUcur8VjI5fitLtwK/vCZBKH2wS/O44NQ4eHhgIpDmBdpvUikrWiXeYgnyZnQe
         PjjG7mKK3PailSIS0IoyjzXxn6ItMDXbyba9H6AF48CmQC7D2zdsUexnZYvqwVLnz5CD
         2CZu9COVtjv1fMPbRriJBhEnwQCJdS/s75b0UVIyA4UB5GSpmvUCcWScu5qtD7lbKyvN
         qKYK9gABacxKVrUPePydmNBN1xJkLaNhKJOsxzTgqXmTp74edL7CsDsT40YiKdM3lVMJ
         INhSv1WyU1FW2guAxYj+cFVgrJAAg8oKMilwbTqZ1Mikgx2ya22Mi/r4FIc7apcim14e
         ++EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605753; x=1795210553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWqjB/0nYVOH43r228nD5yUwpZdUjEPDhzW96fN5h3c=;
        b=QojHMlp5aZrsUBFny8gH9ng2uf/Ed+AfeI4nS3QuDckwlmg9OaDBvIdC9t3ploVPcG
         w6sGe05jU3Pe7kuTwmfcaBQ6i/VkTQNsko5EL5z1mSfC4MfTZAWgatlFnSi6jyXsAEFo
         Q3MfV5aYNKkCHzxHsToGdyrhk8IvVYd/Z8le3eCBMC+grwpUlF8Flh6n89dGWWsWKavR
         oPDaVOy4OcsqwegGRQw3VA1tXrlsNJo7iJzt8HBY1KDnBUXRSq2ozx4IZaqY/uMC+7B+
         61TN/iOtg7kpI/5Pl7A2NGdJ51O49Jb/HjZZi9ysDDm9oEQEbPGbasiwsQHA8RkAI/dF
         JViw==
X-Gm-Message-State: APuU4Z9+pJKpJpwbrTu+V87t8Dn4cd4pzUBTES7Kt1DDLvqyXIRa03Gv
	/pWxkilXeV3ej6YKw4YkBHnE0RYblRxN+WP/EcBg6P16uRLeJff5v+qMMKmXErzV
X-Gm-Gg: AYBFou0RnH1gX9usMe7sSVldL/JGib/ISzzLuGfq0v2DWcEMrabmjUJPKdaMNHnKBl6
	2Kg7qoigOszAncAGdY7BvI3Jam/IYEWaZjMEqeB1gYAObAaeyJQFyDmYOfBUo9E5YhJEsLGNswV
	SovsETPrrQ8XRUW4LvLRPZQX3Ni3TcOC27mKIox8aoqdXKyJsNcZFS5e4s/wsxCh+YTJP/Uk9BF
	Mi1iKTOoWHv1qnBDSuW6QokqyqFei5gDQTr+hu+E5TVNrrVNo5ONkE33SMyTuE+pb7UpEh6jKjb
	dWchQka6EQcDutx5smH59zIdUNsSeqrpj/PdVSdfE6W6fMUMG3fMrGt8gc0MmqfK+xrTyBod/8Y
	D4ppMWZaabOvRAN6LI8E8QVqco8XOWB6beLUfn0U590nzZ3RIVLjbcfq8PkB1Qzrg91+sNhcT1D
	zx91UoNJhF/oxBkqe4hHCHZppB4kyTUK7YYA/LopXL6B+9XqDPcMdacKobOj8KPvjkvNMdrx8v7
	XCUPH5g/629sgLLdYKBm/UW4hb718aMj+vOnOKLXpmNZumBY+ekCk9svdz1Vj6tVC8eS67mmwuv
	SUEQAih0m4/IxNn06PRgArC6GD1JyYUoPB+dIRSmAa/5rbDIlA5TOQ==
X-Received: by 2002:a05:7301:b06:b0:376:13e5:e8fe with SMTP id 5a478bee46e88-37964b08f4cmr2784706eec.3.1794605753341;
        Fri, 13 Nov 2026 13:35:53 -0800 (PST)
Received: from archlinux ([182.48.212.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm10137339eec.1.2026.11.13.13.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:35:52 -0800 (PST)
From: WhiteDoor6767 <gururajnaik166@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	Basavaraj.Natikar@amd.com,
	Sandeep.singh@amd.com,
	Gururaj Naik <gururajnaik166@gmail.com>
Subject: [PATCH 3/4] HID: amd_sfh: Enable interrupts by default for Renoir hardware
Date: Sat, 14 Nov 2026 03:05:32 +0530
Message-ID: <20261113213533.13139-3-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113213533.13139-1-gururajnaik166@gmail.com>
References: <20261113213533.13139-1-gururajnaik166@gmail.com>
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

From: Gururaj Naik <gururajnaik166@gmail.com>

Renoir MP2 firmware requires interrupts enabled to signal command
completion and sensor status. When intr_disable is set to true,
commands sent to the firmware time out with wait_response errors.

Default intr_disable to false matching Bugzilla #218104.

Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1234567..89abcdef 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -23,7 +23,7 @@
 
-static bool intr_disable = true;
+static bool intr_disable = false;
 module_param(intr_disable, bool, 0644);
 MODULE_PARM_DESC(intr_disable, "disable interrupt");
-- 
2.48.1
