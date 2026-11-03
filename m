Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676814;
	b=Uaoc/gwUAw9DPD2q0Hz4UbztcfpefCFMTY0//3pBGfR6rE1e15rBHz07O98gKNF3Hml1
	 XZ/fDmr1kz1S8sz4Q8aT9v/J09wBZxxoseh2+rNLV+4CEkILLfuPp3WNBof+kuuJ6V0Tk
	 g/zPUjkgFmj/d7qgPrdR1dw0T5mdnxYQJP3y55yYVAzjx4ouXO+NN+5ycYWizAw2RM7BA
	 ce0WzbHlHWtyFhzk9O/Ico8ORyiI2fEkhnvuOVp1fOQdFEWxCLv20DuTR+HfWIRyctn3o
	 mQ8A3fUd7qRaC7lOd5qTpyhTeHn2bSdj+CnU85aj4Qm87EGEVJ/E/eg7Oy+0d0wkddg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=err8rpn8kCZEtoYWKx0gv030I55sgvzaIj1RMzAqnaw=;
	b=WqIAJfVDR9AjEmnqQIbmmrTcp1y3I8OSTO9+U8+Z8u65W4AQxVhESBM8qjo3bP1eY48L
	 rukE9U75DAGDkHKl9+yeRdLtxUVLMZ4QAOUsBeVCU7GObjdMVfnzpCpbxUqF16BexAHmX
	 GkdNyw2kShpm7b8qJyqD+WihZNtIJ/kIB/wHjge8NaPhIkrySxd9Fp0W1h/MWjAcBeJTA
	 ++lvWohWJWycI6Lh1RZJU86Yypkl19bY/2cJOVGnDi0IyBdiINxkW6zXRo0KAIRglPCHy
	 N8NFev2oiA7COmHvbQ+ez+BBJ6FzFkG4WWGUfyrLQvdzmuYSEkGsF1JxQFzhpf6tigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJ3Ix53j;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11726606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 03:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11726606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJ3Ix53j
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35829219da8so335038eec.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 19:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793676813; x=1794281613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=err8rpn8kCZEtoYWKx0gv030I55sgvzaIj1RMzAqnaw=;
        b=yJ3Ix53jDYmW1MK8ahpwHeM/d04cT81C9ZZ3x67qAHIAoewqQOAsX6yIY8QNptm/EG
         WW268chWcQGTbuNrhXVI8p+LnTbRwrQ6Oa6fLzJx/E8e8PvDfrBktwmjgmT5WwO54YzY
         QKtUf34UEMH9WmMCEzwZnhJPubQj66XHctHCuMyz+V+0PTZgJjsDYcdLi++lDnLRfxsD
         ISRvqOlAUXX/OwUTpSCVu9lguTTTGimEWIuV+1cLdEFqFrU0zbsGIq8wdjC3Gu/pSXtR
         46jEdTMUB2QUXE7e/kMOY/DRQ+Lvy3cK+EAVWlkNKgq/ZaipUSqNHH7vwcPovoKqC65I
         +WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793676813; x=1794281613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=err8rpn8kCZEtoYWKx0gv030I55sgvzaIj1RMzAqnaw=;
        b=w9aukDu0AAAg+2LW2+34wPSOwgWuL9VvXFmhN+RMXZXkK6mWB+eyK3GfQmpEh3fubs
         yCj7+Coe9ZU5YqeKXaBdRNOnc1o8/WSje/kAPCZ3zoaLaoN7Ud6AlJr/xUQpQA1f3DOn
         KKQFir9F2LWLYwlyNDSSYj8QVzCOrc1vJ4cuiA6ypwLhdSXdOu0YadutYVbgohCWa3be
         mLDKiNyma8TgD8pt/aYYKUoInzRY+HMnz8BAwxr1KuCWSWt7zmF7l3WO0u5pxfGLft0S
         FGIEHIpjJF344EdCUsAtA/CwfVd4TSu5bwBKx8qv/g8FS9Q0RfG2YJjBClO5rOT+nf3r
         7YMg==
X-Gm-Message-State: AFq9FYJfFIlFzGjp2GN4eVMOqkU5a5Zq0iKIe2v+efwSpe+K3kcf0b/2
	u6DufiNkL+Is8G8b31/QUpvA76ijGSoDz5d7eQgipID0ArSPc1zJOCza
