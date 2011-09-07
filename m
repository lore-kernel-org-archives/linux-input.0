From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Wed, 7 Sep 2011 11:54:16 -0700
Message-ID: <20110907185416.GC2874@core.coreip.homeip.net>
References: <20110708204630.GA28623@core.coreip.homeip.net>
 <4E178320.7050401@zytor.com>
 <20110708223709.GB28623@core.coreip.homeip.net>
 <4E179033.9050806@zytor.com>
 <20110709003508.GC28623@core.coreip.homeip.net>
 <4E180BA5.4080808@zytor.com>
 <20110907181641.GA5678@core.coreip.homeip.net>
 <4E67B652.5010406@zytor.com>
 <20110907183745.GB2874@core.coreip.homeip.net>
 <4E67BAAE.9060605@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61859 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab1IGSyW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 14:54:22 -0400
Received: by yie30 with SMTP id 30so5201227yie.19
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2011 11:54:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E67BAAE.9060605@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On Wed, Sep 07, 2011 at 11:40:46AM -0700, H. Peter Anvin wrote:
> On 09/07/2011 11:37 AM, Dmitry Torokhov wrote:
> >>
> >>I thought there were pointers, (or longs) there too.
> >>
> >>In fact, we might have had the worst of both worlds here...
> >
> >The pointers are in ioctl paths (upload of force-feedback effects with
> >custom waveforms - noone actually uses them in real life).
> >
> 
> Ah... we might have lucked out then!
> 
> The proc/sysfs issue is still HUGE, however, because that affects
> all the read/write paths *indirectly*.
> 

Yeah, we are stuck with these unfortunately... Unless we want to say
that x32 applications will be presented with bitmaps encoded with 64-bit
segments instead of 32-bit ones. This would mostly matter to startup
scripts... X and the others use ioctls, not proc/sysfs.

-- 
Dmitry
