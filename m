Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D238462
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773812979; cv=none; b=iu00D1O6Mwb66+lGincfN2YAnt1f0QFfZkaMDSeEG5vP5zfR1uVqHUXnyi4vlM/HyGW2a/Hi8dT1tLoequSDrckl7GW4QeDr8NVMkNpwxXUSssXRTIVIeMiwnmEQHDZBRzNleK+6ZnOetJMOSQEh86cpj6DOH+QRjzyUaWaD5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773812979; c=relaxed/simple;
	bh=NqpgiLDqf9bodps8r/peqgJc11LkNBuj/Hhw1apBlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEOREq8VoPXVm78SQSfJ2n9zb0oAmiG0By4VppXHjTirJAEtk0ZR/qpovDThrlj71XJHnNwbN52b6su7PL9Yi2GVZQiGtcL1FFksLngRLWoDbv0ReztjLWDVSgjxjlKss+W7pj7aK8nDBbPjN1h/+DaK/hm3Ga0mBB9qXiSPPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENK2EJH3; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENK2EJH3"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6404392eec.0
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 22:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773812978; x=1774417778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXkrUplNInJMfmyDQfO7rf+b8M4RvjKyBssY4KRAMJM=;
        b=ENK2EJH3TSxD/1gxpTJ0hcoaP4z5J+4xIEUlcb6J0Hyvjg1fdupFgnwlDOfjnyWZ1C
         2NaQXjUI3DvMDIT5UDkLyibyRb653mvdzYw0/kX1+U7n1lvEEomKb5sEo/oiOHcbfz3e
         GB8HuOu39k+3Rhd+CSYV4FPaQeef8h8VpggqBG7ALuVQUOuhWs0dHk3yeEfvhG6xa1yK
         oIOhuPLO6zy4cW8Q8mgoKUZIRtod449VzpBVhfqrkoHFkbcTlKNeZLoJwpDvtYmh3B+H
         yTKyTxR6EXGzORscJERggR+mmIbvhov59RXkM9/usMV3q71eIdFK3FMdFLbYscQrvmOz
         OUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773812978; x=1774417778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXkrUplNInJMfmyDQfO7rf+b8M4RvjKyBssY4KRAMJM=;
        b=lLUnY+UwZnc+gQx1AHMAiVGKUf8Nsh9VfVczbrWIMKvxDeLaXzyusKxFnutn9n7olT
         pr0cvt4oP8iKwoKZ1gzzL4FEe49K5EmnnSlZ3NuCrEXJoVKCdW/9f/H+2czaDa65t5Gv
         wL2MRDzqsDSZI7YKhstedMWbdjBWgT2gkenqtvmlxR1UOij6phGear3TksnHWzHSbX2t
         XKsi/z2jkX10dVUx4Xw88SPx4x6c10tsaS7x4H0e1ot7HN3v9VtLucTqxFDGzwXQDrad
         ivIe3T2UJuPxMNXx8mUVpnvmEWjgfC83LTPTCYZXW/ZdOkOwd0NOPJgzKX4DDlh5QAjp
         gIew==
X-Forwarded-Encrypted: i=1; AJvYcCXmhlXU+UIbkk2My0cixefQX3N/GUvXWn6dNSKSrYZTLENvsErwgprXmIg+rC+ppKZtL9HfDS3CLdXL6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFUbFucwFWFSCcxFQB7M2REINUeDxiQ5ZYgNBBoxLXKhaSZY1E
	bQzVye1wuSOGB318kb0DdnxMlOPtMlSwuz8TFnNOmEKT3vyB7dUMs1FR
X-Gm-Gg: ATEYQzyD/MquogbX4vPmwKkA+86tKvAXoPyy81ALxnusYlylZioPnPd5KumSwRXpnDS
	1J1deUAubtou2d5H6ZFaY8MJ7i3o3ZVDN//8edhxQnvA3RMZ+/O1m8MsjnfiAumWML9RZprJscm
	5jYEhySjb1f1AOTLORsvIrVV4ozElvuNkkjkFsCi0bELPBtv+CojALw6JqFh52sWRyVnds+Hq8I
	dsLZJVjqbd9PwXCZqhmzfSj1i2Ezrcb5K+stng61ASzr8/z+PbZtOPMh8/f8np0CfnGhiiCd+UQ
	PZzSBBZ1AjxxoSpoL29gIViAN6PSFy4hQk1deJHqarsaEDv7tf5miL/VxlG5mcD3H0Z35KM5vfh
	Hc4y9BAUMNcHLu6RxP069lUmijGHVaYqeKKXdyLfTcLhoHLoUAogpSak8VKMoGWWJtUuZdL51h2
	aFPnWdKA1lXHwzS76bDB/6Vr0kjdIKComS9o2pZqzE6s5IN7f/ERXetTjq92lXESI9
X-Received: by 2002:a05:7300:fd0a:b0:2b7:32a6:82bc with SMTP id 5a478bee46e88-2c0e510fd58mr909045eec.26.1773812977591;
        Tue, 17 Mar 2026 22:49:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ed44:64cd:4ba5:bc15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5368a7fsm3638984eec.1.2026.03.17.22.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 22:49:37 -0700 (PDT)
Date: Tue, 17 Mar 2026 22:49:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH v1] Input: atlas - convert ACPI driver to a platform one
Message-ID: <abo86i-bOwo7-vv5@google.com>
References: <3429591.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3429591.aeNJFYEL58@rafael.j.wysocki>

On Sat, Mar 14, 2026 at 12:54:58PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI Atlas button driver to a platform
> one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied, thank you.

-- 
Dmitry
