Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AC346AD5;
	Fri, 12 Jun 2026 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279307; cv=none; b=u2R0wk+PG5mHWXwic/1nYrYFJOnDVv/9QTlpo9yNDOZO3OxV3cx1NkcYjjrj9odKWfoOqDgWjDjyI1baGxSHCyVP1B79tExThXiiiHkq4P6EKacRhv+KIU05SJBJfKgJFT2EYpKFQVVrcWgsA9bdbrt55ebBozW/6aChVDPH1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279307; c=relaxed/simple;
	bh=dhE/fG3zSiVaKyX58KXtWvcySKLNgHAurdXOkx7iqzU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=O3IHvGfpruQnY2Y9R4oI6dUAsq0/S2NTll2BF/jpQt5K67VBvxuMiLsY59UZLwpZWUq2zYlhDuMTkRxf1CAWCb3C64/QjoDlhMcqQk+0gSv4SbXTiPl1RiCS45/BzJnxmdy1FiKlaoAYvE/CQsNopL2lPWpSKW1U4CRdrcGuKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7//WKJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7//WKJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5E21F000E9;
	Fri, 12 Jun 2026 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279305;
	bh=nfGJUonfV0smk/EonWTEBVVzqnsCUeWSecGaAD9E+P0=;
	h=Date:From:To:cc:Subject;
	b=m7//WKJsFPO3RY12VOXRstxANj0b5xV3xWEY2EEXOPFYVvfDhX3myDRUmAS1goKay
	 iwZOhHP9FIzurkieyVHX/Jz4DvPdmFnQU84MhMn7jSIEeuRrvPB0bdrdpEgaazohcx
	 1N9IvkMNjffjeHbLIetosH5btLqNCDFbzG7iXfdR7FjWIxx+uMTrMMtfEdc3HuID6C
	 WSBy6N9D/vMAuN07Gzu0PrKFRsi51TxoRpVoIqaXjvIy5CrX9zxi8epi59dH2emrsz
	 6guU+u69O7Hzlkk8vUssNoOjqmS+FSPGB5OiMuQhgL+ZMbOY4JtmLQoO7hktifcBJZ
	 N5ycOLYpZO6Mw==
Date: Fri, 12 Jun 2026 17:48:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: hidpp: fix potential UAF in hidpp_connect_event()
Message-ID: <r7qq6043-p432-51o0-3s93-r9382q44n027@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

From: Jiri Kosina <jkosina@suse.com>

If input_register_device() fails, we call input_free_device(), but keep 
stale pointer to the old device in hidpp->input, which could potentially 
lead to UAF. Fix that by resetting it to NULL before returning from 
hidpp_connect_event().

Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1990ba5b26ea..e0dfb7051966 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4295,6 +4295,7 @@ static void hidpp_connect_event(struct work_struct *work)
 	ret = input_register_device(input);
 	if (ret) {
 		input_free_device(input);
+		hidpp->input = NULL;
 		return;
 	}

-- 
Jiri Kosina
SUSE Labs

