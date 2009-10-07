From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Touchscreen driver for the DTS413
Date: Tue, 6 Oct 2009 21:36:13 -0700
Message-ID: <20091007043613.GD10204@core.coreip.homeip.net>
References: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com> <4AC1DAA4.4090508@simtec.co.uk> <a57e67db0909290500k52bcd1faj28903a22cd2c91a5@mail.gmail.com> <a57e67db0909290514r3097a97dtbb82e28a5176ac64@mail.gmail.com> <20091006050640.GG27881@core.coreip.homeip.net> <a57e67db0910060044g53ffd8a2s6db14c305bbf91df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:55981 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZJGEgb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2009 00:36:31 -0400
Received: by mail-ew0-f217.google.com with SMTP id 17so217414ewy.39
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2009 21:36:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a57e67db0910060044g53ffd8a2s6db14c305bbf91df@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jernej Turnsek <jernej.turnsek@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Oct 06, 2009 at 09:44:03AM +0200, Jernej Turnsek wrote:
> Hi,
> 
> I would like to thank you for taking time to review DTS413 driver, but
> I am a little bit confused here. Regarding the comments I just
> followed a Ben Dooks suggestions, but I agree that internal functions
> shouldn't be commented in kernel doc style. Other thing is
> ABS_PRESSURE reporting. At first I thought that this is not
> neccessary, but when using driver with the Kdrive tiny X server
> (Xfbdev), it won't work. Xfbdev gives me Segmentation Fault.

That would be the issue with Xfbdev. There are plentry of touchscreen
driers in the kernel that do not report pressure.

-- 
Dmitry
