Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAF1DF261
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707860; cv=none; b=VKVDXlo8fmrqOktZb/fn4v3BVvrrbej91px+T7GT7zHMeTm7gOQ4M3192a4Se8xhB5pNPitzWy9VfJlaxzw0RlVJJAGJdZsH8i+W2YnbvOakmWuBepKiOAdEcR0RwOylRhpQvmMtCU39SOImPy0tl+s/DlQzEd+VnWzg/DTY7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707860; c=relaxed/simple;
	bh=FAOolMCkINrC3lTjV1XO/oOYFDvOm0h61dGOFddLmK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eW4WzENC0D6Oe+PCc89smttMr1ENalsT07moFJ3GwIhDzINbVchnVwQomh1uaPHABvu7WYZhI63zjIgBPhDsgzKv92SzuDfZKCZoORmz5jEeP+Rvh6i2X8GKZfSBwskRRs8ZSvDfN6woY5aDWQkLHsAQH83LqP3YG1GvehxOyIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPcqT2XE; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPcqT2XE"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-141395927feso1748766c88.0
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791707857; x=1792312657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBHjRRmvdKma54nJSNqg7NX8dKE06rBjHStPBqfNhw8=;
        b=SPcqT2XEljhU7MK0YL/Y8Rba4DQUsjA9ERBEzhESsyVzBkNTnDpy69xRbZkgTfCbo4
         vvFct1Fi94v6apwWwU768XdKrvgWTBOPkgTfTpXv9mJD8laLQEDCepo773gzOspM2eKu
         vnww4m8g5ETALVlLEp/FCVH9Jab1VEKBFPj9NT5fCsUbmeeuko1AK7IbL1q/Hdp0hJOl
         Bf77NRhX08Guj0D1PcGyEtAcERDxgUWakFDLx5jaVHGTW3vpvgh7UlQOTSsuR9Rr9qfj
         /m6j+/eO86M2Bh0VN7HajZMiCM/FMOfvj1J5SSnU9TaW7SmiRXnAkzTe1Y+d1/RXb71U
         FYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791707857; x=1792312657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBHjRRmvdKma54nJSNqg7NX8dKE06rBjHStPBqfNhw8=;
        b=djeqnrVy+kgcV4ApKkmwrW68PxpSKTxJCYoRMxZT2agCGwfFsVZ7Sq4btAqBG1MDT3
         mndJFbmQ2GYgBiVKr2EwMocwjIJ6yWfG2o0TlAA1Np78d8LrHAHbnehpoloHoRDiqih5
         HwvcZRSGmFcHU0BNP4QamwrgnN9dEmZUyHe2FbnGDVMim0GzX0ooGKy7QfRZ8Vrf+pyt
         N8dP+Bc8jeoPGQVq7WC2tp8UAJTw2DlzrxWBOXIbO2n/oGy7derkCYmz4+MGhKSoxz52
         ut/pLHIwcpLk5PZ412UrfUrDI9rlvMB4l1UqxxNNrG388x622ZPuCki0xmMqwurr0FlV
         ScTQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8hOZJB6jdWoG+O/UwuwsPkWbtRL4X42nbOhgo1lhdzBA8G0VwrRP9hIBab0BnI9zckJA7tmgesZeGXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJMJHwosB3hZ/fajNpYjygdPiSe1wQ/YNM+eILnXZcZ4J623RzU
	eVqn+9seDxJDGtD+Wh2bhS3htGlK8Xtt6/5db9mtthOFPNiOMG6b2DYs
X-Gm-Gg: AYBFou21D8fAIP0lZl36zjVcb4ec4lnOLwTFQXPGSPT989qFr70R4vwXG5CE1S3kZgP
	1efppA1t0/elOuEFAg+3zhNCmwB4qann3QA/8GZvZgl7sGuvwpIWzt1o4xCCuW63bVPTU3t8eJX
	9TO5POXyfKvxoqNHAHjvQgC4cOWMXSBfnPYz7cGzMSH1j/o+Tk8f37gxPoPNUtH680Vf4lkIA7y
	OVPGm4bWP4aQwrhn8EZpDLxcmfv7EX7sYliV/L5QUp1JM2V5TdcUo/0QWB2rUekesLFxKJgE2fZ
	XammcraXOoFJZmg+LW2Vxjfa1FRe4MBVAhgDy2wp06stfBVbeICLbqqzFgIWw9u0dcVRkAFGsU/
	ASN38dMEmV6RIe7LjqKo8i2HibQ5Tg9hpe+b9dgZEZSNuQjMYVYLAvm+CFKyfXOSvMpTuCHEi43
	et10vj42khzMNGf1Oe/ktmveXJ8H1d8JIJmUcBuY6/XADWdl8E6qsJKX4Sxm7gHNevJbEtF8YIl
	0r4O68J0QsI0AkqtfR9yT7MfcfgFcGwOngg2ZihExvGj0S2kOOYOTL+2TFMYZwYX0MHc7NXdCUQ
	uIfL2A==
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id a92af1059eb24-16a5ef28a5bmr8084789c88.22.1791707857215;
        Sun, 11 Oct 2026 01:37:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a42407e7sm20186473c88.15.2026.10.11.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:37:36 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 0/2] Input: synaptics-rmi4 - fix two device-controlled out-of-bounds writes
Date: Sun, 11 Oct 2026 16:37:26 +0800
Message-ID: <20261011083730.223083-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for out-of-bounds writes in the RMI4 core that a device can
trigger through its Page Description Table.

1/2 rejects functions declaring 7 interrupt sources, a value the RMI4
specification reserves; the driver otherwise writes past fn->irq[].

2/2 rejects a PDT whose interrupt counts grow between the counting scan
and the function-creating scan; the driver otherwise sets bits past the
end of fn->irq_mask[].

Changes in v5:
 - 1/2: keep RMI_FN_MAX_IRQS at 6 and reject a count of 7 in
   rmi_scan_pdt_page(), after the RMI4_END_OF_PDT() check, instead of
   growing irq[] (Dmitry).  New subject.
 - 2/2: unchanged.

v4: https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Wei Jie Law (2):
  Input: synaptics-rmi4 - reject functions with more than 6 interrupt
    sources
  Input: synaptics-rmi4 - reject a PDT that grows between scans

 drivers/input/rmi4/rmi_driver.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

-- 
2.43.0

