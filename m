From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: Re: [PATCH] Alps dualpoint touchpads losing sync
Date: Thu, 12 Nov 2009 19:40:08 +0100
Message-ID: <1258051208.20822.26.camel@sardelle.necksus.de>
References: <1257812423.6508.22.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbZKLSkH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2009 13:40:07 -0500
In-Reply-To: <1257812423.6508.22.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Di, 2009-11-10 at 01:20 +0100, Sebastian Kapfer wrote:
> >>From d53bf419ca1b035cd6db4a29e9f96190eca676b2 Mon Sep 17 00:00:00 2001
> From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
> Date: Tue, 10 Nov 2009 00:51:42 +0100
> Subject: [PATCH] Alps dualpoint touchpads losing sync

Hi,

a few other users tried the patch in the mean time with success.  There
may still be a minor glitch to sort out, but I still think it should be
committed ASAP because currently the driver is just broken for
Dualpoints.

(See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/296610  )

-- 
Best Regards,  | Hi! I'm a .signature virus. Copy me into
 Sebastian     | your ~/.signature to help me spread!

