From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.
Date: Mon, 8 Mar 2010 23:50:11 -0800
Message-ID: <20100309075010.GE17288@core.coreip.homeip.net>
References: <8763562u0n.fsf@troilus.org>
 <871vfu2tvh.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:54224 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0CIHuP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 02:50:15 -0500
Received: by ywh27 with SMTP id 27so3071583ywh.22
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 23:50:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871vfu2tvh.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

On Mon, Mar 08, 2010 at 07:58:42PM -0500, Michael Poole wrote:
> From 92872d16dfc6f2c037124644f30f807d30b6557c Mon Sep 17 00:00:00 2001
> From: Michael Poole <mdpoole@troilus.org>
> Date: Mon, 8 Mar 2010 19:10:13 -0500
> Subject: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.
> 
> Also publish a parameter to control the emulated scroll
> acceleration rates.
> 

FWIW I am still inconvinced that complex gesture emulation should be
done in kernel drievr.

Thanks.

-- 
Dmitry
