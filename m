From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Adding 'half shutter' definition to 'input.h'
Date: Sun, 11 Jan 2009 23:23:19 -0800
Message-ID: <20090111232141.ZZRA012@mailhub.coreip.homeip.net>
References: <13840250.309261230013670370.JavaMail.weblogic@epml09> <200812230045.42765.dmitry.torokhov@gmail.com> <4d34a0a70812231631u359e85an29d2ed30bccd59a5@mail.gmail.com> <4d34a0a70901071848m65efb9es26a326cf36feeef6@mail.gmail.com> <alpine.LNX.1.10.0901080946460.5377@jikos.suse.cz> <20090110235337.ZZRA012@mailhub.coreip.homeip.net> <4d34a0a70901111700g4b2ccc6fme6cfcf7aa32b46fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:21847 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZALHYH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:24:07 -0500
Received: by qw-out-2122.google.com with SMTP id 3so9557228qwe.37
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:24:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d34a0a70901111700g4b2ccc6fme6cfcf7aa32b46fa@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, sj76.park@samsung.com, sk.heo@samsung.com, kyungmin.park@samsung.com

Hi Kim,

On Mon, Jan 12, 2009 at 10:00:32AM +0900, Kim Kyuwon wrote:
> Hi, Dmitry,
> 
> On Sun, Jan 11, 2009 at 4:57 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Kim, Jiri,
> >
> > On Thu, Jan 08, 2009 at 09:51:11AM +0100, Jiri Kosina wrote:
> >> On Thu, 8 Jan 2009, Kim Kyuwon wrote:
> >>
> >> > Because Jiri Kosina personally agrees with adding the [half]shutter key
> >> > yesterday, I'm sending this patch. (Thanks Jiri)
> >> > New cameras and mobile phones (at least SAMSUNG's) have the half shutter for
> >> > 'auto-focus' functions. so I think this half and full shutter keys are needed.
> >> > Please review this patch.
> >>
> >> Hi,
> >>
> >> please note the "if there is any in-kernel code that actually uses it"
> >> part of my e-mail. Adding just the key definition without any kernel code
> >> actually using is not likely to happen.
> >>
> >
> > Additionally I don't think we need 2 new codes. We have KEY_CAMERA that
> > is supposed to be sent when we want to take the picture, so only one new
> > is needed. Probably should call it KEY_FOCUS or KEY_CAMERA_FOCUS.
> >
> > --
> > Dmitry
> >
> 
> OK, It seems like your suggestion is better mine :)
> (Personally I prefer KEY_FOCUS to KEY_CAMERA_FOCUS )
> And I would be really satisfied, if any key which can represent the half
> shutter is added to 'input.h'
> 
> Thank you for thinking this issue again.
> If there are further steps that I can take, please let me know.
> 

Just add the key definition to input.h and send it along with the rest
of the driver when you feel that it is ready to be merged in mainline.

Thanks.

-- 
Dmitry
