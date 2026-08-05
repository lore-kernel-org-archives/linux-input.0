Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48E17B418
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904175; cv=none; b=kGEYr+5lPlYWRh5vgWc9uSPC9r9x3CBspTXqcWQ1Sb4sr6F6GCU3wU7G+PXxnh+zZ7Bq4htdnmKxaCbXVOXF3dlz+vh3kyYCkJ9NULHWmXTgNmzKwQ6CYDqESa+Rxgi/WfCf7T8fQsEqyZSCzhidchaYsG3leivGHMiGpS/zqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904175; c=relaxed/simple;
	bh=c6qaAcE400LJQHv0RvofYMrC+28wDjxX/9YIHIm3+ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPMhiAVHXMegXZdpji1DdDuaB1XpXrd4wA31HvRBvwkRvXpggKECkMSIms89WDGTNp4zAHgWSmOy2dCmzIjPhtW1cWKO0QwrB0pjJAOe5BSqw/z21lFZ57eBsCg7DmYwFsBGYHoIrOrn3kfxm1KszYOYpTET45qEMHZq/wpy19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SprYMmcJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SprYMmcJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca913a601fbso456354a12.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 21:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785904174; x=1786508974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CsJQ1UBzULplQjauLQuztygbP37D8KegaQ/fwFL4BdY=;
        b=SprYMmcJeiLourbT8vmrrUv+HGexNhwXAW6c8bl6FcjRYDHpFfGYgdX6OfiUtuCdEH
         TDhbfh4QS2CgOXusMlDzdh6TWTvwBWtg4AEsKr+IMV4LIfkyNw6MYh6OHwozKBSP2lub
         zxog2D12kyPHCAIn8YuZ9TArtJOR5Oc20P9zl8JZdnljMyTbokcaqqPoRw9ED0dSIVMX
         2KSW3gx/g9J9JyqMCVd2jBliOQ0etKIimNzAn4wuMiA1B5abEJHvP0dNCXOpWIKGKlnQ
         T1w6TOTJ6YJFhDNI5fgIRp37uUNbXTaOVSOtyz5hxm3dx7r1joqOZMvDZa8n3pqbRrcL
         9XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785904174; x=1786508974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsJQ1UBzULplQjauLQuztygbP37D8KegaQ/fwFL4BdY=;
        b=YaCc5NJcPh0RFZaOyc9QDB41FAuEf46b03ZGrFBEj99wVyj7yewWA2+2ctG1rK29+s
         yjbwqweVA3j27o2jnLRDlWkDx2jai5TWo/qujSvgL4UYgSCzlEKYugvCMm4Vwkoyz+eM
         2/p2Km/8S4JSFMaVvFDxqwGCzuQXlGde+4dvHCEPZWY5eI8e6/jnpHAh6W/I7pbEinGX
         dKnBhWSwFeJncOUvJwjT7Vr95otMwzo6mkNjmk0+Jla+DkCnNj1qNOu0OURD4DuTYsC3
         csGoRJiK9GBKpSjHdMnnFTfZi7KQSzvpnZWncRm1YlQJD+rPDqXLm7w0cA0TMIFAQFL+
         SVhg==
X-Gm-Message-State: AOJu0YxdM92BZGBjcBeRbPeoIXUYiYyHqJCfHKYGc1+e4eIaWLhjervB
	mF2fqmr5KVKmU6G/L3upbIUKU/4igdT3nKYbNQP3AzaYg288erQO43wm
X-Gm-Gg: AR+sD12t5ok/l0TElnEoqHzO1B+tdMR4rcoAOp2pgpJDu2+YhivHKoO6fHk81q8pgpl
	F8zzPu/Vf3WuT1vVAR0HhcogL6aQTMqUtsnPP2wQRVktbmZ0fwAHRWcDz+yullEJoWTykDq/lRQ
	yt8e+0rJSV2QfcT30cdz1tKMQHZaTqMyyc/xATo1TnK+xs8CabILOlCtbAf9mE+cOn1+3fLsHCq
	vHqzPUhM5iq56y45tutmIeNef1Kzk4Xf/3BA6qWhINkja+9CLX+QzgkymG4VNls9/hY52w94fex
	JAfUZ1kWJkAYqXv5Y7KDdmSGO2vNr39TD3hsrapVQFEwhYq//w6vCTBrtH9wkubxXErYG4ayE0u
	nI/a2+W65HApD1tL3hfcxbGwN300UXXk74CTkFU/YxVkb4uzGratoGKQkGncio8H1/qQnXAie9d
	nIpCbci9dB8K2KIGbl7ytdZwAkPUNlOHuirZY/HfDDbwRKXcRGbHZL7hB4xZIv81XzWnExoT1d6
	0XU4vhLwn1Z6b/qe52V3H+UAvFAgQ==
X-Received: by 2002:a05:6a20:6a06:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3cb85df09famr4045038637.3.1785904173734;
        Tue, 04 Aug 2026 21:29:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc261sm10862873eec.28.2026.08.04.21.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:29:32 -0700 (PDT)
Date: Tue, 4 Aug 2026 21:29:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Input: clean up conditional returns with no effect
Message-ID: <anK8HVdQOuJzgSdH@google.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729171001.260698-1-ekffu200098@gmail.com>

On Thu, Jul 30, 2026 at 02:09:32AM +0900, Sang-Heon Jeon wrote:
> Hello,
> 
> This series cleans up conditional returns where both branches return
> the same value, so the check has no effect. The Input patch of the
> treewide v1 series [1] is split per driver and posted separately.
> 
> Patches 1-2 are generated by the Coccinelle script, which you can
> find in v1.
> 
> Patch 3 keeps the check in synaptics_i2c_reg_set() and returns 0
> explicitly instead, which is the preferred way when there are
> multiple failure points.

Applied the lot, thank you.

-- 
Dmitry
