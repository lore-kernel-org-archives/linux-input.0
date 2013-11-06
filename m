From: Gaspard Jankowiak <gaspard@oknaj.eu>
Subject: Re: [PATCH] Input: Adding support for touchpad on Dell XT2 model
Date: Wed, 06 Nov 2013 16:24:28 +0100
Message-ID: <527A5F2C.2000008@oknaj.eu>
References: <1382715581-2584-1-git-send-email-yunkang.tang@cn.alps.com> <20131031075613.GA2590@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.oknaj.eu ([82.226.221.229]:39023 "EHLO styx.oknaj.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab3KFQUu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Nov 2013 11:20:50 -0500
In-Reply-To: <20131031075613.GA2590@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <tommywill2011@gmail.com>
Cc: cernekee@gmail.com, dturvene@dahetral.com, linux-input@vger.kernel.org, ndevos@redhat.com, jclift@redhat.com, yunkang.tang@cn.alps.com

On 31/10/13 08:56, Dmitry Torokhov wrote:

>
> Applied, thank you.
>

Hi,

I don't know how to go about this, but it seems the patch is affecting 
other input devices. The trackpoint goes haywire when used, making the 
cursor jump all over the place and triggering random "right clicks" on 
the Latitude XT2. I don't know if it affects other models too.

Sorry for not spotting this earlier.

Name        : kernel
Version     : 3.11.6
Release     : 201.fc19
Architecture: x86_64
Install Date: Tue 05 Nov 2013 09:22:37 CET
Group       : System Environment/Kernel
Size        : 134433560
License     : GPLv2 and Redistributable, no modification permitted
Signature   : RSA/SHA256, Sat 02 Nov 2013 22:00:51 CET, Key ID 
07477e65fb4b18e6
Source RPM  : kernel-3.11.6-201.fc19.src.rpm
Build Date  : Sat 02 Nov 2013 15:35:07 CET

Best,
Gaspard

