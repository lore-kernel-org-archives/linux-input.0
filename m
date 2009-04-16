From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Thu, 16 Apr 2009 12:48:37 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909015F8F31@mi8nycmail19.Mi8.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <20090416020836.GB2413@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE1909015F8DFD@mi8nycmail19.Mi8.com> <200904151933.06721.dmitry.torokhov@gmail.com> <BD79186B4FD85F4B8E60E381CAEE1909015F8DFF@mi8nycmail19.Mi8.com> <20090416080500.GA16792@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:54955 "HELO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755463AbZDPQtA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 12:49:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090416080500.GA16792@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thursday, April 16, 2009 1:05 AM, Daniel Mack wrote:
> On Wed, Apr 15, 2009 at 11:11:41PM -0400, H Hartley Sweeten wrote:
>> How's this?  I left the ability for the original ABS_* axis
>> operation since that might be what Daniel Mack needed.
>
> Erm, applying this patch gives me
>
>  CC      drivers/input/misc/rotary_encoder.o
>  drivers/input/misc/rotary_encoder.c: In function
'rotary_encoder_irq':
>  drivers/input/misc/rotary_encoder.c:68: error: 'struct
rotary_encoder'
>  has no member named 'rollover'
>  drivers/input/misc/rotary_encoder.c:74: error: 'struct
rotary_encoder'
>  has no member named 'rollover'
>  drivers/input/misc/rotary_encoder.c:77: error: 'struct
rotary_encoder'
>  has no member named 'rollover'
>  make[3]: *** [drivers/input/misc/rotary_encoder.o] Error 1
>  make[2]: *** [drivers/input/misc] Error 2
>  make[1]: *** [drivers/input] Error 2
>  make: *** [drivers] Error 2
>
> You could at least have compiled it ;) Below is a clean version of
that
> patch.

Sorry about that. I copied the wrong file from my working tree to my git
tree when I created the patch.

I'll re-verify the patch and submit it again shortly.

Thanks,
Hartley
