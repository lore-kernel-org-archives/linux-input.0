From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 7/8] Input: docs - split input docs into kernel- and
 user-facing
Date: Sun, 16 Apr 2017 11:50:57 -0300
Message-ID: <20170416115053.233b5a37@vento.lan>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
        <20170416051145.13618-7-dmitry.torokhov@gmail.com>
        <20170416110813.66a4ba64@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:47581
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755948AbdDPOvE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 16 Apr 2017 10:51:04 -0400
In-Reply-To: <20170416110813.66a4ba64@vento.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Em Sun, 16 Apr 2017 11:08:13 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:

> Hi Dmitry,
> 
> Em Sat, 15 Apr 2017 22:11:44 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:
> 
> > Split input documentation into several groups: kernel- and user-facing, and
> > notes about individual device drivers. Move device drivers docs into a
> > separate subdirectory.  
> 
> I reviewed and tested Sphinx generation for this patch series.
> Thinks are a way better organized now. Good work!
> 
> I got just a minor nitpick for HTML generation (see below).
> 
> 
> However, building PDF documentation now hits an error, with Sphinx 1.4.9:
> 
> 	Markup is unsupported in LaTeX:
> 	input/devices/xpad:209: literal blocks in footnotes are not supported by LaTeX
> 
> It seems it didn't like to have literal blocks inside footnotes:
> 
> 	.. [4] /proc/bus/usb/devices - dump from InterAct PowerPad Pro (Germany):
> 
> 	 ::
> 
> 	    T:  Bus=01 Lev=03 Prnt=04 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
> 	    D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=32 #Cfgs=  1
> 	    P:  Vendor=05fd ProdID=107a Rev= 1.00
> 	    C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
> 	    I:  If#= 0 Alt= 0 #EPs= 2 Cls=58(unk. ) Sub=42 Prot=00 Driver=(none)
> 	    E:  Ad=81(I) Atr=03(Int.) MxPS=  32 Ivl= 10ms
> 	    E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl= 10ms
> 
> 
> I'll see if I can find a way to fix this issue.

The enclosed patch should fix it. It should come after the one that
replaces /proc/bus/usb/devices to /sys/kernel/debug/usb/devices.

It also fixes the last reference to the last URL.

Thanks,
Mauro
