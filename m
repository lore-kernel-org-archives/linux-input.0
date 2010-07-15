From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: any value in running my kernel scanning scripts before release?
Date: Thu, 15 Jul 2010 07:32:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007150728520.13042@lynx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


  normally i wait for the merge window, then run my kernel scanning
scripts and post results.  any interest in me doing that earlier?  i
just did a quick test and found a number of incongruities like, for
example:

$ grep -r "config QT2160" *
drivers/input/keyboard/Kconfig:config QT2160
$

$ grep -r KEYBOARD_QT2160 *
drivers/input/keyboard/Makefile:obj-$(CONFIG_KEYBOARD_QT2160) += qt2160.o
$

  which is a fairly obvious mismatch between the config variable and
the test, yes?

  anyway, i'm open to suggestions.

rday

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Top-notch, inexpensive online Linux/OSS/kernel courses
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
