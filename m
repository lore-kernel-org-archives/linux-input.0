Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813846;
	b=QrjSRvX3nqle9oFNCs95TsG56NzDy6fHD7stftpr39b8CO7JSa4aQZ6m6o6Rx5+797Sm
	 XG3HcIDoymSUAOZVmn71sST+I5owcoWcVOYahvWMV5aeeH35CFAISy8tlrp4ZZH/V5aQS
	 cwqzAPaFhS0z7ZuaMWSy0W83IMVRvtApyNrfuvPIYQ8vhzwGrpytvc7VFCxfWBy/CNiw6
	 /BE4usChjul7xRNK0Kh4I2kmXWxfirgp+RlA6nsq6k/2RRibDkc80rNx6/UseQEGpfeDX
	 5vqASkQr5fpK15rJlWL5gtU7238GHVl6M7TTPXuLB61o2gxd/kxr0X0YqKVLl8L0BPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZnkZ1InoVqbMzJo0ykriEGYJYWNq2vEyk285i6Z8tWE=;
	b=hfRIvrI2XWF38fHnkRyUHtZhQhAonDO//Hl7LQIZnXCBMwwh5UljWy9iV15zVpyKTt4N
	 5tjVM6TquN715QIhNPaPGIll4s9XGHNY3RQ5TygDds5/k5rbSBVxFGix5NIs41ds+URkZ
	 IkTGralf7xugbmgw4+ap6Ta2mpttNPSu9BtIYu4JMYiJe2dgISAriZTBU+St5IAuWOrh0
	 7vTOViq8GTE20kU2CUgn+eXVOKM6VOd71M247xf3sXBTrZUNMS8qZHmiRmjeQl3hB9deF
	 /VnZcoGhDFKw8lUCBWlTL0AU9Hyma85quQTgezPwBYfLduvLzuPcBn+AHggDQqbD2HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="sV/HY1gt";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F99606A880
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 07:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F99606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sV/HY1gt
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso1347689a12.3
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794813844; x=1795418644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZnkZ1InoVqbMzJo0ykriEGYJYWNq2vEyk285i6Z8tWE=;
        b=sV/HY1gtIBmJlEnpqZ5GtCSoI7vFi1ijznjmJzDid/6dMqhULkair+am/xzHJf7sb6
         giP/t5xi8w5TCfmY2WcwtFxrlWwBspQPMtkOBeTYiLsqIEzmFTNQOILagk0YOB1l3KPD
         S1ZvFIQTX+pKMcTuH03QXg0BtVq66kAg3ch29tEBd9V+oy/p/x/+zh7JIb2iLNbjWTnH
         PALE6ObljSUAddTZeNMRX0mNWTeE/f/aFEijzWYfJR3FVqqjVqzU6UjfE5og51zESEo6
         LC9Vl1YoTYOx/X1nY1mxMktQRM7KTuCpQPMsIIVaE5EIajAB7HsW2JC+lrDVQuednAGM
         Amjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813844; x=1795418644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZnkZ1InoVqbMzJo0ykriEGYJYWNq2vEyk285i6Z8tWE=;
        b=O3CW1Qdt0tg97mTkmLN/rwiSHFFIdPDaCsQOzBrAEzURB/QyvIMuI5HeDq9Gt1mfQL
         1haYdfXfLjMjjK0UM1noRJ6bSsQU1l0KXhvT9/DmZ6kGmJz9MAGSK8lj8M1ruV+W7BTe
         9N17o5Cc68fLd9/Hql67ejfBQCqmU9xCUa6pMKqZ/mcl7ahR0757/tNL0SvdOZS2zUTg
         cfYCYj3lvNyNjxXmJVVc4zL9d0JHVdFMDnti68hEP9Cck6i3jJYKNNrdAhHxaXBkIsIb
         51D+0e4bTTS0tVxPUpMg+dWzvOJxjvKSUHL46nUsjxtXPkXbqLahJoJj0B/j3bW+K7a3
         o1lw==
X-Gm-Message-State: APuU4Z9Lz63i5jtehnOrpMnzykbM3C7NT+ggDqqjuCRHgNNUPQWWUVr8
	Me4z1PjGvNJ7bY46Qo5NqrYKiQnGeyLBbpJI1u1WX5obNAc8xE+i46yS
X-Gm-Gg: AYBFou1om+WYce57mB9znm1xy1Zu/cwK/LzpJBK9lgDkykT5GFp10uUqYKWEPpDdukv
	K+IzhvclPGLAcrkqDgq3mAy0fPn69zzbBnfK4OhidHSWZp/7aqfqcXZA3lN0ev+ZbxoMf4xeGBG
	25URvudt0r9bX8PDJld/0/Tsi1hHRmBCUI5YW+NNUERRME8/mGGJY2M6eORvVeyG6NgU/1yV2yp
	zcl0Be8aJoWsX22IxzyfINUoGIz516D1RR5Eq/skK+ezLaggQTx8tMMTliDPNPOr6YFP2aJkeJm
	2wRliup6N24nr0j1CV4MeFkG2xSNsEdgg4MmVf8XbIGgCiRdHBuDnZR3cluSFn+tAM+SGbA6gbz
	RnMIeEy5nX3ZVSJkTv5rKYz9NnbUrYw/xQkMih3YxrsAJowEQ0nu3rQGh7EmxzvIqPuk+DHwL8I
	pCKfw5uzJx8zu5RmAZbthJppZFm22on3AFGcj+8RKOXT8EcXbNELJ6+QgqHvctCF4SnRr7pLSsn
	x+5yCFwLZiNHjwPw16HA8Dy6LeQty7O3f9qd6Pxtpp6mmaZW9X43JWQZgZKEAeIi3xJQI4Tr4up
	p/2yWJr1ZhHkhCHqLoJuu0vYLjqhdwDixHY20O2yYpDk6Pz20e9YFdsHFPBgh66uvrS9beQ=
X-Received: by 2002:a05:6a20:6a22:b0:3fa:df2d:d3cf with SMTP id adf61e73a8af0-3fadf2dd8c7mr2922085637.14.1794813844225;
        Sun, 15 Nov 2026 23:24:04 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f133:af41:7614:f46c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4e68sm3816508a12.25.2026.11.15.23.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:24:03 -0800 (PST)
Date: Sun, 15 Nov 2026 23:24:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: max77693-haptic - disable bias on failed open
Message-ID: <avqvjEZfFOzvRdXe@google.com>
References: <98F5ACA9EADBEC89+20261116022442.3298673-1-tuhaowen@uniontech.com>
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
Content-Disposition: inline
In-Reply-To: <98F5ACA9EADBEC89+20261116022442.3298673-1-tuhaowen@uniontech.com>

On Mon, Nov 16, 2026 at 10:24:42AM +0800, Haowen Tu wrote:
> max77693_haptic_open() enables the MAX77843 bias before enabling the motor
> regulator. If regulator_enable() fails, the function returns without
> turning the bias off. The input core does not call the close callback
> after a failed open, so its bias cleanup does not run either.
> 
> Disable the bias before returning the regulator error. The bias helper
> already handles reporting register access errors and is a no-op for the
> other supported chip variants.
> 
> Fixes: 56bbc99e6914 ("Input: max77693: Add support for Maxim 77843")
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>

Applied, thank you.

-- 
Dmitry
