Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7333B8BBF
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095033; cv=none; b=a337v/JNegzu76OMs8SmcbbjinpvcoynPxEDMYvtDYkKSVuXQPVisNcY6AAoYlYkRqy6bWKc7bNro+3XamUFknoViH3b5m92xn6MCJF+5wbwCPDn21SnHtJ1/SETNORgSfNAsrIOuS9PsSGVUGp5oLJCxlM1klCp/e9n/pksWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095033; c=relaxed/simple;
	bh=w8TATEoB6pxgJRrivcnib5fz34jW0UieP1XhmcHAs+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9zk9Bskx6GqqzePRF3KYbIHeNFsw1wb8xq2lKlJTdc2oVT+Ib49yWdBt663dZ6dTnAbgfgg3Zk8oHwavt5a77ZoDMnZuQkf3rKT12uHBi6Go64wPuOUtIF3iEaKL1onO0Ek2+M60cBYR7j+76NfuOr8YkuJHqVHUg4f7qZVK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml/4OpAn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml/4OpAn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1471851a91.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784095025; x=1784699825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9/qISsdQUme5GsgRDDsX/+bi7zmIEF/ab3Tsuj6Oco=;
        b=Ml/4OpAnrTj+HxV44KVRluiesm7GXrniQv6TutxDWc3/S/YQk3CoddG7Y7NaYLxi1t
         iIajJYCETOkZSzThmnqTIxiSlNAZVzDrgvpTlVTQ07vgmpoaEwhfczZJhJyS5pzqHecX
         mc80bF6nQtphjQFmw38MJKl3OvjTMuxyFovW3nYHuavPDPm5aVIrDC6665bvTGucxEGo
         FM6PnlNUOB575X7ut2bsXABBcv2fTeF/9b7D1IiMByIiF0Yi78e4TSWnLORHXMFTb1kC
         na0FhnXShqVULuEVXMajbQUPobvkUdO03RJ5otRlxEtraToXpETFF9Gb2Lj1t9skRQbW
         Mxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095025; x=1784699825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z9/qISsdQUme5GsgRDDsX/+bi7zmIEF/ab3Tsuj6Oco=;
        b=RLr7lT6kYE8LbTaK1oabioWgSJwWFOaQ1LwqMWI7octfn447i6Lmoj9DIGo0Wvdnal
         4aWeIAtIwan/xZ/QvrmOhJaXymH1M28h+B/2MEHmjBgqdwHOOJvKcHDsEGGz8SYEVzPI
         dxXE5QAjZZA7L2L52xd5Y7KbF27JAX9L9Zpn6zE3f71cnow4J4FLCE/oDqB0MqifZRjF
         CaLMIF9zoCjTAjzn8nIeaaDpCiDMtQ9vYMrOblJAx1RexVTY1VCZl0qHvHGWeWwsKU04
         d2RiTYIzMzUP573XcyLCM/rWzbGb6JOmWRGIQozecDood7Kn8QQ0hDGFP3kxFNbhA5if
         xAKA==
X-Forwarded-Encrypted: i=1; AHgh+Roqfve/lKiHWeZcQ7sq9RSaVUlpwNSY49d7Z4AI3mWQ17zq4PO+3wkPkIisXZo7asVVMWKw7580xQ82dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8kZBiCkLsl8boUJxs3RKcBuBDis66gC5zo84b3lbcSZGV0ol
	vDmF1CXMWlfTUQp/5v9WBMgX2IAGy3wiMpp+wlYeoCcntk5bhgftjEPQtf4SqA==
