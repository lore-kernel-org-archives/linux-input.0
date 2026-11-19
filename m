Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122794;
	b=tvwSAVXNBXrCaA1hlth9CUHOcaabNnwjZe/YDoVGDjKCxYqHPOiqpsfO9QpVSEJOVdZS
	 LA36MKIFd91N2ONJDtvGJDXOnjtbkcXb3aE9akdxwPezQnIOPwp+nQmICl/Z6H1572IaD
	 i0B0Y9dX6/uOlVc2jxvSRYIEfDbV4ZpZ1lRAE3BALQdPjSk65PabhDIuCGLN7LFb9h2o1
	 AWl2LPQZ5BsW5tFl/AkTka1wjGQX/hVUfXtQLK2QnXc6Tn9nTh2yhdwpgHdQdFZWOw1Lj
	 ya9q7VxJZ4jhVrZUmKCcxE9RGIdeEVjRrtJEVsqmkd1ab4qcHkjNaoNinblNuFr7MZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
	b=08XKiAEa3bhNB2Z0OAe04Q2mu1CX2TMl9Qv79w6l7gH4jDaNn2cMKfsZCrnn5K3tqSG9
	 IbOr4hoFa4lfxkCqwuYYWeNXapdbgnkR0vnhtDpoJ6FEyezExVi+1Cyn/WDOST7SShjMa
	 7hEun/vruoDuCpEdPkubz3yFCxuMmDAzVLBf1DxO/J3ouw975GZMI5kJNAWgew8Rf9Vsq
	 FjEOpLyOCo5kHEIwCz1qacTt6XaWLhRIIx0DJc7eZuIeDhDk/zVlzW9nQvWXIqkdEhyR8
	 jpTvNZzfoiXLZe+MRAhxcGZjDgvmG/7aY5LCvDCBBNVCFIBf2iEK1EQ8OVqZLncVBwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dl5GeA+;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D7606A33B
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B3D7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dl5GeA+
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3712b6d9843so129276eec.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122794; x=1795727594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
        b=0dl5GeA+cuu98eSuEIfdB5v3gs+RER4Sz0Ip2hbbediS8SRXexbHcSDI+c7udg/BiN
         PkvXk2q1Xe6/Blxx0anGyQ7Vy+QA50JzBwM279PPaciCEmS7p1pqpVpJIl+GgPi6jtkP
         K7/tFf9ITvg4gpMgW/tMXw6+TRyDFZE2eavjWGya1JTEU9+wAQwRWVoNtw36VTgtk3Fn
         PR5uXmjYo/MrrnEXFlch0KoAnv7ozu5OxPVWVBK5Zc97A6Pp59otBuv27siSN3IGAYNj
         Dv74+sAK4mbHLHsEjk+wA3ACpL3HBJx6P9dfa+/NmXPel5duaXGaOmr5BvOrI3F7eoui
         Xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122794; x=1795727594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QolvcktJGBlYryC5TA1stRkYXSEm1zI0kjb3H9ZNhI=;
        b=fRc0/cUCSYBvDhpvNRjXJyRe8eApTsXKG6QtGfwnhBCAj/hRw3XpbWeH5fkyO+oSID
         skItXayReO/qVhoLSxOc/LtvRnajJuVLgXazf95pOP53Z1y+ntyM/tGsbyLWBZheu3pg
         DJahmymZRSwTjUFVYSCQ9tIwJoQAPK5tEnYFI7wDReE+iEYqXkeoF/aDkqLaDC3+ntth
         5W3Gu98KNFsR7zfP7AC9lWmtUGr3fVv+LrWFWi4jG8UTQp3jiJT7KQ4nkNrgsrEnlQzn
         XfHj1DGijuKUcULR8QJUuIBYL4Kv1NrsRCuU3yoelWOtj/XAC492eonwc6g4KaOedl89
         /olw==
X-Forwarded-Encrypted: i=1; AL+hErGlx2r2f+yc8jxJYRxi5aexdxr/lqEihKrA2FxksEqxy8LS1Tz4dwTAXKmIKpfcjYUiwTEFFRyWYetZvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+G+t2UASPA6kz8cql5j/xejtcl6Bju2CBbMXdWz7pKSgaFTJ/d
	guW3ojdixvIuLM5IzRHVRuAHaVGuz5u92+4Qvu53jWZpfJ9xP+xKOSwc
