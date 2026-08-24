Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDE386C3E
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597907; cv=none; b=etfjDcQKwcqHVJDKRZ2woUEG7bpFd0vIGiHkh1Szg1Aj1uz0u7PEc9OpK7v55LgNCmlWEaexHXqiX1cF8GxThMON7KSHOJsGnTWHLqbC/+9dOTRlmMkFGKNSVralpFUtO0AHTv/ccyLhkgA/qmKkaUOY+2Hoq3cpZ/flcWZAywE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597907; c=relaxed/simple;
	bh=wtdWldJsTeTf3pcflN8ScBShHNkZY1NU6W0jKWXyGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHLqhvZfm4Xg7k5FPhyCiFTwY5KDZckR0/nYm6ALKKrIHHpLEM2HQVrVqvGAVo4206pDv4iHljXLexDKGjZM500cQ8UgneSYaLRCXckzPLPRxkgiq1rXEe8dtVh7KBfKt9xmMH/27mMLwFdRIKkfIn+ULcrmkoawYvKHylxsVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=prRg97kE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prRg97kE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so4634031a91.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787597905; x=1788202705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pU8iKvq7pQX543KmDAfcUxWCdClWl9FvkSYys0sFYRc=;
        b=prRg97kEFSMDm2nRELVu6CtU9QIBz2kpffVPDx44OZ4ZKOg4ShMn46O7rLUyoRlASU
         d//o0fpybp+KPlrUDd9hkZyoojD3+Y/OY/pUz2F4r6WbQ02GAoQtFQanm8t8SDynM4Cz
         4FiwH1HTeXCeN2wukaElkI4rbZBCRyalm+gRdFsXVShcJW0BRmWYtcvNvYVm6UuIWocw
         HnUqsYLJkBznJT7tUn48SitQ7J4MdSy89uAEGN7depO3cYIxMZgpNo6kaTlttZMaYdB8
         Xp4KIdS2ipcMvwIoJCUYFGZU1pvd0Oc3fhtSKec0LkQgLxcucXXO8rIL4nsnM+XNJjnl
         OsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787597905; x=1788202705;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU8iKvq7pQX543KmDAfcUxWCdClWl9FvkSYys0sFYRc=;
        b=gthMq8z3bwdbq4p1yLIK2WCzFMj67LxF3dLNPj4fI6u4XPpbmKQiuV6IbkIJbru/j6
         ur39RkgIuxlX+f41RR5ZNXf1xBaJXNE3e12Qsgo25ouvUs0+Eaca5MW2sw+z2rYst4Tk
         GHRKKV9RfeI8GqLUu8yqdvaKoryqhYjDJX/xHZmn6V5Zo3N6Z9OSjC2d5edzl8wifCcL
         zlDERpxg8cdu27w/yut+zmRwu7b+OYVWv43GAZAe8s/DvI1hyg/B1GpD6lfnGWUAZcVP
         ftzReLxrEPwe66bbblz1ZIjYgAeNasmRJvR84yBINtDnL4eX5SYpFOaLsvvp0uDcxpZ2
         3wbA==
X-Forwarded-Encrypted: i=1; AHgh+RpK/im4XY1DDw5I+0dwO4w8TxW6rURKih6KrythzzQ4lqnKq0dRV4G/70Vl5I4YfU+0/bA27+g40JRX6A==@vger.kernel.org
X-Gm-Message-State: AFuF++mZtEufvxFIuodmdYg5x4QdBoroBK/hSOd8TQPbixewc0BRx9XJ
	heTbAaUVvXPhm/ysK380e+0pVtLd4nqnEUHh6v35HeTDiz/kfFJlcVq1S0T8/w==
X-Gm-Gg: AR+sD11R/FwD9uTszH6LHhvnyNhaKTg/zlFPKxWZHU2Q8TRA/Hb7zK2O7EmET6jZh6f
	S7iFJsFlmO2Mmunm/pVDiwSKfnmTc+ntmGapA7xpYQSrwhBWQEXLlpl1CBNzEAPkfefAxQgfzti
	qosXmzQtjlvCOt/SuzkjCG20/89VHlDE2OQ5y9G5c7Vz71nm/6RaqJHXngn5CNdHi2w1RoWgWG1
	PbT7pclUf/dGHsnRkQ3rIZ/x9eqkxPp6GYLL4noM/TGVJJn8WhX4z2SRBL13WBX8YPghXYUPOPd
	NP+N/4PVZkmZAFIyKNN8wpVrv5KUZISfOyETBNVoK1L62YaSqe28741NcJ8LTIiwko/b2J2lAF4
	3imEfPgpSp5+nPgSRl/a/dh61ilhukHUmDCJTCoKk5bVz30TWhF7oKB0NKTAIBL7xx1WEUwjUJh
	XoVXQ8Rkhblz0EFFPtDYap0mYRUrrQaURa8Dbe9rDHkHFYK14IbWKG4HcymjnL5TDtNB5cV6FIY
	YMQJn80pHONc+nAlcpmnOIcwc0S5w==
X-Received: by 2002:a17:90a:ec8e:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-395c2f2a10bmr51502265a91.0.1787597905307;
        Mon, 24 Aug 2026 11:58:25 -0700 (PDT)
Received: from localhost ([2409:40c4:e9:d213:be9b:8a88:1aaa:1482])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183f31sm23775606c88.13.2026.08.24.11.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:58:23 -0700 (PDT)
Date: Tue, 25 Aug 2026 00:28:18 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: Adam <testyiprywatnosc@gmail.com>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
Message-ID: <aoyO68JLUeCZbStK@eggarch>
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
 <aoC-aI_7Dq_nJTHg@eggarch>
 <CAEru=6K=P_oJfksvRf2BfHZF9AFrQD4=izAwrSsz_Xit_i96xA@mail.gmail.com>
 <CAEru=6+Lnwn+UHcpGA29gcET=ERgiYCOqkR0ijShcfOFR1m-1g@mail.gmail.com>
 <CAEru=6K8gYwNWHFoYmwpQY8GGJ3HrqoJxKyu41nSSGQWOTVOdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEru=6K8gYwNWHFoYmwpQY8GGJ3HrqoJxKyu41nSSGQWOTVOdw@mail.gmail.com>

Thanks for data collection,

I doubt this is a race condition, your openSUSE boot still shows -121
errors until ~38s after registration. Maybe the firmware has a window
after power up where its unresponsive even in good boots?

I'm thinking if this is a power state issue where it works in cold boots
but fails in warm ones, touchpad might still be in sleep state after
warm reboots.

Could you try performing a few cold boots and warm boots, see if
touchpad works after cold boots?

And when touchpad is dead after boot try running these two commands:
echo AMDI0010:03 | sudo tee /sys/bus/platform/drivers/i2c_designware/unbind
echo AMDI0010:03 | sudo tee /sys/bus/platform/drivers/i2c_designware/bind

See if they recover functionality. I'm hoping they won't.

Thanks, 
Lovekesh
