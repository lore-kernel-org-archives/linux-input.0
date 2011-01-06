From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 0/2] HID: roccat: Add support for Arvo, small bugfix and a
 question
Date: Thu, 06 Jan 2011 09:00:29 +0100
Message-ID: <1294300829.5622.57.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:35891 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599Ab1AFIAc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 03:00:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-inp

This patchset adds support for the Roccat Arvo keyboard.
The driver is similar to my other roccat drivers.

I'm now finished implementing new device support and my next
step would be to abstract similarities to reduce code duplication.

Has the resulting file to be a module named like "roccat-common"
that has to be selected as depencendy in Kconfig or is there
another mechanism to hide this gratuitous decicion from the user?

Second part of this patchset fixes a non vital glitch in koneplus.


