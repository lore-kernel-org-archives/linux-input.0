From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/3] SysRq: do not pass tty argument around
Date: Wed, 04 Aug 2010 00:58:55 -0700
Message-ID: <20100804075602.30647.91462.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60589 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab0HDH67 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Aug 2010 03:58:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jason Wessel <jason.wessel@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

Hi,

The following 3 patches get rid of 'tty' argument in SysRq handlers as
nobody is using it. If noone objects I'd like to get it merged through
my tree.

Thanks!

--
Dmitry