X-Gm-Gg: AfdE7ckzVSp/7hwSyQJYnBbKi70sacK/vQydKlWcLBFHw+2+v/DSCDOvwDlsD6Ijv5z
	Y2T56WcGtzFdIo+oQEl1e56dSNmir/MzW9gWZ1bc0UidFWdBEmQLdSjKIxhaNXqCsTwZD4uw1AT
	G8ucwAy+HBHUJPPnIiT/ERdio9kTxScAaxvAFs8ez0HezlehbHIl2Fo4voiN4+MdD1ixzo7SZnx
	paOwWfOQkeHnwdgREn+bxQQoS2KML78dQ2QFfh0YdkvbPd2Zyzl0PkkkKnreUuij8uRDFCtX+So
	B6+c/0mstp2/Nnf/O/ML2Ge2HC3v0T/SK4GLL/1BshJkJaEF3WGTJ+GryDGe3ezlOaihh1f1IzY
	piTs+VXAeEvudOByWG0e1z4BUNYncL8TrCA8JrJgcBJ5zHvheyFd6Q8ihgV2r+WH8W9bagMjZDC
	zAOWixs/w21xd43Yt9msnd7Xc4W2mS2wKOzwJmfVM9S2H8hLGpns8=
X-Received: by 2002:a17:90b:3a83:b0:382:1a6f:ba3b with SMTP id 98e67ed59e1d1-38dc74d04d6mr14377317a91.5.1784095024738;
        Tue, 14 Jul 2026 22:57:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:93:a597:7931:c950])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f81f17eesm10617514eec.31.2026.07.14.22.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:57:04 -0700 (PDT)
Date: Tue, 14 Jul 2026 22:57:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: chlgustn3171 <chlgustn3171@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid
 device devres
Message-ID: <alcCgHzV730RKPmR@google.com>
References: <20260714120052.255085-1-chlgustn3171@gmail.com>
 <20260714121819.5FCC91F00A3A@smtp.kernel.org>
 <CAO2ma08Pap6PZKUV7iEpvu11zaKrzMK-cgBLBYKJEEfGH+0=1g@mail.gmail.com>
 <CAO2ma095Hu1kOTMds9yHqTvwde8Gu+GWOLUst5U2eCnSffkm=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO2ma095Hu1kOTMds9yHqTvwde8Gu+GWOLUst5U2eCnSffkm=g@mail.gmail.com>

Hi,

On Tue, Jul 14, 2026 at 10:39:09PM +0900, chlgustn3171 wrote:
> Adding maintainers and mailing list to CC. Sorry for the omission.
> 
> On Tue, Jul 14, 2026 at 10:33 PM chlgustn3171 <chlgustn3171@gmail.com> wrote:
> >
> > On Tue, Jul 14, 2026 at 9:18 PM sashiko-bot wrote:
> > > [Severity: High]
> > > If a userspace process holds an open file descriptor for the evdev node
> > > (/dev/input/eventX), the input_dev will outlive the parent hid->dev.
> > > When the HID device is unbound, devres will free these strings.
> > >
> > > Can this cause a use-after-free when userspace later queries the
> > > name, phys, or uniq strings via ioctl (e.g., EVIOCGNAME)?
> >
> > Thanks for the review.
> >
> > Using &hid->dev here is intentional.
> > Using the input device for devm-managed input_dev strings is
> > problematic; see CVE-2023-53454, where the allocation was moved to the
> > HID device because the input device unregister path may still use the
> > name for uevents.

Thank you for the patch. However, I do not believe it fixes anything, as
moving to devres will not extend (and may even shorten) life time of
name, phys and uniq. Normally they are character array members of HID
device, and HID device continues existing past drivers disconnecting
from it. OTOH devres-controlled resources will get freed when driver
unbinds from a device.

Additionally, HID devices are parents of input devices, and should stick
around because input devices hold references to their parents until
device_del() is called in input_unregister_device(). However before that
it will disconnect this input device from all the handlers, including
evdev, evdev will mark the device as !exist and evdev ioctl will not
attempt to process ioctls for such device.

I however am not sure why we see this syzkaller report. Maybe there is
memory corruption somewhere or maybe syzkaller itself gets confused when
tracing numerous allocations.

Thanks.

-- 
Dmitry
