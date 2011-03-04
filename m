From: dudl@cypress.com
Subject: Add new i2c-based input mouse driver into input subsystem for Cypress
 trackpad devices. (issue6626009)
Date: Fri, 04 Mar 2011 07:49:18 +0000
Message-ID: <bcaec52c66a51e1eda049da36252@google.com>
Reply-To: dudl@cypress.com, rubini@ipvvis.unipv.it,
	  dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	  linux-kernel@vger.kernel.org, olofj@google.com,
	  micahc@google.com, chromium-os-reviews@chromium.org,
	  vb+kernel@google.com, msb@chromium.org, olofj@chromium.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f206.google.com ([209.85.161.206]:40129 "EHLO
	mail-gx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759274Ab1CDKZO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Mar 2011 05:25:14 -0500
Received: by gxk28 with SMTP id 28so43426gxk.1
        for <linux-input@vger.kernel.org>; Fri, 04 Mar 2011 02:25:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rubini@ipvvis.unipv.it, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@google.com, micahc@google.com, dudl@cypress.com
Cc: chromium-os-reviews@chromium.org, vb+kernel@google.com, msb@chromium.org, olofj@chromium.org

Reviewers: rubini_ipvvis.unipv.it, dmitry.torokhov_gmail.com,  
linux-input_vger.kernel.org, linux-kernel_vger.kernel.org, olofj_g, Micah  
C, dudl,

Description:
Add new i2c-based input mouse driver into input subsystem for Cypress  
trackpad
devices.

Through this new added driver,
Cypress i2c-based trackpad devices will be supported in Linux based system
which are developed based on Cypress self-designed PSOC chipset.
This driver reads trackpad data using i2c interfaces and report cursor
moving data and gesture combined keys to input subsystem.


Change-Id: I108ad1505f3d34ab24658921a772e937940a1b88
Signed-off-by: Du, Dudley <dudl@cypress.com>

BUG=None
TEST=Work fine on ARM tegra2 saeboard and kaen platfrom

Please review this at http://codereview.chromium.org/6626009/

SVN Base: http://git.chromium.org/git/kernel-next.git@chromeos-2.6.37

Affected files:
   M drivers/input/mouse/Kconfig
   M drivers/input/mouse/Makefile
   A drivers/input/mouse/cypress_i2c.c
   A include/linux/cyapa.h


