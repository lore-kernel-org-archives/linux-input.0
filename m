From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] sh: maple: Robust checking for errors on maple keyboard initialisation
Date: Sat, 20 Dec 2008 22:17:04 -0800
Message-ID: <200812202217.05002.dmitry.torokhov@gmail.com>
References: <1229797527.6502.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1229797527.6502.18.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: lkmL <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-input@vger.kernel.org

On Saturday 20 December 2008 10:25:27 Adrian McMenamin wrote:
> As was pointed out in response to http://lkml.org/lkml/2008/12/19/373
> maple drivers were not properly checking for NULL pointers.
>
> This patch fixes this for the keyboard driver already in mainline.
>

This driver is fine as is, only the joystick driver had the issue.

-- 
Dmitry
