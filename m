From: Philippe Langlais <philippe.langlais@stericsson.com>
Subject: Changes in keyboard GPIO driver
Date: Wed, 12 Jan 2011 10:41:31 +0100
Message-ID: <1294825292-24134-1-git-send-email-philippe.langlais@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:59183 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab1ALKEI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 05:04:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

This patch is needed to add support for SFH7741 proximity sensor on ux500 platform.
Between ux500 SoC and SFH7741 sensor, we use a GPIO expander (MFD TC35892) which relays the GPIO IRQs.

