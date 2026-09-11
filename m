Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF2470453
	for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150853; cv=none; b=mhQ66hU8So0jkV3VBnCPsQtEW/MKIewD/tW6CHbUhOY5ObJXywIjIBh3jHCCtAzff5M1K3tHx6QTpCOAXpbiesC91v+6y6+1epy5o86Yqfu4DK4ZwkWWW5Nx2PMHY2UaIVN4EIEBa8Jdyr7Z6iR1IbireAnpiAq93oPhWEVONY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150853; c=relaxed/simple;
	bh=gi7sL3KY2sz6QA9RwzBfaKxGTtG3BGziQJpEdWzH7tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3n2RZilYcYvY2jfgJLTNPZKjhUmzIH4pRoFmWjGViJXFGp1ZsaQVv4ovup2tNi5SqWir6wBjyKKaGHgMkfkDZpoWEZ+2HzCVrGy6P7OxM6uC2q0zOSUhYSRUYCWcBkIgVDsyNgRF7LTNS/ji/CkTJQHwP0KfELDFE+zdq2oCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrM+A7Tj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrM+A7Tj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1285413f8f.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150850; x=1789755650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m0qADRog6x++il57lr7EA6g1h38VeLT7OTwOYzw7rU8=;
        b=KrM+A7TjH6qHm28bKUE8qd/lK5SB7icssaeOmGFNcPhtN+P6XKyGO1GdYmt8pAOaAa
         KGfcJE7uMzLITXVttQKOkUgNKmjNeQepULR3h0AGfQFa7eHxhRwzrUQKI9kD9Mec5V4H
         RZZFMofVzvkgATkRfbhgBQg0JvBWvF4rSfyU3eSeTPNbgSyNRGgf+aLi0v+JRM17IjWh
         d7yUOj/CrZMZ0vK+g0nFivmYKHn1jkPLU3BASECqVAwryJ9SA1FeWrz64F8V6RVuIGo1
         ta4mH7xPh15vrc9qHzqiQHFg+jlNaaEYNkf0pAZLHE9C9d1TNRwJfAmsd6YTxQJNC+oU
         2NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150850; x=1789755650;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0qADRog6x++il57lr7EA6g1h38VeLT7OTwOYzw7rU8=;
        b=mF5JoZQV3HuPhOCu6jvm245ZSG6/e/CH2VPT4XvuSAI/SeoAPV5M+YVwYGlMZAAqcF
         KlgIls8vwc8RZRixGfSlpTHUt96q+PvCGx7viLidwLZVBZyTFvkCmKeog5ufBrhhI7B7
         6ooK8IACzO52alRoMIDz09ngnlJKm4xss5c0zoc3eahJbI94l2Rdc1yeU6ty83cT9CMj
         OE9IytnM9VCzhihttcwjgHmH6fVm7Cvhf3kRoiO8YmIR9o36ardBZiHEbjtRlSFn+KhU
         lvrtP3wj6cMrpqYC2WjEAeqVpNhQGxo4o3ULz8Ad3/UgRWLXhYx5S4JSybmaZFB8Q6Az
         NsuA==
X-Forwarded-Encrypted: i=1; AKwUvBx9dVX75vXHJu2jTNNEWIkyV3+7jItxlwzz3N/MYyU1SH2uD5TqY3VuDRNHzi2Sp7VZNYMAdgOiF6NmmA==@vger.kernel.org
X-Gm-Message-State: AFuF++m6gokGbSCMar9GrlgsnjnBx+h1nv/9VWN3QuiwspzBMnQM6ZfI
	B3p4Yko6D+/4m1C0mJ3/b40ZJ4L9653CjcYlAnaTFLPUqFQK5sIgMyg2
