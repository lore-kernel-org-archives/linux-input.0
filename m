Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382047CC9C
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636222; cv=none; b=jKxAWeDJQ2LeNMQAkxgmG6EeBT80Z7dByNbIkcHs2lwrdrR8ieJAHqmp1rMzhbrCimkRATaj3I9nYNRPz8K4SmSmJamMWrl/gijE2170DTRcbP28Hss9U3HumW5p+zB7My5uh7TE6bDhzuNL5NDCeGkbv1JkLH0eO//fb5Un924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636222; c=relaxed/simple;
	bh=4CElZiTPHGArORKYD+4KHH07uAFYrw8mEUdxEdUCaTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heku1CvEq7C2EyAO/yum2KF3HG0CO7ExO70C432d5iB9W+TINNS+yqIJ1BiJj9KQYocX+fkccor8SLyKcFwWGwGVPPRo4E/m9aPImIA8WDv1z8GA+MNBqBSp9xFGynLNOARRHK05MoEHbnJjrp8UwREQDAE2vmNM6N1GBSr0pDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6FIHJgT; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6FIHJgT"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso6010540c88.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781636221; x=1782241021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ysnj9WdUwSfcQFI+hBHALQ1tHbNJvuivqwhgA0jRGmc=;
        b=Y6FIHJgT8JZPDCLxk85eVxcKAgvsT+Ya8MYCHYPyFVRJDiSS/RIWJAtOZe4Cqh3tew
         TDJxwGmAamPr3Kf/uEy7qWMih1CjSsFiiML5FYc4KEPimo5IPkMNAiddCNAocG9XBA9i
         cgjXkI8XYdBz6DF7+Mh9x5x/CaJms0uKVpzJbReRB7G7Q06eElrOdTAGFtLxVtnR066+
         Vb50U5yp7mhqFaoUzcMnZTsMwQZKxx1RncrC++DavnDyjEE9//dBR0EH5KSbFUwS2SID
         7NDzooo3lFoUlCD+t+I9wkKT+n/L8AdcdOZS1CpJMzrEamZcy/bR3vAFyMuyDTrcTWpd
         pMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781636221; x=1782241021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysnj9WdUwSfcQFI+hBHALQ1tHbNJvuivqwhgA0jRGmc=;
        b=ec0P3ekqeOZc7yFp4DgglMiWa02z9zECk1yopYS/N/hIX4hvZfylxt8To0gcSEt37S
         OnkEpDQldtl6PqyoQ6o6qKOIZceQrLy6wOhzJcBcSp3hzOaUj7cMRmwqjrUnCMLsQ/lO
         gyL17YxJQuBp64wXtBA5KW/vJMZvEtBc7l7wBWrdFurWUpzA3b9qrZCG6YrQV615FfkI
         ZGyPCiQ5/1a6j2m6O9VxwUowfkmY6IG4ebcSh2Yzmfoc4SQo63TyAJxmEd3RZF78F7oJ
         03yDihwllOeA38WpwBO8RpIVknvnUTI0h2ArPs0kz6mw4+mKNBg6FM9Msb9VzcDy8v+N
         eL6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8tCcaPM8458N0dhAHN8JwCucH3K7AIJAe3mCVQM18qgu16HxuhEyH27NSaFx3D3DIwuy+HzQBVeDv3LA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+AGMByA0Rixp0I1GF6Q8UVkqnnXoX8i02xWaPHvMLEHzFM89
	hpuvlMsrBXGFtk5p1lu4148fGWXVphqpefLqH2JMs4lAgt3CKo0HG3zJ
X-Gm-Gg: Acq92OG8g8uRdC1tedbk/6KH3ZIojdwjDtu/uzNqISl+yeV7occ5gsWqXdDU27tDZXC
	6xq8EQeMd9qSqY32d32yo8XcfWrF9bMm8kodsG4wnrTFdT0kZYRPFkKqe4cGcXltikbd1YHb84N
	xUhmXFPadzYuLNIpMzPWcDsScdblC9nbMhA0iXyGx3Y/NvbbyKDZhBNDapU4kUbt2kK5oTU6zej
	WurB63xxNDiWxvqu506Ex9RH04m0XyXVUznKdxecqBsiNetFlzEY6zD5VNRyJxvQGNDPtP3h9Y5
	q8FGDokzbeWgyM6xtsLPZYUgIRtZiJ3XhfVAAMq/q0EJwON4YR8C1TTiwoVYj/MV6Cm4huKsSti
	uWNhFH4iI4plPiDiNnThv0EQ8jfWVJfNJGX+2GkHXNl3ahLyGr5pm613i4n9kay8Z2jeqo+v4/J
	J20SudPpmhJDldxaO/i+UgIvYHDEGURkaz8RlFjYQ29X5g7V2Gq5Vc5VAnYK6+fes=
