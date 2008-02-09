From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] keyboard notifier documentation
Date: Sat, 9 Feb 2008 15:43:41 +0000
Message-ID: <20080209154341.GK4379@implementation>
References: <20080209013322.GC4463@implementation> <20080208201253.46c068ed.randy.dunlap@oracle.com> <20080209114031.GC4379@implementation> <47ADC913.5010202@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:53641 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004AbYBIPoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Feb 2008 10:44:24 -0500
Content-Disposition: inline
In-Reply-To: <47ADC913.5010202@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: torvalds@osdl.org, linux-input@vger.kernel.org, dtor@mail.ru, linux-kernel@vger.kernel.org

Randy Dunlap, le Sat 09 Feb 2008 07:38:59 -0800, a =E9crit :
> Samuel Thibault wrote:
> >Randy Dunlap, le Fri 08 Feb 2008 20:12:53 -0800, a =E9crit :
> >>On Sat, 9 Feb 2008 01:33:22 +0000 Samuel Thibault wrote:
> >>>+- 'vc' always provide the VC for which the keyboard event applies=
 ;
> >>>+- 'down' is 1 for a key press event, 0 for a key release ;
> >>>+- 'shift' is the current modifier state, mask bit indexes are KG_=
* ;
> >>No space before the ';' (3 times).
> >
> >Well, as expected in French...  I'll fix that.
> >
> >>>+For each kind of event but the last, the callback may return=20
> >>>NOTIFY_STOP in
> >>>+order to "eat" the event: the notify loop is stopped and the keyb=
oard=20
> >>>event is
> >>>+dropped.
> >>>+
> >>>+I a rough C snippet, we have:
> >>   In a rough (?)
> >
> >Yes, rough as "something that a C compiler will never accept, but th=
at
> >you, human, will make sense out of it".
>=20
> so s/I/In/ please.

Ah oops, sorry misunderstood what you raised, I actually had fixed it i=
n
the second version.

Thanks,
Samuel
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
