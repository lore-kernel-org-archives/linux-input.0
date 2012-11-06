From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Subject: Why Cypress does not upstream its trackpad driver?
Date: Tue, 6 Nov 2012 17:47:12 -0500
Message-ID: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58058 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab2KFWrN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Nov 2012 17:47:13 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: kamal@canonical.com, dmitry.torokhov@gmail.com, customercare@cypress.com, mario_limonciello@dell.com

Hi,

This driver [0] was written with a cooperation of Cypress, Dell and
Canonical Engineers within the last 3-4 months. It is very nice that
Cypress as a vendor cooperated with Canonical (Because Canonical works
with Dell for their Project Sputnik and Dell XPS13 is used as the main
hardware for that project and Dell XPS13 has this type of trackpad,
Bingo!), and I am also glad that Ubuntu users benefits from this
driver.

The driver brings multi-touch scrolling, disable-while-tapping and
makes Fn+Fx touchpad disable/enable work for not only Dell XPS13 but
for all laptops having this trackpad (My Lenovo Ultrabook U300s for
example, I tested the patches on fedora 17's 3.6 kernel and it works
quiet nice)

But what I am not getting that why NOBODY from Cypress/Canonical/Dell
isn't bothering to push this driver to upstream?
Is it too hard? I don't think so as the patches are quite non-invasive
and small.

Is the only distribution around is Ubuntu?
Is the only laptop sold in the world is Dell XPS13 with an Ubuntu?

I'm not trying to be impolite but it hurts me to see that a vendor
produces an open-source driver for its device but makes use of it only
through a specific distribution.

If Cypress is just beginning developing open-source drivers for their
devices, I hope that after this mail they will be much sensitive about
the issue and push their drivers even before the release of their
devices to make user experience flawless.

(I googled and searched the archives of LKML and linux-input but
couldn't find a discussion or patch series about the driver. If I
missed it, ignore the whole stuff above)

[0]: http://patchwork.ozlabs.org/patch/178903/

--=20
Ozan =C3=87a=C4=9Flayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
