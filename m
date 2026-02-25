Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783A3E8C40;
	Wed, 25 Feb 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041003; cv=none; b=DX9vPVqKmS1i7pzKh7c1zdN2uCrNjUVfXoMrZMgV9KftkML/6cLNPBOJdTvq1rOSKY+WRKtrq0bS4Pn7bezIuPKF/+yQY8Ge4Fnh/ZEvDMcf8LQzmAXvZaL2zJdUpHsIGKbTbtH1Bqdp6Af5Jc1Gg3gXICUVcjN1+K3zLiFE9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041003; c=relaxed/simple;
	bh=7QDMBMvY2b6tZSLDMf5h84kphENPEICEPxaIb57GQbQ=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=UZwzsH7oIVi2a2ISq9/bhHDqZedyIfcAaO2pM2zobJmZq6hkZxtXOYVziYosJCkYo+YbqpF15+BALDTsilW56R7FRtAt2hgAIDt7CPmENBmu7sHRp06EyoTV5DHhywY3cznrm+xNzypFfaizosXimSEEXCBo9SnfUOcRdONQois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tF+Wrfiz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tF+Wrfiz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=eZJe1ysZtHDQPXqYHzpEFAwR2dAkNxW7ASLxemDvh/o=; b=tF+WrfizVOqWBP1aoKqgQFJKi9
	7aWfTCGHVJ7F+0sHSSaOjn2xTVV+zsvEbdDFcrEApR8LLJEC8hYZcIfiiOOy5TkamOIOxuTWkeSHt
	pirVEDGEIj/ZzLbBX/J9olz8lvqTyyZPpB9R3/KYbE3GDeqiBocLFYHhYq26+Uz9ASvU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:53172 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vvIoJ-0007uZ-Po; Wed, 25 Feb 2026 12:36:32 -0500
Date: Wed, 25 Feb 2026 12:36:31 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, robin@protonic.nl,
 andy@kernel.org, geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hvilleneuve@dimonoff.com, mkorpershoek@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lee@kernel.org, alexander.sverdlin@gmail.com, marek.vasut@gmail.com,
 akurz@blala.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Message-Id: <20260225123631.6a2c039e05d7609604463809@hugovil.com>
In-Reply-To: <aZ8voAddPvMLCvc4@smile.fi.intel.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
	<20260225155409.612478-5-hugo@hugovil.com>
	<aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
	<20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
	<20260225115652.8beb1979df3824f7a95d22bc@hugovil.com>
	<aZ8tocPCKqTXqbC0@google.com>
	<aZ8voAddPvMLCvc4@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -1.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 25 Feb 2026 19:21:36 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 25, 2026 at 09:14:16AM -0800, Dmitry Torokhov wrote:
> > On Wed, Feb 25, 2026 at 11:56:52AM -0500, Hugo Villeneuve wrote:
> > > On Wed, 25 Feb 2026 11:41:55 -0500
> > > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > On Wed, 25 Feb 2026 18:12:13 +0200
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:
> 
> ...
> 
> > > > > > +#include <linux/of.h>
> > > > > 
> > > > > Is this in use? Or you wanted mod_devicetable.h for OF ID table?
> > > > 
> > > > I need only OF ID table, so will replace with mod_devicetable.h.
> > > 
> > > Hi Andy,
> > > finally I need <linux/of.h> for of_match_ptr()...
> > > 
> > > But I will keep <mod_devicetable.h> ...
> > 
> > Do we need the dependency on OF? We may include of match pointer
> > unconditionally and the driver could be used on ACPI systems with
> > PRP0001 HID.
> 
> Not only that. of_match_ptr() or ACPI_PTR() shouldn't be used in a new code
> (there are, of course, _rare_ corner cases, which this one is not one of).

Ok, will remove of_match_ptr() and also include <linux/of.h>

Hugo Villeneuve