X-Gm-Gg: AZFdTZeqiAf68n69DtxE0YcZL43u06/FUm/8x7lQC7BlsWU+IomhWdjrRf4JAyWxP/4
	qy2J0/Dae74EmnjbmfQDsftfh1zAvM/EOnFAyASmpZ52s8FNole9u1zWGoLp/PXhL/E0Ayxb6xZ
	DvtnN7CVxgiF9XsRK9aBKjzzCVQJnktUTLcMqL3Fk12jfIFPSIdeXC9mPIfp2/ys04jl5xzlpC9
	rRqok/T1svltnAP2j3dm+NNlMZrwHZPRnHpTyKWPJRByPMq6rJU6B11Cip9gFkn84QspMiLk/0l
	iKEr8YJD+bsqUwX84VSZAT45xhxSCPfR/gdpvn/QJ0r5SQvBJ6MoCgh9/om7KsdwaW1tKeWncBR
	L3FI3mZLZgg37RHidL3RBVpv0gI3qdDfu69ivCNY15Lhc+VFxPAMn9+9G6ScgoBxwfRxFIy/1DA
	qWZ8JwcO/yOPU4dQ/MdUkzJYxf8pdOjWtQvgZZdGadjJmP0N4PyharISN1O0SjxEvfZWCBSvpwO
	LSAqEZxPnReojIo9fLphlZoGkUoD2O6+Ew2nUtSImwta1YKno2idZAUWjgM5Q4L9053sTxXMdRe
	C6AwHyXs9Tla4aI+mjrPZIZtizJmc/9Cn87uzqxAlVhJQpQHlt7UFVnO9L8DyxZV+ZC5r/I=
X-Received: by 2002:a05:7300:d218:b0:378:1191:43ca with SMTP id 5a478bee46e88-3856fe552abmr460254eec.18.1795122793583;
        Thu, 19 Nov 2026 13:13:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:861a:3517:4ba8:8641])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm1288871eec.14.2026.11.19.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:13:12 -0800 (PST)
Date: Thu, 19 Nov 2026 13:13:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Gideon Heinz <gideonheinz02@gmail.com>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
	Edwin Velds <e.velds@gmail.com>, Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
Message-ID: <av9mLqY8TMOhJK2-@google.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <p6p98p0s-5p97-q584-14sn-ns404p6s3orn@xreary.bet>
 <49nqon1r-32pr-19r1-0r65-50494sq350n5@xreary.bet>
 <sr340r82-n378-035n-78ns-nrq4p808r3pp@xreary.bet>
 <av9lbJa8VlQTeatR@google.com>
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
In-Reply-To: <av9lbJa8VlQTeatR@google.com>

On Thu, Nov 19, 2026 at 01:10:45PM -0800, Dmitry Torokhov wrote:
> On Thu, Nov 19, 2026 at 09:36:07PM +0100, Jiri Kosina wrote:
> > On Thu, 19 Nov 2026, Jiri Kosina wrote:
> > 
> > > > Wow, what an endeavor. Thanks for looking into all this.
> > > > 
> > > > I've finally got to processing it. I've applied 1-14 to 
> > > > for-7.4/upstream-fixes and the rest on top of it to for-7.5/logitech.
> > > 
> > > Ok, now I see that you will be respinning. So I am dropping it for now and 
> > > will wait for respin.
> > 
> > Are you planning the respin to contain differences only around the 22/23 
> > patches?
> > If so, I'd prefer to still take the first 14 through upstream-fixes, so 
> > split the series.
> 
> I do not have any outstanding code changes for this series unless you
> have some comments.
> 
> I think if you simply drop #22 and pick up Gideon's tested-by you will
> be good. But let me know if you want me to apply the tags. 

Oops, sorry, I forgot there were couple of Sashiko comments. Let's me
send out the updated series (I already made changes earlier).

Thanks.

-- 
Dmitry
