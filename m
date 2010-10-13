From: chatty@lii-enac.fr (Stephane Chatty)
Subject: [PATCH 0/4] hid-multitouch: a first step towards multitouch
 unification
Date: Thu, 14 Oct 2010 00:28:11 +0200
Message-ID: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:38108 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0JMWfd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:35:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rydberg@euromail.se, dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org
Cc: chatty@enac.fr


Hi Jiri, Dmitry, Henrik,

this set of patches is aimed at unifying support for HID multitouch pan=
els,
in a driver named hid-multitouch.

So far, this driver works only for panels that share common features in=
 their
implementation of the Win7-compatible multitouch HID protocol. This cur=
rently
includes Cando, Quanta, MosArt, Cypress, GeneralTouch and Pixcir, and e=
xcludes
Stantum and N-trig. 3M is left aside for now because it contains some s=
pecific
code. eGalax is also left as a special case because of the duality betw=
een
their resistive and capacitive panels.

St=E9phane Chatty (4):
  hid-multitouch: support for PixCir-based panels in a generic code str=
ucture
  hid-multitouch: migrated support for Cando panels
  hid-multitouch: added support for Cypress TrueTouch panels
  hid-multitouch: migrated support for MosArt panels
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
