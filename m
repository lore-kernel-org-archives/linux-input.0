Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15D4E234D
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562536; cv=none; b=enpHgfIn+gPuhNZ1XIwnkmHSspMxoq055ANNLLq+GY6HTWJTMV9El9IpkqjY9C1djzcEhrN5UJ7qmm5NQFv6jtdtGUkjFpIr1PkirCeeMrE8iVo5CO3QrF1gHrlNoj73sR7Z9xb+K8K5L3l0fPA1GMVhMVAdvsz65TX9vIdfZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562536; c=relaxed/simple;
	bh=fkCGVwmKIpjHe694X+0ebN6/UjIIXO236sQO1cY9Hv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QeIEkLO+fVS6aL9A3Kk5OoCsERG5aoVSYuEo9/D2CHCjKhmTog/opnAtT4h8ymSTeAgxlRIk8FYCWRuXi9AONW1ux0qgriZww/6gXkIwSXlMxNKPXY4U1F82Pvke3JqRZbdo4/lXfION/VZlVI1VLCZiqe1H5VI0lEvqAVbB3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORvZ2Y9g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORvZ2Y9g"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso67345e9.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562533; x=1792167333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fkCGVwmKIpjHe694X+0ebN6/UjIIXO236sQO1cY9Hv8=;
        b=ORvZ2Y9gZn3XtoxgNoA1qjW7qlYxFh8ui4oSn2cUv99MzMxgw7s4prvjLpB2dU6gzp
         6YZCqIzGFU+qVOY+2G5umJqw1g4fTVXY16V22cA7SPePDMrdDuPUWROAPnfC99awIlj0
         kfO1yLU3tvcwtwCXk89SIKlNO2qg99x2N2z5V2Vv9UPEZSLMbcfBcA6pyxVnYR7d1jFA
         da0Qqz9iQnxSaTrK/k+Eq+1VdwqQwY4fce/uEY8A8fYVtO/wv22TDv937awZekij4QEf
         z2gAS9E0+TMHHyJXXs/pix3WxGUqZTfcCgYat4J/s6zHqfNNUPzCLA8713Hvf3mqwStX
         NfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562533; x=1792167333;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fkCGVwmKIpjHe694X+0ebN6/UjIIXO236sQO1cY9Hv8=;
        b=lmgLKOKe2Zmb7DWxgnE2i0qm8KxNxRdZoJe6W0UCjCxa8n4cDQyUPWIzvxzFjYlofV
         VQQ+jLmnoLtsymOn/pRw/hMMe5e/0MykjItimrRJms0dxXc4/DQAWGyGsqLlHnw3aByY
         EKl28wd+/7nfuUxZYKCy6G8jL/ZT8EF4oClAziNq3vAY/38t8ajMFFUYePCKgmhfwKB5
         4n1VJSEC8wh1HVaSjnw6hsADxpdOhA4L2MhW1rNDqrKOw+/+2mB0pEW9BoTSfbNq9efA
         KkBRFmiwKBYFfDrRtezlJJPEmAENjUwtpoPh4a49G/7dTGY41rxUuWD83jWtPoVLMBzy
         g0Fg==
X-Gm-Message-State: AFuF++misIaWzmWNMj0fKe7qJrtK93Uski39VKnXqDUPuwmWtgbEaT3I
	YD6wS0bbldtiPgzyU3eM8JXdJtd7haKSwtoc0o7vzlHmj7SAn10Y1hgjUPQTuW65
X-Gm-Gg: AYBFou0cgOjkeTRTUxkuLmh0Y6Pa08XBUubiZ9HycfD2hr696W1OwcNG6xC/NEBlmG/
	VSkBXQfr3nxhj+iCBcAq8FnGrtgKpQvqV3OaHxA8z365jA3OP/BI/4EEJ+bMEL5PJsagDPnoQw7
	KoWUYTvNYWZwdBEtUxBbPKNZLqZ+quLg+lvwdk5EDLMjaBEV1+yOAN9XK4c4RaNf8JyXCW0oGyB
	wnBwtPFBvkfH1dQ0zjXdPLEJpnxzqKVhsW9wK8G2A5nP7Oq0/xHhxMg/Q6vMqUWXZxmwryGyqhi
	rmhYNIqK0pBz+H79mGEsv8nztTjc3GnwjWFPRwisd4BWTRg43Nfuc6cviWQ2mjeXNrciJVVlLju
	QX0F00GsmZeUi/RKbJREugD23fTdKtdD6n9Wv6ZpATEvWDeKmlzi7cPHp3ENkYtcLCrSvhGCnNf
	Tico82aiPcdi+dA+F0fa5Fd0xbBPqhsf4+y+UV3Uufk7FR00ohf/Rn2DCgLmSZIFBREV/OUvA1c
	2O7FOQ7V2ITSDxcjJs4s+Olx2+fbBJ0o0DHFDzAC/pY+pkFQZDAcEMO2eK0IuHJRQ==
X-Received: by 2002:a05:600c:e557:10b0:4a1:8efb:c9ae with SMTP id 5b1f17b1804b1-4a18efbcae9mr28358095e9.23.1791562532539;
        Fri, 09 Oct 2026 09:15:32 -0700 (PDT)
Received: from localhost (185.64.3.89.rev.sfr.net. [89.3.64.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dba1be42esm4909273f8f.5.2026.10.09.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:15:31 -0700 (PDT)
Date: Fri, 09 Oct 2026 18:15:30 +0200
From: Jerome Tollet <jerome.tollet@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, lains@riseup.net
Subject: [RFC] Radio diagnostics for USB wireless receivers
Message-ID: <cu0019-rfc-f29e990c-f139-45e7-af04-5f01ac2f4ca8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Would common radio diagnostics be useful for USB receivers with
firmware-managed wireless links, such as those used by mice, keyboards
and headsets?

The motivation is troubleshooting reception issues, including suspected
interference from nearby USB 3 equipment.

I have an experimental Logitech C-U0019 module exposing a raw RSSI
candidate through debugfs, without replacing hid-generic:

https://github.com/jtollet/logitech-cu0019-radio

A common kernel interface could provide consistent access to supported
radio metrics, without each application implementing receiver-specific
protocols. Would this justify kernel support, or would a shared userspace
API be preferable?

Are there existing discussions or conventions to follow?

Thanks,
Jerome
