From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Mon, 22 Jan 2018 10:41:37 -0800
Message-ID: <20180122184137.ea3opwnburtrkhmo@dtor-ws>
References: <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
 <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
 <20180105162313.higyrbd6unumgtjb@dtor-ws>
 <20180107065201.q2xck62unijt3avr@dtor-ws>
 <20180114203958.GA3686@beacon.debie>
 <20180116234919.c7xgfllsf62g4fw4@dtor-ws>
 <20180121203700.GC23310@beacon.debie>
 <02711055-0359-46D3-B9DD-9182918A1632@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40934 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeAVSlk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 13:41:40 -0500
Received: by mail-pg0-f54.google.com with SMTP id g16so7746649pgn.7
        for <linux-input@vger.kernel.org>; Mon, 22 Jan 2018 10:41:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <02711055-0359-46D3-B9DD-9182918A1632@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Aaron Ma <aaron.ma@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

On Sun, Jan 21, 2018 at 01:08:17PM -0800, Dmitry Torokhov wrote:
> On January 21, 2018 12:37:01 PM PST, ulrik.debie-os@e2big.org wrote:
> >On Tue, Jan 16, 2018 at 03:49:19PM -0800, Dmitry Torokhov wrote:
> >> 
> >> Hi Ulrik,
> >> 
> >> 
> >> On Sun, Jan 14, 2018 at 09:39:59PM +0100, ulrik.debie-os@e2big.org
> >wrote:
> >> > Hi Dmitry, Sebastian,
> >> > Nack for the patch..
> >> 
> >> NAK because of the issue pointed by Sebastian, or bigger
> >disagreement?
> >I originally had 2 reasons:
> >1) issue pointed out by Sebastian, of course easy to fix
> >2) The remark I had below which was because I did not understand yet
> >the reason
> >why you made this patch in the first place. I now understand it is not
> >the 
> >purpose to change anything for the Lenovo e470/e570 and it will also
> >not change
> >anything for those if you at least fix nr 1) 
> 
> I see. Yes, I did fix the problem mentioned by sensation of course, I did not bother posting updated patch because the change is trivial.

Gah, that should have read "Sebastian", not "sensation". Damn phones and
their swipe/autocorrect keyboards.

-- 
Dmitry
