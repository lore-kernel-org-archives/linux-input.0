Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C14848AD
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585614; cv=none; b=dZ2D3L297VPtcl0+CvyyAgcUe6YqAqRTcy/eeva7gZDYRRNUjzQMtPVsHaU4ITbwAgDLSKUtAS6s/WEEzuca5YinnsEMdSBJxDSiMZHkePXYQkEJqHrgovfPhMoRqZFwaYpr093oKdi0ZDilvZKm1m9V+JvpTUVdzsTrgFTGOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585614; c=relaxed/simple;
	bh=ZaeIQS1rA7QgfqJAf0PPDtdWcH4akOQrPw06QL4tVLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtoZMMoRWm7/h+WUwON+rrVyOq6Zu/MzcLdqyucvk2xGEDjHUXZWVp7PzWzGgTc+mW+w6uCRaP+kJJYZ4w5FDdDWR0LNDpcv9WACnlf/l63Vlwe3BjohuSlzZ02r7ZmSISXoTLUMX37BmhVMv0RHIq2jIvxbua3CQcxWbVw1AXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7hCUDKq; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7hCUDKq"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2da4eea067so184285266b.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585610; x=1791190410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZaeIQS1rA7QgfqJAf0PPDtdWcH4akOQrPw06QL4tVLk=;
        b=R7hCUDKqtohj/v2Xj8LmjSn2VMSrM9zfTip7o34VGzFEmQx+bMN2C8VtZ1znR+Oou5
         jzXEtqfK+ZJj8JwIfCl7MkVmFBXAWU/RngV95DVhLwS6EAFXtrflzbbp7szFHEuGfgh4
         DtG+YA4eYRUxu1LyIbpOI+pLZWv6QSqa1NYldQxks9iitW3Sq7WOeYXqL9UdrZCgL/sE
         SBUNiaaCEp2lc14Cl9Wdss8WmJdR9oMIeciKau6HyOZdoJqOSAWJKYzRGwwgC1DBNnUX
         6Ie+6MkbWtcNZA6IPhCEVmEvDrLceO995HEckV99BYBIHxqPLnSm2C3G0Y9VA1Gox0uT
         IftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585610; x=1791190410;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaeIQS1rA7QgfqJAf0PPDtdWcH4akOQrPw06QL4tVLk=;
        b=WZmc8rV3mXtw8C2QkkMK51K8xtsfzccBIZco3CDWBiioR1WGNVQ5TS0ilKDxAaLZpN
         /GWeHhue7qjDESE5HasEz7rXkgU11dDZskpaJAQ21gCERr5lSKAwC0e0CYjTQK1bJUxp
         3tgP83I203W4jjsLHTllPS3h8YLuCNtlB4R7fhva2tUVdRIwFFvuU0s0hpN1JLN6VG4X
         HmOvED0/VZOOWviB89VoMKR1ABm2bxUK/pvfSl232e9LIB4Blg9j+1zmJIIAKD92RBOd
         HdCPcENK+sdMlBJ+ATOXQ7Q9fgVWn+h64RATDg3RN+TRdGDPhSAQe+3wHiykdAMqlMi2
         7ijw==
X-Forwarded-Encrypted: i=1; AKwUvBxsWmZ7lRNxZ9Y5apPGC4Tw8qmaFmlkkFmrvnIDrb/YTp8Wfb5Z7vKKwyztIVqeiPrQQ3U9bpyGGkryYg==@vger.kernel.org
X-Gm-Message-State: AFuF++m03os/cB9doPZgXmMnN3wkICAKP/qvfEoGV3qVooMdbp9sLpEG
	TExas55GZR9+eggHRJGSx6IZah51uKT7RqdvIKe+kUuXv9YEyGMZXTTJ
X-Gm-Gg: AYBFou32/4i9ZErnWldsgsX1cFZqsKICznbH+VWSX+0BDTzNa76TrwIkAhi13t91X3s
	q3JUjjPXNhcFK/xYgBmZ9iPPbdmenhvWoiGvkud6pjKgDWge+W+BDOxaf328hFl0qySm0KlOW8l
	ngybTUbOc+F/sNcRbiucUe287EjhLHUb1N9zEvTaP4999wA0Hip1VAybcnin/6jJuwJST0h1C69
	KwbJTgicCXZo05P7Rc8Nk4/QGcoaEbx25EjlI+Nqqi/3Ya5Kde7GWf3yu3NWV6baykAeqvPSFgR
	PR+mME34YV79nR9vzLGJMT+bP0LMk+J1okhS2ceB7/3Vu49ErUDyiWH5QUBVAcBJAxfzjTO5cYg
	dujlWAWVi3GsOaQgJap6C98hZirQbox0ItWc2QvnCqPpMapG49K782+UYjy1DVw1086W7vrs8FG
	WLCgMMysWhW+UmwrY9JYib8Ga0JQlRGbqv66s8mFrk5MYLpeWcmPFmnfoGhfJ8ta9WMUs59jGaO
	C1XgQgu8qDvWyFRiC1ZNjX6YC4suDlRi3714zsz8PaUymZIjhDpVDdUkZ41TWj/MLNH3+P0MKJz
	9cjhOfvM2ofxA2H55ImL9d1QkUNohw7iaWBzgLOU
X-Received: by 2002:a17:907:ea91:b0:c29:45f6:6a1d with SMTP id a640c23a62f3a-c2ac5507183mr937039566b.43.1790585610060;
        Mon, 28 Sep 2026 01:53:30 -0700 (PDT)
Received: from [10.109.205.21] (ewetel-whiteboxtest-142.ewe-ip-backbone.de. [91.249.214.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd380646sm257637666b.68.2026.09.28.01.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:53:29 -0700 (PDT)
Message-ID: <8b0d1fc7-1966-4eae-9ebf-ab14ada5af8e@gmail.com>
Date: Mon, 28 Sep 2026 10:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: Kysona: Add support for Kysona M600V2 variant
To: Tjark Effenberger <mail@teffenberger.de>, linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, linux-kernel@vger.kernel.org
References: <20260926124337.45870-1-mail@teffenberger.de>
Content-Language: en-US
From: Iwan Schadrin <schadrin0108@gmail.com>
In-Reply-To: <20260926124337.45870-1-mail@teffenberger.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/26 2:43 PM, Tjark Effenberger wrote:
 > The M600V2 has a different HID ID on the wireless dongle.
 >
 > Signed-off-by: Tjark Effenberger <mail@teffenberger.de>

Tested-by: Iwan Schadrin <schadrin0108@gmail.com>


Tested on Arch Linux (kernel 7.2.3-arch1-3) with a Kysona Aztec mouse
(dongle shows up as "CX 2.4G Wireless Receiver", USB ID 3554:f5d5).

Adding the PID via new_id binds hid-kysona to both interfaces and the
battery shows up correctly in /sys/class/power_supply with accurate
capacity and charging status.

Note: this dongle PID is used by a Kysona Aztec, not an M600V2 - it
seems to be shared across models. Thanks for the patch!

