Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119363;
	b=XeFUdhFWDCwwCcBDI7HA7jeH2Mw98yvmb98BtRw7DL6fT9JvanomCtmVjiZvvrhso2vk
	 LAws3iJWTI0SM29/lBC+MSyBo7WQwin0yqaie5dWnwx8YBTLFRFQTYNvFuKE+C/Eot8/T
	 e0fj7Ma0dzvDxs18eRO2zoYv4htYZYtiywYf/bLMeAuBYrVU+i35aJx+LILaNqw6Ldv+D
	 B4/TmzxEGiwuWuX+/4Gm19Kw6fiB8n3e0p1AP3vYW2hABZwddQdTWZ6mthxDNNb8cPg12
	 pNg5KWCzsQUpGRDwPQY+XebxXpfGQ4kcwpgApPagIqEymcoIvSXAZ+juH0ml0FjDEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
	b=hESaWt/6O//Q5W2R9I/yxNUsaadue8IbgIiqkHyQCnCuzWtZPG0xHh3Ho1WVSuw1kpP7
	 eHiAzsKDj2hCTgLymbmTDk1VRnFvPYkv6yElxQGuC/nWU3JUGTcSB9O0upnYTQrPLnGcA
	 67/AHjyehyT/4pEqQawm8UfWC5W5Tpf6HAqlzz/tdyE9d/1ae7aF0BftQDCohgaF1Vax6
	 IlUUOQYv0lmykLaUMYf9yc4pynBNFUJvmEjOUcGXGHPaA05RXeZ7qvUUaENqSP8WZhZgV
	 x/mvXMWna52A/54lYeFkvDThQ2U8+BsPxkVe9Ursk/ojqCjRfAUAoa7qCbkAAccmkAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yinSp1IW;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE32606A32C
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE32606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yinSp1IW
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso189482eec.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795119362; x=1795724162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
        b=yinSp1IWy19Mc0Uvru8QtwhV79tjjpVKWi1+9FHUQHTEdVmwh7FMqghXtoaFhil3Up
         HuJyR8YsyRLwKs4GnH+Dq5WPejkKt36FY7awxnFTJB0xJB3kuj0hjJ8LjQHaNYiEaKLt
         dcGwROZVLMg4UrfyMlUjcNs59EyPsnwAkV+ttTTNnaZMx0BOOaS3ovLp9O5ZAWLK6AeB
         ZuAEHqj3ZflLDXxARL/LXnCzMb2gmeEJLIcSsZHXdUyfF+n/4zqZvZgZLFG+tmG0sNA2
         GKL5jSf0lxUk7HNvWtwDf2IkOW5uKBbVI/ZS2ENqhhG0wSeCfavwncA1dCEpcxCDleB5
         /rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795119362; x=1795724162;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IioXAUgBLX6qGXmIL+lHfh6K/SMkoqjXHsXvXuXc4kw=;
        b=B9kBpWe4A/Thk1uNAv8j1fZ3lGKUDsG4mAwughQPVDmNIiKzyTuFsmYDlAQ3+gl6PU
         7uyhw8xjTmJlZPybw9QPJ/e+gXmSpYJG5OfzjabED2jQmrjcICMFy+d53EA/uy0JBdYT
         pMZytS5kFO6kRqJwNGi+GHbT+j65RV0LY2OhfSQ/HL0itBxv55RGVx8exGIioYKAg9Wi
         VRQnR/TI2Jiw1rTIiYn+VTkmkh6jGfyfYGfrMDTCtkKxeRkUUJrv68eaIPK0gv8npjk0
         I/fnVA0JmYDoahWbyKDA4kcmn6OX8UHbOxj1SGHNV3IhPjljZk9Y5zqtdSUKQTQmuvh+
         h3Yg==
X-Forwarded-Encrypted: i=1; AL+hErFXR5+G9F7PnoNQGPCoCJgfD9Btd4d58j0JuvF9PlKj3+rxmiob8uK8OXkOKJZF4R2fSiT0FOi6doO09Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VrTtwJqe3bw+A8DmhCrS2SZD+wy6dj3yohIqqaYxy7UHXEk7z
	OSbNOA97Oyeb4Rn8ZZHXtm7Q9BXnu9UJZOo1EaaTpl+uaUYhuBUg9JPx
X-Gm-Gg: AZFdTZdF9Ykfyz2kK9a9ENh2ZGSqOQEpTCL2JBd95YCgNPuwGX4+PKwTm6K7KAwEl/e
	Puo9jsNXzmx2Ljq41LZaXeBF+gTUYYvBd7BhVP0rRg4SfilMP+o0PQyqTjgJh5hhQs5xTfEvrAX
	Y8B+zA4pE/7H43NJVdd7EYTEzvMTnmwSUPlH+7c/dKLRA5WRrJYOI8qZ866EVVxpRoQiL9ezdrM
	cNgxU4gLET1dw9H52BP4gtSWlS3UDaBySFzdrT2mWZJnqhBqxbb9jagY+pe7tyopAFtGaWz29wN
	B9unMxIG1Z38/ghF7uR1vVEtkDn/uHcHYiwsnxL2AKI2wLa0udq9EY2wWqCmfIgNqPkwi44paHE
	GVHX+p1pZBU+qqBZ02Htmhv9nsoKOvmk3IVLMYLnlKuk0sKtxLKn/pqaUQnU1R4Got1N/G0yk4Z
	OeCtW+LgelMKOibCROXcJUtazSf1P/CoAguUrAyHv5Z7wiVXVBXGbYOKrs1Lm8KScuhbAxMkMV1
	BlGPRnyyafo+47ftaoOE9XWsuv4i1dMf5KRDE47JITVkyjCSj0PQr3rbZEAv/XtWHNMtjpGuYB+
	6cJvh4pgi2MKmkMofTDKd1sjMkrOu3J/6YkVj/jCu5YRrvFF/mgz3jwSQgKhmTG/KuakWl+0ByT
	4Jw8LB/X1kif8g30bnMAy+telgt1ixutBywiy/j/q+rX6rWkS4X7/RW6c+pPKuZjB+LjAAMEE6c
	bR7FF0gOOXUq3qp0VTKNP6XLUcUYKeR+rUmZQPD2vAi4A=
X-Received: by 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr448850eec.2.1795119362463;
        Thu, 19 Nov 2026 12:16:02 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm1097351eec.28.2026.11.19.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:16:01 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 01:45:55 +0530
Message-ID: <20261119201555.185270-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
References: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 12:50:46AM +0530, Ayaan Mirza Baig wrote:
> Move spin_lock_irqsave()/spin_unlock_irqrestore() into
> sensor_hub_finalize_pending_fn() and pass data through
> device_for_each_child(), so &data->lock is only held while inspecting
> and completing each child's pending state after klist_next() releases
> &k->k_lock.

...

>  static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev = dev->platform_data;
> +	struct sensor_hub_data *sd = data;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&sd->lock, flags);

...

>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);

The commit message says data is passed through device_for_each_child(),
but the call still passes NULL, so sd is NULL in the callback and
spin_lock_irqsave(&sd->lock, flags) dereferences it. That would oops on
every removal of a hub with child devices, instead of the lockdep
warning. Sashiko flags the same thing.

I think it should be:

	device_for_each_child(&hdev->dev, data,
			      sensor_hub_finalize_pending_fn);

With that, moving the lock into the callback looks right to me: k_lock
is a plain spinlock, so it shouldn't nest inside data->lock, which
sensor_hub_raw_event() takes from interrupt context.

Could you send a v2 with that change, and say whether the syzbot
reproducer runs clean with it?

Thanks,
Arnav
