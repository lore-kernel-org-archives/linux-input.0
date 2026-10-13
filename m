Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E04EB867
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935464; cv=none; b=uT1iBN8IPOu4M1BReMIdXRCGos3nUWh/tGc7yonAQt+Tj3BADqKI6kqy58jh1R+PLAuIfP9Od+QuWps0IAXBfUtyZTmAMEeOR4E8YNJ4BA4MMEsBbmNqDdE9gZOOstNzFe52Xd2C4WxPLhSCeAipS/JXWFQJZIrOCI0gdBMmDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935464; c=relaxed/simple;
	bh=aiuMhEhhajzqsfSxE/gpX2M4LnCvyqPdOXwdjJ+wf+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbYQsAoI5bWzVUyAR036tLsDEuERsRUqerjXuwwMPgZ60zvGmO+jIGHidmuyQH+0123O4x/1/f6z+SYbNZUVwWSFy7uCvxg6JCKPf5y+c8AXzr3FmZRR/5kKxmN9V71CzGXIeI5mUs7cYrEWO+6jVHYfGVTJ49FgHYt7i5vfDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwqjaIj/; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwqjaIj/"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5989488eec.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791935462; x=1792540262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jz79PmNG+KXjzWnL8ROr8qzw/ZQMjbqEAKvxMlEE3xc=;
        b=WwqjaIj/hBxxkSo8ctUz2awkN+iOvJjGSvy4zvSQ/KG2yf+Bj1RI+hhCUhs6xUjMyu
         iaHoakxD9fKWYmRUJPRduSx/XSnWnN9xPfhx+9gymi+4VV8z9UXLZBD5miZpk8FQIXMz
         0cjPlJoDdJLdmUcVQMWG9qIwBfzyXzEcQSkSMRM0v11AJsQNn/yYyI9xWwGzyzsrsDUH
         hfvQEDwR5wxkX0SBXyey5wZHVS+gTxfXc4WCHHmdMN+GvYS1F1QcMR1G8I95xg2QK0Rr
         SqtD86Se2TD3QDJn0i8rx19kt+dZ82C854ejucIybKCg0U2zRx3pY94zthqaDyOiGYaL
         Nl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791935462; x=1792540262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jz79PmNG+KXjzWnL8ROr8qzw/ZQMjbqEAKvxMlEE3xc=;
        b=E7IPFEdo/QRnerzXaasO3p82elRwVqYa4TkM25Zd9L43DQNFevWfM3WgWBVG6Z68gB
         XMbtzx49wYn1VAeBNGww3YHRVd+VsEIzWyfxYZ07X0ivizooOf778JvRxfzDm1O8KVW/
         WIJI84Chzr+yOnz/2Vk6bTFu2oe59HIzX8Co58ey0Oe15h0P2sf0KrQbp87R6A7PYhm8
         4xyydgzfxWPunI/xbHalCFaE0DE0S2KtR7SH+xSCa9hfqG3KpL75disrwrdhHG85O9HY
         MQ0m+DGeA2gZy9mLULi7g4r5cqDXMHoFBd4KvkCOo7sFFK7DqzwZPrVHBVcvMGTIUbbd
         oZeQ==
X-Gm-Message-State: AFq9FYLrRYSylM4hHtXuEYBCo/lbrEqn4ONaG7/CWv3hK0ssuIrpSIKJ
	/FMQK3bLr7Mtg74M5u6Hu2cX/Jp9y3X9orh8I6czvfRJ07WpQ6hrSuXQ
X-Gm-Gg: AYBFou0MhXdYCuzJxp0BZ/5Ka/xNYKyYmW9bHSb/JYJac5OE/CmaEpiZQqwE5zgcrkr
	1JF4zdyPy5Ty4sAmXh3KxRMS930LW9jSVPbxeqkaEECwoTbEXyvzh5M7PRhmSaUx5Gv6M++5ysh
	p4hxSjihUgQ8Iy++0qQxEkAhxkegsC0qPTozhcofOcZqCg4zmaerCQpz8GF1aSEaIBzcEk/8UGf
	USxoVfDEwTVb5uNljdBEyIlzGpErHMndkq+4T9nE1NL7Zgl9QI+rNxBXsuK2Cr0E/ik+zxYzDnE
	zJXoZpviIFq/c4pKyUlZ02CQQD4zPQd2F3ZOSkhJMdaCYwnWA8L0WSSOdOizSrj/zsBTYbbjw9N
	KHGWGrAiwDvRJ6VRuq/dS/GUeO+Mdstflkfp4OFKC3OIBdhKvOoN97eS7vucoeNT3nRCwiVQLUD
	EUQQdYkiuOltZ/xTeVOyP2GWiO3/IN7b5to2/TI8oF9uoEsN2NRZqGm0r2duApzmWsIgZvizjBv
	Jyh0dNHW8kddbYM0rqPljjr33cryQmxLi1dGpFf
