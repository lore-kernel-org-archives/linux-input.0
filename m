Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549004;
	b=DfeqKnVfpWiLIdGgtpxS2W4F9UX+tScM41+WjX5W0g8v+8IXvTIA0W0YdInKkEeKrZ8w
	 UYWnsMd5aDQMbGUGVebTjOsjYWd1XjCYF3Eca7s5pOEdt8QuRL3DvOUDb9PQXCPTqcH8W
	 upYEF5tghj889xlXo4tjjleAYpyk9jlzZGSK6jcY+Igqf+W896kn/Wsq32BlpY303kVKK
	 +9BA80WOvOyI48EevcXpXnBaOYMHafydVz9PeqPMt8SofnrTN+sjRTG+2bJYI1+6I0+Kj
	 2BzlTxeBJKMl/odnBEu3Ccwg+nwdZUL7tE3/cbsLzQaZ4sHD9tV+pngAeLC40t7lkLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=yqf0V0ahyBHVRuWhFtdBAiBcWunJExbVVuyktIhjkac=;
	b=RJsOxkhIb5JjgZUPO4kyd0vnyrq0rFCcRo2Z9/x0PsJhEbKgTXJS8lxtuucvwYj/cbTl
	 xU7FKCAb8iOrapmN6wU4Oqr7RLRqWShvMEVU3A2xZsEr6Xv3nVTxntJHbt7V8nwV5RqzE
	 ruw9mkhi5DRz5fJ+WqtUJZWTcqiWg3BbvHq6QuzeXCmbl2/cyVlThnXF1EWZsB+5iu1fq
	 kwpqSKjy26uGKQTTMMFFp0dRmoaWT93LGefeM/k5rug+bFfV69AbNdk1tv37ciPUFa8L0
	 gjPnj6SwbD86MdV+W2bNVbNHG4M23vM/atL8O2zbLsFR34XRElFUXwJeyEhLbZRy8xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NTPs/DTp";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD13606A32D
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 05:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD13606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTPs/DTp
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so691046c88.0
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794549003; x=1795153803; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqf0V0ahyBHVRuWhFtdBAiBcWunJExbVVuyktIhjkac=;
        b=NTPs/DTpOttjHIW/fzyL9SpFCXzDkpiHent5Xdr/3snp8dFt30h1I/sz02G02vgmJH
         hTj6mEUhHV/Pws0iVMqWw/nAbG+zsxrcmUnw27cTvEI4Ox4JgnUgIZ5p27ayfUsmXVZ/
         WPuHOBuFhOPjap26qQ03XvFdKhZ9C/kQFkfhWRU+oe8Q4ynyLyf90nmaPgvXplfPl+yI
         4lcNqdg0NRNhYanYGDQTenBGxGyThtyRWLj1v7fIRHl0vNZpcXyf4AkxSKM5zvZpwsK/
         iEoQJylQwcmd5dIftlpKh93JCQCJ3UBY3Ci6QF78WZMRjSUdhjXogNZu6bA6Orre/YUq
         UmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794549003; x=1795153803;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yqf0V0ahyBHVRuWhFtdBAiBcWunJExbVVuyktIhjkac=;
        b=pBR7LMAuH1eE6Iwfgw8j3WdIC9Avht43jXv+FZpCyB785fnsYa6c2mPO6L7uPHPM0g
         cjQKHqOqGujiRsTJNAB1KfOx8Ogvdh4Uz2haXGK6H6Lr3W+/ebmT6+z5vdQDOH2DcoXR
         A7Y20AIGFdLMF3J2ZdCShgLZpANkVyO1JplNgk8QYYRq0y2T2Pexy6AljPGGLDRzAbTP
         om2KiSoGgmYehk1eOfC/LLTXOaT6pSW7cyiNpWEbbVhd+Xc/ypN3ktLyz76dk/MAoBS0
         mCao/gjU5YGxCtI+NL0nrBNblnFhcORdRBERBRTCtIKXqoRJMlH2vuvalZ0CUw3S4Akd
         hQEg==
X-Forwarded-Encrypted: i=1; AL+hErFQomdrAJB6A40fPUxxVJuodo/uoUikWlw8eBBOyMDPZN8SVf9TSpoweKJtDdBXX2YaaBf1oQrSFn6Avw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/EaZ7IUpzKHxyFvE9rFEuesG9q3k55jyVWv23S4JfuPKvOYaE9
	4iVitve3vrSSLKoUKri77jvmY8W6iD+PF+9DUOGJsSrOu+0hP1FBle/X
