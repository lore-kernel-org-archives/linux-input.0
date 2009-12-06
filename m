From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [RFC] HID and multitouch
Date: Sun, 6 Dec 2009 12:47:55 +0100
Message-ID: <45cc95260912060347u2e4c526bpd54b49c6f1a65ec9@mail.gmail.com>
References: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34811 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933715AbZLFLsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 06:48:10 -0500
Received: by bwz27 with SMTP id 27so2891346bwz.21
        for <linux-input@vger.kernel.org>; Sun, 06 Dec 2009 03:48:15 -0800 (PST)
In-Reply-To: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, Peter Hutterer <peter.hutterer@who-t.net>

Hi,

=46or the first issue, it seems that the mapping should be put outside
the kernel itself.
Or in a more precise and possible solution, to create a small
component which will do the mapping.

=46or simple devices it can be done in textual mapping files, but for
others like multi-touch screens, a module doing dynamic mapping can be
a solution.

Rewriting the component to push it from static one2one mapping to
dynamic one may be a transparent solution for other components in next
layers.

Cheers,

Mohamed-Ikbel



On Sun, Dec 6, 2009 at 11:58 AM, St=E9phane Chatty <chatty@enac.fr> wro=
te:
> Dear Jiri,
>
> over the last few months I have been working on HID quirks for a bunc=
h of
> multitouch devices: NTrig, two flavours of Stantum devices, 3M, Acer =
T230H.
> For each of these I have working code, which I should be able to subm=
it real
> soon now.
>
> However, people are asking me questions about why a specific driver i=
s
> needed for each device. Answers are starting to emerge, and it looks =
like
> they might lead to some work on the Linux HID code itself:
>
> - the one-to-one mapping between HID and evdev is stretched to its li=
mits
> with these devices that have several times the same group of HID fiel=
ds in
> the same event: an event is made of fingers, each finger is made of a=
n X, a
> Y and a few other fields. We need a mechanism to emit SYN_MT_REPORT b=
etween
> fingers.
>
> - furthermore, some fingers have to be discarded because they are
> placeholders with no valid data, and we know if to dump them only whe=
n they
> have been fully parsed. Therefore, we need a mechanism to cache finge=
r data
> until the decision is made. Currently, the caching mechanism has to b=
e
> device-dependent because the fields are not exactly the same and they=
 come
> in a device-dependent order.
>
> - for all these devices, it is very tempting to have a touchscreen em=
ulation
> so as to use them with existing software (X.org, particularly). Rafi =
and I
> share the idea that this should be done by creating two evdev nodes: =
a
> backward-compatible touchscreen, and a multitouch one. Most of the
> corresponding code could be shared among drivers. However, the algori=
thm for
> producing the touchscreen events differs from one device to another a=
nd we
> need to support this.
>
>
> Any opinions or suggestions?
>
> Cheers
>
> St=E9phane
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
