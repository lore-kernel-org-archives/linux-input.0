Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13253C73D1
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804580; cv=none; b=juQ43QQLh29+jEFQBFdcMcCHkUp9bGp9OGmFpr8bsxjKPFB0fecahKOQSi3NynmMBBAFhVPLC9NSZMnoXMaAJhyad+w+G4ePkMLoQkUE6zzwNsP2Ql/uk6HbMBQcBe35ydpI7eEHVToqyKOOXYYd7Yj3rQpGbDmSgheeVeCWqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804580; c=relaxed/simple;
	bh=oa+H6nWC+O0SGtuz+1s7AAMO0NBQhgXa1uTfnS6jUk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltBqxAy79/rmVo3wKbOBCvQhqQKfOvJOIcKFLKOd03z0VkatOTIZpAwLc1J9AiK+A3yTzNk+1FLUrzCMp3J0AKFOkauSsMPGI+PsxjBU/+ZGOSt1GMRHFHGEiQK8nHIMBWPw/BXnpHUbZYQXTgWS9jgb7EENMCcq3BTdzwGle64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3QoWO+y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3QoWO+y"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2973081a12.3
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 17:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785804578; x=1786409378; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7vHz5OIbygjwNdyPf22CXsjNKdQWVu+Ycy4+8mUpd8A=;
        b=O3QoWO+yq4TphsvWi3Mp8Ybbh/womT5q8Z0yh6gxeC1OOxqvkKjo8h74vYw2aJvdhc
         wS88Ggka+F/1WqkX+GNPUEYL5BGUwQxrKROUm6e9XNRa/kQ+xZVCnLXyqcAnXsfOdfEu
         rZQ/8eGvmINH3uRX5k7ClGg7WyhZ+4vj80AhmCgFEiyymZB2dTDHmA65/SaS1AB7g8cV
         8iKJHEXgIDFVXHeQeQitTcqAGIZ2ql7H6zN44aYMFVafhr32grTlPU4gb8vNw9M9Q/Gr
         /5u6Icft6kRfjZoznJkC+9h2FQp8U948A2fFl4xDk2EdlZ0KxfREP6nhcfy3sBI74veM
         oAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804578; x=1786409378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7vHz5OIbygjwNdyPf22CXsjNKdQWVu+Ycy4+8mUpd8A=;
        b=KSNUSl94KAom5kUM97uYmlNTqRs2fIdC4zEvzlzlwsFleQXoxoaAIPHbDWQ5VwlKI/
         1F3dHWZ6GTRJ36bXjJwZYTBVV6N1RZ1G0SB/B6PS0jsrQQGJ6dM8ioyNG5GCltMe7URE
         BQ6Tc4BCLCTX9GIQfvuRj/UivJEp/aO8zeLBpcAWXXiAjVGAkHkT0+vMyDCIX/U18sKZ
         Kr4EJh0EukWip+Rzk/83D3GQ0jYFfa4v5f1hKsCaPmXe/h6mgjFbN1Ee+2LbVR498p2A
         IwRA7iXaYsCMZmbysLeAIADirYaaXTkUhi1IddBqAiL+79Lwm704GF4+2gwn1h1ss9UK
         pqyg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo7gXXCfbga9OeXtXYz/kRoBhdjhldHFRyW5eK3E5hznrjtn8xhKO/FUmYa+Wimr9FrvJZvv8tCgAY1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfi4ZhlC1jGPlA3+/8PWE4XOwx3ubAZrEgyLeeCq7RF2PIbaMa
	VSE9ejvevv2SYlUPlSrKFPvrWPJFAkXAUQrRHZPefNujgPNCY4/7Zpt2
X-Gm-Gg: AR+sD10Zeo5oXZ/qI5NDI095eEkVSY/873UBoHK+9NydKc/Fhr59zc4v8G6UpxAbI8c
	9oC3ZH5J099XWFob2rlmPaMQXm14ZBzspyT8wTPUzLarCqMggt3mEaLkIadoa67Cx/ugXLAmbnO
	3wbea19EUIQU+bbYywHTMm/eV4oVhlAJ1QIPTrbP9JdTUwThc8BC8Q1nnZKeDMZvw/epr/AyGT8
	c2MtoAULfzJHrI9MyvcPFoG3Fqq9iGZNWrN89YG4tBk17W6lXLfIji/sxtgA+M45bSpuCLic985
	SYTS4ZXV9iYr+E+Slh2nI30kLI3eYVJw9xKBnTr0UKjZPWh33rQidi6AXXG7whLk4JI+KLgPtjI
	TW7EIvNNtZZe3WR5gYFHcimpDPqXVgfWdAUd32mPILw05qaUgs3rJNa0Ch+VyKucSpwJkIsGDz/
	gGN74/PPfgCvU87jQ+FBhdddxEKNc5wQU+1zIi/T9lTER7lnqPBT4D3G+yuikXdiZvd2qeB/bTe
	FKYiUMM6zCUBxjLVK2CdMnGthQ/UA==
X-Received: by 2002:a05:6a21:6cc4:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3c92a89bebamr11916363637.37.1785804578109;
        Mon, 03 Aug 2026 17:49:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f0f0sm41716849eec.2.2026.08.03.17.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 17:49:37 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:49:34 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Message-ID: <anEuB78-HMX4Dwx7@google.com>
References: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc>
 <anElA4get_VxNuB4@google.com>
 <anEqUZyJGBrQ6HIW@pve>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anEqUZyJGBrQ6HIW@pve>

On Tue, Aug 04, 2026 at 07:54:57AM +0800, Shengzhuo Wei wrote:
> On 2026-08-03 16:33, Dmitry Torokhov wrote:
>  
> > What stops these jobs from re-arming? Should it use
> > disable_delayed_work_sync() instead?
> 
> Agreed — cancel_delayed_work_sync() only drains the running instance; it
> doesn't stop the works from being re-queued from the raw_event / sysfs /
> LED-brightness paths before the device is fully torn down, so the UAF
> window isn't closed. I'll switch all three calls to
> disable_delayed_work_sync() in v2.
> 
> Do you have any other comments you'd like addressed in v2?

Since you are addressing work-related UAF, fixing it on probe failures
would be nice (Sashiko mentioned it).

The other Sahiko comment regarding global instance would be nice to get
fixed as well (but separate patch and only if you have
time/inclination).

Another potential change is not to create device attribute group by hand
but attach it to the driver structure so it is created and torn down
automatically, and control visibility of the attributes through
is_visible() method.

Thanks.

-- 
Dmitry
