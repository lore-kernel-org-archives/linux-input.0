Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B41DE8BE;
	Tue,  7 Apr 2026 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527580; cv=none; b=JMIxoR2znSFvxTI9OUVkKHr6LuBPudiyTvcLxLoiMzXmUJ1xFuVTV/aLhTk6oBnNr6SdhUi/ksV5b5rnX+O7WHltZAziVv8MbF1yQkAFSaYnXlP5c6pqWMgBSr3tS5DvTSBfpVm9huRrQo0tzuGuZP2HgQ9Wid0wxT+mS0couCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527580; c=relaxed/simple;
	bh=lbqkEsikjsQ74uVZ43vx66OUAXZiT5sTLjBxz1plQYs=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWadMkwXjFNA+MBp6hN11HyecUg4hZ+KNYATAHmMbSS/g9oIaSmscQaFosCrxXGhwO/MrACHRAfdJHS0YwteKy7b8XC/1YiOMI+Vv90bj2EwgTWIQTyfp62tj3R8NPJoxANE+m30UXbhbdk1toCGECcNmGvkctqJ8Eb2uLOlXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-gf2k-reply.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADHbGiQZtRp+pt2DA--.27248S2;
	Tue, 07 Apr 2026 10:06:09 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 11:30:00 +0800
Message-ID: <20260407113000.1-gf2k-reply-pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org, pengpeng@iscas.ac.cn
Subject: Re: [PATCH] Input: gf2k: clamp hat values to the lookup table
In-Reply-To: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
References: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADHbGiQZtRp+pt2DA--.27248S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYz7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAI
	w28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Dmitry,

Thanks, that makes sense.

I have updated this to skip reporting hat axes when the decoded value
falls outside the lookup table instead of clamping it to the neutral
entry, and will resend it that way.

Thanks,
Pengpeng


