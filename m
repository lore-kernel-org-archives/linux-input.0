Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D5387344;
	Tue, 24 Mar 2026 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774319398; cv=none; b=PmaAWYfUGHxjbyqUTl0E5T8PVGvzifPQglvx2t9VIp+LpKNKv+2T/8LKydMmF/InNpUfTL+W27Lqo+V38eWXspluzWId2VI7dYaR6RkmN3qXMmPKKdAwPQN92LQSzbbNDSios10+5PstvOVwhGWea+2F6XToX2pG29PD8VH0vnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774319398; c=relaxed/simple;
	bh=1CCpNs0NDckno4Kr2P6+CXNRXXrb48B4RlXN54UYXX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be4Lj7HtqYl7kRHG47sxvJCwsaeJ6IaoCQusptc+FCtfdClr7fOksIvSSbJDRMPnz5P4BOeq9qKjJLFQUnPL0zYkFUhTcMhrq6HXj2cBMLRq0YIUlZjLMmzDVyw9ANys2S+tsmYmDeN4Ft+RspRuwDdfqrSk609H8mZqAJGKH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAAnvA8e98FpkZVKCw--.57708S2;
	Tue, 24 Mar 2026 10:29:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: andy@kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	andriy.shevchenko@intel.com,
	hansg@kernel.org,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: penmount: bound packet buffer indices in IRQ path
Date: Tue, 24 Mar 2026 10:29:50 +0800
Message-ID: <20260324022950.456-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnvA8e98FpkZVKCw--.57708S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4kJr13Xr45Ar4UWrWfXwb_yoW3Wwb_C3
	ZYqw1kKw4jyFW2v3W0krWjvrs2qay7WFyjv3yxtFnrtry5KrnxCFWvvr95ZryIqa12yrZ8
	C3srWa4a9r1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Andy,

This was found during static code analysis of the packet receive path.

About the fix: my reasoning was that once pm->idx has already moved past
the valid packet buffer state, the current partial packet is no longer
usable, so the safest local recovery is to drop that stale state and
resynchronize from the current byte. That is why I reset the index before
storing the next byte.

I did not choose to ignore the IRQ entirely because the interrupt has
already delivered a byte, and simply returning without resetting the stale
state would leave the parser in the same invalid condition for the next
interrupt. Resetting the index seemed like the smallest change that both
prevents the out-of-bounds write and lets the parser recover cleanly.

Thanks,
Pengpeng

