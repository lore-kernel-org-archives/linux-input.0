Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360042;
	b=fZJvOV6QLiK2zE45wSewYbUhb+E/vhfxJml0aGJz2YPhhONiRoT7o4BHNVdikAWhz2ri
	 WlhFxUBCYmCoycmVcgyQ7cOaPq/dr5KQnbkXhfMcojcfOI8SRmjTQE15Pf0e5U9noYdTm
	 mPWrF9Zd5D3cLzSQhAwQMsEAW23nz/NY9mzC3UfkEpBNwHuXtlah6YU1/zFtxWw25I7CW
	 wPNNPv54YuZ8MeglmllCx65VfJeGbt6JP2IkFhZikg0191SLuJ4PmCxIhzuiQ2IDkldQ1
	 EF9LfPGVf4k65RtuX04BGFm0Z+pB41czwp9+mPwAPRUgotdtWbcUJlzhYpda7DWoQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
	b=ug2ikLycQlW0mc3EUPp8US59AeB8p0Zfl4ASNMNWweLtejxFACJY0Tv1rHVixQV3hG4x
	 zqDubJQQp9bj5snG6Z/QmxeW5m5T3rvycTqO7h8Z4mQLtdV7704kfH/G0/UBe33xIWqA9
	 IO/CRoMoojZLeKCclMViCGahh1txoW3WOHmE/uwqsupb7ZhU4SVyYIVkWCxWNO0o3iFr+
	 7rTPdo/ewfDhsGxZzPNlpZTWqggOogmx9CEfuRWEICCHb3HvSY1b2dErOOQdpDVOaFnry
	 j6c6lMCeSHjj81Xk+FWXX1PsVawD9CJVwDvWKQABlsi053zldupEqrklLZS9Vmazyhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJbow+Ry;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013D606A31D
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 11:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F013D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJbow+Ry
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso1458929c88.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793360041; x=1793964841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
        b=qJbow+RyFWF5QFZ1uK9QqF+vowuLwxygWZLw3anLNkpKt2i+llLDUTDFmgfzAzjRDW
         oyoO4VUhqgpzvKvOjHKs+v0GdLN2btyCgZ3VD+WGsHR2hYOqCkx85LT38YXk/IqcJNiC
         h234mBMjvur1K224jgfEktoInVsrpWOUt4hyGawetllJ/V8UOmCz7Zbvn3P8c1/uezFi
         FxbQZNbgWqxGWcS8MfP6+lGInMZVeDUSpYHXoakWwI2Xw0JJ6Q8TR1wo+c6TG7Zkw5yE
         dI2qrjaklS8FQIjpCEZTp6sr0+yqS1dWRZD32ne98Gi6+XLuQYF1tvdu3epsW3V+mlGu
         EquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360041; x=1793964841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cI5Hjpdp7zO9I2V61FPJbbgLxeyy0DYFAxQRxLR6EAc=;
        b=VQRsbfu69maRX+susW1R22LdiJ09etea7AbtBslqq6CkYLVXW7bBlvgM3dX4uDI+Ni
         b3CvTyYaYO5Oe2RKVDirQDXJ/Rc1AYNQ3UOIa8PEHxcjuc9fJrOJLPs4pKTcsYx80yY+
         A68N6ejow6cjFCV1vieO8zgEZKlPok7gO3Uq+RXwR8OT88mRWE/woi70EXHn52VaoMWN
         83uDeyq1E49v9AcvT6CR5gFTBW2YIVtJzLt6Y9/i9e8yvWLgSAia8mEITSd4MqtEN27N
         6L9yOKIk8VDk2Lx0x1adkNRwAt6BnCRdoUomPQjDrlo3QjeSXLze7xe2Lgt/l9FcV+NS
         B/Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwHm3rbwfl14EZt7c1dx+SlWsMW3YDsZtY8gGVdHe0z+0tpUj+DVncOupGBFXr6UNq2apDtcft1DZY/oQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL5JBENzN4itdTAqXYNTUH2F/Nv/GOa6EUdoFossS9Hfg+s+YD5
	0w/7AYvkP4uHKgY3yOGVmnEXc/uFhZ4dYQYu4WLzH6uTRR/qqOAcIbFe
X-Gm-Gg: AYBFou2CJGRU8Z+YlWOHtWLAdyYmB+4MexShbIKvvejH5HQXYcZXSK6H4hcnEATbeTn
	dx7P8E5gMhHAijXm4yRFWsXugm129JUyeui7usOUZ8J63L74K6/6nY+BGpApmjKmszj/aqaKfIQ
	CYoUqLR2ngkuODNTzT1c+/HAis1MYbM9NPuT601JTp3Ut57xaOGexlmlJckvVmtNARE+bVvwYfL
	gdJT3tXQWLrBUhuGQpIhiYFj7Tk0swlSFHa3W5rm7s5HUWhZRBQb0mbc6tkuRu7cMDieA/wnN66
	t/foKHed5lMD8tBTDtnJHdkppWj655Dio7YuVhk96eKGBR+A5b4WLDStK0mwdEhfcKSFpwUFkh2
	7/1VzTWnkEElKUuXMmr+gGBvaHOcX/Si+Zk1mx59gb2rMrcFm3WD+5i6sJOUrkNdc7g6cUE8y31
	v18dkQQ1EWybatpmNdnrvMl8d28rREq0oDAx5kCvukk3IIR5eotURAY+zChsMk+fdSALl9lidrs
	WlgKApewh5cO0Fb8jdk+5dNQnoFOETYBpVMiCZytWFxzPDETQP64+CrfaTvkzCO2pRdeWP/BiXS
	DWyhmGi58LuMpfvGZJ25ZHdEEXsaZogA8roSIhrSqtMOUg==
X-Received: by 2002:a05:701b:424b:20b0:199:7dff:f9cc with SMTP id a92af1059eb24-1ac5ceefcafmr2906676c88.42.1793360040974;
        Fri, 30 Oct 2026 04:34:00 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm7809929c88.11.2026.10.30.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:34:00 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 19:33:56 +0800
Message-ID: <20261030113356.248358-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103043-tributary-partake-aefd@gregkh>
References: <2026103043-tributary-partake-aefd@gregkh>
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

Hi Greg,

On Fri, Oct 30, 2026 at 09:33:41AM +0100, Greg KH wrote:
> So this feature has never worked?  Or it is just "one change only"?  So
> your change is an addition to the feature, not a bugfix?

It is a fix.  154b7a489a5b ("Input: sysrq - allow specifying alternate
reset sequence") added reset_seq as a writable parameter, together with
a version counter so that each keyboard rereads the sequence after a
write.  The reread just never clears the old keys, so on a keyboard
that already used the old value, a new one has never worked.  Hardly
anyone changes it at runtime, which is likely why nobody noticed.

> So this isn't a "real" issue?  If you are modifying the key sequence,
> how can you press the key at the same time?  Doing "major" rework for
> that might just not be worth it.

Agreed, please drop 1/2.  With only 2/2, that race can hit any
keyboard, not only ones that never used a sequence.  Do you want 2/2
resent on its own?

Thanks,
Zhan Xusheng
