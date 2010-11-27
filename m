From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 15:39:02 -0800
Message-ID: <20101127233901.GA29981@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
 <4CEE6EE8.4060805@gmail.com>
 <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
 <4CF0BC13.2010800@gmail.com>
 <20101127083229.GA28745@core.coreip.homeip.net>
 <4CF0C69D.9080904@gmail.com>
 <20101127091533.GA27213@core.coreip.homeip.net>
 <4CF0D35B.4030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47539 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab0K0XjK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 18:39:10 -0500
Received: by ywl5 with SMTP id 5so1456856ywl.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 15:39:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF0D35B.4030807@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 12:46:03PM +0300, Nikolai Kondrashov wrote:
> On 11/27/2010 12:15 PM, Dmitry Torokhov wrote:
> >2000LPI == about 79 l/mm. How is it not useable?
> TBH, I didn't make any real calculations.
> The introduced error isn't very high, indeed. The vertical size of 4x3 inch
> tablet becomes 75 mm instead of 76 mm. So maybe it's alright.
> 
> >In mainline synaptics is the only one that does this. We do not know how
> >many drivers in vendor trees fill and use this data nor we do not know
> >about userspace. The fact that we were not able to locate them does not
> >mean they do not exist. The units/mm are part of input ABI now.
> Well, I can't argue with you here.
> I didn't think about 3rd party drivers, TBH.
> 
> >Right, standarize on existing UOM (which are per/mm) and then implement
> >other UOM if theya re really needed.
> Will this fix qualify for inclusion into 2.6.37?

Yes, I believe it does.

> Also, what do you think about units per radians for rotational axis?

Works for me.

-- 
Dmitry
