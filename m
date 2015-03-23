From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - quirk for Thinkpad E440
Date: Mon, 23 Mar 2015 10:34:43 -0700
Message-ID: <20150323173443.GA11116@dtor-ws>
References: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
 <CAO7PdF-NNkxo5Ym2+Wf9Bd+d7pU7U3X0puN8QNj_cXpQfbf9qA@mail.gmail.com>
 <CAN+gG=HJgrdK+qRbRn-HetFNTxFf43Cig2aV_d567bX_kZW6_Q@mail.gmail.com>
 <CAO7PdF8VKNOAz6b2nkt5bfqfK+jpDm2LhsQX0QeRX_woGD+ZKA@mail.gmail.com>
 <CAN+gG=G1byht7trjgGpUzEtHWUnK3stmxV0hjNTx0WzSgnOk8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35390 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbbCWRes (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 13:34:48 -0400
Received: by igcau2 with SMTP id au2so49156951igc.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2015 10:34:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN+gG=G1byht7trjgGpUzEtHWUnK3stmxV0hjNTx0WzSgnOk8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Ramiro Morales <cramm0@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Mar 23, 2015 at 12:58:16PM -0400, Benjamin Tissoires wrote:
> On Sat, Mar 21, 2015 at 9:24 AM, Ramiro Morales <cramm0@gmail.com> wrote:
> > On Thu, Mar 19, 2015 at 7:15 PM, Benjamin Tissoires
> > <benjamin.tissoires@gmail.com> wrote:
> >> Then I am even more surprised that you need to quirk a late 2014
> >> haswell refresh.
> >>
> >> Can you post your dmesg when booting the synaptics branch so that we
> >> can check if the FW has the correct values stored or if we really need
> >> to quirk it?
> >
> > On Thu, Mar 19, 2015 at 7:15 PM, Benjamin Tissoires
> > <benjamin.tissoires@gmail.com> wrote:
> >> Then I am even more surprised that you need to quirk a late 2014
> >> haswell refresh.
> >
> > Actually the laptop manufacturing date is Nov '13, I bought it on May.
> >
> > This patch is almost a year late because I had a false start
> > submitting fixes through the Ubuntu BTS[1] only to discover that a
> > clashing quirk for the E540 got added upstream about the same time.
> > The ability to include the board ID in the quirk table logic added by
> > this branch provides a way out.
> >
> >> Can you post your dmesg when booting the synaptics branch so that we
> >> can check if the FW has the correct values stored or if we really need
> >> to quirk it?
> >
> > Here it is:
> >
> > https://dl.dropboxusercontent.com/u/5403630/dmesg_thinkpad_e440_synaptics_8f004f3f.txt
> 
> Thanks for all these information. So indeed, your patch is entirely
> valid and is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> Cheers,
> Benjamin
> 
> >
> > Regards,
> >
> >
> > [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1395243
> > [2] https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?id=bce4f9e764c36bc35dd5c9cf9e057c09f422397d
> >
> > --
> > Ramiro Morales
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
