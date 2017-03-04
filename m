From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 0/3] Input: alps - cleanup
Date: Sat,  4 Mar 2017 12:24:23 +0100
Message-ID: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
References: <1465212241-14702-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36000 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdCDLde (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 06:33:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

This patch series cleanup usage of alps_model_data table.

Changes since v1: Patches for ALPS_PROTO_V6 and ALPS_PROTO_V1 were
dropped and support for those touchpad are still in alps_model_data.

Pali Rohár (3):
  Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
  Input: alps - warn about unsupported ALPS V9 touchpad
  Input: alps - cleanup alps_model_data

 drivers/input/mouse/alps.c |   75 +++++++++++++++++++++++++-------------------
 drivers/input/mouse/alps.h |    6 +---
 2 files changed, 43 insertions(+), 38 deletions(-)

-- 
1.7.9.5