X-Gm-Gg: AYBFou1unGDwxRDkOqSCK3cx742HmkWEJu5if8bI8NtBwy4XzHaxvvvHMvQ1RMLJ8mw
	YAsuyTnQFZXH0a5ZNDMWc9TNKAp9+vB2Q/woUVn+Y3xG8oBr7wexDn8BLAgTv7aSxU5p6wWHK4I
	TgHUbBNpK8M0nOzVwgQqynlo4zALCKQRzv3XN0fp/9+ErskUeQ5NhayL00Eg/184R7yRNUaACcZ
	CBK2K4OXlxFUJqVJDlLsy1qb0PqhzzxsH4VRdK1ZV3fwN5pfKuheyiWv64IwmT0XtB5etbOe5CT
	bvcTExZD+Tgy0i4tHhYcaxAkpq+TfjXKB3JbY2f6hrqpHrInrLimiOd3sgO3kiQH1b9htegmLg4
	2/QgpIGm1C4lzee/LjnUCqOhJG4c8NBLj1klGK2MjX1Xjnjczwlx9GeXc020PXYSsu9IhZb5t9w
	x7IJRiRglBtWMwmESTzIh52Irc7+vqSjzKWHny8Z+hntCxzrw39kn4rlG3vldrI99VAC3zrnT7u
	f2AxLfj5TAyFRqM5X44QT/7XYKxJsVuOom4zouGD3IJlqGbipOhlzdWmxozZ/lPidPoRVH0PNwT
	QbSKU3ov8Ht+TNWf/Dq8bgT9VIipZp/2wQA3L1z044UNGBJxyvYO40qpgx+pylnP2Rad
X-Received: by 2002:a05:701b:271b:b0:148:ece:8cc3 with SMTP id a92af1059eb24-1a94adc93b7mr19034522c88.24.1793676812990;
        Mon, 02 Nov 2026 19:33:32 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm50195547c88.6.2026.11.02.19.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:33:32 -0800 (PST)
Date: Mon, 2 Nov 2026 19:33:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] input: evdev: Always terminate SYN_DROPPED with
 SYN_REPORT
Message-ID: <aulT9-9OU5VE_PpL@google.com>
References: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
 <20261022-evdev_syndropped_fix-v1-1-b5400740e1f7@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022-evdev_syndropped_fix-v1-1-b5400740e1f7@google.com>

Hi Kornel,

On Thu, Oct 22, 2026 at 01:39:12PM +0000, Kornel Dulęba wrote:
> Per Documentation/input/event-codes.rst, on SYN_DROPPED:
> "Client should ignore all events up to and including next SYN_REPORT
> event and query the device (using EVIOCG* ioctls) to obtain its
> current state."
> 
> Currently, __evdev_queue_syn_dropped() queues a standalone SYN_DROPPED
> event without a terminating SYN_REPORT. This causes two issues:
> 
> 1. The queued SYN_DROPPED event remains unreadable until the next
>    hardware event frame arrives and finishes with SYN_REPORT.
> 2. When the next hardware event frame arrives, SYN_DROPPED is prepended
>    to it in the same packet. Compliant userspace clients then discard
>    the entire hardware event frame up to its SYN_REPORT.
> 
> This was discovered on an Android system with a gpio-keys backed device:
> 1. gpio_keys_open() reports the initial state on open().
> 2. Android follows open() with EVIOCSCLOCKID.
> 3. This creates an unterminated SYN_DROPPED, causing the subsequent
>    event to be discarded by userspace.
> 
> Fix this by appending SYN_REPORT after SYN_DROPPED in
> __evdev_queue_syn_dropped() and updating client->packet_head
> accordingly.

I do not think that injecting synthetic SYN_REPORT is a good idea: we do
not know at what point the clock change will arrive, it may arrive in a
middle of transmitting a packet, and if we discard only half of such
packet it will result in incomplete state being presented as complete
one.

Compliant userspace should not only discard events until the next
SYN_REPORT, but also query state via EVIOCG* to reconstruct full
picture. Is it not happening?

Thanks.

-- 
Dmitry
