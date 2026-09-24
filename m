Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062E2DBF75
	for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240473; cv=none; b=AyYEBnQda6+V5TeOyndSxoq6DxYqh9B2CaGW8A6gGDv2oA1flNRs3bm6130hV6heUSk1ldy5n3X9aohrQm/agfvjis16dTSbFXyF3cQzlYYSKf6ZLQSLng50yKQdw+IxUSbBjKyj42dTi+JMtHcjf5cJRToghU/nnZl7Ckk7CDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240473; c=relaxed/simple;
	bh=VwobRVpYjANaRMwKe1VS/B+7A4faDHmtP7SCe6Ik4Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXSmrcUhVa1S5Jq2xd/iWVaT34gCI+KjMMDq2ILhzerhjx2OCkEa0zZkXzb37EM3SlhdP0cJQAFzVRbjqdSDJvTKIIR68+0EMWmlnjx7ZmQqTyGe3/jjgPOjlCZYSvzdQEIkc17ZjwkFTOmKzTPjqes5FE79Hv2YoCUyjfXmfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jlMwOUoj; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jlMwOUoj"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso287038866b.1
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2026 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1790240470; x=1790845270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VV2A/h1hdmSjmCuEGrBZoGbpIoorMrIlLJZkmtVMN8E=;
        b=jlMwOUojVDcAAfPez3FOQ/jbGNvuWPUs+W1SJft2w2awaQ2CNY8uLxCjyZMj1rFkBT
         KEk37cB/YHKgE37QYai33SUmCdPEC2HW0oLgtFhEOHMzd8mNJV0gFzcl3BzBE3/cz1Uy
         rffwurd/UnhBQ4EwG8cvuVTJlPxZ6QjK+y8tiSTBQu2EL3n5UP+Ob6voSiTJXI1hIVXn
         1eeRexy7zHnZ5SyJMQ6jPdnGV7/rxwUqCCV2jZ2L51vay5s2U2cJDw/oZMYhCd8KkNSL
         LAWIm7Xba9gAAhpfBUBF+WEoKoa8l1Kso8KX69XL0jxS6Zu6Bpy95Il1lNMbOF6Eot4X
         z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240470; x=1790845270;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VV2A/h1hdmSjmCuEGrBZoGbpIoorMrIlLJZkmtVMN8E=;
        b=STyTY7Uc/CA7kcwekE4UlrFK7IPGbRT0ReZsKB9ndETGjjFyUEz5j3aKzkdBeqkACm
         ONyniDLS13TCfdZUvfcGYBxjBCbLx8T/8WRgy26quhaNIIosmcH73KE03rpb25Ojk69R
         yXlgv2stkKyuFtv/olLHmoivigrgeLaX0U11UVdv0j0nK2MHB6Fi3SNn9MUvFwqYsvPi
         lL3hzwlefGYhtAbUK52mp1jXlm4oe5p3KVxq8bJB/y7pXJBHJ+EUwyaaVBtDghWHIid3
         RCvOxDH7mjcbTYY549WUFuoSyEZ4LRCxJqEDCbOw+fCXI4fedsVmJl6fkPyhOJgjtQ3J
         T7tg==
X-Gm-Message-State: AFuF++lqLb4XcvOd9tDC5yN7B6Fi34iwlklFs1r3JiEyGZP8UCC4fn9y
	NdfbTAc2jS/LE45dxw0o5lB6ZTxgl3sY5Pn1RG4ESUThJp6W5UFFvkQq8s/tpAGx6as=
X-Gm-Gg: AYBFou3dVAoYR03z+u5F3okJRUjF/f4Pt3wP5USOBfrWm6Gu04Aj6g03xHzttc+b6j+
	4v3PFzqJlhUHR/Yq5sWMbDYZP6bkYr9uf6Ur/sRWcN19Pjpx/obNqzy2QIfczR2r/RuL2obaFaw
	UlW51Ec1hz2yafNwknoYnsMrLxPuDjGomgRd02Y8t8scVEKSoSBWDmFPdYg2bcV6HiPHaL6gv8J
	MD176WS5xvYcfjWByCidZUftgFQpwQe/+OBFWYd5+p3wyJGajLEyfT/9mntoH+XzhkrqoBVK0Lh
	kPYoovPo2yzY3gvnXLIQKjLTyuo4AxznHpa7OxldNPPcHuaaSTv8i3JiMm1ztT4nLxAkrmwYOx+
	KbLxb6wIBehD43IsNAy122YYKZzUQuIRgOlDXWLUpkc7SvY9eVvDLM/M6lqyODKSKxpBsu7W5DO
	pfZ2ViMwBkc377F5yuIHCA5gVtIThA57qPY8Y0FjaukAywINaY9BWeM1KtWXoIGfDX//745H3o+
	lX32tBq33+QUBE0E40BbfMGd2hvIToAgsMFbX0fa0ImMMfhSwLgpXKM
X-Received: by 2002:a17:907:96a2:b0:c29:f5d8:9c7e with SMTP id a640c23a62f3a-c2ac22cb906mr148643166b.45.1790240469960;
        Thu, 24 Sep 2026 02:01:09 -0700 (PDT)
Received: from [172.16.220.225] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm273374466b.15.2026.09.24.02.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:01:09 -0700 (PDT)
Message-ID: <7827fbba-b8e7-43f9-ae80-caea7f191d2d@fairphone.com>
Date: Thu, 24 Sep 2026 11:01:08 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] AW8695 haptic driver.
To: Val Packett <val@packett.cool>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
 <c49fe267-7da4-4b34-8dbd-3536a327423c@packett.cool>
Content-Language: en-US
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
In-Reply-To: <c49fe267-7da4-4b34-8dbd-3536a327423c@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Val,
On 9/15/26 06:14, Val Packett wrote:
> 
> On 9/14/26 11:37 AM, Griffin Kroah-Hartman wrote:
>> Clean-up of the aw8695 haptic driver patchset that was sent in 2022.
>> Variables dependant on devicetree have been hardcoded, and unnecessary
>> functions have been removed.
>> [..]
> 
> This looks similar to aw86927.c just with a somewhat different register 
> layout, but there's even the same waveform and so on.
> 
> Could it be better / worth it to do everything in one driver (aw86927.c) 
> and only have different register accessors per model but shared "logic" 
> overall? Or would that make testing too annoying?

You're totally right with the similarities, and the original idea was to
add on to the '27s driver, unfortunately the register layouts are too 
different for it to be worth it.

> FWIW I've been trying to bring up aw86224 which has even fewer (but 
> still *some*) differences to aw86927, so I'm potentially interested in 
> having a unified base to add it to (when I figure out why it's stuck in 
> overvoltage protection or whatever it was..)

After a brief glance at the register layout for the aw86224, it totally 
seems compatible with the aw86927, lots of shared registers, so I 
definitely think that your approach is the way to go there.

> Thanks,
> ~val

Good luck with the aw869224!

Best,
Griffin
