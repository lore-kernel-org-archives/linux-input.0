From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Adding 'half shutter' definition to 'input.h'
Date: Thu, 8 Jan 2009 09:51:11 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901080946460.5377@jikos.suse.cz>
References: <13840250.309261230013670370.JavaMail.weblogic@epml09>  <200812230045.42765.dmitry.torokhov@gmail.com>  <4d34a0a70812231631u359e85an29d2ed30bccd59a5@mail.gmail.com> <4d34a0a70901071848m65efb9es26a326cf36feeef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60178 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751038AbZAHIvM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2009 03:51:12 -0500
In-Reply-To: <4d34a0a70901071848m65efb9es26a326cf36feeef6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: linux-input@vger.kernel.org, kyuwonmoru.kim@samsung.com, sj76.park@samsung.com, sk.heo@samsung.com, kyungmin.park@samsung.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, 8 Jan 2009, Kim Kyuwon wrote:

> Because Jiri Kosina personally agrees with adding the [half]shutter key 
> yesterday, I'm sending this patch. (Thanks Jiri)
> New cameras and mobile phones (at least SAMSUNG's) have the half shutter for
> 'auto-focus' functions. so I think this half and full shutter keys are needed.
> Please review this patch.

Hi,

please note the "if there is any in-kernel code that actually uses it" 
part of my e-mail. Adding just the key definition without any kernel code 
actually using is not likely to happen.

Thanks,

-- 
Jiri Kosina
SUSE Labs
