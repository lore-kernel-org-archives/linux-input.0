From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: Re: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
Date: Sun, 3 Jun 2007 11:53:30 -0400
Message-ID: <20070603155330.GB14913@rcn.com>
References: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz> <20070603153723.GA14913@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070603153723.GA14913@rcn.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

* Brian Magnuson <bdmagnuson@gmail.com> [2007-06-03 11:37]:
> * Jan Kratochvil <honza@jikos.cz> [2007-06-03 11:18]:
> > Hi,
> >   this one is tricky because I can't test it.
> > Brian, there is something I don't understand in your previous patch 
> > concerning this issue. What is reported data length for wireless receiver 
> > when it is sending its status report? I thought you are trying to ignore 
> > packets about headset connection. But it is not working the same way for 
> > wired device. In data[1] is actual length of packet (20).
> > Please test this patch (and the previous 2).
> > Thanks
> 
> I can tell you without even testing that it's not going to work.  The data
> length returned by the wireless controller is alway 29 bytes, but as far
> as I can tell there is no field that indicates that length.

Ok, looks like I was a bit hasty.  Looking at the data again there does
appear to be a length field in the returned data however.

1) It's 19 bytes rather than 20.  This is a internel data format length
though.  The USB data returned is still 29 bytes long.
2) You still need to apply to four byte shift for it to be in the "right"
place.

-Brian
