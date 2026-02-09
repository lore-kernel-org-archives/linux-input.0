Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856153644BE
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631566; cv=none; b=G4d0s1Rb2ITXPMpMYnREuVy8yC9KxYMwfgIxC35khA0zNOLl6Vx4TMxZbGbVbagNk64r2mcOBj8HnRovUNHf91+CKiJZU967YGHVEez5WEhrmQvMMi5NWqOv0SP7afCuqYVoEl77cBCHHGwQdDZWjO4a45Lmt+J1OGvRvDl08BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631566; c=relaxed/simple;
	bh=ktBNYdWzXN/A1xozDS+kqmFY3+NPo2micQEXYdF9S7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEoV8Vt0D45iBsdHtnwlmACpBx7W6i2Iv0bfEygvueiNU0iSRBFSz5IUaIo5mJVo7aZe1IN0woeujZ0whED07Azw5fA5GbP8tnc1t917K1rzSSPO/llbhu0PWk3tVG16ttnoU01k3Hjj9c5Acgu6lTwoxQce8T+dSW5+fTqrZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IcuAGmbD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IcuAGmbD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806bf39419so32420655e9.1
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770631565; x=1771236365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0dLY4trYV5gv/wnMZ8s2klnMyNr2VH+hAlexQTTgvs=;
        b=IcuAGmbDN/gBC52KKRldzTIESjgxjAP7na8w2ce9YVT84Ofj/GVC0y9z3BDD/RoMmA
         HypthDf0qmnlhSY9KeekcgSvjSwYxYGA/Z1qbCjfWtPw8vcrdsZy0v00et7VnjE7QkTC
         EbKz/S76n/j2QuvNKG/oIqt+iQb/9KaL0pHmpKTG5bG0ChMdN6Sn4Fq22YErCAA+iNh1
         Key9yhG/uWiVNIZvdQarggp7u+wTfK+Uc12jx93IzN+QUUom4UWGuTqRqVBZekpB4Oox
         mJoLsvhXq9ZNQLjYWSq0h8rTgulZxuH2GLgZGEKgpImlBpS0jMUdGp+feckZlI/279y8
         0SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631565; x=1771236365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0dLY4trYV5gv/wnMZ8s2klnMyNr2VH+hAlexQTTgvs=;
        b=DrEN4x+xF5Ci1zFR6bSPQt/dYezcwppkmiZQgPxFKP8J9ss62JXSUAGFn1z3H7AOgx
         MMmP4aXSSJfqhAuCGvfdMgkzYxZo6XNP0L8cJuR/gQ9rrIp//W4kLazrlJZxyjd+9q01
         +40lReNEKybBJ39/EBU9aPYzTKN/Isa0V6RVJoSNMnho7VEQtOXtwCJYBxKzaqIFIuLc
         e/2CYfaE338T5UP78JUWqdnIlo1wjqXPsUw1SKcUTqO56I96iJ2GcSwzO2wfsXYJylYP
         aOaOfkxTxSC+elxR1jgFgcKpzRjgop6UG2K02xsVZU/nr2z7Wx0ub8oTAcCpPhdZ8rgO
         iPbg==
X-Forwarded-Encrypted: i=1; AJvYcCUzYXVv0IAOSddHOeUga/M4f4DAqU/QG6J9qkk3xTn7MChAS04jZE+btagEe4Nsyko+kbQrLT1BwNHFRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj83bcMm/K7i6tvFBvZ7SdELUFA/SDKL5F51BwPBrnypCAsvZp
	XAPTbdEApzZxk57miaSGmXaNtxVxcAX4BMtcXionUcfo41qMNHxVaCO/VbiNJtsTgfw=
X-Gm-Gg: AZuq6aKk+e0ONTsg8zSBbc0ge+1haf9VZxv1jYx8M6IoCcqpEEw8XDPZISisWpg7MUR
	Apg5Y6GkX907Yq2VGUL93azu7VZfWTb8+DcmRrGE7LUp7Rm4LUMfeMdhanFlPsCXTa+O39t07gA
	uNZl7yQyZPVrC/Bdug87UoMmW3dQRaM6TLMTrVvqHxRPlDqfWs3UrdcmVVoGSrUFPvywjXsjqn/
	02ShuxSH1iJ/7keix33HSwQmMrUa9Kbwp5fdPi00wsmqogil0FGtlPg3zJ24brqXRHK3VtrRSKA
	1ySVoXpvvVuhdaQ/qsc3dFXce/5EtF+IM++YOM5c/lWhzfudGWeePRI01n3uiMyZXvyftFQi4qF
	8vWyr0jshkqXy/YyNPUUEll+zYw33D7cxDurgRBDsKsivH0vicxVnuLdKZvIPoadcDeVYao+fwv
	JLwjAX6Ls1KuzjvhVKhm1DiTtvYoR8AbaKUrVs+3tSBMn9bNG/ZWRL
X-Received: by 2002:a05:600c:5884:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-483178e11bcmr154203285e9.4.1770631564829;
        Mon, 09 Feb 2026 02:06:04 -0800 (PST)
Received: from ?IPV6:2001:a61:1376:df01:e943:d12:a8fb:e1d7? ([2001:a61:1376:df01:e943:d12:a8fb:e1d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm118531335e9.6.2026.02.09.02.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:06:04 -0800 (PST)
Message-ID: <a31763aa-77af-4e13-8708-b007ed53277c@suse.com>
Date: Mon, 9 Feb 2026 11:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbhid: tolerate intermittent errors
To: Liam Mitchell <mitchell.liam@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260208-usbhid-eproto-v1-1-5872c10d90bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.02.26 18:10, Liam Mitchell wrote:
> Modifies the usbhid error handling logic to better handle intermittent
> errors like EPROTO, which should only need resubmission of URBs and not
> full device reset.
> 
> Reduces initial retry delay from 13ms to 1ms. The faster the URB is
> resubmitted, the lower the chance that user events will be missed.

Hi,

in this case I have to ask the obvious question: Why wait at all?
It would seem to me that if you have spurious or intermittent errors
the right time to retry is immediately.

	Regards
		Oliver