X-Received: by 2002:a05:7301:fc8b:b0:34e:67d0:bbb4 with SMTP id 5a478bee46e88-3537e03eedcmr16602477eec.10.1791935461471;
        Tue, 13 Oct 2026 16:51:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm27050808eec.11.2026.10.13.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 16:51:00 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:50:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] Input: wacom_w8001 - fix teardown order and device
 lifetime
Message-ID: <as68uSzmyM3eubYT@google.com>
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
 <CANRwn3QGaQYUZqm2Mh56v0SgQHY8mLuG+FKCtFXjUPRpP6bpNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRwn3QGaQYUZqm2Mh56v0SgQHY8mLuG+FKCtFXjUPRpP6bpNg@mail.gmail.com>

Hi Jason,

On Tue, Oct 13, 2026 at 03:41:53PM -0700, Jason Gerecke wrote:
> On Fri, Oct 9, 2026 at 12:25 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > In w8001_disconnect(), serio_close() was called before unregistering
> > the input devices. When input_unregister_device() calls w8001_close()
> > to shut down the hardware, w8001_command() fails because the serio
> > port is already closed, preventing W8001_CMD_STOP from reaching the
> > controller.
> >
> > Additionally, w8001_connect() pre-allocated both pen_dev and touch_dev
> > upfront before serio_open() so w8001_interrupt() could dereference
> > them unconditionally, and then freed unused input devices mid-probe
> > without synchronizing with w8001_interrupt() when pen or touch was
> > absent. That created a race and use-after-free hazard with
> > w8001_interrupt(), as well as a double-free on the fail4 error path.
> >
> > Fix these issues by guarding event reporting in w8001_interrupt()
> > against NULL device pointers, allocating and registering input devices
> > on demand after querying capabilities, synchronizing device pointer
> > publication and teardown with serio_pause_rx, and unregistering input
> > devices before closing the serio port in both disconnect and probe
> > error unwind paths.
> >
> 
> This patch seems to be pretty complicated for a 'Fixes' and I'd feel a
> lot more comfortable reviewing it if it could be broken into smaller
> chunks. I know that might not be possible, but it's pretty hard to
> audit all the changes here. There's nothing that sets off loud alarms,
> but I think at this level of complexity the best I could do is Ack the
> patch...

Sorry, I do not think it makes sense to split it further...

> 
> > Fixes: 66fd9385ee9c ("Input: wacom_w8001 - simplify w8001_remove")
> > Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen devices into two devices")
> > Reported-by: sashiko-bot@kernel.org
> > Assisted-by: LLM
> 
> Just a note that current recommendations are to include the agent name
> and model version in Assisted-by lines:
> 
> https://elixir.bootlin.com/linux/v7.2.9/source/Documentation/process/coding-assistants.rst#L39

Not anymore since 816d9992d9ed ("coding-assistants: simplify
attribution")

The current format is:

	Assisted-by: LLM [TOOL1] [TOOL2]

as in

	Assisted-by: LLM coccinelle sparse

> > @@ -349,7 +353,9 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
> >                  * sends invalid data packets that are larger than
> >                  * W8001_PKTLEN_TPCPEN. Let's start over again.
> >                  */
> > -               if (!w8001->touch_dev && w8001->idx > W8001_PKTLEN_TPCPEN - 1)
> > +               if (!w8001->touch_dev &&
> > +                   (w8001->data[0] & W8001_TAB_MASK) != W8001_TAB_BYTE &&
> > +                   w8001->idx > W8001_PKTLEN_TPCPEN - 1)
> 
> I'm not an expert in the w8001 protocol and don't have docs handy at
> the moment. Can you explain the purpose of adding this new
> W8001_TAB_BYTE check? I have a vague idea that it might have something
> to do with allowing the query response packets to be processed prior
> to pen/touch being initialized?

Yes, that's right.

Previously, w8001->touch_dev was pre-allocated before querying the
hardware, so !w8001->touch_dev was false during probing. Now that
touch_dev is allocated on demand after the queries complete,
w8001->touch_dev is NULL during probing, and without the W8001_TAB_BYTE
check we'd be junking query responses (which are longer than
W8001_PKTLEN_TPCPEN).


Thanks.

-- 
Dmitry
