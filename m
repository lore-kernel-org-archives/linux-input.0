Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2A352029
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571089; cv=none; b=LBUfRgarFs6L+xXwDziKQPv2fGe7PhBbnuFV6h3gsrLrs3AHt6965M2OQc/zlDZr+TCtARaE6zSmmqnLTyqYP+ioJeWUi5eCNKuOTf0bOtmXvL0u2VesADX/22j1MqJgN28WoJe3Cvf2jpEjuSXpjGWM06TveucOvX0OcWeqEhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571089; c=relaxed/simple;
	bh=/RiLw2SErvUKqOgeJzpySOUxPAqr2XROBbtgzqBp1HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWuJG5Hp5KmJx8m+FUn6JKml7/x/zBwJIpr3MO9cD3rc9nTvyEB9NOsHpQpgo8i0aJKiwEbY4JSrBcLjgk7vTBXeJbqouEtjPUdHPK6mc2PIUxzY7Z2QYRjlaNQv+BdhhsBAvHFsXNBaA6fqXyZbOuellrZ7VTCIH8wu6V984K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7ccztPx; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7ccztPx"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341fe27b718so2591371eec.0
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 21:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790571087; x=1791175887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxBVsadU3CapuSwF1ZwYMR5BhuIaCuGr5O6zle7Zy+0=;
        b=o7ccztPxpxzhKsryUU5W3ki29pXPltPeaqr7hj1j6KqXGcLvALnP0J8kbzDYwDVw/a
         XEgl3Hu37uW8e9r87QEM7N2pRr33Fanvwk2j6kw9YqPjLHWIqZ2QEkrSPa44mMr6v9ms
         Hv2K+bJYOEQiNl/fr5AgpqGCD8m1sKPHF/Uzd2IF5h19Po0wnhQf8dJsQNjnTckDOMX5
         qqUrjif4ryPR1gfsrk3qLyR+U/k+9IMahMkzQav8kuBBn3zIjwYHOBk/VXh9xRchJ77T
         1/1Cue8wGD6DeSrcvV7R034lH9uViAVHLMhgwHkcZNTDbqiVJ8gxva10lAXFI4UIghKX
         6SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790571087; x=1791175887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fxBVsadU3CapuSwF1ZwYMR5BhuIaCuGr5O6zle7Zy+0=;
        b=ZWhAFw3eOacRfL+yNE/FLev4WJ7DUhPv5+mjaRfFnBAyK5KwUmUI0iKwvVUFI2KdsG
         BvSa8xzJnzMpC5zckn1sxiyp0EnAyJovX3OMSYgLlsRyRllQmPHiztwbVlvALzPxBshI
         6c+Y06OBed2xddYQ/F8xwWglMappZ5ZpZzX5wrdlIzrfLWMpFBZB8Qm8xt91Dtb3G9/Z
         QvUAvISRZRyAT+YKDONMOKY603stE+IkwtqIeOwd9TULp8tfFTEGnHHPhBaSR62sicV4
         /tqyNRkEm4HmtyMp5Cup0zIZp4+qEFSXaq2/2jo2dM8vCR3ixgsLcYv+YqwpzRP9wdip
         7kMQ==
X-Gm-Message-State: AFuF++kWEmDk4skWF8ioOE2xKIg9BRcvYmHIl3SnOzHYCm1LbVaypM+l
	zok/M4aZslX2BgK84aSlK9LShfbiGah8jIj3ASN9kIc4q6GXFEwUmyYA
X-Gm-Gg: AYBFou3WTAXSevjbK4vBR001QUKQu+yssGEhexCbN1YIBk/xad0tG5djRDCpog9TcQR
	v531pkDJmepCzfESStrzN9yA/ZSlDPo8lEw5DxdA8YuTEIN/vl72OQgrwBaEJojoKjiT0d9RIvU
	nbCqejzCYH0UmpszTQqQmO90Bz2gWrHLZqAFhglQXXc63yrzC+2k+2D7vuCASw9bmjJ18rJZlFo
	maZxSupAM541ccFrMpO0uC9cBb8CiEjCo0HEwStDJxqiWFPxLY2ANSSLMtvDB7dEEA1HzHj7V7d
	DJrm7QGUMRRqn8sAR4YLY7AejlPF9cXbp+Dl2eBXofeaar3DvXExC5W8Fu+H/sbPMPp/HObzmnX
	nQZeR+6TDaxmCBihxNV0djCmNKvztr72gHgwwpGUnH8WLhWAsL4v0usEQu7XDEbtKyKO8n5NEKu
	wiafXK/cUlI1Xq56N214exlitYNFTjFfsh22Wevt27nMIq+v0Z41VVZHCV6CHe7ZQWIhuttf8I+
	tXzdMzc/XQurtZxSNH2hTP0HfHvwCKQU43SormU
X-Received: by 2002:a05:7301:4201:b0:33b:ea8c:811b with SMTP id 5a478bee46e88-3426fbbeb5dmr8469221eec.5.1790571086738;
        Sun, 27 Sep 2026 21:51:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22840869eec.28.2026.09.27.21.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:51:26 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:51:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, salmundani@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - limit T440p InterTouch quirk to
 LEN0036
Message-ID: <arnyJnqIpwcwX2nT@google.com>
References: <20260927005810.85971-1-rlarocque@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927005810.85971-1-rlarocque@disroot.org>

On Sat, Sep 26, 2026 at 08:58:10PM -0400, R. Larocque wrote:
> From: "Raphaël Larocque" <rlarocque@disroot.org>
> 
> The ThinkPad L440 also uses board id 2722, but does not have the SMBus
> initialization problem seen on the T440p. On the L440, the SMBus
> companion becomes available shortly after psmouse probes, allowing the
> touchpad to use SMBus/RMI4 normally.
> 
> The T440p's quirk is currently applied to all Synaptics touchpads with
> board id 2722, unnecessarily disabling SMBus InterTouch on the L440,
> as reported by Daniel Salmun.
> 
> Restrict the quirk to PNP ID LEN0036, which identifies the T440p, so
> that other devices sharing board id 2722 retain their normal
> SMBus/RMI4 operation.
> 
> Reported-by: Daniel Salmun <salmundani@gmail.com>
> Link: https://lore.kernel.org/all/20260925230039.236786-1-salmundani@gmail.com/
> Fixes: 26eb3d92c7a4 ("Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raphaël Larocque <rlarocque@disroot.org>

Swapped the condition (since integer check is cheaper) and applied,
thank you.

-- 
Dmitry
