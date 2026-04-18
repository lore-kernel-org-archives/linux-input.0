Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86671326938;
	Sat, 18 Apr 2026 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776496483; cv=none; b=SLoTSGtPmGfCjEB5QqdVp7SF665rR+1C0J/ZoYTbLq9q1iVnB4DIZA3/nyLyJc+2kf89OYhNmOFgS+wwYywYu+6IMin2fVIwMo7VsdlNhPalUNaWvTm2kDoaWTa4xoj3KY1lOeNPnbjXSFamiPSEyo03H3/DJnmKo+GmBrtqoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776496483; c=relaxed/simple;
	bh=9gkKROIrKMDYokgdoKbSwsI9W1L9HMdv/hQ5Qmf9yYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLQuz4rjTun0dbX+BCVKlKxqNC2mRG6YZ+vVZPdv5q32lNaEJBmjzFY9t+CLhtfN74KL5TcupmlkeaLRbVIYQxCKxbgL/I1xV1UzHGoMdWjt2GNpM4xVhhoM4X7yIf5KDq4X0VLSfeh4KbCy6bDPDwmw04EaAMDZguruNjP7xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=D0UlEWiG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uSPPKZB+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="D0UlEWiG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uSPPKZB+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB0F41400095;
	Sat, 18 Apr 2026 03:14:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 18 Apr 2026 03:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776496480; x=1776582880; bh=GtnYZp7AKb
	GAz+DaPar8dtMqZFmTpMDldNC/2g0WWao=; b=D0UlEWiGpTmJ5HplBfqkgIcIWL
	+h3OyKmM9UyrGd/ppWKFYS5IohNTWuls0bZpqF40DT/7Z/rlde4+3tZoyRtHa2eS
	R8Nlt+TsKAF44nUyAxsiTycEhFLxsSbHhXGh1/do4tPzARyVBiQjnPp1clNNCM+q
	3bXSIM1lVIJvhBFejY9SvVF9boJOp9FLleLVZCFmfjbwSwO0SdlW8Pcq74bKLhHK
	eno4uERm4ojQy/zJ6DCbGqh0FeOhneUfc/g/FDzdVn4POByZaeV4VQV0z06sGm/n
	e9cFMx1TpdGdMCvxc4WXYE4prGZXr2Ppir0uGGa9a7qbziunDzbutOqKrdig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776496480; x=1776582880; bh=GtnYZp7AKbGAz+DaPar8dtMqZFmTpMDldNC
	/2g0WWao=; b=uSPPKZB+mcA25MUIGNUpxRNJujlFMHOi4scYPvlNfdH9R3nouOu
	Z4CgOiUqDXb+PSc/jG9n2sUXJzb1iArxNM871DzOiBv9Sp2P+MbVmKQMIkQbf0GV
	qB2GMM9HlfVtLhuqk+xJR03+y0kZn/fRYFbFfhT+sSJc+cFJakphF4EV8QSV5nK2
	XOz/kt+/AINIzR6mOls3AoP7xQBYdwO4F5OBExfVt7eFhaL+ke08wBiExb2nKSF1
	95wlDRmiHWvN8mV8Qps5HAbsKcev23Y8Rld38LDi2mT5YQMhlKeAaAQVcmEcSXh2
	Fyeb1DWBNJ6/odNzDjuPXBfPOKNkM9YHEuw==
X-ME-Sender: <xms:YC_jaZn4wn2Yc_NPPeOPKWfu7cH_yLJ-LvbyZx4vKvIql9z82J_Xkw>
    <xme:YC_jaRibE6A1x7cRgbBR0eYL95AGqVF9Mof_1Za7WTFONsAq5d58DYoq1j2tdNoHp
    80il8lJHRnkM14GvtnUAi0KJdF5V7jRk0Cr5Rpk0SsAY1j0Mg>
X-ME-Received: <xmr:YC_jaTh8vgljbTmWzxkOmKGfNKmRvRjTO5xtCxwa_I9v95qbZG7wpi-r5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehvddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtrgihlhhorhesvgigphhonhgvnhhtrdguihhgihhtrghlpdhrtghpthhtohepjhhikh
    hosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhtihhssheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:YC_jaTsnG_u62w8sRheLlORiBLjLDIM442fdPfYQzGSIbuDSSLo9yA>
    <xmx:YC_jabsDqmvzDO0Nh1xa1b61i6wC-BZMedeIApgLudbxY0nLEL-PxQ>
    <xmx:YC_jaRrgoWF7JDzvbIFV0G-vrW5yCvfQlwH-wTSgSPU18b0N7qi_kA>
    <xmx:YC_jaSJPpkQmtLH1YCkOQHRIhzMJWgJB4rVeNVHuukjNw_AZKumqzg>
    <xmx:YC_jaSZO-G0QqeknlxNuCW_XGu9Eq4t4BNuWhJeBMc-mHRmnvN8YKAxq>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 03:14:40 -0400 (EDT)
Date: Sat, 18 Apr 2026 09:14:08 +0200
From: Greg KH <greg@kroah.com>
To: Taylor Hewetson <taylor@exponent.digital>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: sanitize hid->uniq against non-printable
 bytes
Message-ID: <2026041845-approve-pelvis-9845@gregkh>
References: <20260418025823.21767-1-taylor@exponent.digital>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418025823.21767-1-taylor@exponent.digital>

On Sat, Apr 18, 2026 at 02:58:23PM +1200, Taylor Hewetson wrote:
> Some USB HID devices (observed on ASUS ROG Azoth via its 2.4GHz
> dongle, USB ID 0b05:1a85) report an iSerialNumber string whose
> USB string descriptor declares a longer length than the actual
> serial, leaving uninitialized firmware memory - including control
> characters such as 0x18 - appended to the returned string.
> 
> These non-printable bytes propagate into hid->uniq, which in turn
> populates /sys/class/input/inputN/uniq. Downstream userspace
> components (systemd sd-device property_is_valid(), and by extension
> mutter input enumeration on GNOME Wayland sessions) reject devices
> with control characters in their uniq, rendering otherwise-
> functional input devices unusable in graphical sessions despite
> the kernel input layer correctly translating keypresses.
> 
> Truncate hid->uniq at the first byte outside the printable ASCII
> range (0x20..0x7e) after the serial is read.

Why aren't we doing this in the USB core instead of forcing all users of
this to do it instead?

thanks,

greg k-h
