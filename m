Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CB19B5A3;
	Wed, 25 Mar 2026 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403221; cv=none; b=qvSmbVUCRQ9Xm7DBcC5GdKmfTersPopGXlKgQNj/Dl3rnvzL7lm9ykL/vxtajX4W2KJ8JPCFYr7i8HEETYdEXNNZDL3Yyda22hBs/9ywk+RhUuFYo75H1HtnVYhUgXn8y/VjOPQ34KuiwELcOLozHf0gh36ovOh5gtwfiCvTXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403221; c=relaxed/simple;
	bh=R40G8pe6GUERSy1cKnPSBGxCKWSGspKB0j3sk9WgB14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndipQFZDcmGxJH9/cP35LbukxUzYHWC34OERZ5B6tfz9L9x8SX3YpGYFUCqLKYSbdmH6fxfq8eL0Kx+G5kqzkddChYDCmS6W6bPz98B1RHQBiBNqXIssnWtjeOP7Eh03Qmz3BFNYViGHETL+SGhFD/w2Uzj+UxgpFeRbzlcoCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowABnDWmJPsNpq8wRCw--.8367S2;
	Wed, 25 Mar 2026 09:46:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	andriy.shevchenko@linux.intel.com,
	kees@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: penmount: bound packet buffer indices in IRQ path
Date: Wed, 25 Mar 2026 09:46:49 +0800
Message-ID: <20260325014649.36468-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324131442.27632-1-pengpeng@iscas.ac.cn>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn> <20260324131442.27632-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnDWmJPsNpq8wRCw--.8367S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY47AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2js
	IEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Hi Dmitry,

You are right, thanks for pointing this out.

I rechecked the control flow and my analysis was wrong here. If the
first byte does not match a supported packet header, the left side of
the && fails and ++pm->idx is not evaluated, so pm->idx stays at 0. If
the first byte does match, pm->idx only advances until packetsize and
is then reset to 0 in the handler.

So this does not provide a path for pm->idx to grow past the packet
buffer. My analyzer missed the short-circuiting behavior of && here.

I will drop this patch.

Best regards,
Pengpeng

