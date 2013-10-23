From: Justin Clift <jclift@redhat.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Wed, 23 Oct 2013 12:29:54 +0100
Message-ID: <20131023122954.2d63b0e85fd963dabde574f4@redhat.com>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3JWOCa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 10:02:30 -0400
In-Reply-To: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: dmitry.torokhov@gmail.com, cernekee@gmail.com, dturvene@dahetral.com, linux-input@vger.kernel.org, ndevos@redhat.com, yunkang.tang@cn.alps.com

On Mon, 21 Oct 2013 19:41:50 +0800
Yunkang Tang <tommywill2011@gmail.com> wrote:
> Hi all,
>=20
> Here is the 4th version of supporting ALPS v5 protocol's device.

Niels de Vos, CC'd, was kind enough to build a Fedora 19 kernel
with this v4 patch added.  We've been testing it since yesterday.

This patch has been successfully tested on:

 * Dell Inspiron 17R SE / Inspiron 7720
 * Dell Vostro 3360
 * Fujitsu Lifebook AH532

With the v4 patch, the touchpad:

* is recognised as a touchpad
* both KDE and Gnome can control it
* Both hardware buttons (left/right) work
* Both 1 & 2 finger scrolling works

So, it seems good here. :)

=46rom my point of view, I would be happy to see this
patch applied, and you're welcome to use:

  Tested-by: Justin Clift <jclift@redhat.com>

Side note - Many thanks to the Fedora Community members
who tested this v4 patch on their hardware and reported
back. :)

* =C3=96zg=C3=BCr G=C3=BCndo=C4=9Fan
* Stanislav Datskevich
* Thane
* Alexander Volovics

Regards and best wishes,

Justin Clift

--=20
Justin Clift <jclift@redhat.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