X-Gm-Gg: AYBFou09+3pQzDcO4jyrcCvFenFpWTLOTVY9C9EiB3eNuS6/mbFTaNqKzIJ13MaBzUw
	6pzYjxepMqLUUGaBkAhhvDwhdjInc+7PQhI7OC248Seu9/EtwIDh95pHoCVR6RIYhXfTPaU9z2m
	VFvT1dpEQBovWsQ2tAeUxYiC2pCJfei82q6ERvuqErovg5ExQtTauRi2Cpiji1ZZrOBcmT26Pg+
	0CF/mHEVE1ph3cFHI6TDP696Khy/Yh54LoLq2p1Gud95U8z0FdMr+mkaBwt4Hfm7zsFdpZ99a46
	LgQlLtp44uY0Hf6jpEW0chCZfjbYKujBAMT41QHGdej1UroUg9YT04H2L0iUGQCwD0aVaOyMpQv
	XPAH0/Jmz4CamTQSRI38zlSHorBfEjetb3m571eE+UUj8bSwVOK09K4snRv2MJ6eA8VQuz/iVRl
	9Cga1NAv1NLzhw3XNeO49DIIqChsLTWDaGy2rAuHu1MTj6de+5F0W4an7hlNLyM83v37DnchK4d
	jRb3oE3AQVN2XCQK2uF+QRRWtls2fWK62NMfn0PsKYO8+GLdUxcOuOa7v7rztLAKswwXuLT9Bsj
	KK1i5Hym4SHRM+zb0u0MktFJUcl9GFXmK5vFSqhajb9M2MdBOnMnoxMWnbM/uMsWyTt6Ig==
X-Received: by 2002:a05:7301:6184:20b0:36e:a179:85f2 with SMTP id 5a478bee46e88-379675fea57mr1230534eec.23.1794549002605;
        Thu, 12 Nov 2026 21:50:02 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm3860092eec.5.2026.11.12.21.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:50:01 -0800 (PST)
Date: Thu, 12 Nov 2026 21:50:00 -0800
Message-ID: <f44447354f28c295e79a025bbcab7a4e@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rong Zhang <i@rong.moe>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Angela Czubak <aczubak@google.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] HID: haptic: Get rid of input_ff_destroy() in error paths
In-Reply-To: <20261113-hid-haptic-kmod-v3-2-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe> <20261113-hid-haptic-kmod-v3-2-e7dfa8766c0d@rong.moe>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Rong,

On Fri, Nov 13, 2026 at 01:53:55AM +0800, Rong Zhang wrote:
> It's painful to have error paths after calling input_ff_create(),
> because input_ff_destroy() frees too much things but does not restore
> some other things.
>
> On get_device failure, the module's bail-out path calls module_put()
> right before hid_haptic_destroy() calling it again, causing refcount
> underflow.
>
> Besides, every error path calling input_ff_destroy() frees ff->private,
> while the others don't. This divergence has caused quite a lot of
> trouble.
>
> Get the module and the device beforehand, so that there is no error path
> after input_ff_create(), eliminating the call to input_ff_destroy(). In
> this manner, we don't need to restore dev->flush and dev->event either.

The only reason hid_haptic_init() had try_module_get(THIS_MODULE) and
get_device(&hdev->dev) (and their counterparts in hid_haptic_destroy())
was to work around input_ff_destroy() previously being called only from
input_dev_release(), which could be deferred until after hdev was
unbound or the driver module was unloaded if userspace kept the evdev
node open.

I am queuing an input core change ("Input: destroy force-feedback device
on input unregistration") [1] that calls input_ff_destroy() directly in
__input_unregister_device() once all handlers are disconnected and the
device is removed from sysfs.

With that change in place, hid_haptic_destroy() is guaranteed to run
synchronously during input_unregister_device() while hdev is still bound
and alive (and dev->dev.parent already holds a reference to &hdev->dev
anyway). That means get_device(&hdev->dev) / put_device(&hdev->dev) and
try_module_get(THIS_MODULE) / module_put(THIS_MODULE) are not needed at
all here (until patch 8/9 where hid-haptic becomes a separate plugin
module and hid_plugin_get() is taken before calling self_plugin->init()),
and simply dropping them eliminates the error path after
input_ff_create(). It also avoids the devres lifetime issue with
put_device(&hdev->dev) mentioned in patch 1/9.

[1] https://lore.kernel.org/linux-input/2f722967b6db0692d4dd4164aff39b62@gmail.com/

Thanks.

-- 
Dmitry
