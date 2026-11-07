Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794088943;
	b=lDCd25U/BrD+B83YLa6W94Xl/8sz7921LNYOVnw6gEZcjjwzy3IV19Dtnj4ezw4ezkD+
	 IkHiZuMQdgpTWgUdNVdnaQbEd0LwoHzAroEYZZ1J+ZiTMVR19iVqp7y1Pt9Y9zWHyWhOj
	 vguq3E/KZcapF5GNp1FOzizxsP6ZetTtP3n5JfJT9CdR+TyDhhHw0cuzDlwQdnbUs5YlS
	 yMFkwFYbySxuF4/9GVqAyCjcejU/Kz9XyLuW7uqvfvMuDaj7CqhYwhednYzv1Umfy+Ffq
	 LRrg+YdITt8YFAm5AquEkxCc1S0AuqkQf7u3gvgfKA/G7p7OEAmKhCD/83g7Efj8OAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=HhO2GUWTHHGUCCwjPZ0qgnmH/fB5f4KuTQU5G5MnyeE=;
	b=ufOjcH6p40AcKhGLdHdanVB4Q3VoSIU94d/IfxvzkSWVlcvDiOJE8e82teRn4+u1GxIl
	 r7AU4sXcwa3gxh3kEOT+Ig1kLzycdm4/oRo4y9A0+8kqitpNXFZ5xa5u2vbxRMQQCjc0Y
	 SrilC3k4/8F83tgUu+EbIjFbnSGZuq/W8Am29HH+j6joGjCBlVKEpyg1qan8aewm84lsE
	 N1oPLO5HaPtKaYV56PElzey1oWlfyIljA3WS1mYHxGu+eD5W0T88oYCTLViOUKLgj6Msr
	 gSTq6Dq24p01a24HfO6mpfATYXS6ElhtDTh+zA10t8GtZrqiKMUk2rmmGGbMh9hIDyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpZMCX8R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05A606A326
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 22:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C05A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GpZMCX8R
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4932b13c4ccso18841fac.3
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 14:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794088942; cv=none;
        d=google.com; s=arc-20260327;
        b=jfshBu61I0/ET/nzf1XigKVZ19HMnldoeVq69Wn+VT/t/O/+x4hCzIFdfYL5hUaZ3w
         0mMvcYITc0MGj69A4SSMdHnqerBEeNdkSChPah9H+MY+8mBJr0NJpPr96qbkLgR8uflJ
         AEicF2Gi1Bt/dFugY0NG7FPLYR9wz3kaUXo958XBEv41DQUWx/iPS9X0NowbNEA0tQIO
         BHmk2W0KpFNO/kB7oaNshcyFu0JyG6SNTycJ7HvB/HsneuU+hNqhesfH6rVU5+0wB2y1
         FkCjXPyPIunJiwQTH7VdMCcH9VTntIVks+qnfZblc+AkrLsYgsqPsISJFsodRuW9sT2Y
         q0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HhO2GUWTHHGUCCwjPZ0qgnmH/fB5f4KuTQU5G5MnyeE=;
        fh=RlhTxD77Ow880eqrTAlehrA5R92+cuE9nzPgBgkt7xg=;
        b=Ues4grZgHWgTapVVWVUEvhuVdtGuak7H7lPk2fYtegpYN90Vsnf2AJnbXQ8IkExIph
         JICuOWF0zw8xvYGi9JPU4Nd672JR8D2wwb2ykJMqS6VGuCLIrGyOLYmoIN2+mNWpsmJ4
         6VaSWee4jieTyuewCvpGEYwpKbY4Rl6SWhkp011Kb4uTLuHMgISdSbyJuK5j6iHMVskc
         a2uBTb6HqXY7BFqAeZVwdjYAfKLfg1CB2hC2AELkvZ7rTk8hUbDx+TOOso3UU6SA7wjr
         9+XQvc/YBWxyc/YFZY4ubyR8dGkZ1NBReP3zmcJap3nAbpyTxRa1bZnP0G6yzbE6iM53
         Po2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794088942; x=1794693742; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhO2GUWTHHGUCCwjPZ0qgnmH/fB5f4KuTQU5G5MnyeE=;
        b=GpZMCX8RCW94nn7GoR9LFVNdWebZ9SaXayR7ju/r4c/MTjkTtdGi4ff6qa8yYvP11+
         DiCgqtBajEKJDi3NGlXPZwMVwgmZkXPMVaKFeZs7JEQM2Lhv9pKBpTn8cwwL3ykUt9lz
         n4YJE3qmiWd10FVcg0KLhzuitFQBSfCTpye2oLdUmPTjBI9qJyYp8rJF4nvpgRWR9Myo
         Buxo/XeFCt6j630g2rK/nqBL6OOKmMhiHgnokedH7W+byTyV5pLq3rpAWxwChyO5nm/v
         S5e2fTGDnx5aXzx3MeJPy4Ka7sIER3Q9rsZLS4cbe1rSZkxDCLeUeulkET5SABSD91RF
         Y/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794088942; x=1794693742;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HhO2GUWTHHGUCCwjPZ0qgnmH/fB5f4KuTQU5G5MnyeE=;
        b=hULFeus6/SqvtRgrb5i+fFAXtzqJfo0j8Lr7Hlzj6CgiMNVa50hvWjyH0axPkSyZb9
         AukCP5sonnh8yJzMDc84aTC9iEm9oV9lKKywBRvbnwrGqOtycUqQDq8EYbqjmLu7QeUZ
         SrOWiOdARZRdMkINZKucLtTng13RiTpqzQD0EhtVNSt/oFy3Rgl4Zo/gbwhY76pRKoB0
         2e2eHc5Z6GidtSeRIzMFXmvy8PHX0wW40qM7sNpRbOrF2B4z7zIEkKJ6r9zjf+JiihM3
         xUAJH4KnAki2Evu/q9a0OQbt70uW66/l6dTmdkUtCYDoXy3PgPwiWghOC5jbRD4GA+4D
         xWkw==
