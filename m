Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485422;
	b=clPFsw7PFwbnGA/Yora/7vumNbFFww1teslzU82CVBo9T2AUNwr/Bu17TiDzhb3GshGM
	 Ao7iitL7yKeaFCE+DTrr1S9QXF0REGC6WqA7fVETAt6yILEJD7Z1ex+nkiNbdX4NZIBJj
	 3mddNq2kLqoZ9Jjbm71+sk0HcU9EVI4fqxgUATFzT/aFjVv+q1ZobGhsd1JFCrarjaVQT
	 7pwgA5PE8WvxxwdiWRmT/MluGFfDK5JG0Z7TGQw8x4ryJdTK0TuDQNVAcXCMNghqoyeu8
	 jl6d5wzM1ZbbVJzdcqXvncmqgpl7KYl2ALLxNhypYyO3HKgtyegBROa3zCa2Yb1zSHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=/L8uXiaS6bmFC0qrn35Iu5qpKgrTHXQ2XkvCS11ygz0=;
	b=Vaw2SdTUKuEOMVnaufeHJicswZSp5KnWrwMgqgdlUNEu21MaVmt1e61oW3WyjEqNdXM5
	 k5/Azh1gfIZoAshR7Wwrx4IwOgN322yKbQlMA18OcLGbJF6Wl0fa08rXZaAJgVQfp6fiX
	 0qtbO9INxZazxpdheQnKO0lxMeEKt5QWv9gGMgcmSf60o/Ldn+BL4Wv83TU/o1uXEQUB8
	 eX3R5oyD7UsvI+KQfzHnr5bDUOJjXUVzkjDrpOxe4JnPS5j6b1OY0MkK1GW62EfDxHk/Q
	 ZeIaZ+CTQ6ljVCHl8vWRdn+y8faqRvOs/twiSdxk+i4Yg3kcqgaC5ARGCWqX5g5vwPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZhSgvR9;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E9606A32C
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66E9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HZhSgvR9
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so5758073c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485421; x=1796090221; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/L8uXiaS6bmFC0qrn35Iu5qpKgrTHXQ2XkvCS11ygz0=;
        b=HZhSgvR92UVg9Gq6HWqTK1bfiQW+QTlzc2rF/HYUTdPNoZvqr10ACNdZxih9eThop9
         Whqq6Q4xUHj8EtouQFUvHGQPLYCk4ErdQXnKeV2Dx85saqW/mnNmsY0pj1GrYpAvbxJs
         zCiOYS3IPunuybgG+6XEBCsICaWsDckSZ8WqzSgY4EKkqQ3nGsZotVUrlw6RpdJ3IwLB
         IcVvPpJ6MCrB+DoBOa7HMARzplDr+2xsgkMu6R0dLGGnwk/GOHhVE2+R0khJGOAa+yZz
         Gi+IopmJbX+heqCxNBTSn3NMb7/Jo2ZaC0OfwKBOCcxffGA0igcZVxm4FA3vYSwLSV7A
         RYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485421; x=1796090221;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/L8uXiaS6bmFC0qrn35Iu5qpKgrTHXQ2XkvCS11ygz0=;
        b=Mlq/ZyxZC3FxbwGf+nBPvUUFHq4nr7DObJPTTo+Dwcv43pOlK4n9ez/o/J8Zknskw0
         wUQiLqsV/8AMg+YzQrsfuRtnclMYBxoZCqEV2zT9S0W5TVCY1niF3s2eWGReQJrgkH+Z
         zFAS26Y7GgsuQeCvT01A4W5/Es3babGUdT3KdaKaXJm0aqq3NJIerJwsvgSX4TO7G+fz
         2r+/TZBhRDyTymXhy0ieI+3G9qiUZQuI8NO5JvJr2GSorQ39odM1e5e02p67QjARP19S
         7rVD0EjlEBFSCiAdb4E5tpmjyrVq2gdG/IaJIAq1iMZn7Rhe6CqFd21INdqfrR5/tWtX
         KCjA==
X-Gm-Message-State: APuU4Z8UWwbewjrTzLzfSbMD18eo6VbyI6oSbgVNZvtSIi0lfySISIl2
	kQRf+yj8ikYT9UjYyOZQ1Vs/OqvOe7m8eamcB+fSTW9h15dT488OhS4F
X-Gm-Gg: AZFdTZeH2aeUByUNfXOd8grLSBcAiQAOHvyEpRESlNiDxTJqJ5/GQ5bKyErNR+z0Ucr
	IiR0WTFiq7IZCkUKhvB/rnjyfM1udLRBO8xGLSUiY1VbMZgDjWAPIfqQD5Zks+mca+tYtiUwIro
	n7kJVzUNlm7twX7aB0uwyytaKmSYNUGFjs4d3HpCJ+qfuSHhw4g/hMA5FKSyqM9WBGLjwUaiLeL
	y98Ce8oUudXi3y/YuhMCeMzviG5ku/NHk1EnHmFUcaiJ0UrX+9JsJjozo3uZ0jsKNoUVbmWgvz7
	qsxEWpOMT2XFFf+sM14jYPKzzdctu/raLvM53V7QG8heByT+LLaF9zqrg9bZvzicI3asp/yg00e
	cSJRb7G80Fkf4CUifdUQ3ivJifqxfB4j06oTgHqF/Mzqt9ytZMf4At/MebY9W15KhfZEIJU9HKg
	ZkhtZ1AkVJOiI7tFvU1ykBlSamjj8Ssl6uLCz1hU6cXZlSjR7yV/PxDt4JEtGHH5/QD5LgFbf8c
	BMkPZY6le/X2ioaHN9XX5fw2UIFObUXtu/+EHLqbfT66lX57GXADbdJ9/P/fDXpEJDqEyjJyqhy
	z6W+uL4DDFlJNSIBur9hMe7xCatZrDMyPK9W9LJc6kFkhT4nFd6cYbcjJtROnWM9UgPbgg==
X-Received: by 2002:a05:7022:6988:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b55689f5dbmr18451310c88.10.1795485420878;
        Mon, 23 Nov 2026 17:57:00 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm35459890c88.13.2026.11.23.17.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:57:00 -0800 (PST)
Date: Mon, 23 Nov 2026 17:56:59 -0800
Message-ID: <a4ffb45b13ddacd888f169eb9a60aa69@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: CJ <firefly0158@163.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: WARNING in cm109_urb_irq_callback/usb_submit_urb on v7.2-rc3
In-Reply-To: <4ffee3ca.5062.1a1c4325d29.Coremail.firefly0158@163.com>
References: <4ffee3ca.5062.1a1c4325d29.Coremail.firefly0158@163.com>
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

Hi CJ,

On Tue, Nov 10, 2026 at 02:43:17PM +0800, CJ wrote:
> syzbot reported "WARNING in cm109_urb_irq_callback/usb_submit_urb" on linux-5.15. The same failure is still reproducible on v7.2-rc3 with the reproducer below.

Thank you for the report. The obsolete cm109 driver is being removed
(queued in the input next branch for v7.5):

https://patch.msgid.link/20261112001642.243554-3-dmitry.torokhov@gmail.com

Thanks.

-- 
Dmitry
