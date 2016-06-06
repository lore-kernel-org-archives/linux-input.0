From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 0/5] Input: alps - cleanup
Date: Mon,  6 Jun 2016 13:23:56 +0200
Message-ID: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38612 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcFFLYW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2016 07:24:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch series cleanup usage of alps_model_data table.

Pali Roh=C3=A1r (5):
  Input: alps - move ALPS_PROTO_V6 out of alps_model_data table
  Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
  Input: alps - move ALPS_PROTO_V1 out of alps_model_data table
  Input: alps - warn about unsupported ALPS V9 touchpad
  Input: alps - cleanup ALPS_PROTO_V2 detection

 drivers/input/mouse/alps.c |   99 ++++++++++++++++++++++++++----------=
--------
 drivers/input/mouse/alps.h |   10 ++---
 2 files changed, 62 insertions(+), 47 deletions(-)

--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
