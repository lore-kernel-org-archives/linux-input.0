From: dudl@cypress.com
Subject: Update cyapa driver support MT type-A protocol, add cyapa_misc_dev
 interface (issue6905092)
Date: Thu, 28 Apr 2011 10:04:13 +0000
Message-ID: <90e6ba6e8adee93df104a1f7ad35@google.com>
Reply-To: dudl@cypress.com, rubini@ipvvis.unipv.it,
	  dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	  linux-kernel@vger.kernel.org, olofj@google.com,
	  micahc@google.com, dso@cypress.com,
	  chromium-os-reviews@chromium.org, vb+kernel@google.com,
	  msb@chromium.org, olofj@chromium.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f198.google.com ([209.85.210.198]:33241 "EHLO
	mail-iy0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759116Ab1D1K1c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Apr 2011 06:27:32 -0400
Received: by iye22 with SMTP id 22so5767540iye.1
        for <linux-input@vger.kernel.org>; Thu, 28 Apr 2011 03:27:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rubini@ipvvis.unipv.it, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@google.com, micahc@google.com, dudl@cypress.com, dso@cypress.com
Cc: chromium-os-reviews@chromium.org, vb+kernel@google.com, msb@chromium.org, olofj@chromium.org

Reviewers: rubini_ipvvis.unipv.it, dmitry.torokhov_gmail.com,  
linux-input_vger.kernel.org, linux-kernel_vger.kernel.org,  
olofj_dontusethisaddress, Micah C, dudl, dso_cypress.com,

Description:
Update cyapa driver support MT type-A protocol, add cyapa_misc_dev interface


Change-Id: I8c70391a581bd1f62803f25fe3a52589b56aeed7
Signed-off-by: Du, Dudley <dudl@cypress.com>

R=rubini@ipvvis.unipv.it,dmitry.torokhov@gmail.com,linux-input@vger.kernel.org,linux-kernel@vger.kernel.org,olofj@google.com,micahc@google.com,dudl@cypress.com,dso@cypress.com
BUG=3220 6902105
TEST=test on kaen board

1. Remove codes that support relative report data, this mode is not  
required for
trackpad any more;
2. Modify cyapa driver support MT type-A protocol working with multitouch X
driver;
3. Add cyapa_misc_dev interface, so applications can get driver, firmware  
and
hardware version of the trackpad device.


Please review this at http://codereview.chromium.org/6905092/

SVN Base: http://git.chromium.org/git/kernel-next.git@chromeos-2.6.38

Affected files:
   M drivers/input/mouse/cypress_i2c.c
   M include/linux/cyapa.h


