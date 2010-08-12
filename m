From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 0/4] Add drivers necessary to support PS/2 port on TQM85xx boards
Date: Thu, 12 Aug 2010 13:31:49 +0400
Message-ID: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62580 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0HLJcH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 05:32:07 -0400
Received: by wwj40 with SMTP id 40so1297310wwj.1
        for <linux-input@vger.kernel.org>; Thu, 12 Aug 2010 02:32:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On tqm85xx boards PS/2 keyboard and mouse are connected to the CPU via
special PIC controller multiplexing two PS/2 streams into single UART.

To support this I'm using already existing serport UART->serio ldisc,
on top of which runs protcol multiplexer serio->2 serio ports driver,
which provides serio ports for atkbd and psmouse drivers.

-- 
With best wishes
Dmitry

