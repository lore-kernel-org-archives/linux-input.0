From: James M Leddy <james.leddy@canonical.com>
Subject: Re: [PATCH] Remap micmute to F20
Date: Wed, 29 Aug 2012 11:43:12 -0400
Message-ID: <503E3890.3050605@canonical.com>
References: <1346196739-3619-1-git-send-email-james.leddy@canonical.com> <1346197001.1928.16.camel@sirocco.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36702 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab2H2PnO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Aug 2012 11:43:14 -0400
In-Reply-To: <1346197001.1928.16.camel@sirocco.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On 08/28/2012 07:36 PM, Bastien Nocera wrote:
> Em Tue, 2012-08-28 =C3=A0s 19:32 -0400, James M Leddy escreveu:
>> Because of a limitation of the X11 protocol, we can't use micmute in
>> it's current mapping. I've chosen to map this to F20, since we do
>> similar things with the touchpad buttons for the same reason. Whatev=
er
>> we use, we will have to agree with xkeyboard-config.
>>
>> http://lists.freedesktop.org/archives/xorg-devel/2012-August/033442.=
html
>=20
> Feel free to implement this once you're done :)
> https://bugzilla.gnome.org/show_bug.cgi?id=3D651051

Already ahead of you :) Just have to make sure the patch applies cleanl=
y
upstream. Thanks for the bug number.

https://bazaar.launchpad.net/~jm-leddy/ubuntu/quantal/gnome-settings-da=
emon/micmute/view/head:/debian/patches/micmute.patch
>=20
> Cheers
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
