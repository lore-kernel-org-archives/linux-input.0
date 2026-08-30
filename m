Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078571A9F87
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788078453; cv=none; b=MsM9qL76LSL2+wS96FcQrcBwAH4GT7Hh+VHKG88FwYZZK2PQxum0OqxvWuxxOIXAI97yeLvIo6W7oxqFHOXIUMCMF39g7r2hgiejtw8wol+V7jdvpyNvjBX74eGi/Poubw/LtJBYEc8n2AQ+967gcwXJ+epX8rZgVfWYpvvOlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788078453; c=relaxed/simple;
	bh=IA+d0A5QcyMe6n8YDpvZW44tVbbxmmPH7u3V+8hzS1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF0dd2ANchM0j/X8cIIJGGlYzpiyxerdBcRduTHTtiE/1F6sSk2IleCn8dgh+wLdFrVV1E1ju3ipaUUc+7kAdFkJSm9Cfrlh8hAGbqPuNtkNs65rpa774dhvcVRQlcZaoFJI1CGqOqY3ET3y6lVv7eoNYzDOAnODtvumU4nNmxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuR9XT5J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuR9XT5J"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2867696a91.3
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788078451; x=1788683251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IA+d0A5QcyMe6n8YDpvZW44tVbbxmmPH7u3V+8hzS1Q=;
        b=HuR9XT5JYCrvblV3mtMNm9t22F0nIN7XZ8AMROg0aXAwCMemQpHrGvyDdKTeVvzlHq
         CTdRpF+f04zFpXwCosmiQdPH80mC+lbSZVu6I0TjTV/FnoONzYOVZxHO191DKYyYFLvQ
         DhOyKgx6ntQWVNH30ZzCd+dwfVOmKxJ7uF47JpYPTwSLAgxKkUwSv3L/HGydGmouT6hm
         5zaR00Lrd5HcngZPC5+M8Hyi+c57s3ssl9jxhZW7toTUoa7oJ7mzm2sYLIY+EBOWzPJh
         nQmqfSEnIqavOq4hmc8xRdKuClXPv3vQLaLADSyzNzxPJdbxQeuUY8xdmzCoOh4peKqJ
         tj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788078451; x=1788683251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IA+d0A5QcyMe6n8YDpvZW44tVbbxmmPH7u3V+8hzS1Q=;
        b=bo8nXivqRj7fHXpf60V+fzIj6rr5GPfK7oHEofufFnbSmFNu3kkNz2zuApD62M/f/R
         By86ZpbOKX17fnRQ5mxt6zvUyuH/Kj4++d7pTz3RQaEUz10vDO8TZSKtwxH5okopRi+0
         7pkT4PssUDf+GAzfkD/j8sKTGeCRjwhWqrc3H6U71HOR07IDB5B3aGsWG0UtPeKYxPoF
         il2saSExXiaMVQjOHTYX2Dkvy2bMftk9OpYZ8bL7Ha28bsb9waCvGwJmX/QihjbdHC1p
         a7IG3HbHXSwoVYjT88lshmvHx8WwIXESpB56QrJD5xh3MGekHGpfW7Q6Ws5lY74Sjnj4
         J8+g==
X-Forwarded-Encrypted: i=1; AKwUvBw7UqfqSI0gVsCllJt+Gnj+f+9W6QmRYjbG8S3ZNSTdDaxcCd/+yF/nqP4vyshGdCOAPl9xibNtNb/b2w==@vger.kernel.org
X-Gm-Message-State: AFuF++nt9RfuO5qIr193JjcbYM9Qy0BPynD3H2oqVdpL/9/ZQHasZPwx
	6TNgFK9tAq5ON903w2/c9+amP2aoP4Ea01DxXrbH2LwASkHyeBv+HXVM
X-Gm-Gg: AYBFou3wbCbZOKaqCFPqWz8P7loXwOWgN4p7k6NLHHaVx8N3KcMjJiNRU+wCj17cCOy
	KItZK33kG5B5KoTBEam8J3UxR58z+W4P/+vcLOeNbnfz96bQwrnJOhv+Tz+cnlIcogSHALncOOg
	ZSKqL09vRjhCvDjQPj1z0HUiuyafvU86/Q4XuYC+RJ8Gkl2uF7LZcAyqn/7CTpc7fPLqoAO2IZw
	F9492cIJ33UCR7T6Pl6N9NTuDI8SZ6SHtBd31ky88A1QgECywYJqS9pMXIfQN3dbTUrbt7Xrb8/
	qPIWPOQ8Mgfep+W4d7KcAgYwnVyQwDt8evh7ahGvqOTwZZpIj6JqH7JhVDfWQid385X/ZCyY7xd
	VlUvJgF0jPoH53XvJAphqmsNNiu8n3FAslpSJQXisH4DziniN2CQaAAdm6M9/FrvjXcjLVoA8Y1
	Y2COMXYAgZluiWXO5tlMB4vskHk4e69Lh+wPVmhZC2Mk9mn0FMhRXaEl/C94K0HdOZ
X-Received: by 2002:a17:90a:da8b:b0:398:9be5:b41a with SMTP id 98e67ed59e1d1-3989be62ef6mr16592222a91.21.1788078451274;
        Sun, 30 Aug 2026 01:27:31 -0700 (PDT)
Received: from Default ([2409:40f4:101a:c47:80b4:fa67:fe3f:eecf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm36211979c88.14.2026.08.30.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 01:27:30 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1e2ef9bcb29af666b2e6@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] Input: atkbd - fix uaf in atkbd_set_repeat_rate
Date: Sun, 30 Aug 2026 13:57:18 +0530
Message-ID: <20260830082718.8375-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830081415.15187-1-jeffinphilip14@gmail.com>
References: <20260830081415.15187-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 13:44:15 +0530, Jeffin Philip wrote:
>Would cleaning up leds cause any weird issues on reconnect?

Correction: Would _NOT_ cleaning up leds cause any weird issues
on reconnect?

Thanks,
Jeffin.

