From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Need for 'nomux' has been rising lately ...
Date: Tue, 14 Oct 2008 11:24:42 -0400
Message-ID: <20081014111522.ZZRA012@mailhub.coreip.homeip.net>
References: <alpine.LNX.1.10.0810141652090.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:17538 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYJNPYs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:24:48 -0400
Received: by yx-out-2324.google.com with SMTP id 8so515372yxm.1
        for <linux-input@vger.kernel.org>; Tue, 14 Oct 2008 08:24:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0810141652090.26779@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>, Alexey Starikovskiy <astarikovskiy@suse.de>

Hi Jiri,

On Tue, Oct 14, 2008 at 04:55:22PM +0200, Jiri Kosina wrote:
> Hi Dmitry,
> 
> lately, I have been seeing a couple of bug reports in which touchpad of 
> certain notebooks misbehaved, and i8042.nomux solved the problem. Most 
> recently, this happened on [1]. Do you have any idea what might be the 
> cause of the need for nomux rising so much lately? Apparently, some older 
> kernels behaved correctly even without this workaround, at least on Acer 
> Aspire 5710, as referenced in the bugreport.
> 

I am always happy to blame ACPI code (especially EC) for bad
iteraction with input devices ;), especially since there weren't any
significant changes to i8042 in any recent kernels. Do you think the
person reporting the failure on Acer could try bisecting it? Could
ALexey Starikovskiy have any ideas whether there is bad EC iteractions
stopping timely delivery of mouse interrupts?

-- 
Dmitry
