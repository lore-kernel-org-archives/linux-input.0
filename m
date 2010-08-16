From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 0/2 v2] Add drivers necessary to support PS/2 port on TQM85xx boards
Date: Mon, 16 Aug 2010 15:26:35 +0400
Message-ID: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37155 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab0HPL0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 07:26:51 -0400
Received: by wyb32 with SMTP id 32so5578465wyb.19
        for <linux-input@vger.kernel.org>; Mon, 16 Aug 2010 04:26:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On tqm85xx boards (and several others) keyboard and mice are connected to CPU via
special controller multiplexing KBD and MS traffic into single UART.

Changes since v1:

* Rewrote serio to use iterative algorithms instead of recursion for serio
  tree traversal

* Changed ps2mult to register as SERIO_8042, not it's own special type

* Small cleanup in ps2mult

-- 
With best wishes
Dmitry

