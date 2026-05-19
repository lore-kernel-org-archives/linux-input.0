Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15513E316F
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225542; cv=none; b=fP6Pq5NqUyx7KoKevMEs7kTdq+f4hsomJtnP4e9Z1FTHudXs5KoPelytJq0lclRSuW/UjUUsHfLjFYkcLreXGCQlIkRNheBst1oRqPNlHxFMeaSTew9UJ1yZ+9su1OydodU/c47SZKTygOXmrNT5pgjHjrCqBNwOjCf9UzVu0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225542; c=relaxed/simple;
	bh=Ni1O+ttjWyFvVUKt8lAX7EvY2ywrQgWuW9JHDzx3ZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umd8UCqlGScOJdfD28n3Z0iLDqxFRUh8iDxjM3YSrWYy7a/DCI2q/YUHJ2rFF5GxePTfZG/hQOKxUKwaXetCpV2vOIk8wE4gKSe1IjEmjUC1OUCDEHB/AE6DRJFtxRMQpqC2SA95gsfzfo2Vx+CDIthOLSYytumjKyCHEAu+b9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7TRGzy0; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7TRGzy0"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30246cfd41aso1396305eec.1
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225540; x=1779830340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKFqPmbc0emHjl4Uy095kwQo0zZOzPS5AMfXrMiw7kc=;
        b=R7TRGzy0juwcbR42ITBbkFw5Of2iPWQ8Ce0qqTmsYS2ljM0kU60fKavISAKo1wcyN7
         HkBVBcqIT48sIckhn8aHALoqZKqJVLR3iw2FACz3utNe7u8g2P+R7dEQuglvG7NjeI/K
         LTv1FNa5t1ZccCKSeENhjWd7RZ0xnb5uKHN9LMnNvOJhuVQYL68rn/scDT7oRgA1VGp0
         RrVhzj5MHYdnVUxIkiL95d9gAz5RyzYH/Rvq8A7lMfPL6AYO1nrSxmRETyZFDybvwPTV
         KOiX2f2lok25CwwJzY/xpc11TUB/0u1sTHUma+ClrFk6Aln0W3CZb5Uf9NBi0ws2Asxf
         zjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225540; x=1779830340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKFqPmbc0emHjl4Uy095kwQo0zZOzPS5AMfXrMiw7kc=;
        b=NgCweZmbY8N+dGfIekJOVmHP05DNOKsZLKMefEqFEDMfx5qtiALeTjyEbH/KDn/ZS6
         Gx202wnZkVL+BSwZyPgt/mHRSQlasF1wpxcM8lHLfLLLtOnrLLaD43wnMBhHso3qgcJm
         zsC9+MHsXJm+uSPjzTw8oq705jrjpxMqgonIM88mbHi45AG0QpnkPTbMkq4fuwIa72sW
         JB1VI5Ry8M7y12jNail7eWZipi5K51e7UlAbyndMlPDRZcSeEtioWiVBd7vVRoB4LXxf
         e0AW2NxK83f84C++LEz7PBXDyOOssS4Er6AhqRIUPIsPxCRhfF6DZydkNDzgGShwBqe9
         iZcA==
X-Gm-Message-State: AOJu0YyJ0XTzmzrG4C2KIFyGvivnvJRWDeONG1S4tXaNjnCltASJfCuW
	ALpGHZ5y8c4TUyLyQC/GbZK5Xmyg4nvB88RXXdia6tQN2F+ECkGDgbVyl1b/jw==
X-Gm-Gg: Acq92OEyEqmoZtU4NeppFIaQJPnDlVkw8Tv4499zgxUptyFsol/04boIsAISHPq9V6p
	7g2qK3LO7UQ4zokhhS2cJU+J6ZLJT89GKzseYzkBQhaqzTrevdMIpZE2ohdHajPd7+lDzEok8Vk
	yEO95EJoKu7zneRRh++Kb3oJ9eQ/eegvcqZh6Vg3UqG3+DY02EGTMmIMeCz+HEpaQ3nAwf99vhY
	Vusi6HLUON5ieHZWwUFlE9xR2k3NihwjuIOd8m4UQFdhufrkHi9siXYHAq+JLwT7v3u5zQAJYnk
	guXmfrbIHnNGMChUutRWoBu1h6tz4CffodDvmh0uFZ5qEGKLrOUcFiMKKyM1z+CqP1NHEFxewRP
	pXvqOiWdOdxsFz5O08NlcboF8h5a3kB4k/4UIP4CCZHNXllEHjuuV5ffyevR1kHRf0f8iANQDOl
	3sxJV+L8fcymsB/xtTVmq9I5cPNZSPDg33oNN4brI45UxRj6yddT4M6BsTfHNMjm5/
X-Received: by 2002:a05:7300:a907:b0:2e6:e868:4f38 with SMTP id 5a478bee46e88-3039818b054mr10101619eec.3.1779225539795;
        Tue, 19 May 2026 14:18:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7677:c3e6:c92a:e780])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500a97sm19907687eec.9.2026.05.19.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:18:59 -0700 (PDT)
Date: Tue, 19 May 2026 14:18:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Justin Opini <opinijm@provdh.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, "Luke D. Jones" <luke@ljones.dev>
Subject: Re: Mismatched product ids for the ASUS ROG RAIKIRI PRO
Message-ID: <agzSfM3TH8Pg0M4I@google.com>
References: <Zjb8RrOFLHFSk_Gv@google.com>
 <20260519173800.6765-1-opinijm@provdh.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519173800.6765-1-opinijm@provdh.com>

Hi Justin,

On Tue, May 19, 2026 at 01:37:59PM -0400, Justin Opini wrote:
> Hey Dimity,
> 
> I had a question on the product id,
> { 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
> 
> This doesn’t match both my devices so I was wondering if somehow we
> have similar named devices with need for different product ids or if
> there was a mistake in the original commit?
> 
> My relevant entries from lsusb are 
> Bus 001 Device 002: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO
> Bus 001 Device 003: ID 0b05:1a3c ASUSTek Computer, Inc. ROG RAIKIRI PRO
> 
> On my system I have ended up using this udev rule for quite some time
> ACTION=="add", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="1a3c", GROUP="input", MODE="0660", TAG+="uaccess", TAG+="seat", RUN+="/bin/sh -c 'echo 0b05 1a3c > /sys/bus/usb/drivers/xpad/new_id'"

I am CC-ing Luke who added this VID/PID comboi to double check, but it
looks like there are many variants of this controller using the same
"ROG RAIKIRI PRO" name. For example
https://github.com/atar-axis/xpadneo/issues/612 talks about
0x0b05/0x1abd.

Thanks.

-- 
Dmitry