X-Gm-Message-State: APuU4Z90PWEXolYxmL5oD9a/uGjZ36lLbc41olY8xlKznbiRpXhA06gi
	bn4/Op7L2ufESHf2jTzquBi8x/IR9n6AD7GwqsM9hCVazNfFMzrIujo3qZcrRmi3bY4/8QyQbXb
	vrSaAVYIRdMCxkC7Sy6nF8o7mtHxarMCFUs2cy+o2fg==
X-Gm-Gg: AYBFou1EtlvfTa4cDMq0N70zrYh+xV8dEgY1PUhADyaKBvlnIt2+GKV5WDFQa0gkdvJ
	40oTOhjmI7kmwB4FEoHgQnnQGRKHs4R9v8vvQZ+udBomulTIO8aVBu06sTvOJmctdEOvT2FUduQ
	15w1gChvC/x11NYXZBpNFMChWCp+ZnFjFx1V0xu6oagjvF+GbmcTSvNgPRH8lGVhR/Fg+pDUnLK
	kHKA1it3IFoIxSElD5oxLL7pPN1IIGi+K3HcLo39Ma2cDCbE8cUO0pxdbQmx3mthsFPUgjDf5P2
	WlPByy9VVquT7VF6kOYRdwpIsCI2e+LOMregITVcyNcx3seEwbhvrY/OrwAg/OLYP7aTjscxvtr
	bfWfqc/QiNYFPsZRhfevCXEkMJA88u00Mcr54
X-Received: by 2002:a05:6808:17a1:b0:54c:7dc0:649a with SMTP id
 5614622812f47-568143856dcmr52733b6e.32.1794088942150; Sat, 07 Nov 2026
 14:02:22 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Juan_Parrado_Garc=C3=ADa?= <jparrado.1817@gmail.com>
Date: Sat, 7 Nov 2026 23:02:11 +0100
X-Gm-Features: AclHuK-R6JrdxxGntXm8nPodkKTOIjEwqetL6Dmiof2wVz9mQ6GkwDQN12URbrE
Message-ID: <CAFkAFXq-avEh2KP5vdpzK1cxvg9X+5nwc12-5m3NG47Kg7HWcA@mail.gmail.com>
Subject: [PATCH] xpad.c: Add support to Hori Real Arcade Pro 4
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"

Add specific support to Hori Real Arcade Pro 4.

Signed-off-by: Juan Parrado <jparrado1817@gmail.com>

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782..2567ea3bd 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -255,6 +255,7 @@ static const struct xpad_device {
  { 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) Xbox One",
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
  { 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
  { 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai Xbox One",
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+ { 0x0f0d, 0x008c, "Real Arcade Pro 4", 0, XTYPE_XBOX360 },
  { 0x0f0d, 0x00c5, "Hori Fighting Commander ONE",
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
  { 0x0f0d, 0x00dc, "HORIPAD FPS for Nintendo Switch",
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
  { 0x0f0d, 0x0151, "Hori Racing Wheel Overdrive for Xbox Series X",
0, XTYPE_XBOXONE },
