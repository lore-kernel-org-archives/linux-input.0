Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822A3E3153
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944283; cv=none; b=mTbnyYgRb27paM7FQRNPzR8dScHI9z5WtGizbFKUdO4JL1BMGA9nV7u7KEhcygh2Acc28bDtoN1uSJh6boVm/0LET2hQnfkus1YCXPiKdUClZ510jdAXSLbIPPp0NUOFXetGJIYxt8yL65wylIAYxv/GA++Pus6QkQC9SZVuBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944283; c=relaxed/simple;
	bh=j8DzpVzKCPohAN4GIc9hsJHXHEG3dHjrBsy5G02GDKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AerTHKCtpGgVF5IkKLyWxd+ZVn9Mtxyonn0uJpgiP2FxMEJZd+/JdLpgR5StOrm7sU3mpaOqM2Z+HtGmKXYN5ioDuJsG8cLXvN1cnjdtNMKnJKQgjyp+YedRNtS6/RfoTPzAKqTyN65ZyFiX3DZTx38VAG+uXOuVNuEkXNwr66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcYFd4cl; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcYFd4cl"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso5673560c88.0
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944281; x=1781549081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxyBcgcYevr6p5KeSHkchlx6TrrFrr/53KeZylT/cHk=;
        b=LcYFd4cl7pfMUlRn/vLBMRCl+AMX5+N2e2KIkEIXm7dm4cFIfTozzW0b0LGuBoMAsv
         3FDbi7lcd6d9B4b4zODXga3XAyl7w7JsNKlGikNpK6pxbjUgjCQdmwVoQVqSQkNKUmx7
         JDJ5p6tcq9UzoAsNrXW3/wnHHUIcNG5NpKwf7wju5tY1AGYg3vol7TLMOQZtJejbmOu9
         UrWvUejMueR9Pf/Zjr0UESSokrEiG4NNqzZQZ4znl31VCjgx/jDj3QyUt1i/Xf+IPUKH
         /zfVr+90ccz+VKpeMSU7JYLufYbQ+sk9FazW9g4F5pmCeS+UoJX35TJuf5Xv//ofSmdb
         izIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944281; x=1781549081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxyBcgcYevr6p5KeSHkchlx6TrrFrr/53KeZylT/cHk=;
        b=WctZBMicDe/vSSu9mungcKVCfynYxtZxGKMsS7Nd6Y4HUPxjP6E27tCs1lDmcblsx/
         OBrFO9QXQKfqwIyD/YzItk0pW+Zl/ZePu1vvjt6KID2xILzi35fbllI3UZIvzWh09syN
         xHgQMAhN8CUGt7S+fd24zNNQh6FwngjdH7Kc1F1S0cUzmu3S4+p2Nw459JRXzc01Y5tq
         KEclz/PagRMCH+fqCxZ0K/5011Qco6GlEf3qSHFxmSTk5IO1/uZ88BGaTDnNZU8JXGzZ
         2/dhBzFVklaUici2/pp04ootHUsKC/ljG7zLJBUJGg30eqqg3OnB6qwpS84+yKTIMRmO
         OV0g==
X-Forwarded-Encrypted: i=1; AFNElJ83aKxFw9bVr5WI/xeBL+NLm2tSBuc7Oi7RNNJTtFm+sox401ORgrkg6ACZMQOKnc+gJf4reGmLHQOFDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Ffu3vb/Lk9h5RA+ZkrXndEHj9GKh3sJ2fdv5/CWsqMWh4w80
	vw+7WR5U0AYh6lDIWz+F+Xpwu1bHw4W8QuxMqpwoYWnyWvT+Qf6VFHHE
X-Gm-Gg: Acq92OGZSM10wMs18ZQej7SqPtPEgoOGseO+HGsrlDxjpVJ2r91jVbzpFckFuPpFju3
	nvDuyCLInVpm9AbUUUGjEMbb9kET/qlj8by/RanV0yr1fl0y4xfWRsJE4Fgx8jHYPskmLDIjnie
	5AJFfb9KqwQxfMrBPcQUzrV+MGrHfbVYfSnM47bSHBJOi4mYo46j1ya2vk9rPj/YrBpk3FGoILI
	pnwRPUPMQot2rtC4cCK0tKYyLWasXGjzytQLHGGYZ5oAxJ4Ar+sj0BiKjHlwqO5uEWvDKIWgddJ
	c8eN4GIAkqtlROs4Ji7jh2CHQmO8+MSTKWnu7qsj4c+dIvl3x7a0RSnD4DTMxQmneg79q7ToJ49
	Uo+NrxBcZm7tYAo1ibgCQsbdm0Dpd9aL5wIL3npdp3jZ1/AV9I3P2YzzcLUyPMoidoIHHZsQMNg
	WDPiRrVvh+kpHKjWLtGD8dO/jtFtpl4x36xb3JUTW1235BlYbYqJAFZTfAzZgQYSm5LUHwvA1s4
	8c=
X-Received: by 2002:a05:7022:6b84:b0:136:9ebf:3bf4 with SMTP id a92af1059eb24-138066e025emr8220847c88.26.1780944280825;
        Mon, 08 Jun 2026 11:44:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138173e5b47sm5980727c88.8.2026.06.08.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:44:40 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:44:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Heitor Alves de Siqueira <halves@igalia.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, kernel-dev@igalia.com, linux-usb@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+563191a4939ddbfe73d4@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: hiddev: Use kref to track struct hiddev lifetime
Message-ID: <aib06cgHVLIb9vtl@google.com>
References: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-hiddev_kref-v1-1-cd240c95423f@igalia.com>

Hi Heitor,

On Mon, Jun 08, 2026 at 01:33:03PM -0300, Heitor Alves de Siqueira wrote:
> If a USB HID device is disconnected while userspace still holds the
> hiddev node open, hiddev_disconnect() and hiddev_release() can race on
> the embedded existancelock mutex. Syzbot has triggered this with kfree()
> happening during the mutex slow path.
> 
> Fix by introducing a kref in struct hiddev, and moving kfree() into a
> dedicated release callback. This way, struct hiddev will only be freed
> after both hiddev_release() and hiddev_disconnect() are done.

This looks like a common issue with usb_register_dev() that does not
allow tying the lifetime of the created device, lifetime of user of the
created device, and userspace accessing it. Ideally the class device
would be embedded into struct hiddev, and tie its lifetime with lifetime
of the chardev associated with it and userspace accessors using it. tie
its lifetime with lifetime of the chardev associated with it and
userspace accessors using it. See cdev_device_add() and how it is being
used by multiple subsystems and how they handle class devices. 

Thanks.

-- 
Dmitry
