From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] ideapad: let Fn+F5 also trigger KEY_BLUETOOTH
Date: Tue, 14 Jun 2011 15:52:03 -0600
Message-ID: <4DF864A3020000230002E40D@novprvlin0050.provo.novell.com>
References: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
 <1308043321.26522.4.camel@air.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from novprvlin0050.provo.novell.com ([137.65.248.33]:54692 "EHLO
	novprvlin0050.provo.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101Ab1FNVwN (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:6:1>);
	Tue, 14 Jun 2011 17:52:13 -0400
In-Reply-To: <1308043321.26522.4.camel@air.hadess.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ike.pan@canonical.com
Cc: dmitry.torokhov@gmail.com, hadess@hadess.net, Gary Lin <GLin@novell.com>, mjg@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Ike,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2011-06-14 =E6=96=BC 10:21 +0100=EF=BC=8CBa=
stien Nocera =E6=8F=90=E5=88=B0=EF=BC=9A
> On Tue, 2011-06-14 at 16:28 +0800, Ike Panhc wrote:
> > The design for ideapad Fn-F5 key is not only for wifi but for all
> > radio device including wifi, bluetooth and wwan. Idealy it shall
> > acts like this:
> >=20
> >     wifi on          wifi off         wifi on         wifi off
> >      bt on   ----->   bt on   ----->   bt off  ----->  bt off
> >=20
> > This patch will switch wifi mode every key-push and switch
> > bluetooth mode every two key-push.
>=20
> If that's what you want to achieve, then the key should be KEY_RFKILL=
=2E
> That's what the key is there for.
>=20

I also agree push the wifi key logic to userland application has more
flexibility.

Highly suggest you can use urfkill daemon:
http://www.google.com.tw/search?sourceid=3Dchrome&ie=3DUTF-8&q=3Durfkil=
l

It support KEY_WIRELESS, KEY_BLUETOOTH and KEY_RFKILL, and you can setu=
p
the wifi key rule on urfkill daemon.=20
Please feel free send patch to Gary Lin <GLin@novell.com>, he can merge
your key rule for ideapad.


Thank's
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
