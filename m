Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC90409112;
	Wed,  3 Jun 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472967; cv=none; b=kYzW2I6qhp7USG3d3ZuBpcHee08FvVLKOjDIFUpvYcuaoQCik/omAmEpUeozWk/2EqMyaoXhK42OmeFnPaqboK9QiBBSxIvN/KBjXwvrJjVjox8/8bsQs66AMBFnS+KQ0bQO04jvJKeV+fJKthpDE6Qhr64Sc2ZBvdxKMRT+Z60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472967; c=relaxed/simple;
	bh=2XkSI1X4dYhXLnRwF4U3+pImviP3QkV76SJOD7OFVVk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mh3FHINLVdIJ74fxiIxj6RqhYv5EQbfEv0ZvfLveyAPR5wdi2egv+Y/ivvsmaeiyJ8366Lf3qbZmZQ+Pr3sewtk5zb6BqSBn9vO5XrinnoyRLwEJr9pnH/8Zmy8WFi4T+2J4HGe+JS+A5W2G718iCm4jxIdXxe3DtSyqHlzcwYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Fg3P3Zd7; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Fg3P3Zd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780472956; bh=9autlALe7NVfJxAgshuF1mqiE6uuG/c1nkPNnxF59Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fg3P3Zd7va9GZ5Nkdz14VYHqvBtmigpQsoJ/QQlJ0xvGxaGXQr9UdVXLZudTNOFUj
	 MQHMuppE8vxGBO9nNO6VNZpq+jboonwYD7He7AO6rM/pTgO44h1tsNxA60MEF7tT7b
	 Rv0W6d4apI9mMOLcujVg9Wq27M64W4bWI3Ld3Tm0=
Received: from ASUS.localdomain ([113.65.236.26])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BDF9EE4C; Wed, 03 Jun 2026 15:47:31 +0800
X-QQ-mid: xmsmtpt1780472936tnvbxyvhq
Message-ID: <tencent_58979D4AAAB2237B7CFCA5445D81B687E207@qq.com>
X-QQ-XMAILINFO: MhLcXbI0hPoHn+saUR8Oh6jJc1Nr8ncoVHJNLjZ0pn/17YYtZEdB50j9TguPb/
	 tsJqJQePORK6ASNbwDFA0BVizqXSOW1/EcWfzuRQzoJRXlOcbQZJ0FsiMpSxna8jWsnBAc5VMeba
	 1rZO3z8nqi/VjihtHxW3lyXd3Ws8KWGoD5DWm7JVgudbHhwOO/sTtAlyEbfLW5awZL3jX2iUiakn
	 VXFfLQ//L4q2tNqkSJA8LQX//Pha4OOxWUBQpsjlBgumnk5r1iZz4nAjhEnXgovwlHpJNccNKefm
	 dn2+NQY45hcXKSul6xt+lNn+XIxBvA9thFVBiGgA4Dn56Vd7T4om0UNwbOivoHrLt0J9zCUrg20x
	 AjR39CzTOAHcwwS5aKC3fQB4J963xd9w11RYspe6zyyqURY7EjgojyqdZFWNCf144g11aNx/RQ5n
	 LJpuMi7TLR7XlGxKfbJhKe3f/rBsCzwp4mmMkLyD7KSB9OWzTTZqbDqPNa9yPhNh4ko9C401NGJT
	 kWh+zesmY2jzTGLP3fPOJ3Xa8gR3vsQc1biJ/RMOukcN6JCtL5jMNyhgTns9zP+FXOpgLA7CVtOh
	 6mEFOA8Y7eNv1Da+Smp37aH4g5lxxve/QRf6PyHWuGTGJRK/eGS+sj1wQ2utr4MBZAKrBvIQwbr/
	 k3UTM27YiPmaR1cSGvGCZShis17V0XQ9xdOpaltjK3bGKOqoVLOLgZYP0VQPrCnslx0AdmYw4ud1
	 ZbRXAHgLm+OK1ZVXSEQVmFvLssRPkSsMvzj79lUC29pQ3ESGrVpmQd+DT2jz83+JhDIRQZlQ0Iee
	 Cpo9v+GJG5JB2Wa/1o1f3UvIlwLXD+ZpsblFqXfXrWoXoNL+AGt3j1Dio0aHBmy4Jh0Z6L7vGCHX
	 QCK1tUX1GT+nfsTomFYthZGc4fUEulj9WffAROyMIBmlWK9WoJNyb9R5Z1zXf5r+KX2CrKK1uaVD
	 dlFGFln0hKU6l5taovDu9ntVEMBKqu0scZ/vu3ak1xw+UwH1ouFvUC/LMkVFz6NbvNnXGGYYCoSZ
	 U2TiYVQS9Q6yEz5VK0BSJfHT8XB9z0xgi92qvCx4vvwDEhj93yJXA43dQlYiptebARN0EU9RX31H
	 zbcEiL3zf3IpJ8iP7aX8cvPuN+AwhoSfN0wYUa
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Steven Feng <steven@joint-cloud.com>
To: wens@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH v4 2/2] Input: axp20x-pek - add support for AXP313A variant
Date: Wed,  3 Jun 2026 15:47:27 +0800
X-OQ-MSGID: <20260603074727.613319-3-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603074727.613319-1-steven@joint-cloud.com>
References: <CAGb2v64PLZn+VD9LdxOQxHC0FUJ=5fMrpwEyJEJHkZnUZkHRRw@mail.gmail.com>
 <20260603074727.613319-1-steven@joint-cloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power button support for the AXP313A PMIC. The AXP313A does not
have the PEK_KEY register (0x36) used to configure startup and shutdown
timings, unlike AXP20X and AXP221.

Create a dedicated axp313a_info configuration with NULL time tables.
The sysfs attributes for startup/shutdown timing are automatically
hidden by the is_visible callback added in the previous patch.

Signed-off-by: Steven Feng <steven@joint-cloud.com>
---
 drivers/input/misc/axp20x-pek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index c1a4e5ea1e00..964b39817af9 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -85,6 +85,13 @@ static const struct axp20x_info axp221_info = {
 	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static const struct axp20x_info axp313a_info = {
+	.startup_time = NULL,
+	.startup_mask = 0,
+	.shutdown_time = NULL,
+	.shutdown_mask = 0,
+};
+
 static ssize_t axp20x_show_attr(struct device *dev,
 				const struct axp20x_time *time,
 				unsigned int mask, char *buf)
@@ -414,6 +421,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp313a_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.43.0

