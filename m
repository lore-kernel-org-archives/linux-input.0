From: Justin Clift <jclift@redhat.com>
Subject: Re: [PATCH v2 0/2] Improve the performance of alps v5-protocol's touchpad
Date: Wed, 16 Oct 2013 10:37:36 +0100
Message-ID: <78C6748E-8767-4F39-9AB4-0839D74370E4@redhat.com>
References: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27156 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760494Ab3JPJhp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 05:37:45 -0400
In-Reply-To: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: dmitry.torokhov@gmail.com, yunkang.tang@cn.alps.com, linux-input@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Niels de Vos <ndevos@redhat.com>

On 13/09/2013, at 5:03 AM, Yunkang Tang wrote:
> Hi all,
>=20
> Here is the v2 of improving ALPS v5 protocol device.
>=20
> Change since v1:
> - fix the issue that previous patches were broken by mail system.
> - split the modification to 2 patches.
> - Change dev2's name to "ALPS PS/2 Device"

Thanks Tommy.  We've been trying to get recent ALPS touchpads
working through Red Hat Bugzilla issue 953211.

  https://bugzilla.redhat.com/show_bug.cgi?id=3D953211

Niels de Vos, CC'd, was kind enough to build a Fedora 19 kernel
with your patch added.  We've been testing it since yesterday.

Your patch works well for several models of laptop (confirmed
success):

 * Dell Inspiron 17R SE / Inspiron 7720
 * Dell Vostro 3360
 * Fujitsu Lifebook AH532

With your patches, the touchpad:

* is recognised as a touchpad
* both KDE and Gnome can control it
* 2 finger scrolling works

That being said, we have conflicting reports about 1 finger
vertical scrolling on the Inspiron 17R SE / Inspiron 7720.

* 1 finger scrolling works on my laptop (Inspiron 17R SE),
  if 2 finger scrolling is NOT enabled in Gnome3 mouse &
  touchpad settings. (seems mutually exclusive)
* 1 finger scrolling does NOT work in KDE (Inspiron 7720)
  * I'm following this up with the reporter, as it may
    turn out to be a KDE settings issue

=46rom my point of view, I'm be happy to see these patches
be applied, and you're welcome to use:

  Tested-by: Justin Clift <jclift@redhat.com>

Side note - Thanks to the people who've tested this and
reported back. :)

* Stanislav Datskevich
* =C3=96zg=C3=BCr G=C3=BCndo=C4=9Fan
* Pentarh Udi
* Arnaud Lacombe
* Gaspard Jankowiak
* myself ;>

Regards and best wishes,

Justin Clift


> Best Regards,
> Tommy

--
Open Source and Standards @ Red Hat

twitter.com/realjustinclift

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
