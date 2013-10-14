From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv2 3/3] HID:Kconfig: Correct MOMO description in wrong
 place (handled by LG4FF).
Date: Mon, 14 Oct 2013 20:48:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310142047370.12405@pobox.suse.cz>
References: <alpine.LNX.2.00.1310101002120.13289@pobox.suse.cz>    <1381414814-2107-1-git-send-email-simon@mungewell.org>    <1381414814-2107-3-git-send-email-simon@mungewell.org>    <CADbOyBQodqzSb04OCO6oduJSZvveZXxQjSdp+CdyKKk5Bs=O7w@mail.gmail.com>   
 <alpine.LNX.2.00.1310141602540.12405@pobox.suse.cz> <d241ee8c4a607eebd06cfdf5b04ab200.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d241ee8c4a607eebd06cfdf5b04ab200.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Elias Vanderstuyft <elias.vds@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@prifuk.cz>
List-Id: linux-input@vger.kernel.org

On Mon, 14 Oct 2013, simon@mungewell.org wrote:

> >> only two axes: steering and combined accel-brake axis.
> >> So, same procedure as the Formula Vibration wheel, I'll send you the
> >> report
> >> descriptor and some hidraw data when using the accel and brake pedals,
> >> in
> >> my next mail.
> >
> > So should I wait for v3, where the rdesc fixup for splitting the axes will
> > be done, or are you planning to submit it to me as a followup patch?
> 
> The HID descriptor for the MOMO Black was re-written in part2 of the patch
> series:
> https://patchwork.kernel.org/patch/3016111/

Bah, you are right, I was still by mistake looking at the original series.

I am now applying all the 3 patches from v2.

-- 
Jiri Kosina
SUSE Labs