X-Gm-Gg: AYBFou1VVPd6rtbI1i3nGxLI6mqJ/u13gkTT6d/6I/q9DQbIrQqu+50JoYC35LW18+T
	6leleesp9Pc4ynt8Q/06h4fmSuUggGL6phdTlRAymarT5eNb40q5GtCgdM6g0StBK2aPOSFURo+
	DmErno8DEvAVyfbNVV154/jQ/1UGEDds/C7GG19Sy4jMg29pW+77Y+OvIKRfkbObeOVT+kQWtE3
	LSITDONfUIqh3PYw0PhKJaGFxswnxVOOtwU7WTUrVJqCnruQL/1M4xOXzfCFtpsfQiH30/1zE5Y
	2O2TUeRjqe03VtX4CsvgQOu/29LdHYkSnDrJY0i4OjfIK76cHjgJQcNuEnRl8QJCANDUjDkeHFS
	Vjlm8us4H7ucoRK8r5BJpeKmmctTY77PMS0mRy1ojl+FBzMhlL02dR5H47zoc3NM8IWhMipG0WF
	5RWMSvrFrhZSHdKuMe+wn7AEKgg24547icCKPeUtoLZUOIY2MOJETmF8hAYYGyTL2Kf72J9dYKq
	cv+pxrn
X-Received: by 2002:a05:6000:2f86:b0:486:e73e:abe5 with SMTP id ffacd0b85a97d-486eb2e269amr7641832f8f.10.1789150849834;
        Fri, 11 Sep 2026 11:20:49 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb330bdcsm8116975f8f.13.2026.09.11.11.20.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Sep 2026 11:20:49 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:20:46 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Pierre-Loup
 Griffais <pgriffais@valvesoftware.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER"
 <linux-input@vger.kernel.org>, "open list:USB SUBSYSTEM"
 <linux-usb@vger.kernel.org>, Curtis Vogt <curtis.vogt@gmail.com>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <20260911202046.5c28864b.michal.pecio@gmail.com>
In-Reply-To: <2d4b2c51-ac5f-4fbc-82aa-8d573d095687@amd.com>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
	<20260910170254.833871-3-mario.limonciello@amd.com>
	<2026091133-silliness-recollect-e190@gregkh>
	<20260911111652.703b865f.michal.pecio@gmail.com>
	<2026091106-footing-antelope-7ceb@gregkh>
	<2d4b2c51-ac5f-4fbc-82aa-8d573d095687@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 10:12:34 -0500, Mario Limonciello wrote:
> On 9/11/26 04:23, Greg Kroah-Hartman wrote:
> > On Fri, Sep 11, 2026 at 11:16:52AM +0200, Michal Pecio wrote:  
> >> On Fri, 11 Sep 2026 07:54:12 +0200, Greg Kroah-Hartman wrote:
> > You are creating an "odd" user/kernel api that is used for
> > debugging, that's not what sysfs is for.  sysfs is to show
> > attributes that a device has NOT to cause the device to go off and
> > do some random thing (yes, there are exceptions, but generally
> > that's the rule.)
> > 
> > debugfs is "do whatever you want", so that's a better place for
> > this.
> > 
> > thanks,
> > 
> > greg k-h  
> 
> I suppose an alternative path we can build to all of this reset
> handling at power state transitions and sysfs/debugfs is a callback
> system for a failed EDID read.
> 
> Something like DRM drivers can send a notify to a global queue when
> an EDID read failed.  Other drivers could subscribe to that notify
> and react.  I guess this would only work if the USB reset sequence to
> the HMD looks like an HPD event to DRM though.
> 
> Also it wouldn't be perfect.  If the HMD was connected and the read 
> failed on an unrelated monitor on the system the HMD would reset
> needlessly.
> 
> Eh, I think I'm talking myself back into this approach the patch does 
> now.  I have no qualms moving the on demand knob to debugfs.

Perhaps one more option is to put this in userspace, with some libusb
or HIDRAW hacking. And if it could be scripted to run on shutdown, no
kernel driver even required at all.

Regards,
Michal
