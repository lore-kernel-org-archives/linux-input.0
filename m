From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/2] Groundwork for Sixaxis paring into bluez.
Date: Mon,  3 May 2010 22:15:54 +0200
Message-ID: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out110.alice.it ([85.37.17.110]:2399 "EHLO
	smtp-out110.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756535Ab0ECUQ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 May 2010 16:16:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org

Hi,

These changes are in preparation of seamless integration of the Sixaxis
pairing procedure into bluez. It was about time :)

The first one cleans up the quirks handling.

The second one adds a sysfs interface to set and get the device and master
bdaddr, this is needed in order to setup the host for pairing. This kernel
interface is a mere workaround for the lack of features of hidraw[1], if
someone wants to add the missing features to hidraw I will be happy to drop
this one, otherwise consider queuing these for 2.6.35 if it's too late for
2.6.34.

Thanks,
   Antonio

[1] http://www.spinics.net/lists/linux-input/msg08311.html


Antonio Ospite (2):
  hid/hid-sony: Apply sixaxis quirks only to sixaxis
  hid/hid-sony: get and set Sixaxis bdaddr via sysfs

 drivers/hid/hid-sony.c |  170 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 155 insertions(+), 15 deletions(-)

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
