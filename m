From: Dima Zavin <dima@android.com>
Subject: Re: [PATCH 3/4] Fix hover in Android (Gingerbread)
Date: Fri, 8 Jul 2011 23:22:02 -0700
Message-ID: <CAPz4a6AfZBsaH=Q4MHT2q=UE7RJhngrvDfPtKBTbenC9co3rZQ@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
	<1310072700-2829-3-git-send-email-killertofu@gmail.com>
	<CAMu+ixhnAXoSEvjt+aC=imnXx-b8uM8TYWWWoV2U99WMJJU-kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:59534 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab1GIGWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jul 2011 02:22:06 -0400
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com [172.25.105.84])
	by smtp-out.google.com with ESMTP id p696M4MH000389
	for <linux-input@vger.kernel.org>; Fri, 8 Jul 2011 23:22:04 -0700
Received: from ywa6 (ywa6.prod.google.com [10.192.1.6])
	by kpbe20.cbf.corp.google.com with ESMTP id p696M3S3011660
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 8 Jul 2011 23:22:03 -0700
Received: by ywa6 with SMTP id 6so1216572ywa.37
        for <linux-input@vger.kernel.org>; Fri, 08 Jul 2011 23:22:03 -0700 (PDT)
In-Reply-To: <CAMu+ixhnAXoSEvjt+aC=imnXx-b8uM8TYWWWoV2U99WMJJU-kQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>

Jason spoke with me. I pushed back because I did not want to carry any
patches for this in our kernel tree and asked Jason to send them
upstream. I, unfortunately, did not take a close look to see what the
patches were doing. As mentioned, these android-specific changes
shouldn't be accepted.

--Dima

On Fri, Jul 8, 2011 at 11:15 PM, Jeffrey Brown <jeffbrown@android.com> =
wrote:
> On Thu, Jul 7, 2011 at 2:04 PM, Jason Gerecke <killertofu@gmail.com> =
wrote:
>> As of Gingerbread, Android does not pay attention to if the pen
>> is in contact with the screen, or merely in proximity. Since the
>> Xorg Wacom driver does not make use of MT pen events, we simply
>> do not emit MT data while hovering.
>
> I'd rather not change the behavior of the upstream driver because tha=
t
> would break other things. =A0It would be better to just fix the Andro=
id
> framework code for the device you are shipping.
>
> What is it about Gingerbread that causes problems with hover? =A0Is i=
t
> the fact it isn't checking BTN_TOUCH or the fact that it doesn't care
> when ABS_MT_PRESSURE =3D=3D 0? =A0(Is BTN_TOUCH still relevant to the=
 MT
> protocol or only in single-touch?)
>
> I have already added hover support to Android. =A0It will appear in a=
n
> upcoming release, along with support for the MT slots protocol "B".
>
> Sending a non-zero ABS_MT_DISTANCE is also a good robust hint for
> hover. =A0Zero pressure can be ambiguous sometimes.
>
> Who did you talk to at Google about this?
>
> Jeff.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
