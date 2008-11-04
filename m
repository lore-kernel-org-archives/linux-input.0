From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 1/5] Fixup reset for systems using reboot=cold or other strings
Date: Tue,  4 Nov 2008 08:55:09 +0800
Message-ID: <12257601213192-git-send-email-jayakumar.lkml@gmail.com>
References: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbYKDAz1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 19:55:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2922566rvb.1
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2008 16:55:26 -0800 (PST)
In-Reply-To: <12257601131298-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Jaya Kumar <jayakumar.lkml@gmail.com>

This patch makes do_hw_reset the default reboot behavior when nothing
else matches. This restores reboot functionality on gumstix basix
devices where reboot=cold is the default boot argument.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Acked-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/reset.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/reset.c b/arch/arm/mach-pxa/reset.c
index 1b2af57..00b2dc2 100644
--- a/arch/arm/mach-pxa/reset.c
+++ b/arch/arm/mach-pxa/reset.c
@@ -90,12 +90,13 @@ void arch_reset(char mode)
 		/* Jump into ROM at address 0 */
 		cpu_reset(0);
 		break;
-	case 'h':
-		do_hw_reset();
-		break;
 	case 'g':
 		do_gpio_reset();
 		break;
+	case 'h':
+	default:
+		do_hw_reset();
+		break;
 	}
 }
 
-- 
1.5.2.3