X-Received: by 2002:a05:7300:8182:b0:30a:e530:ebc6 with SMTP id 5a478bee46e88-30bc9ce896amr406960eec.12.1781636220591;
        Tue, 16 Jun 2026 11:57:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm19888556eec.17.2026.06.16.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:56:59 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:56:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rong Zhang <i@rong.moe>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Adding device-initiated haptic feedback knobs for
 pressurepads
Message-ID: <ajGbFNj73yxaEj0y@google.com>
References: <bbee6e61a243a0ae4db6ea155909607326a80dac.camel@rong.moe>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbee6e61a243a0ae4db6ea155909607326a80dac.camel@rong.moe>

Hi Rong,

On Tue, Jun 16, 2026 at 11:34:45PM +0800, Rong Zhang wrote:
> Hi all,
> 
> A pressurepad is a MT touchpad that simulates haptic feedback. The
> haptic feedback may be either device-initiated or host-initiated. While
> drivers/hid/hid-haptic.c [1] provides comprehensive support for host-
> initiated ones, device-initiated ones are currently not configurable at
> all.
> 
> According to Microsoft's Input Device Haptics Implementation Guide [2],
> pressurepads with device-initiated haptic feedback can support
> SET_FEATURE reports to allow users to customize the intensity of the
> haptic feedback (usage page 0x0e Haptics, usage 0x23 Intensity) and/or
> the force required to trigger a button press (usage page 0x0d
> Digitizers, usage 0xb0 Button Press Threshold). Each knob should occupy
> a dedicated report ID.
> 
> The first knob maps to "ClickForceSensitivity" in Windows registry and
> "Touchpad feedback" => "Intensity" in Windows Settings [3]. The second
> knob maps to "ClickForceSensitivity" in Windows registry. 
> 
> The pressurepad on my laptop supports the first knob:
> 
>    # 0x05, 0x0e,                    //  Usage Page (Haptic)                595
>    # 0x09, 0x01,                    //  Usage (Simple Haptic Controller)   597
>    # 0xa1, 0x02,                    //  Collection (Logical)               599
>    # 0x09, 0x23,                    //   Usage (Intensity)                 601
>    # 0x85, 0x09,                    //   Report ID (9)                     603
>    # 0x15, 0x00,                    //   Logical Minimum (0)               605
>    # 0x25, 0x64,                    //   Logical Maximum (100)             607
>    # 0x75, 0x08,                    //   Report Size (8)                   609
>    # 0x95, 0x01,                    //   Report Count (1)                  611
>    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)            613
>    # 0xc0,                          //  End Collection                     615
> 
> I hardly use Windows but the last time I booted it I did see "Touchpad
> feedback" => "Intensity" in Windows Settings.
> 
> On Linux, I can tune the knob by setting the corresponding feature
> report via HIDRAW. The pressurepad remembers the knob value until it
> loses power. However, getting the feature report returns garbage data
> (probably from the last input report in the buffer), which makes some
> sense as the implementation guide only requires SET_FEATURE support.
> 
> I'd like to add device-initiated haptic feedback configurations for
> Linux. For now, I only focus on the first knob, i.e., Haptics Intensity,
> since it's supported on my device. If I somehow get a device with the
> second knob I may work on it too.

The question is why would we want to support device-initiated feedback
instead of enhancing userspace to fully control it. For the record on
ChromeOS we tried implementing support for device-initiated feedback but
it made the kernel code very cumbersome and left a lot of gaps/rough
edges when combining device- and host-initiated haptic effects. 

I'd prefer it all being driven from userspace.

Thanks.

-- 
Dmitry
