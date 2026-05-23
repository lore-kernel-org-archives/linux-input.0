Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D9343890;
	Sat, 23 May 2026 04:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509527; cv=none; b=epPm6J/yF4RZHnw9t91Lk4XuIYFCFUDiXx6lX9r415Zw7JzaeAGWVKWW7Mzyc1kV44K8TIOxMHNbx2jjN6HzZu1s0JMmZQ5IsrYfg2XFAzQ2xdx4IV65K2k4of0vr64iQjy60cTpgR7f/hB5LR6/BRKOPczYoZiMUdFHLZ3y5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509527; c=relaxed/simple;
	bh=8mjSqbbAizGwwB1UZ90sUvx+4w59Q+78ELkYmdkZQq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI1+cnqQbnyLcly2ebIskWTe23pPlc8z3F9czX7tVj12GZKLJZbahJxyk86NTmfv+KdHmR1u9R72mWMb2Dd11lQsAwDOn9dMl1EFmFKm5tzvzR/BHSj2bzmBBXdKn7skt5NK6/0fE9V/Vdn/Jw9j+lCHFdUBx1WYlOh+NcS/PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ad2PVg0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ad2PVg0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD01F000E9;
	Sat, 23 May 2026 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779509525;
	bh=AdDvgGz/Md160gz3jHkaSj7hzyLNLsuWGmCNWxCfrm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ad2PVg0ehxKsIsknxd+jlD9Y1+lHIxv6x2SiIeInwug1wmcAge2c/14/DqxR38edT
	 mC7lLpvNpkVeiiPfa9mMuY4oDgVeOaXWefQge65AmosNjs5F52V/JSOBzNk2QO5HhM
	 nycM+XHE3GKVknt7u1MrHs4hjALik1KxEqy+iK8k=
Date: Sat, 23 May 2026 06:12:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dev exalt <exalt.dev.team@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, jikos@kernel.org,
	bentiss@kernel.org, lains@riseup.net, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sari.kreitem@exalt.corp-partner.google.com, hbarnor@google.com
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
Message-ID: <2026052308-economic-cradle-14f7@gregkh>
References: <20251215125319.33261-1-exalt.dev.team@gmail.com>
 <b1a7b5ab35c5dc16753e6a4ce98837d26c0eb98a.camel@hadess.net>
 <CAJaUH_-0vDrXTr==n=eKJH+BmhDRjzpd6s9by2yTMJH9VuD+gA@mail.gmail.com>
 <CAJaUH_-aPMopA90xthPMVhktyyL6WHJPgn748yQ95UAVgaaaFQ@mail.gmail.com>
 <CAJaUH_8Tg=QCB96aFBu_zvJd03EN6zgBvS8RGGvN4UonjTJ7_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaUH_8Tg=QCB96aFBu_zvJd03EN6zgBvS8RGGvN4UonjTJ7_w@mail.gmail.com>

On Thu, May 21, 2026 at 12:27:05PM +0300, dev exalt wrote:
> Hi,
> 
> Following up on this thread regarding HID++ Multi-Platform feature
> (0x4531) support.
> Please let us know if you’d like us to proceed with a V2 patch based
> on the discussed approach.

As-is, a module parameter will not work.  All systems have configfs, and
sysfs, so use that for device configurations that need it.

thanks,

greg k-h
