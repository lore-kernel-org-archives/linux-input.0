From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 6/7] thinkpad_acpi: More Carbon X1 2014 keys
Date: Mon, 23 Feb 2015 11:09:05 +0100
Message-ID: <1424686145.28361.9.camel@hadess.net>
References: <1424443477.22910.18.camel@hadess.net>
	 <54E78AAB.2020604@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42547 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbbBWKKl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 05:10:41 -0500
In-Reply-To: <54E78AAB.2020604@mit.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Fri, 2015-02-20 at 11:27 -0800, Andy Lutomirski wrote:
> On 02/20/2015 06:44 AM, Bastien Nocera wrote:
> > +		KEY_MICCANCEL_MODE,  /* Microphone cancellation */
> 
> What's this?  We already have KEY_MICMUTE.  Is this different?  If so, 
> can you improve the comment a bit?

I don't think the comment needs improving. This is the device driver
part of the patch series. If comment was required, it would in the
commit adding the keycode to input.h. We're discussing that with Dmitry.

> The answer may be obvious to anyone who has an awful X1 carbon gen 2 
> keyboard, but these KEY_XYZ defines should IMO be clear enough that even 
> people without the hardware can figure out what's going on.

I'll make sure to link this in the input.h patch:
http://www.lenovo.com/shop/americas/content/user_guides/x1carbon_2_ug_en.pdf

In any case, it doesn't look like this particular keycode will make it.

