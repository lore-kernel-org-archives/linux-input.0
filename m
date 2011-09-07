From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Wed, 7 Sep 2011 11:37:45 -0700
Message-ID: <20110907183745.GB2874@core.coreip.homeip.net>
References: <4E17504F.5070806@zytor.com>
 <20110708204630.GA28623@core.coreip.homeip.net>
 <4E178320.7050401@zytor.com>
 <20110708223709.GB28623@core.coreip.homeip.net>
 <4E179033.9050806@zytor.com>
 <20110709003508.GC28623@core.coreip.homeip.net>
 <4E180BA5.4080808@zytor.com>
 <20110907181641.GA5678@core.coreip.homeip.net>
 <4E67B652.5010406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54036 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab1IGShv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Sep 2011 14:37:51 -0400
Received: by pzk37 with SMTP id 37so110792pzk.1
        for <linux-input@vger.kernel.org>; Wed, 07 Sep 2011 11:37:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E67B652.5010406@zytor.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On Wed, Sep 07, 2011 at 11:22:10AM -0700, H. Peter Anvin wrote:
> On 09/07/2011 11:16 AM, Dmitry Torokhov wrote:
> > On Sat, Jul 09, 2011 at 01:04:53AM -0700, H. Peter Anvin wrote:
> >> On 07/08/2011 05:35 PM, Dmitry Torokhov wrote:
> >>>
> >>> Input only need to do this compat stuff on read/write paths so maybe if
> >>> you add plumbing similar to compat_ioctl we could switch owver to it.
> >>>
> >>
> >> The problem is that read/write ties into a large number of system calls,
> >> and input is the *only* subsystem which needs it.
> >>
> > 
> > BTW, while listening to x32 resentation on LPC I realized that the need
> > for compat tests on read/write paths in input subsystem is due to use of
> > timeval in input_event structures. If x32 solved the time_t issue by
> > moving to 64 bit times then input read/write should simply use native
> > 64 bit operations.
> > 
> > That still leaves sysfs and proc business of course...
> > 
> 
> I thought there were pointers, (or longs) there too.
> 
> In fact, we might have had the worst of both worlds here...
> 

The pointers are in ioctl paths (upload of force-feedback effects with
custom waveforms - noone actually uses them in real life).

-- 
Dmitry
