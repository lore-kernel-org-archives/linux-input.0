From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 09:01:15 -0700
Message-ID: <20100414160111.GB2450@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
 <20100414123643.GB9242@srcf.ucam.org>
 <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz>
 <20100414135350.3b1643c2@lxorguk.ukuu.org.uk>
 <20100414125244.GC10075@srcf.ucam.org>
 <20100414143550.75def636@lxorguk.ukuu.org.uk>
 <20100414133801.GA11142@srcf.ucam.org>
 <alpine.LNX.2.00.1004141538490.8345@pobox.suse.cz>
 <20100414134321.GA11335@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100414134321.GA11335@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 02:43:21PM +0100, Matthew Garrett wrote:
> On Wed, Apr 14, 2010 at 03:40:14PM +0200, Jiri Kosina wrote:
> 
> > Ask vendors, who are shipping specialized windows drivers for their mice, 
> > to be please so kind and always include a linux driver as well, and nuke 
> > all the probing logic from in-kernel driver?
> 
> Well, in this case we know that there's a synaptics (it's in ACPIPNP) 
> and we know that an internal synaptics places pretty heavy constraints 
> on what else is going to be attached to the machine.
> 

As in... anything? Many boxes still have external PS/2 ports that can
have pretty much any type of mouse attached. Especially those HPs that
have active multiplexor.

-- 
Dmitry
