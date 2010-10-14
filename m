From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Thu, 14 Oct 2010 13:43:32 +0400
Message-ID: <AANLkTimPA90Z3foSaC9gA4WRp_moWeLiq1b1pzftzvHZ@mail.gmail.com>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
	<AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
	<20100930062547.GF5260@core.coreip.homeip.net>
	<AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
	<20101007163606.GA24406@core.coreip.homeip.net>
	<AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57340 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab0JNJne (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 05:43:34 -0400
Received: by wwj40 with SMTP id 40so7666823wwj.1
        for <linux-input@vger.kernel.org>; Thu, 14 Oct 2010 02:43:33 -0700 (PDT)
In-Reply-To: <AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 8, 2010 at 12:50 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Thu, Oct 7, 2010 at 8:36 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Oct 07, 2010 at 07:19:57PM +0400, Dmitry Eremin-Solenikov wrote:
>>> Hello,
>>>
>>> On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov wrote:
>>> >> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
>>> >> <dbaryshkov@gmail.com> wrote:
>>> >> > PS2Mult is a simple serial protocol used for multiplexing several PS/2 streams
>>> >> > into one serial data stream. It's used e.g. on TQM85xx serie of boards.
>>> >> >
>>> >> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>> >> > ---
>>> >> >
>>> >> > It actually depends on "serio: multiple children" patch. I'm not resending it
>>> >> > as you were the originator of the latest version of the patch.
>>> >>
>>> >> So, what about this version of patch?
>>> >>
>>> >
>>> > Looks better but I think you also need ->start() to make sure you do not
>>> > try to deliver events too early. Does the following still work for you?
>>>
>>> Sorry for the delay. Crashes w/o the attached patch.
>>>
>>
>> Ah, I see, however what I actually wanted is to create ports before hand
>> and handle any errors that might arise and then enable the device and
>> register child ports.
>>
>> If you apply the patch below instead of yours does it still work?
>
> It won't work, as we don't set psm->ports[i].serio before ps2mult_serio_start()

ping?

-- 
With best wishes
Dmitry
