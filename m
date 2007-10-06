From: Oliver Neukum <oliver@neukum.org>
Subject: Re: even newer version of USB HID autosuspend
Date: Sat, 6 Oct 2007 11:15:53 +0200
Message-ID: <200710061115.53986.oliver@neukum.org>
References: <200710051329.23385.oliver@neukum.org> <Pine.LNX.4.64.0710051827040.25413@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0710051827040.25413@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

Am Freitag 05 Oktober 2007 schrieb Jiri Kosina:
> On Fri, 5 Oct 2007, Oliver Neukum wrote:
> 
> > Please review and/or test.
> 
> Hi Oliver,
> 
> thanks a lot for taking care of this, I will look at it and give it some 
> testing ASAP.
> 
> I am still surprised how large this patch has to be ...

So was I.

1. The input layer insists on doing output from interrupt
2. HID has very elaborate error handling which complicates locking
3. A workaround for autorepeat is included

> > This leaves me with a planning difficulty. For keyboards it is not fully 
> > transparent. The LEDs are switched off when then keyboard is suspended. 
> > Should I now implement a mode where active LEDs block suspension and if 
> > so, how do I switch it on?
> 
> Maybe module parameter of usbhid could be used to specify the desired 
> behavior?

Yes, but what are the desired behaviors?

	Regards
		Oliver
