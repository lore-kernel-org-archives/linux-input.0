From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] keyboard notifier documentation
Date: Sat, 09 Feb 2008 07:38:59 -0800
Message-ID: <47ADC913.5010202@oracle.com>
References: <20080209013322.GC4463@implementation> <20080208201253.46c068ed.randy.dunlap@oracle.com> <20080209114031.GC4379@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:12207 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYBIPn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Feb 2008 10:43:28 -0500
In-Reply-To: <20080209114031.GC4379@implementation>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Randy Dunlap <randy.dunlap@oracle.com>, torvalds@osdl.org, linux-input@vger.kernel.org, dtor@mail.ru, linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Randy Dunlap, le Fri 08 Feb 2008 20:12:53 -0800, a =E9crit :
>> On Sat, 9 Feb 2008 01:33:22 +0000 Samuel Thibault wrote:
>>> +- 'vc' always provide the VC for which the keyboard event applies =
;
>>> +- 'down' is 1 for a key press event, 0 for a key release ;
>>> +- 'shift' is the current modifier state, mask bit indexes are KG_*=
 ;
>> No space before the ';' (3 times).
>=20
> Well, as expected in French...  I'll fix that.
>=20
>>> +For each kind of event but the last, the callback may return NOTIF=
Y_STOP in
>>> +order to "eat" the event: the notify loop is stopped and the keybo=
ard event is
>>> +dropped.
>>> +
>>> +I a rough C snippet, we have:
>>    In a rough (?)
>=20
> Yes, rough as "something that a C compiler will never accept, but tha=
t
> you, human, will make sense out of it".

so s/I/In/ please.

--=20
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
