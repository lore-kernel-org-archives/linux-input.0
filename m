Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B523DB339
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591851; cv=none; b=mygwpK58x19YjxXpRSe709IUfYsPSWtL056I+ItMONollhco2qG9EDU0/8lnh86UCpRkl73iYyI6r2tpJi3qFRFFkBfg8VAQVGki+VA5r/BczX0+GX9lBluQvxCoxYR65kgWUQI9A+lxxwJ3LAXoVqPQReStwdvdNtz8o5Cq/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591851; c=relaxed/simple;
	bh=zqIZgn7Zgj5WSQepFgJtQ9GMMyKpvR8InLxOiqTa/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbBWqw/vPzcWKsVcYlLGr49/K10amndVtDTZG/GIBtKLeFjnwkx+KBPqdWFLTnunCZIeFcAfKOYI5yiBg5E6zQ1aQAwNt7h6rWf0kBx4HIwOXZdfeEg/CHh6/JoYcYrZDbtcGKgCXQfLw45av4W71OMROJUFnf6Ii0wZSVm7dMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsSYwLwK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsSYwLwK"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so3071947a12.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591841; x=1789196641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=XsSYwLwKu7HA+M9qQDLAv4qyhXqLO3Y3B2nrMauWYL5U/x9gMoPFVblanGk8nChIvd
         le6ND8o0ZGm4oLALDhgc8N7ll0NDm2ZuPPkg3BJ06DJiogDlzQZ7zgsVhbbx8LbTWTMz
         mJUu/Jy2EurM5VuMdsk3Uh3EF78ZdYkgcASPo4/iFhmVEz3GAbWH7dHmqsvIEDnJUq5t
         lb/gNVUNWETamXJAzcASXkot7DuMJvhXDEsA1GTzHxHbB2VyBuB5mB8CDW0siMQqovX/
         k/fP1XF6rKWc+9P18y9oJQoOw4mcO+2An2bQ56vnNdwBBSq7VrcBgCOkAHtz/ZsR5Mq9
         3s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591841; x=1789196641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RNFfTw1WuaSNgs5HCMSq2uznGZvnZVsIDtneqTMILXg=;
        b=VOFXnU77GphJeOm7pwSaMJnMvqojZnt+SI+pl/8nM91sA1sYVI0+cDvzvOROAXh2c1
         3JjMv6LukT4YSNsr0bifyBgcrfAJRMZlm0/jP/VFtieKYoCRSeHj4Lx+CCjT6K4M9hae
         Q9gpMOXr4dGJURUvccgQCSIQqXAQjsUXJY6JHV0P9rabSMvDLKg6kQFBVA0yGgblv250
         RiX8T+zgj+Xx9qOWLT2A8L/ZdX1hRBq8glWYANwOe2vu16XN1/mGWrOK85wkS4RTYFIh
         XRIa9+qwzi9n1gr97w9JXkBKJsekeO9PqdydohIgyEYBTrUU3FmYr7I8nh7Gk2ZwMwZ9
         zKAg==
X-Forwarded-Encrypted: i=1; AKwUvBwrPw/vlAEAXVlkWfajDlXKkFUYZ3edb5Ahn31jWJQGr9LvVrv7TcZU0d2Q/zCnDNMIOaVt0CEL1wRh2Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mkQ7YeEfcGUA5plljcl/+6+3FeS/1fu1a3QQr5gPMfkYa+pRtc
	zjAo5JLHHOVtpqKUYbJSmVae6zhquA7ruaG6NMM8tDVzuG2ldJ/fnsNc
X-Gm-Gg: AYBFou09jwYAF5YUYhu+lBgoulRrLhnyFkgbFRJ9QiHxQLJyBo4zsrB9XYFxuaxbTqG
	ETW+WQDF5vGvDi77PqwirwUbQ5azAmwoaCDc0JNkhwcQH5F/vs/FwPnU40kqeBYUNAcGAQv7cJk
	qbl5JAQ4JVW5yduTFU43mdlolWpG8+VRpIMRzFQBHtmdCPTyhHCLUmAyoB9t/mVZA4gE7lvuIQg
	Jt4p/QLxSMKq1ajw8IGEj7zPr9H7g42Tn0SDjMsNk/C6mTrIYwpdwv3PcAc8Hiy/2bNAD4556Cx
	khNHl2PVo7PnrzV0TCuBIiE8rm22FrZapQZk6xY3N9tU1hJ4Eky7guOYMENgxy2otlwwh9gmAJ0
	IuJ88FPboR/nimAToQErMjuiQKFBKNlQTT9VqliI5YczDlNdZtIvmnTHb1Tbux+mTVaruyGlZl7
	D/U1xH0FSNlAnAcNgzn49jjo+1Cniu4wtEtluFS9TdcL+L26PVMDgvNUwDIjgp456lTxUiC4mNa
	AxTc+jE25Kp2Nbnetv320Ewshvy+WEaKKNksUvRa0kL7FFciIxhVbE0VdNXHqidepOxOWIzDFuL
	z2LDGcOeYgWa1x8Z7ah/d2mtstW6kJaoORv9gyKdKy1G4ovds/T6CCFvgiapr2xpwb4/ClVL
X-Received: by 2002:a17:907:1c9f:b0:c26:1691:b374 with SMTP id a640c23a62f3a-c261691ba04mr359894966b.45.1788591840842;
        Sat, 05 Sep 2026 00:04:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm12011719f8f.34.2026.09.05.00.03.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 00:03:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: [PATCH 3/9] docs: kernel-parameters: Drop the edac_report= entry
Date: Sat,  5 Sep 2026 09:03:41 +0200
Message-Id: <20260905070347.25902-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905070347.25902-1-kmehltretter@gmail.com>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

edac_report= went away with commit fee27d7d9788 ("EDAC: Delete
edac_stub.c"); nothing parses it any more.

Drop the entry.

Found by cross-checking every documented name against the __setup(),
early_param() and core_param() registrations in the tree.

Fixes: fee27d7d9788 ("EDAC: Delete edac_stub.c")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 99d5bb68968a..2a8d862ef30f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1578,14 +1578,6 @@ Kernel parameters
 			PCI device even when its classcode is not of the
 			UART class.
 
-	edac_report=	[HW,EDAC] Control how to report EDAC event
-			Format: {"on" | "off" | "force"}
-			on: enable EDAC to report H/W event. May be overridden
-			by other higher priority error reporting module.
-			off: disable H/W event reporting through EDAC.
-			force: enforce the use of EDAC to report H/W event.
-			default: on.
-
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
-- 
2.53.0

