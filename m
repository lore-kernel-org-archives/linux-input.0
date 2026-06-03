Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878728F948
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482209; cv=none; b=ESmELzRkSh+jeAhKelGEW2EtVnqeWBSBHUp4YeFZhejrjFw0/cEfBanwU/7Eah0CHz/ymaa9qH8WKe1GI9kQ6UE2U3977XqJaUmg7dm+TczmM/KMBEx5f0TdmlN1OgzAL3OzxgSGqGcpK6M8KYTi+aAZFcP0lbxmh5/MabmjN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482209; c=relaxed/simple;
	bh=MNGidtN6elm6k0eV9biEPfebyZhABRCVKjykBULSUpA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkQ7RiMp5ttyoDrublx2AKnaJa8pBIlm3DTKeCrj3knJjGaKYcu2a6o7j8ixjTKQCZ2DMueuN2Hha+JQTRrvolBg66XF59h+ja4/DOQzY/yn+MnO/3LTXpDRcXYqgpqT6HalSVMAFsuBWHd6Gp6VhErCl/CGn3BqSeYgcdea9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JYZ2LiBp; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JYZ2LiBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780482202; bh=gk7Fsvq4o1q6QrEqDRh5emeeV/8a6nKM0fS/cy7x2B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYZ2LiBpaDC5YpWSpfVvQGngymmGnTfglI+bSa67JIuyNK2JVBca965jvHjOjVZ8O
	 rksIY8Axbs7BijqEkQ/s1Ad9OPHD4QmFlhdmzG/kq2RFizTaJA8d1Jki51E56hVE+N
	 lNLV2YodGn0n9NF34iQyD/klUWW608P0sDf0ZGq4=
Received: from mail.red54.com ([139.99.8.57])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5C23E0A6; Wed, 03 Jun 2026 18:23:02 +0800
X-QQ-mid: xmsmtpt1780482182tkwj9x3uc
Message-ID: <tencent_BD16038B68D97B46AC5BFFBE9FD5DB3B7E09@qq.com>
X-QQ-XMAILINFO: MGIHRVWp0RD3EpbhU96g+YOBSgqf3TMDgComepAWJ6o97mdihNOxVrAlR46Aak
	 gykVf3NsLf3vxiB5396IlT47MUC0Ux0UYj34do9Z0renxmNt4qDsfK/cH9g5OxTxOVgryAgcwshp
	 ywlEc2QDzLQDWHs9PmPI1bs3JeQb3//kN79L7tYB0unSFed5mI8jDL/S13Xa9syFkBZ3IetCiGlT
	 DjbIqrD6lHDptOLWB3BAmU8jloXU7lDTEo3HE2u5/fz98JUp/EWXdPqL+SP8sj7XMK+h5I/WPG6o
	 hqRpi1gce7PYC1DRpLEVZgKEnSqfpMekR9DP9HBc0Uq/bmXyp9bwKv3mPPe1PO1l/oTl9UCDxk65
	 7wpynOMk/fqpnr5sQeScdHj9p9HNwm835pnzDkOPHAzbwL4eUlHln1hek87lZPZ94SlGCNvZ8YDj
	 M+pqBLGRKPWxXpxpJjB2grGglWJxnVWIIOp3+O0yyLhXoAo0a6mrybph9htzbKie/MOBxSAFB+IZ
	 rITuqyFEaxlv+mNdKLekyMeRcVc8tF2Zl4Qna7Ayoe+r7jqYvhX54f/t4Z4So478sUspIZ1VHzeN
	 RiH9hbPvPjoAhl46MRNsVWrf1qsJWAvcKsQZ5lSdcrtYnJziplYamN2fxZO9ctgviuB/Vx34TyOS
	 IV8/sfMhk1VJrIAyNLeiwdbMbk7tdTawCVBx/Y6FS9SKa5mgHPkh+I4YIFRhVfJjiMWKvRvXqion
	 9YSHK0m+QJyia+bPpO8T9hWUlF0WZ4tXiZv+K89knOfFDA2ypDnGulRt1qV4W1ro02cpx3TWATF4
	 eVu8kuQMeYJ2eDU+sD5mMtkCI6HzRYWFwK0j1JautZoizShZ2Su1DO4d7c5R8cj+Wy6uQ34lOtQr
	 6ODLacoY6zHkeCOxbKbfQBCKeNcaA0eT9WFjtdyTa2VcupNZuKJBnSBLzbswwWQiRcRmgIAOzv2p
	 YJj7i6B5RiHZRASE+GlBlm83ZaxLgDVweMn4dm8dowR0B06xCc3ho7oIloFwS2pEFHJ5csNKEVuM
	 Q6Nz9sOI1d6XMFsTZ4Hd34O9osWOTkoKKEeyRwPuHVI/awp/vwcLE5cvi8+gEstsqATTQr6LlxL5
	 aHzNNd/M8i1kdMrGGWC6sLD/jIgbBaShY1Fvg5Wa5c11aG5OA=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com,
	sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] HID: i2c-hid: Fix some PRP0001 touchpads probe after OF/ACPI split
Date: Wed,  3 Jun 2026 10:22:36 +0000
X-OQ-MSGID: <20260603102239.26491-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601184747.843DB1F00893@smtp.kernel.org>
References: <20260601184747.843DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before commit b33752c30023 ("HID: i2c-hid: Reorganize so ACPI and OF are
separate modules"), the unified i2c-hid driver handled both PNP0C50 ACPI
devices and hid-over-i2c OF devices. After the split, devices with _HID
"PRP0001" and _DSD compatible "hid-over-i2c" are only probed by
i2c_hid_of, which requires "hid-descr-addr" in the _DSD. Some devices,
for example the Lenovo KaiTian N60d and Inspur CP300L3, provide the HID
descriptor address only through the _DSM method and thus fail to probe.

Patch 1 moves the blacklist check so the function can return early
without wasting an allocation.

Patch 2 moves the _DSM call that gets the HID descriptor address from
i2c-hid-acpi.c to a shared helper in i2c-hid-core.c so both
i2c-hid-acpi.c and i2c-hid-of.c can use it.

Patch 3 calls the common helper as a fallback when "hid-descr-addr" is
missing, and sets safe post-power-on and post-reset-deassert delays.

谢致邦 (XIE Zhibang) (3):
  HID: i2c-hid-acpi: Move blacklist check to probe() before
    devm_kzalloc()
  HID: i2c-hid: Move common ACPI _DSM helper into core
  HID: i2c-hid-of: Fall back to ACPI _DSM when hid-descr-addr is missing

 drivers/hid/i2c-hid/i2c-hid-acpi.c | 41 +++++++-----------------------
 drivers/hid/i2c-hid/i2c-hid-core.c | 35 +++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of.c   | 38 +++++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h      | 11 ++++++++
 4 files changed, 93 insertions(+), 32 deletions(-)

-- 
2.43.0

