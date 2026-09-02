Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D38344D8C
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358927; cv=none; b=uxCITgsA3e3gwjWOnnq1F9pKsgNvCIQc4w2NDS6pHdEpAI16R9th1dM3Tv3mYjQCmSZRRa7hsKNt3nWNNJn+yn689OU6zH0OuZXAb/55NikhcIHlsI0yEXYhM5L3/lhC6UKWLocnP13FSIdrNDPc79yxnLUlX7ut3kIXlM1tTNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358927; c=relaxed/simple;
	bh=Am8EvF/POWisDx1/UjCIYbNZdPpH61Yb8zEeWbsnVRI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9eA6AeRTvmxmFmXB3p44rUYikfjmjMeTpc8v6aGz8D9R/2iQX56kD38BS9GbNwpgvy2ojiMNyQS4VgCVfPMu5dsirojmRLOrxh7UWFXk9kF47NVaKpryXijo8kRoqDfbd0kmF5E0HVrZfVpTYJZ95T+bD6bkSV1lRRw3pqUcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=W9b2fb1K; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="W9b2fb1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788358918;
	bh=Am8EvF/POWisDx1/UjCIYbNZdPpH61Yb8zEeWbsnVRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9b2fb1KUmQyi6R1oszVrhgtHfvmHKJe6SZk4yZ8+9wDvHsyEq90HwgsrdM9IbvkA
	 EANWVwf5N+/9SsbegOUthKchvZhy7PUGD9w0w99eQkclldaK3Sb6Dr7XgXkmm6HGT6
	 53EzvIUsUtruAk1vRDMyhyMb8uridqSoxhVzACFc=
Received: from ArchLinux ([183.229.155.44])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 52B1309E; Wed, 02 Sep 2026 22:20:43 +0800
X-QQ-mid: xmsmtpt1788358843t2jj7cwnf
Message-ID: <tencent_7AEDCAB585C685F6D529E36C2D23CEAA4F09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G6rMQC/bOIyOWYUTNeoRDR8J2Af5OeBamVl1e95nrHJ5eAU6fFB
	 sWzpZQCcbmeP7Zanagd1LlJPOSOLsCRK3PSRRbVZiLwhGgBy8kn+maTsAqOl2i+JWfptq5fyOL0x
	 Hpnv6zgQE8/3htEEqI23KpzquK3APgDylyQZxveF40coJ8x00qRqpB4BhEASVG7Yr4zTlXvyRd8z
	 rcU05XBPQVgJkTedHn5qT4XM4gBumjv19vEj+m3Y3iS3A5DikmJ/8wrgBoHGuKD3go/iyWg7X2ss
	 oJNHUfY6gvBTFEFaCyn2MFXNyi2CyzZTLS0RfsUiSwWUzdtWbONmS+I5BLw49KPk14RscXev7HiE
	 Mu88TtgIU1Z5MGXMzVSdLm+SWkSRX6Y8gC82PhtATvbQ+nmadUsWrAwaroWxcDYEzd3WW1W91dtn
	 lIdGB7yQLA7GQ559kJAF4LYm8kZ1WWrBch07rlaW1HVh4wH+DuwDELw9zvR9eH5Ofq/FdS69yKnD
	 cTgZ7fyoRx2lmZ0q2WU8RxvGZCxeuccg5E0kBJDef7SKNALgKWZs6i/VN6lLmb4PJJM/86MK366E
	 c57p5qH4IG71cACh/8fhmHTxdUGlgG5mkuGRXdJCTUN99EC3PFnATeio1Z/iI/v16du5mMmKvclh
	 hCnmlipcfxwgIMc9kJz6v/91AR28YxIUy7uBjfT7EthFMvtqPnQapfdSqcBaX2WP4NSjy+NiEr+2
	 NnwG1BpWWB/bTq8ou/IDdKhL3WzfQOg5bDyB9qJSJyp5nDcqAWvSHcKvLddhogBnzXpxg0USlzU7
	 o1QGwREH/+TQHx1WmzX87soAT3vU5d3ZlYY4oYU+x4XfIAVgZnELwtKDqL+Z41Gmp4TLkREHqRBV
	 6YsW67GG7uvL66xOlDmCEJYFlE/KG51hWN5TE521ErIelyth7XFU+sgMoiaVRkhDClBn/Ud1WBgP
	 a4PwXP/eN+sgxbHdeznsgFpWWnJ95GukOAQ+K6TGpj+hdiIz4plXfp+otvCb6Q6zRI/9ouXZhz+O
	 pV+0bVRG/h88fkA0/53hkyEk7VgwPtCxKtHm5vvM7j8JJIt9ynmHPtBGXIunBGwHDKGoo6jil2Xu
	 UEWwB3zYxfRwvZlwRaIi5q0ZIQVNYBEanaweY2
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Tao juncheng <mono268@foxmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Tao juncheng <mono268@foxmail.com>
Subject: Re: [PATCH] Input: atkbd - skip deactivate for HONOR NWB-G's internal keyboard
Date: Wed,  2 Sep 2026 22:20:40 +0800
X-OQ-MSGID: <20260902142041.6238-1-mono268@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901140336.10568-1-tjc1437@gmail.com>
References: <20260901140336.10568-1-tjc1437@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the extra message — just updating my contact address. My
previous address tjc1437@gmail.com is no longer usable (the Gmail
account was suspended by Google's automated risk control; unrelated to
this patch). Please reach me at mono268@foxmail.com for any follow-up.
Thanks.

Tao juncheng

