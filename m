Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681288;
	b=tmlYnIT2c+q4XQwxxOYI7hgYcW+6P01wcF2WC6kcD+gnCBCvWC5dOOeRZwVI9m4gRhC+
	 zp/rF8sJhoa+JcjDhC0sPLbLjviChtJTWrXovR9grsNEH/z+eEKqSStxFvzox7Y8BDYoK
	 sBIFEGOce2T6Yj3OaLPIz4n4QH9mBh2FgSXsknuSmDL5YbMY7zkloJprkvtJHrgR+a1zt
	 t86d+3SRUN/n8CqvLt4/9FNYTBYrKl7dgdWdzkEY0uxntKwJYrNUaBroYapSmce7Y7cCb
	 EdqimFNsaGl8TZJXI8RhdtQAtrsafKqCD7NMfN8EK7RNLfU1PewEw7BE4SBOJP34uAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
	b=asiE0gK9vXPZPOKmPYd/gG3VOeJBgvEtJO98rl7UethMuCRVH9r+Z2AS85nFz2Xa/068
	 WIDrU/naS5JIxnAFp09Gq985UykWHth/rlCvGi/4Sqq3dHFZW3kj7mZtXvdUj82nT5c/t
	 N0lsbCMAMnpw9AcLhMMgBG/SBcYI1UaoErBWvik4dMBwXT2nwZ6BvERXFGs0KQRyW7Ov6
	 W1e/lw+mN3UlliNE5C6ZR5Ows8X0w7TzGmDvC0HxJW5X3JZatFbelcPB+pH+uqfexGdpd
	 l3D0YeVCma8ixF3jzq3cJxVA5iMztTxOu91WaZiexTbbBJ9sW84W/eQGfO3q/0VRIjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTdOHobo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD6606A68B
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 08:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74BD6606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTdOHobo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38431138772so8758275eec.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 00:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681288; x=1796286088; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
        b=yTdOHoboSe6gfTIhG0tnGzhdNHIQAkvIbhmz5xF0MSi0F3yzUttS9+e2B6NcNcIQDs
         9EHGmW3RTIyx+j8cGN6BbhT/YpLjG1pT6jhRZ3JKA8qgfElDTHGasz2d3K5oUrWu0Em6
         a6yl9NQfONiJP/AsIfiLJ4O2TyFU6nE4/lblOyl8ObcJFlqen0HDBvx/LYXPySKN2XZH
         ncia7RMEpCsjWQHz1+MHUp9z8tPfKaDCHPQbb6ElzkfKoj/btr7J+dC9wpX0uPkPMzI/
         mYzpIof1/CY389zEianq8zdKEJekaG0A+SmhmSJDS4+ThXSI/i+jstn5UkxKhJ3Kg05y
         XOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681288; x=1796286088;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wBOZvbV/Ao3pnBzrcXZtW9CD2639Ae7gzM3oEey/+58=;
        b=LSRK3LDRtj7uylrse4sZYp26cxJe2MtJ0o0GrUD8ykEbPvuhHla6Y6xpmCKbE/lOPk
         LEfZ+KMZRv9l6mpwJZ61kJA3D+VrWcs7QFSNZ0A/lGyVvaOaaXMckxYqRWDxn+ASPS+o
         tOzF8ERe+IHJQJS6RWDZjRo8LPuHrmkG6xwZ0WHAb4LjSRAeVolgAjsGow1E9l5qq6gc
         Rte5G61tlZwiumPOHupeD4yiSUWqPtRVBSw6yv1ZVQEdVFKljceMtnNc65Xo6HHrZoJf
         zHg1v9JnAZr33BmC6/0kNxZPhS6RtYDd0LnKbHVhttZMU8fVziyvRz3qCrOhJmY7gZi/
         biug==
X-Gm-Message-State: APuU4Z/5c5qSzNHGaeERkgCFx6+dj2h32VgHU83t3swFnaJ9bXVQVzVO
	rHNGsz7WwUmHXgR+VPq8ygWn+wWj6ITQrOjmgwCaV8jFl4fWekk6+X8m
X-Gm-Gg: AZFdTZfQlUOTAvvpMDURstIplz9FRkS4OnABdnX7uWpdNe4hEJzTyJprr+TO3cPXEyo
	ylszgzFGmfNLqaZLaqeHsf47GMVie0cEI9CTerPqlBh5Lk9hGYEar8fN4+nexfXYmTLh89zlqsS
	QAoz51wzcuhTyDvL1mBEqD28BBWwKU/Ogr+Jo4p5ud9SLD2N9EvcpPyb0iQkLE3tIVwxd6CvYFU
	Qs5iH8v0/f15+y6VsGrfk0KbRq+B38Vtmz+QTx/8cRGimULJsvs96zZEFZJ3rDwdtyum1aqb87h
	4VgPdUvkZYRxJ3PA5RRTiLvPcutUUBzDUa7RPIzy+t21eJEjExYt1rEFOurx0qofEvEHRiW/XD0
	9gZ32FhYZFHVfNBxh3Eow+0rd5ekDFm+PaOxO1UzfUp/RfYKEzhu1e5aAr8CJfuBDBCpVw2OlGs
	Ge8tK4yVnJcAiOiSs3F48fVIhi80dAkqUHrg/C6rX00xxzmeOlrjuzueXfWK4844OGEp9yzrjzx
	+oH/gaZqmP9vnvKJYIzddH+ZGyzHRka23+8QLJvY1FSc59aHuLa7xRv1y2kfYqAKQXGNQHEE2Im
	Fo0bq0WBd6c3oroP0TaswxdgMZ07Y5ftrnx2bck+uov0M+CwlkLKsNejKunfacWax4bkcw==
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id 5a478bee46e88-3857093f077mr31004036eec.21.1795681287254;
        Thu, 26 Nov 2026 00:21:27 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm68602910eec.26.2026.11.26.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:21:26 -0800 (PST)
Date: Thu, 26 Nov 2026 00:21:25 -0800
Message-ID: <8497d7101dc7524be91edbaa5a9face5@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Prasanth R <ragaprasanth@gmail.com>
Cc: linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	driver-core@lists.linux.dev
Subject: Re: [PATCH 0/3] Input: clear the wake IRQ on unbind
In-Reply-To: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
References: <20261125072124.2997511-1-prasanth.r@lineo.co.jp>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Prasanth,

On Wed, Nov 25, 2026 at 04:21:21PM +0900, Prasanth R wrote:
> These drivers set a wake IRQ with dev_pm_set_wake_irq() and never clear
> it. After unbind and bind, dev_pm_set_wake_irq() warns "wake irq already
> initialized" and returns -EEXIST.
>
> Switch them to the device-managed helpers.

Adding PM and driver core maintainers to the thread.

I wonder why clearing the wake IRQ cannot be done automatically for all
drivers on unbind, for example in device_unbind_cleanup() alongside
pm_runtime_reinit() and dev_pm_set_driver_flags().

The only case I see where a wake IRQ is attached at device registration
time rather than by a bound driver (or bus probe()) is PCI OF WAKE# in
drivers/pci/of.c:pci_configure_wake_irq(). That could be distinguished
by checking dev->driver when attaching the wake IRQ, or via an explicit
flag, so device_unbind_cleanup() only clears driver-bound wake IRQs.

Handling this in the core would save us from having to hunt down and
convert individual drivers to devm_pm_set_wake_irq() across the tree,
and would also fix buses like SPI that set up wake IRQs in probe() but
do not clear them on remove.

Thanks.

-- 
Dmitry
