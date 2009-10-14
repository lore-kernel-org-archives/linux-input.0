From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Wed, 14 Oct 2009 09:19:50 +0200
Message-ID: <20091014071950.GF23248@one.firstfloor.org>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907081317000.27327@wotan.suse.de> <20091014045851.GA32413@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756806AbZJNHU3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091014045851.GA32413@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Andi Kleen <andi@firstfloor.org>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Btw, what kind of keyboard is this? I was playing today but I could not
> get my USB keyboards to report release of more than 1 key per report....

The log was with a PS/2<->USB adapter, with a PS/2 keyboard connected
to a USB port through it.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
