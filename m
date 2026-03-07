Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B1258EC1
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772923982; cv=none; b=Q4ksuxKi9qIlAqX/XVPD5PUk2jsALbjVPxTUSDB4OG9ZAlycoCcfA2//mGNF5FL2zWPgpXCWSbUAwfTOJDtOxaFCHLfMysppRnE2d2bQ7yF4kyuxiJVXXJmdpK659fsnx7i7xqFpzrKu+GXV09wJ6147K9t0BSbzc6fNnJlnIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772923982; c=relaxed/simple;
	bh=onuSXtg6F2LCy0LxbZ/34VrpJdyeiEFGVxLttUdYP3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZsyXf2UWSysXKGMmevAMgMoi8mnVSxYuabyImIorR+I3VEWnAsbQ8R844ocAMhmMctBbDqROKJQeoaBDlRRYgKmMHdQuHxWJLqw+ZbYkJaQLB6f4MDWbJCpQAwsFF63XUmCmSpRa2TUpSUnYVSMtl4InrqFx4HM1JJ/ARHNPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=p0mw1HKA; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="p0mw1HKA"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so1066995285a.1
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 14:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772923979; x=1773528779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csKDsiBXgnWt/0Smw1tLZwTuHlhZeD6UkDDjhH+moI4=;
        b=p0mw1HKAR0Ynllgi5cdAuMq576fHQl1VVQrNmwJrauVgoxvG57fP0zssEdbRxToTFQ
         d7hNkJpl2mUGvbKbCufFNMF+MPQvdgii73IT9eLLf/ieDE/epwjgzzYzMkhicetwsiGS
         f+8lKnLhWkxZZunFJmlzvbd+YJ7pb/DJaSmhUBvr1uTSODhtiFypOSBM25IZMpf9xuoY
         j48cMoTH3mw93SHGEB6+k9I28PYGDwCtVpSrXGQu76exfpCruvyCFWqieZ9OExotCJWT
         hRmGQDlDOaSKNxBsTN2E7R/+LzKScydN7z1pU0kklkYL6BA5elyttSDLsvJYHxmlOXNe
         LyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772923979; x=1773528779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csKDsiBXgnWt/0Smw1tLZwTuHlhZeD6UkDDjhH+moI4=;
        b=TIzZYEy+zARDS5mxORNU67K002rZiUA93EBljdWt5wlHHKZBu87GFeOG9H8K5M2PKE
         qiSIyIZTxuJLCm9MGG2Ur/RN0zaTYi3U6RTamjE2WFgGgZY14DNq1ZLDRPNK/Y5I9xwf
         esoB+kKo3KI1i9UJPb7rKE4LVAS5mF9KElWpo+VFMSIL1K2m4670gPKDUSURsXXY/lxJ
         JhMxhkhGPSiyw55V+xZMU7ggFWnB5VvRrK0HXoMC+ETh9sDrPu3+bfEtwzKxPQGgwyji
         uwQN3QFqeZbqNqotQOy5q1uenu5sGbfzKoW7ziUYjreYOOp0GyUGm5YaF6HYPUSvMIEg
         kWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUU3XeQkmPJ3o1r/Hhy4I/bo5MHhUdEVuA0R9FPloC1UPiVnNd6aN9BUpYJvzep7q7pp5SY/yJfJQa8VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rdJMCbxkpFxXOmbsvcluEDOFXBriwzD4VJL33/1hTqCyccAV
	El+1S6nvVjUHHU8tTM8z/qZoWGTM3XRHsWNGJ2xbAg2nG+4nZKXQg2k6zNsqTQapQA==
X-Gm-Gg: ATEYQzzPkbxwCAFbgmG5ERflBJJOvhzX9tOaiBBF088HBARqKrc5cuLHYjoAoaxAtNH
	qegGywmGApeIiQQMjkhwAUtLA4JAqu3ow8OY/FXNr5PH1j7A0fLuDaHjMcRI1JXJsZBe2d3vKLI
	AzAw3U23Npxe8uf6ELIdPwiijvh8i2pwtcAghdy/e7JLlvGfdqrhpFyclGW0bJkLfLu1HPNyx72
	NS4XdyKA2FTIdAM44QCEK9LwFrCtbF72JPuDQWKXKWF+V6kKRCRzSmygn3a0Zl2DGGeAzOOA8bu
	KmvlRCDrM8uSskD62jQhRDd96xf/hEJikGIb0vuljrMeBFKmyR5aLhgoUisZT99ct4geF6uRa+H
	TPtMVpcl428qfBsUbjv5ur9wOwqmUZ4RJM3MSaoJS4CEHxoSBVDi0uB266lFXy0EhN6jihC9Be+
	7fAxBdgRsdqJ29F3ldNz1aoqsV
X-Received: by 2002:a05:620a:580f:b0:8cd:75a9:eab9 with SMTP id af79cd13be357-8cd75a9ec10mr410940685a.14.1772923979416;
        Sat, 07 Mar 2026 14:52:59 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd7e857037sm90933585a.20.2026.03.07.14.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 14:52:57 -0800 (PST)
Date: Sat, 7 Mar 2026 17:52:54 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Liam Mitchell <mitchell.liam@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbhid: tolerate intermittent errors
Message-ID: <6cbc6c70-8252-43d0-8701-e1613ddc769f@rowland.harvard.edu>
References: <20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-usbhid-eproto-v2-1-e5a8abce4652@gmail.com>

On Sat, Mar 07, 2026 at 07:57:09PM +0100, Liam Mitchell wrote:
> Modifies usbhid error handling to tolerate intermittent protocol
> errors, avoiding URB resubmission delay and device reset.
> 
> ---
> Protocol errors like EPROTO can occur randomly, sometimes frequently and are often not fixed by a device reset.
> 
> The current error handling will only resubmit the URB after at least 13ms delay and may reset the USB device if another error occurs 1-1.5s later, regardless of error type or count.
> 
> These delays and device resets increase the chance that input events will be missed and that users see symptoms like missed or sticky keyboard keys.
> 
> This patch allows one protocol error per 500ms to be tolerated and have the URB re-submitted immediately.
> 
> 500ms was chosen to be well above the error rate of a malfunctioning
> device but low enough to be useful for users with devices noisier than
> mine.
> 
> Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
> Link: https://lore.kernel.org/linux-input/CAOQ1CL6Q+4GNy=kgisLzs0UBXFT3b02PG8t-0rPuW-Wf6NhQ6g@mail.gmail.com/
> ---

Liam, take a look at

	https://bugzilla.kernel.org/show_bug.cgi?id=221184

On Roman's system, these protocol errors occur fairly regularly, 
apparently caused by high system load.

Do you think a better approach might be to reduce the 13-ms delay to 
just 1 or 2 ms, and perform a reset only there has been no successful 
communication for about one second?  This might perhaps be _too_ lenient 
sometimes, but I don't think such situations will arise in practice.

The reason for having at least a small delay is to avoid getting into a 
tight resubmit/error loop in cases where the device has been unplugged.

Alan Stern
