From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: hid-rmi: configuration automatically changed after suspend/resume
Date: Mon, 06 Jul 2015 12:20:51 +0200
Message-ID: <1463383.73UKVcFjqX@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36683 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbGFKU4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 06:20:56 -0400
Received: by widjy10 with SMTP id jy10so156471307wid.1
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2015 03:20:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, aduggan@synaptics.com, benjamin.tissoires@redhat.com, jkosina@suse.cz

Hi,

I recently noticed that there's a minor issue with hid-rmi.c. After a
suspend/resume cycle the f11 control register is set to the default
configuration, thus undoing the changes performed on init.

I made some changes to the driver to prevent this from happening: the
configuration is saved on suspend and restored upon resume. This seemed
the simplest thing to do, but I encountered a small problem.

I'm saving and writing the whole register since the kernel can't know
what userspace tools might have done. According to a comment in the
sources, some firmwares split the control register, so blindly copying
and writing 20 sequential bytes as I'm doing could be a problem.

Is there a way to recognize those firmwares? Or even better, is there a
way to prevent the firmware from restoring the default configuration?

PS: I didn't check if the same happens with other registers, but I
suspenct it does.

Thanks,
Gabriele
