Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C25471244;
	Fri, 11 Sep 2026 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118606; cv=none; b=dRqtEbmer8Kp34H1RRgQqKMXSZR9TZOxIBed1qvTBPmlzzmC6y3UPt6DojFkspdH/7jSkjlkqhHIX+ETftDa7FwU5x95b61dxlvqN9nQHFXtAHnR1UIQs6tSydFx/TrVuJzwdBwEYxapSHmZrQIFw/RjmanhT/v43J6wwqMMrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118606; c=relaxed/simple;
	bh=A5R1j4b2WdozHjGLESWY7+Fg1W3oIbcwdKwoZcmJVns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muzv0Jn7/FgaMgwKQoAxGibvpsxcGhjAkpSps6pjWHnphIL9LnC17YVjGiRvsV8FKoTsb4SFkOBXFbcusuiKarIE5vhVN08bToem/UBdQIlamW7/5F6J1yHMKZycXA0Ed94j3KtyQLVDphEQkh6tR5bKmnPJQ5D4+j0boq4nhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XCqS9Qiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XCqS9Qiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB971F000FF;
	Fri, 11 Sep 2026 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789118605;
	bh=eDVfDMZekjMYTulsUhydxfWHgUuUUaEr6z9vF9HmPOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCqS9QivL6Ga3uP5PvTxoflSwntErYIQ5zM/NnJ1tu6AF4tgw5hJ9n61AgNRIX3e+
	 dhv1oW3YekdNQH+j57Z7gvTiQsQm3vA3M4ceK1lSpd/Dyi0DGu39gzhvj3xSV6zp12
	 iK16v52Tugl4oUs52Ddfu684KMR9Ltpn3tEuZxyo=
Date: Fri, 11 Sep 2026 11:23:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	Curtis Vogt <curtis.vogt@gmail.com>
Subject: Re: [PATCH 2/3] HID: valve-index: Reboot headset on system power
 transitions
Message-ID: <2026091106-footing-antelope-7ceb@gregkh>
References: <20260910170254.833871-1-mario.limonciello@amd.com>
 <20260910170254.833871-3-mario.limonciello@amd.com>
 <2026091133-silliness-recollect-e190@gregkh>
 <20260911111652.703b865f.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911111652.703b865f.michal.pecio@gmail.com>

On Fri, Sep 11, 2026 at 11:16:52AM +0200, Michal Pecio wrote:
> On Fri, 11 Sep 2026 07:54:12 +0200, Greg Kroah-Hartman wrote:
> > > +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/reboot
> > > +Date:		October 2026
> > > +Contact:	linux-input@vger.kernel.org
> > > +Description:
> > > +		Writing a boolean true value reboots the Valve Index headset to
> > > +		recover its EDID service. Writing a boolean false value has no
> > > +		effect. This file is write-only.  
> > 
> > Shouldn't this just be a debugfs file?  Making it a sysfs file seems
> > "risky" as it's not a normal operation.
> 
> Not sure what's "risky" about it, it's hopefully a root-only thing?
> 
> And it's the only supported way for userspace to recover buggy devices
> from certain failure condition, it's been suggested that this could be
> run by udev scripts. Isn't it more "risky" to ask userspace to mount
> and tinker with debugfs as a matter of routine?

You are creating an "odd" user/kernel api that is used for debugging,
that's not what sysfs is for.  sysfs is to show attributes that a device
has NOT to cause the device to go off and do some random thing (yes,
there are exceptions, but generally that's the rule.)

debugfs is "do whatever you want", so that's a better place for this.

thanks,

greg k-h
