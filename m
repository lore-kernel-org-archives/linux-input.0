From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Wed, 14 Oct 2009 00:39:28 -0700
Message-ID: <20091014073927.GB5318@core.coreip.homeip.net>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907081317000.27327@wotan.suse.de> <20091014045851.GA32413@core.coreip.homeip.net> <20091014071950.GF23248@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932167AbZJNHkL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091014071950.GF23248@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Kosina <jkosina@suse.cz>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 14, 2009 at 09:19:50AM +0200, Andi Kleen wrote:
> > Btw, what kind of keyboard is this? I was playing today but I could not
> > get my USB keyboards to report release of more than 1 key per report....
> 
> The log was with a PS/2<->USB adapter, with a PS/2 keyboard connected
> to a USB port through it.
> 

Hmm, I don't think I have one of those... It is curious beast - we have
software autorepeat for HID but PS/2 keyboards do autorepeat
themselves... What will combination do?

-- 
Dmitry
