From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Mon, 18 Oct 2010 08:56:27 -0700
Message-ID: <20101018155626.GB10559@core.coreip.homeip.net>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
 <AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
 <20100930062547.GF5260@core.coreip.homeip.net>
 <AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
 <20101007163606.GA24406@core.coreip.homeip.net>
 <AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
 <20101014142347.GA18011@core.coreip.homeip.net>
 <4CBC2E83.70308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51117 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab0JRP4j (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 11:56:39 -0400
Received: by yxm8 with SMTP id 8so485098yxm.19
        for <linux-input@vger.kernel.org>; Mon, 18 Oct 2010 08:56:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CBC2E83.70308@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Oct 18, 2010 at 03:24:51PM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> On 14.10.2010 18:23, Dmitry Torokhov wrote:
> >On Fri, Oct 08, 2010 at 12:50:34PM +0400, Dmitry Eremin-Solenikov wrote:
> >>Hello,
> >>
> >>On Thu, Oct 7, 2010 at 8:36 PM, Dmitry Torokhov
> >><dmitry.torokhov@gmail.com>  wrote:
> >>>On Thu, Oct 07, 2010 at 07:19:57PM +0400, Dmitry Eremin-Solenikov wrote:
> >>>>Hello,
> >>>>
> >>>>On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
> >>>><dmitry.torokhov@gmail.com>  wrote:
> >>>>>On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
> >>>>>>On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
> >>>>>><dbaryshkov@gmail.com>  wrote:
> >>>>>>>PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
> >>>>>>>into one serial data stream. It's used e.g. on TQM85xx serie of boards.
> >>>>>>>
> >>>>>>>Signed-off-by: Dmitry Eremin-Solenikov<dbaryshkov@gmail.com>
> >>>>>>>---
> >>>>>>>
> >>>>>>>It actually depends on "serio: multiple children" patch. I'm not resending it
> >>>>>>>as you were the originator of the latest version of the patch.
> >>>>>>
> >>>>>>So, what about this version of patch?
> >>>>>>
> >>>>>
> >>>>>Looks better but I think you also need ->start() to make sure you do not
> >>>>>try to deliver events too early. Does the following still work for you?
> >>>>
> >>>>Sorry for the delay. Crashes w/o the attached patch.
> >>>>
> >>>
> >>>Ah, I see, however what I actually wanted is to create ports before hand
> >>>and handle any errors that might arise and then enable the device and
> >>>register child ports.
> >>>
> >>>If you apply the patch below instead of yours does it still work?
> >>
> >>It won't work, as we don't set psm->ports[i].serio before ps2mult_serio_start()
> >>
> >
> >Indeed. I guess we need to set the pointer immediately then and also add
> >a flag to the port structure telling whether it has been registered.
> >Does the following work for you by any chance?
> 
> Yeah, works w/o any glitches. Thank you.
> 

Thanks Dmitry.

-- 
Dmitry
