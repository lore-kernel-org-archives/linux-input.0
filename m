From: Brian Magnuson <bdmagnuson@gmail.com>
Subject: Re: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
Date: Sun, 3 Jun 2007 11:37:23 -0400
Message-ID: <20070603153723.GA14913@rcn.com>
References: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

* Jan Kratochvil <honza@jikos.cz> [2007-06-03 11:18]:
> Hi,
>   this one is tricky because I can't test it.
> Brian, there is something I don't understand in your previous patch 
> concerning this issue. What is reported data length for wireless receiver 
> when it is sending its status report? I thought you are trying to ignore 
> packets about headset connection. But it is not working the same way for 
> wired device. In data[1] is actual length of packet (20).
> Please test this patch (and the previous 2).
> Thanks

I can tell you without even testing that it's not going to work.  The data
length returned by the wireless controller is alway 29 bytes, but as far
as I can tell there is no field that indicates that length.

However, there is a bit returned that seems to indicate whether the pad
state is valid or not which is what I was testing.  Here's the relevant bit
from my patch.

static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd,
unsigned char *data)
{
	struct input_dev *dev = xpad->dev;
	/* Valid pad data */
	if(!(data[1] & 0x1))
		return;
	
	xpad360_process_packet(xpad, cmd, &data[4]);
}

You see that I'm not checking a length here but a particualar bit.   Also,
when I had off to the original xbox360_process_packet I shift the data over by
four bytes.  This is why I made it a seperate function in the first place
since I envioned that something more might happen as the meaning of these
first four bytes becomes more decoded.  The bits that I had figured out
were explanied in the comments preceeding xpad360w_process_packet.

I'll go ahead and test these later but in the meantime [1/4] and [3/4] look
fine but [2/4] will break wireless controllers.

-Brian
