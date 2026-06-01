Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBF43E867A;
	Mon,  1 Jun 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337752; cv=none; b=h76vxKyCYKk1PcJGUdUxFUojyi00/L2xbP1iRzGWIlZkNKQLAouSVTVlcTGZJo5pBf9mLRQpv56hNySzPAIYEWjAsD7etC5XIgvq8grQUEaZablL4faTH6hrgGu3ruylEpq5+SD3FwHJQW1rLCTj/PiD8inoLhW926mRm5bNqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337752; c=relaxed/simple;
	bh=pJ6XoF3GWDQXLnZoUmIFvoH5X4NBpzbiqsFDi7xEdDs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKFNr3DdT7UXmqwvjogXlosdWlf+lI6mguIb0/4Oiu+3ABVex/xw7Q1OpId4LrR9O5HJpDCYhyItjs2SXow3e6bsDfovcF7z49K4lJoov73YG9a42iQTm+BbplXKsW+jYPOwnlMevhhhOSJuSkTWwpLUlKeBiFfkWUYmfC6DS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l78OUSHF; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l78OUSHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780337736; bh=3AnkvTJMGd40bjWvK6skG9Ztodb9tC1Tx3c1XPbNnEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l78OUSHFZiNp3yFmsUC9jTrTOllRAw8a77DSM4QT+LIGvS9NEBxNt7oSnPM1x9Mwn
	 QGxjsTIQoDMHnZI5YsffxR5xaUuaZ3neu0uDvzNc2ph1q5H97LIlknQaGFI+Qz7ov+
	 bY2/vbpl4b/gJi8RqkkRHHjL1NN3mC6dtbfP8hbg=
Received: from mail.red54.com ([103.253.24.18])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 3D41C48B; Tue, 02 Jun 2026 02:15:20 +0800
X-QQ-mid: xmsmtpt1780337720t097og6kb
Message-ID: <tencent_77D9F3497BDBCF4FE01AED4D8F9B75C49F06@qq.com>
X-QQ-XMAILINFO: Nh+XzM4m2f2HXGSPvVH4rrnm7TUzeJex6wS99bBXhxBBXA20YQCrDzE/r8Il0I
	 wvNt0vFSfmKQ/iz3Oo8gCDd+t1qSoM0CPNj5toGZdE11IIEoj34BtAo3Lls98IwEZK+rc+jCMsMb
	 LdY5CJxvs7rcxS18fVadrk5KtHvSEjtFwgGEtfIVWYvUv16PwMA+UH6z2I4dUZ8qJcOmjOA4oVr+
	 Iu+Zl/wtXcRGmE8MGeFcEU2AEBc7zrOoVuYC/oFiwYu7vA6HgeyhlsyPyZtxsu7XZDAfYSl5X66s
	 GrLuqA9rSdgppigIIJx9gjTY47usO6YvgJ7NaJBtWRLgxHhmZtM24CGKy6oJ87wg/YKmh3qCzmVT
	 6SLwm+P23HTLhkrdNS5h6jZ7P25kJz2YUao6WhwkLdjxXU6JiUUp42XqBIebAiJZlVJbJNwNqo9u
	 rzs67nsq12OfeukkaEStLIqmY0dngVNfurbqtBH42gUPj+3CFgo8El67zkIK6KWSt//Efbo1CJY7
	 9/BFJxya5I6crG65iG3Lo9gddOhTq7JAfvlxtUpKk2hT6s+ahBkya1gSzN1agI1qkKO/5Wb6rcJd
	 f3zdDegGin8MrNVui2dGDGKELH47UFJSsV9M3cYDlkBvq/0v+W+LiPL8F8KJ2iPVpSZLwtu9YhKt
	 7MCK4i5bb587ISRakz2GQEoho2jGlcd5HYTemPaUiw+yHRnur+S8X8uvmTNlGOzrfgHngmhudPZd
	 jktqssMd5e8WAntN36g77qDwFpOscQKVeFy01MTNmZsR5ZxtFAMiAyLmFz8lxPHZsxPxqSXsGdh6
	 2mn6TnGyUkb0DW5mZe/EA7g8oAtQeKxyDSJj8khHJ1ZPdTLORGp9ub7oSFFQWqHkGk/dzf+rusI7
	 MhsMvnM7APN559MsI8elWROxr8S6u+SKQZ5zKsuAPCas1QQYij49rmnnKrQ3GGDwKmvvkp6HYjY4
	 aVUNySr5lUao5BCpB1I4AGKn7gx6JyrqPGx7MORbw8crln7dfVDq9JFEH8V6V37p7Ovmg5bOfTh8
	 ID4PxzENQBHLKPYHJzVfO6iR8vCXVEziX6CY0t1qZNM/z3LphZFOlEoRkmG7Ye+7wM1aFpxqqEfz
	 Tco86s4tTR22nnaoB5NG24sC0u1lRbQC7uabOWOqDleMv7mbAuDoUIAIHbKJ6+aeSP4gha77wvLG
	 ncTHZ4hibtkWjdbDNP4zVe5J1L
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
Sender: yeking@red54.com
From: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>
To: linux-input@vger.kernel.org,
	hansg@kernel.org,
	dmitry.torokhov@gmail.com
Cc: Yeking@red54.com,
	bentiss@kernel.org,
	dianders@chromium.org,
	jikos@kernel.org,
	linux-kernel@vger.kernel.org,
	superm1@kernel.org,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Xu Rao <raoxu@uniontech.com>,
	Kwok Kin Ming <kenkinming2002@gmail.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 0/3] HID: i2c-hid: Fix some PRP0001 touchpads probe after OF/ACPI split
Date: Mon,  1 Jun 2026 18:15:07 +0000
X-OQ-MSGID: <20260601181510.38705-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahnqMMhD8jn51ch7@google.com>
References: <ahnqMMhD8jn51ch7@google.com>
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
 drivers/hid/i2c-hid/i2c-hid-of.c   | 30 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h      | 11 ++++++++
 4 files changed, 85 insertions(+), 32 deletions(-)

-- 
2.54.0

