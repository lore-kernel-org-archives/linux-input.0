From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware ID"
Date: Sun, 21 Jan 2018 13:08:17 -0800
Message-ID: <02711055-0359-46D3-B9DD-9182918A1632@gmail.com>
References: <20171231082646.GC25965@kroah.com> <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com> <20180102070811.p7gfaq3vr55sdbd3@dtor-ws> <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com> <20180105005659.j2x56opkq74wm7v2@dtor-ws> <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com> <20180105162313.higyrbd6unumgtjb@dtor-ws> <20180107065201.q2xck62unijt3avr@dtor-ws> <20180114203958.GA3686@beacon.debie> <20180116234919.c7xgfllsf62g4fw4@dtor-ws> <20180121203700.GC23310@beacon.debie>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:46537 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeAUVIX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 16:08:23 -0500
Received: by mail-pf0-f172.google.com with SMTP id y5so5514484pff.13
        for <linux-input@vger.kernel.org>; Sun, 21 Jan 2018 13:08:22 -0800 (PST)
In-Reply-To: <20180121203700.GC23310@beacon.debie>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Aaron Ma <aaron.ma@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

On January 21, 2018 12:37:01 PM PST, ulrik=2Edebie-os@e2big=2Eorg wrote:
>On Tue, Jan 16, 2018 at 03:49:19PM -0800, Dmitry Torokhov wrote:
>>=20
>> Hi Ulrik,
>>=20
>>=20
>> On Sun, Jan 14, 2018 at 09:39:59PM +0100, ulrik=2Edebie-os@e2big=2Eorg
>wrote:
>> > Hi Dmitry, Sebastian,
>> > Nack for the patch=2E=2E
>>=20
>> NAK because of the issue pointed by Sebastian, or bigger
>disagreement?
>I originally had 2 reasons:
>1) issue pointed out by Sebastian, of course easy to fix
>2) The remark I had below which was because I did not understand yet
>the reason
>why you made this patch in the first place=2E I now understand it is not
>the=20
>purpose to change anything for the Lenovo e470/e570 and it will also
>not change
>anything for those if you at least fix nr 1)=20

I see=2E Yes, I did fix the problem mentioned by sensation of course, I di=
d not bother posting updated patch because the change is trivial=2E


Thanks=2E

--=20
Dmitry
