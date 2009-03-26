From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: Rawmode keyboard for your....
Date: Thu, 26 Mar 2009 14:30:43 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909014E279A@mi8nycmail19.Mi8.com>
References: <20090326185925.79ca6833.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og110.obsmtp.com ([64.18.1.25]:43803 "HELO
	exprod6og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755769AbZCZSb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Mar 2009 14:31:28 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090326185925.79ca6833.kristoffer.ericson@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>, Dmitry <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thursday, March 26, 2009 10:59 AM, Kristoffer Ericson wrote:
> Greetings,

Hello

> What exactly does this build warning imply?
> We have a fully working keyboard driver for the Jornada 700-series
> and would really like to get rid of this.
>
>
>  CC      drivers/char/keyboard.o
> drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate
rawmode keyboard for your architecture yet."
> drivers/char/keyboard.c:1126:2: warning: #warning "Cannot generate
rawmode keyboard for your architecture yet."

It means just what it says, if you put the keyboard into VC_RAW mode you
will not get the expected key codes.

But... Hmm... Jornada 700-series is arm/mach-sa1100 (CONFIG_ARM)...

Looks like if you enable CONFIG_KEYBOARD_ATKBD the build warning message
will go away. 

Just my 2 cents...
Hartley
