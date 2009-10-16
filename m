From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Thu, 15 Oct 2009 22:41:55 -0700
Message-ID: <4AD807A3.6060508@zytor.com>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de> <20090708065325.GE3309@dtor-d630.eng.vmware.com> <alpine.LNX.2.00.0907081317000.27327@wotan.suse.de> <20091014045851.GA32413@core.coreip.homeip.net> <20091014071950.GF23248@one.firstfloor.org> <20091014073927.GB5318@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753209AbZJPFnB@vger.kernel.org>
In-Reply-To: <20091014073927.GB5318@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Kosina <jkosina@suse.cz>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/14/2009 12:39 AM, Dmitry Torokhov wrote:
> On Wed, Oct 14, 2009 at 09:19:50AM +0200, Andi Kleen wrote:
>>> Btw, what kind of keyboard is this? I was playing today but I could not
>>> get my USB keyboards to report release of more than 1 key per report....
>>
>> The log was with a PS/2<->USB adapter, with a PS/2 keyboard connected
>> to a USB port through it.
>>
> 
> Hmm, I don't think I have one of those... It is curious beast - we have
> software autorepeat for HID but PS/2 keyboards do autorepeat
> themselves... What will combination do?
> 

Autorepeat on PS/2 keyboards is a mode setting.  I would guess the HID
adapter would turn it off if it is halfway sane.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
