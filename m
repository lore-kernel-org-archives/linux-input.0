From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Adding 'half shutter' definition to 'input.h'
Date: Sat, 10 Jan 2009 23:57:04 -0800
Message-ID: <20090110235337.ZZRA012@mailhub.coreip.homeip.net>
References: <13840250.309261230013670370.JavaMail.weblogic@epml09> <200812230045.42765.dmitry.torokhov@gmail.com> <4d34a0a70812231631u359e85an29d2ed30bccd59a5@mail.gmail.com> <4d34a0a70901071848m65efb9es26a326cf36feeef6@mail.gmail.com> <alpine.LNX.1.10.0901080946460.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:21560 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZAKH5q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2009 02:57:46 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3266681yxm.1
        for <linux-input@vger.kernel.org>; Sat, 10 Jan 2009 23:57:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0901080946460.5377@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Kim Kyuwon <chammoru@gmail.com>, linux-input@vger.kernel.org, kyuwonmoru.kim@samsung.com, sj76.park@samsung.com, sk.heo@samsung.com, kyungmin.park@samsung.com

Hi Kim, Jiri,

On Thu, Jan 08, 2009 at 09:51:11AM +0100, Jiri Kosina wrote:
> On Thu, 8 Jan 2009, Kim Kyuwon wrote:
> 
> > Because Jiri Kosina personally agrees with adding the [half]shutter key 
> > yesterday, I'm sending this patch. (Thanks Jiri)
> > New cameras and mobile phones (at least SAMSUNG's) have the half shutter for
> > 'auto-focus' functions. so I think this half and full shutter keys are needed.
> > Please review this patch.
> 
> Hi,
> 
> please note the "if there is any in-kernel code that actually uses it" 
> part of my e-mail. Adding just the key definition without any kernel code 
> actually using is not likely to happen.
> 

Additionally I don't think we need 2 new codes. We have KEY_CAMERA that
is supposed to be sent when we want to take the picture, so only one new
is needed. Probably should call it KEY_FOCUS or KEY_CAMERA_FOCUS.

-- 
Dmitry
