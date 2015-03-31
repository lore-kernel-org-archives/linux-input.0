From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/3] tty: eliminate 64 byte stack buffers passed to tty_name
Date: Tue, 31 Mar 2015 15:55:56 +0200
Message-ID: <1427810160-15779-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35741 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbbCaN40 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 09:56:26 -0400
Received: by lbdc10 with SMTP id c10so12932842lbd.2
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2015 06:56:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org

All users of tty_name pass the return value directly to a printf
function, so we might as well use tty->name directly instead of
copying it to a user-supplied (stack) buffer.

allmodconfig compile-tested only.

Rasmus Villemoes (3):
  tty: constify return type of tty_name
  tty: return tty->name directly from tty_name
  tty: remove buf parameter from tty_name()

 drivers/input/serio/serport.c    |  5 ++---
 drivers/tty/amiserial.c          |  8 ++------
 drivers/tty/cyclades.c           |  8 ++------
 drivers/tty/n_gsm.c              |  3 +--
 drivers/tty/n_tty.c              |  7 ++-----
 drivers/tty/serial/crisv10.c     |  8 ++------
 drivers/tty/serial/serial_core.c |  4 +---
 drivers/tty/tty_io.c             | 34 +++++++++++++---------------------
 drivers/tty/tty_ioctl.c          |  4 +---
 drivers/tty/tty_ldisc.c          |  8 +++-----
 include/linux/tty.h              |  2 +-
 11 files changed, 30 insertions(+), 61 deletions(-)

-- 
2.1.3

