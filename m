From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Regression since commit 92bac83
Date: Sun, 18 Oct 2015 18:59:55 -0500
Message-ID: <5624327B.7080906@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36283 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbbJRX74 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2015 19:59:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi,

I recently upgraded the kernel in a Dell Latitude D600 and found that the 
touchpad clicks failed. The problem was bisected to commit 
92bac83dd79e60e65c475222e41a992a70434beb ("Input: alps - non interleaved V2 
dualpoint has separate stick button bits"). The laptop has a combination 
touchpad and control stick. For this device, the following values are found:

priv->protoversion is 0x200 (ALPS_PROTO_V2)
priv->flags is 0x6 (ALPS_DUALPOINT | ALPS_PASS)

As a result, the new code added in this patch is executed, and left, right, and 
middle are updated. Once this code is introduced, a left click causes some event 
as it will wake a sleeping screen, but not select any windows or do anything useful.

Please advise on what information would be needed to help debug this problem.

Thanks,

Larry
