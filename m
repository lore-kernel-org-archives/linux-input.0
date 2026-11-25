Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591293;
	b=yBxKLLNStF2P7MXoD6V9xqCOUW/QLaJzms7RlFZoQ+paxVVbICozRXkLVBadNo8tGEoM
	 0KWp+xPrf615Ds3MnHXHje/7cVGVhUeWgBDaYM53PJNI8QIP2DXsysFrTg3SWhIvSp7ch
	 PSYAZkX10hPgWCmi8KXDyuRol9smV3slUz8+l6VBcEtNNtFsdEDuMGsVjqo/9uc6NtxjR
	 QEOSC1B/ceh76QSxtsMuc5aD3BVBPgr5bcELpeHWETAiPGiUVOQof7zUn7SW744pBK6Gx
	 6Q+Nn//ZunlixrT7HFX4blJFS7jqJebsdiR6Ofx+V2Htqsb5519k9NgCMhBcOH1ty5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=R52vvQCOEP2yQoOtzfmf3tXHj9q6TsgHnskwuN5yzD0=;
	b=Vv2QbDxNv9kaFCmYScUgsxC6F3jBiQuGtWnNXM+Rml9PMYVPTOocgv3kQIMTu6Agfisj
	 73sg/SqkDF7eyJt6+hJx8VCM+Lvs5pYU3SfDxCFkhKR+7W1rt9fzDxir93W4cfcmoEXnH
	 2ZBhjhOlH3BshB/g+k/0wbBB1DTbKPS4uzu/3LO/0EHJt0x+pIxox8Qx0kUdPEQh6LhKP
	 x/s05RQNCPLH4uPjfF8jk8HXq3xmorMoFfJ0eKstYnpo18io7yC406QCtpSeWUfJtKIyB
	 grcDNMmNaLjp5THYGRLT6INcpQvHFoK2pYwebqxMWXhw3TIpISsOGmSRiLtnpvFBWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eiaDeDQN;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A0606A32D
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 07:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 070A0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eiaDeDQN
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3869f03af6aso4666246eec.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 23:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795591292; x=1796196092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R52vvQCOEP2yQoOtzfmf3tXHj9q6TsgHnskwuN5yzD0=;
        b=eiaDeDQNydWTl0/IxwrSYEgDzBFnARAkgYIpTp+9IXivx+g/jLbtg28ZA76BT6bYhJ
         jXBYE5JhoCbJ4+Q/y8EmsQ+cNHb7DkgrfGldmYvwWCMuxszr+qlJj+CyXOmqI2ZtQsB9
         FWIiJ0i6MvEkwqFPMKz7AaM0eNv5W578d7wvtkkSOsGIlKLZkhkzy6IGmLZGsr1/RSMA
         53kvaTFSgCKzl1sjPN4VdJQVmggV4Y5E9HHjUjp4zupC9F8Q88fGVyxiPtq95Q1PAnu/
         c43quDoVWX/nuvZothbKg24ZA5CyBb6yuELKiuatYHrbiQr7hJbKHhRCxhedrxwVK8N6
         CMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795591292; x=1796196092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R52vvQCOEP2yQoOtzfmf3tXHj9q6TsgHnskwuN5yzD0=;
        b=d+M/HbF9vL+OkhhiJ0oSibXnuVozurg6lDOXAykvKcZYdrkrKbSB2H12rkb994nn3n
         +4JrGmcGdw9d2PfMGdoZQeJlYs0cFbB7tgJBJ1DqfiNdLVIoBOZvUAKNdU4N/uYl+c7d
         gYoqdYi2LocdCRfAxMrf3G8ah2czcz9OrHJwITT47r/MZVN1sFvzDs/pWrg1vtw92wlo
         kS2bYwQkN3C67q2iwoQt42zHBdIny6WMn+My8ObgZdIYXbUgB7AKe/ujmkzbW8X+GJmW
         uJQULgcgKUB1iYtg1a6sJgWHZnD1jKvR+NqK6azApE4zozllzroMBmcrS/Zlykd5XZ+c
         N0ZA==
