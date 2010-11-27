From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver
Date: Sat, 27 Nov 2010 00:19:00 -0800
Message-ID: <20101127081900.GE28667@core.coreip.homeip.net>
References: <4CEBED7E.7010101@armadeus.com>
 <20101124195523.GF27368@core.coreip.homeip.net>
 <4CEE3632.6020502@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41252 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0K0ITH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:19:07 -0500
Content-Disposition: inline
In-Reply-To: <4CEE3632.6020502@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabien Marteau <fabien.marteau@armadeus.com>
Cc: Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 25, 2010 at 11:10:58AM +0100, Fabien Marteau wrote:
> > 
> > Just why does it have to be separately allocated? I'd even stick with
> > "as5011" for all IRQ names.
> 
> I thought that irq name should be different for each IRQ used under device and
> for each device used in system. I can use the same irq name if I've got several
> as5011 joystick in the same system ?

No, it's just a tag shown in /proc/interrupts and a few other places.
Simply a driver name would work splendidly.

Thanks.

-- 
Dmitry
