From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Tosa keyboard support
Date: Fri, 11 Jan 2008 09:56:06 -0500
Message-ID: <d120d5000801110656n1e65f4amf743a8f90183cc09@mail.gmail.com>
References: <20071223232914.GA28932@doriath.ww600.siemens.net>
	 <d120d5000801030851j6629e4f0m102939aff412df5b@mail.gmail.com>
	 <fljpft$nc9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:55299 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbYAKO4I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jan 2008 09:56:08 -0500
Received: by hu-out-0506.google.com with SMTP id 19so451700hue.21
        for <linux-input@vger.kernel.org>; Fri, 11 Jan 2008 06:56:06 -0800 (PST)
In-Reply-To: <fljpft$nc9$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi,

On Jan 3, 2008 6:01 PM, Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
> >
> > Also, I'd put these defines rigth in tosakbd.c.
>
> The TOSA_KEY_RECORD and SYNC are used inside arch/arm/mach-pxa/tosa.c
> (for gpio-keys declaration). So I would prefer to place all such defines here.
> When the Kdrive would be fixed, I would drop KEY_RECORD and happily move
> that defines to tosakbd.c
>

Ok, fair enough. Because driver touches arch-specific arm parts it
does not apply cleanly to my tree. I think the best way would be to
merge it through arm side, this will minimize merge efforts Feel free
to add:

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
