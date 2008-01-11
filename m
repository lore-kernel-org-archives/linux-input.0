From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Tosa keyboard support
Date: Fri, 11 Jan 2008 15:52:04 -0500
Message-ID: <d120d5000801111252k54b9d706i543086f771e9896c@mail.gmail.com>
References: <20071223232914.GA28932@doriath.ww600.siemens.net>
	 <d120d5000801030851j6629e4f0m102939aff412df5b@mail.gmail.com>
	 <fljpft$nc9$1@ger.gmane.org>
	 <d120d5000801110656n1e65f4amf743a8f90183cc09@mail.gmail.com>
	 <fm8619$ili$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:9521 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYAKUwG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 15:52:06 -0500
Received: by fk-out-0910.google.com with SMTP id z23so979369fkz.5
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 12:52:05 -0800 (PST)
In-Reply-To: <fm8619$ili$2@ger.gmane.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Jan 11, 2008 11:38 AM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
> Hi,
>
>
> Dmitry Torokhov wrote:
>
> > Hi,
> >
> > On Jan 3, 2008 6:01 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
> >>
> >>
> >> > Also, I'd put these defines rigth in tosakbd.c.
> >>
> >> The TOSA_KEY_RECORD and SYNC are used inside arch/arm/mach-pxa/tosa.c
> >> (for gpio-keys declaration). So I would prefer to place all such
> >> defines here. When the Kdrive would be fixed, I would drop KEY_RECORD
> >> and happily move that defines to tosakbd.c
> >>
> >>
> > Ok, fair enough. Because driver touches arch-specific arm parts it does
> > not apply cleanly to my tree. I think the best way would be to merge it
> > through arm side, this will minimize merge efforts Feel free to add:
>
> Strange. The patch is against 2.6.24-rc7 and applies cleanly to both
> for-linus and master branches of .../dtor/input.git

Hmm, I think the version I originally tried did not... Anyway, my
concern is that when flood gates for .25 are opened there will be alot
of changes in PXA land. However changes to input side are trivial
(Kconfig and Makefile) and are resolved much easier so if you
coordinate with Russel it will work much better.

> > Acked-by: Dmitry Torokhov <dtor@mail.ru>
>
> Russell, do I need to resent patch?
>

-- 
Dmitry
