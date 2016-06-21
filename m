From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH v3] Support for Alps SS5 touchpad
Date: Tue, 21 Jun 2016 11:19:28 +0200
Message-ID: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56520 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbcFUJUa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:20:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>



Hello all,

Here is the third iteration of my patchset adding support for the Alps SS5
touchpad used in the Dell Latitude E7470. The patch is largely unchanged except
for a reorganization of the DUALPOINT flag detection logic and the addition of
protocol documentation.

Thanks to everyone who has offered reviews so far.

Cheers,

- Ben



Changes:

v1:
 * Initial revision

v2:
 * Rework device detection
 * Fix contact release behavior of 1F events
 * Expose pressure of touchstick

v3:
 * Add protocol documentation
 * Move dualpoint detection into alps_set_protocol