X-Forwarded-Encrypted: i=1; AL+hErHIurvnOqtevKJ1ynUQC+owasjoBRoZ6jX1HyOBVFuuFFS/Gw9R5gzIqgHYvQ2ph1VQN6zU2IgFqcmoqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fkjNfqFvpI4KYbL77rw3vtxqDz7BHVYCaprq6j1XpJLXN33fL
	PF/ZSDEt+z5bKJVtP8zI3ankJS9Sojqm43hvl7aKPCe84lqFR5qIDHbZ
X-Gm-Gg: AZFdTZdOwc47jMndP64+AK6ltQRCkF21FKI+uYtJf2yz2suPpq6h7fVDG7E4J+Q+jYv
	xQ8oXzRMlV9MQcFmNQHkhHRdizWxWPIgw1vlmPv6U2SGxM3prGlgSj9VUs8XDkrbvC0RIFLT5mA
	16LOmhnbVYphQBd7YbqJ575QXrL+ZLaC2QV6JP/DP8NTTM6r0FaFNANcUln+1tTC/Li4+tvXWHA
	dFjISjs5QI49L0CQsshpCDX2ZT+Sw0cXvyALc/xAlVal+GXspY3cZYn9Zik0RyRf56dRWarRNM8
	mGNEGGmUBM1CdaBHHQHYLUXglHDSyCjivy0NXdWph91E4pLLt7PkSRtiBJ04NVXVZWl/ezUmYyt
	A0PE91cbwodS25bwZw1S4ZJRRHPLO4OU4+RqDES53d7y8YY1sVeqaXjrRx6HW3tq7OdM7eY7A1H
	FflXqemmdDTC8cgGKr3gPdNmYkdXK8ivL72p/p/Es5068e7z+Hm5n3PVBZbiNDLiBw0q3ODfajk
	jrcS2eM5Vhu/LHywQujDHfUtG/TTxptBruig+n0ilGvLRo4lPWSgErvQfs43K8W1t3YLsAyM5QG
	P+1I0Q4/kD+a99Nk3tGKD0MVnf0axcl8+hjYd8MKKq/zHJ5W8M7JDpITW7ItmgLy
X-Received: by 2002:a05:693c:8943:20b0:386:af00:e9a6 with SMTP id 5a478bee46e88-386af00eb48mr8612674eec.2.1795591291989;
        Tue, 24 Nov 2026 23:21:31 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm62232352eec.11.2026.11.24.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:21:31 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
X-Google-Original-From: Prasanth R <prasanth.r@lineo.co.jp>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Prasanth R <ragaprasanth@gmail.com>
Subject: [PATCH 0/3] Input: clear the wake IRQ on unbind
Date: Wed, 25 Nov 2026 16:21:21 +0900
Message-Id: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
X-Mailer: git-send-email 2.34.1
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

From: Prasanth R <ragaprasanth@gmail.com>

These drivers set a wake IRQ with dev_pm_set_wake_irq() and never clear
it. After unbind and bind, dev_pm_set_wake_irq() warns "wake irq already
initialized" and returns -EEXIST.

Switch them to the device-managed helpers.

Patch 1 is tested on an i.MX6Q SABRE-SD board by unbinding and binding
the driver through sysfs. The others are compile-tested only (ARM,
clang, W=1).

I used an AI assistant (Claude) to find these and write the changes.

Prasanth R (3):
  Input: snvs_pwrkey - clear the wake IRQ on unbind
  Input: sun4i-lradc-keys - clear the wake IRQ on unbind
  Input: da9063 - clear the wake IRQ on unbind

 drivers/input/keyboard/snvs_pwrkey.c      | 9 +++++++--
 drivers/input/keyboard/sun4i-lradc-keys.c | 2 +-
 drivers/input/misc/da9063_onkey.c         | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.43.0

