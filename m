Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41D3603F6
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909501; cv=none; b=agvJwc2E/L5zXCr6NXtduDXVGxwtfDY5l94PaofPmWNbiPCDFYvfX/cKMaT77RKsBbuQT+sxQASXwpRKwaDRVcX2MRG/extU7OEy8O1wFK0Qd11pkJM4BazNQSbdMsrfejbbcbMf3U4wh3kEdpuRQGxS8eRR/OwMWvjPdsSJ9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909501; c=relaxed/simple;
	bh=t0rjTqOZvOLuVyg0IrKzfpdcNbAW2LgYA1nuGLHCNx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jk55HuXSUoO3rcT6FdGAMd3LilRYdcCByj3oxT1sv1nUoYlMNxAP4H51hPFAMkApU0a6s4YVnNc4uFczRnN4IlmW39fSaOFGa7L+gOrjWfLOhVRSptgoQm1l3pIHSaP+7FY2FoO1CT+6XZaKWRD0kTA/uR+T/ETh2EaEPW1wZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmIjP908; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmIjP908"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3025d725a05so26952837eec.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909499; x=1780514299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bXT+KoekSYXIqzGWND4TiUi3TuNJGTNeenYWK6EeKo=;
        b=dmIjP9080KuxFKfYBGN7ZFIN7F5zSpUIl3WOdnd7tb57/23SyqZByxrmUWOjrV/13u
         kVa1QxlTHPqSoPqqB5tkv/kYtKHAhANQskPMxEr6IkRegtkNBLJkkRLnlWkUFraJOI4c
         P4yHGETpDBF8AyaTsaEWKF8ADlhSTT/iOYd979GBQveDOLJmf+vyTSAvcszMGGEuIgSV
         9Aqzc3q7nkX98RDiuADdGj9Z9a4Hk+MdL49GSBw1rM31L9T8s0wOMxnRbTLFT7ecTFjj
         J3MapGzzUzB0cTnQ1xvYKRuyy2f7/w9XDqOJN91D78t81xxQhdMA785ic3Z1ukIEln+U
         LTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909499; x=1780514299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bXT+KoekSYXIqzGWND4TiUi3TuNJGTNeenYWK6EeKo=;
        b=YIvcp3QSsMHQ4NDNhh+5moExTCnNWDySSoNUseGTZhRi2x70N8jMgTwlAHnOvzqkGH
         nO12xWE+5maJK4E/ZBLWqziAkQcsTt/msbDUGA+NaPj8h+VkWqSLcmnjWY1/0UFQZxIY
         lu5Ug0vki+0KdOOsLopE2wj2IBdmS7RaYuze79AW7RN2XReMtluXEftVU5x9mZobd71f
         58g4agEW+0TPHQzJEbIedNvFaUme61jz/qDyb920VCAPCBHRsuZGSer+kC9J7oPe6x7E
         deIMTuedXvDZrGrGCDMsdDbbjjvsyKeIHkWImhJXLCykM6MNZfZP6voiH7f2Q7BcdYIN
         PyAA==
X-Forwarded-Encrypted: i=1; AFNElJ9lR+ZxxPOrmxmmrgM0FcV8ZWXPaCQCqDX+COlkIZ1GgbidCNnnzklUanlKo2PhFQKMT5PxYrYg6Ku5aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrfs+vV1g2DZytSLJOcodk09gvc397ST1p9MY+sHNa+QJbSZeU
	fXz8odQV2cCmVd/OFzG1fcrEivQ7xZNLwrdMke0+f/hny6tN2iyUQ84VJnoFCA==
X-Gm-Gg: Acq92OG90kI9DI4kPnQ4d5BJlUkPg+CykvpGszY7oSdkTAm4Hrdwv+ayOg9j+/s10dy
	yWo7I6ahnUqNsY7ni0FrjmRLa59OWLvrwrXh7yFRil56MI4nBeABSs2xROkX9pI4SHSoo7Tgpw3
	FB4+lXDOUUwKdAXkC0kljkMNWZgu5DcwCy+grlXvkocJoT1rqCksotu/6VGdLZoy+lYVWmcmTy2
	P/hroqszaMmoYyKaGyJtoJmZuHGM4wKE8WiXyCFpPAs2PwCqV8vB7tXrFLAOCcx2Qa2+bUwm5VN
	SXIsiLfzBP9CW14VXMR9w/WywyU6R8NohLN/CruQvqVP8wyL8EBpOJWF9P6jgr0zhP1/RQ8hAl3
	5Bt03t34PNtvk9pFbjm82fhiQGgDLTAR+xKos2LIAign9eePbV2M4m6bJudrhfAn6306/3RJAHF
	J3d2gQWRMe3zGZaVYf+PBUcyXiaeoiAQLww+VAXKPAJkQfIX/akvvGzJ/BPYa6/lD2aLKgeTnMo
	RI=
X-Received: by 2002:a05:7300:730f:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-3044919da81mr12181831eec.24.1779909499321;
        Wed, 27 May 2026 12:18:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452461cb5sm19767519eec.31.2026.05.27.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:18:18 -0700 (PDT)
Date: Wed, 27 May 2026 12:18:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix multiple Use-After-Free issues in
 shared state
Message-ID: <ahcLS0tBhkHlUuLS@google.com>
References: <20260527140731.642783-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527140731.642783-1-lee@kernel.org>

Hi Lee,

On Wed, May 27, 2026 at 03:07:30PM +0100, Lee Jones wrote:
> The Wacom driver coordinates state between sibling interfaces of the same
> physical device (like Pen, Touch, Pad) using a shared structure
> 'wacom_shared' inside 'wacom_hdev_data'.  The driver kept a volatile
> representative pointer 'data->dev' pointing to a sibling 'hid_device'
> for physical path comparisons during sibling matching.
> 
> This pointer management is fragile.  When the representative device is
> disconnected, wacom_remove_shared_data() failed to clear/update
> 'data->dev' or wacom_wac->shared->touch_input, leading to two Use-After-Free
> vulnerabilities:
> 
>   1. dangling 'touch_input' dereferenced during touch switch sync.
>   2. dangling 'data->dev' dereferenced during subsequent sibling probes.
> 
> Instead of adding complex pointer handover logic to keep 'data->dev'
> updated (which has logic gaps with Pad siblings and introduces race
> conditions), completely eliminate 'data->dev' pointer.
> 
> Redesign 'wacom_hdev_data' to store stable static copies of the required
> representative attributes when it is first allocated:
> 
>   - Copy 'phys' path string (stored in data->phys) for stable path comparison.
>   - Copy 'vendor' and 'product' IDs.

This I think makes sense.

>   - Copy and accumulate 'device_type' capabilities as siblings are probed.

This (accumulation) I unconvinced is safe. In any case I think it should
be a separate patch as it may change the behavior.

> 
> Also explicitly clear 'touch_input = NULL' in wacom_remove_shared_data()
> under wacom_udev_list_lock to safely avoid the touch_input UAF.

The fix is incomplete and should be split out. It is not enough to take
the lock, you need to make sure you are not racing with URB/IRQ
handling. Maybe RCU can help here.

> 
> This resolves all vulnerabilities permanently at the design level without
> complex pointer lifecycles or race-prone swaps on device removal.
> 
> Fixes: 471d17148c8b ("Input: wacom - move the USB (now hid) Wacom driver in drivers/hid")

This is not the commit that introduced this behavior IIRC.

Thanks.

-- 
Dmitry
