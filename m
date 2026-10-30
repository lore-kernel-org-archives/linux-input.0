Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349225;
	b=AZdTDRgYiRCb2jGnF7aOdOUtfUHDi++9qCvZ0LdXd+cEKrxqrWvET1IEuo9BeRYoDphh
	 8Dn+E+QzLS4zKnY8HCL7pYR8w9+RCSXXd1dndzZ1CwYENgsL4LpqwrCiWxBsNmcFpq+4N
	 fsEXWsXGTd7zzyGO6H8PYXbRTms+7N1jF0uEBHB+BOUjDJkT69YOjrXZFZvaVMhLAoVDo
	 +quAIcsQirtxx/dV8JoGb1bQi5YINJhqfFO8OkJNQ0Fz6MHzMguyLzvG/qvfYUWZeX8XN
	 5hHgxMDUKQpcDXA0ayZu0nVWFFHYHF3RWoGrwm/DkwbPvgisA6fWTHkvRbboGwMoxyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+c4jsLL0T595PoLzh/BXjFRLEK6XmKiSGFk7aEqBpRg=;
	b=vmV74LhU4c+RFo+JvY+bHw0utMtUv5zEqVcnwdi5JSlPpHonvsacHwptfFrSqgZ4VRHM
	 yh8FMpe3FIyRQ4Y4c7Q4e1VuFuON8QIT3TwoyumsViy3DK3h5sAOd0AY/kWbadOQb9DJn
	 dhCA55LJISIOPnr60qVyQRcuoFvxklq79BvcLBH9+glszwDf6ikOhNhmxhJpOcipXqbbT
	 CSfsGtFVWfSZ4129wqJGTuKvLZhlXC2Fk3Vnrf1jspT6oTafE+ckVpSiX0D7DXlb8u5OJ
	 xwZYb2bET4ofmwHA+rSDMFLO/qq+4ToaGJ72aJ2zc45MciAIv+Sm7xAIYz5LIs8TX/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=seqOCzUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1290606A31C;
	Fri, 30 Oct 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=seqOCzUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD67C1F000C1;
	Fri, 30 Oct 2026 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793349224;
	bh=+c4jsLL0T595PoLzh/BXjFRLEK6XmKiSGFk7aEqBpRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=seqOCzUw6nQu9IivIDK5wwe5nGK49tanah9k49jhHwVtng8UZP2M4QsnMoblQqLAv
	 M79qycDsU052vMzbH88/wSbSc4w1VNTZ0MkgW1jW0gF45CPewTDYSXoSOFRq7dqBhJ
	 OKJ7dCxOO/MBg/PX5PD/ZuBBQCbIoDjV1cNbsk3U=
Date: Fri, 30 Oct 2026 09:33:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: jirislaby@kernel.org, dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org, linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written
 reset_seq
Message-ID: <2026103043-tributary-partake-aefd@gregkh>
References: <2026103014-sketch-headed-2fd1@gregkh>
 <20261030075820.207049-1-zhanxusheng1024@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030075820.207049-1-zhanxusheng1024@gmail.com>

On Fri, Oct 30, 2026 at 03:58:20PM +0800, Zhan Xusheng wrote:
> Hi Greg,
> 
> On Fri, Oct 30, 2026 at 08:02:30AM +0100, Greg KH wrote:
> > I still don't understand what the root problem is here, sorry.
> 
> Each keyboard keeps its own copy of reset_seq.  It rebuilds the copy on
> the first key press after the parameter changes, and it rebuilds it
> wrong in two ways.
> 
> 1) It adds the new keys to the old copy instead of replacing it (2/2):
> 
>   echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
>   (press any key)
>   echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2
> 
> Now F1+F2 does nothing.  Only holding all five keys resets.  So setting
> reset_seq once works, but changing it later does not.

So this feature has never worked?  Or it is just "one change only"?  So
your change is an addition to the feature, not a bugfix?

> 2) It can rebuild the copy while the write is half done (1/2).  The
> write stores the keys one at a time, and the keyboard may read the list
> in between:
> 
>   echo 59,60 > reset_seq
>     store 59
>                       <- F1 pressed: keyboard reads "59" as the sequence
>     store 60
> 
> On a keyboard that has not used a reset sequence before, or on any
> keyboard once 2/2 is applied, that F1 press completes the one-key
> sequence and reboots the machine.  The window is microseconds; I only
> hit it with an added delay.

So this isn't a "real" issue?  If you are modifying the key sequence,
how can you press the key at the same time?  Doing "major" rework for
that might just not be worth it.

thanks,

greg k-h
