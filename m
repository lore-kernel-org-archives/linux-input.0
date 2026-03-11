Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0030EF8F
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251436; cv=none; b=M8Eucc/lNPcgxrNOmOI+tudH8bH5sbAzNPTcCgwIrIuZMso8Zdlq5pX5a7xLSLoJX2pDTk2tVITOqWyDuB3tlzDlofaZh0zKnMcGjA512aOJy0BQuwTX3CnuoxlesM1j9rXmi3qef8XP7FUFV/+P1iRoJaFZMrE3nF9TG+4Li9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251436; c=relaxed/simple;
	bh=AqtE7Woo2wJkk4YzUSo/ljmI6DBc2LqEBMpIQky+d6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj6mwRpm9fVhp432UheDKMKkO2lHK3KsqJlLJz7016VI3iMQiUkBIKsuel3IfDa62FhCAZMBnGJn1xxVrqEznq3bFQ0TxrjRmz9dT9v4Oh//ploi3eeNzq8QFNS6VavYuzxcb0k80mb/8TzbWqG5OMMq8LJNdMB+rTXY0nsGHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CH25+LoT; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH25+LoT"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso174148eec.1
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251434; x=1773856234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0C7idNGphygpy7RxPPF10pjDsEO+bsMCLejih4BdrII=;
        b=CH25+LoTfib/KxbnVuUAHmRSaAZsDWguSCH+OoBz1DXZStyFlwyLHFjThbu1fSXVU6
         w5mH6Oqm2n321jjEcdJ0V22d7wYK1SQB3p3Xczj+TXfwyIxPb9xe+ve0hrcTNRX0/Kzr
         DrW1u0wXcbTKBPbuH+hc43OU2St/M/YWT9BEiOI8XwsBwTF66ewOGiK3HnE5EnqvhlGM
         07RkVpxSgoQwjXWHDW+jUczac894NSXHcF81eX0G5Kk0Pki4WrKaweX8LnaCs3IFnpwE
         RIB60mDFsBNBKkkYHHezbsZQXsPncNQtui2Hr4uYwqfd+vyP5iXR1ZPiwOP5zjMr1NAB
         o75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251434; x=1773856234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0C7idNGphygpy7RxPPF10pjDsEO+bsMCLejih4BdrII=;
        b=Qn7XHtHvJIclhlQ9HifKwVr4IzGrWBzKRdyWXi0tKKuWVMPVxpn5ch1I+wo0Lf8xMZ
         AGMMMbSXbIYqJByv/58enu7NX5HBu+0BZA14+X1ZUxUGkFoDmO8YZ6/nzwUfvfREXFqO
         jsFCkgI48AIqalRd8XXVPZGSbtlBYJG0LdmEn1kNll3RMtiy3INiOq1mUFbMe3q/v/y8
         mUK9qu5ZlOpmLOp7DZfnS+gx7vnpMyOeI5l0iYaS8aL5zDvcJx4D+4cWepwRQdmhTC5L
         33ggThaQd8lBkt8d8Hzc7pFFo3pE0IPGXDPpqE9qX2oFJkVmf0iRjyiPZdWBdwJXwBxe
         cCRg==
X-Gm-Message-State: AOJu0YwZYU+bocfSp5YinyZc6hcW0CEBJS9jxEA8g7lM5ER/GNX8GhiK
	vB/1mrASO6qs3F/GmpPy3DeNkH14nXj/K31wmR3PItjR/m6+GVmmmvDw
X-Gm-Gg: ATEYQzzaC7KbLZ2SAJmjstdAaLpfkcU2MTMVmrDnNjdBg2lft7AjXXbe6YgVDu/HVp6
	mhfdNZq78XQxxzNgtnKygphibqtI/JcqGlUz3vsNjh6qgcHYGXfC6y5GcNAAxbrH7PcE05jmoMe
	PAjHeh6q/fPHJxQ8xh3VzyFIpYtLkfcflSzJxp2luW0SqPX00n9pRFPtmR+Jn1fuHzYoMDKkFmO
	tl1Q45V5Gmx+n9GWKfFGBhkvbjZvLnSOoJy1y4rMKMCC141iM8x4/fFJkO5dFQBHg4t+kMqUDzb
	0lsWZIdnRjDnwmVUmbDPD/ZLon/L73TRqe81WXl8yksIu1fUAqdqguVNp1F7qHHM6AJewKH8ni8
	p3ishiWF5RAHKj3+Cg/W1W+ONpbpu+Syt2LNlGkIXmizxoc/Pq0af79dfND3b7N0BwZEq+hySpy
	Wi+pb6Vwh50umn55mgZ+naHtVojs60fQGPx7iaYtDbhHIesi/IEffOKkOpq2jya8j9
X-Received: by 2002:a05:7301:5795:b0:2be:969:75f3 with SMTP id 5a478bee46e88-2be8a528f33mr1232940eec.34.1773251434418;
        Wed, 11 Mar 2026 10:50:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:53e0:5b17:5211:b0f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa4eb92sm3729992eec.22.2026.03.11.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:50:33 -0700 (PDT)
Date: Wed, 11 Mar 2026 10:50:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: mikhail.v.gavrilov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <abGrAV9qmDGI6aJA@google.com>
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
 <e28527adc34ace88462f2fcce53ab8586dc760a7.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e28527adc34ace88462f2fcce53ab8586dc760a7.camel@gmail.com>

On Wed, Mar 11, 2026 at 10:47:25PM +0500, mikhail.v.gavrilov@gmail.com wrote:
> On Sun, 2026-03-01 at 03:36 +0500, Mikhail Gavrilov wrote:
> > A lockdep circular locking dependency warning can be triggered
> > reproducibly when using a force-feedback gamepad with uinput (for
> > example, playing ELDEN RING under Wine with a Flydigi Vader 5
> > controller):
> > 
> >   ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex
> > 
> > The cycle is caused by four lock acquisition paths:
> > 
> > 1. ff upload: input_ff_upload() holds ff->mutex and calls
> >    uinput_dev_upload_effect() -> uinput_request_submit() ->
> >    uinput_request_send(), which acquires udev->mutex.
> > 
> > 2. device create: uinput_ioctl_handler() holds udev->mutex and calls
> >    uinput_create_device() -> input_register_device(), which acquires
> >    input_mutex.
> > 
> > 3. device register: input_register_device() holds input_mutex and
> >    calls kbd_connect() -> input_register_handle(), which acquires
> >    dev->mutex.
> > 
> > 4. evdev release: evdev_release() calls input_flush_device() under
> >    dev->mutex, which calls input_ff_flush() acquiring ff->mutex.
> > 
> > 
> > 
> Hi Dmitry,
> 
> Friendly ping on this patch. It fixes a reproducible lockdep circular
> dependency warning in uinput with force-feedback gamepads under
> Wine/Proton, tested on 7.0-rc1.
> 
> I realize I should have included:
> 
>   Fixes: ff462551235d ("Input: uinput - switch to the new FF
> interface")
>   Cc: stable@vger.kernel.org
> 
> Should I resend as v2 with these tags, or can you add them when
> applying?

Sorry I need a bit more time to evaluate the patch. I think what you
proposed makes sense, just give me a couple more days.

If there are no changes needed I can add necessary tags on my end.

Thanks.

-- 
Dmitry
