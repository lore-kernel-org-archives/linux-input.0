From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: even newer version of USB HID autosuspend
Date: Sun, 7 Oct 2007 14:57:23 -0400
Message-ID: <200710071457.23780.dmitry.torokhov@gmail.com>
References: <200710051329.23385.oliver@neukum.org> <Pine.LNX.4.64.0710051827040.25413@twin.jikos.cz> <200710061115.53986.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710061115.53986.oliver@neukum.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

On Saturday 06 October 2007, Oliver Neukum wrote:
> > > This leaves me with a planning difficulty. For keyboards it is not fully 
> > > transparent. The LEDs are switched off when then keyboard is suspended. 
> > > Should I now implement a mode where active LEDs block suspension and if 
> > > so, how do I switch it on?
> > 
> > Maybe module parameter of usbhid could be used to specify the desired 
> > behavior?
> 
> Yes, but what are the desired behaviors?
> 

I'd say do not autosuspend keyboards (and other led-equipped input devices)
unless user explicitely requested to do so and then turn the leds off.
We have too many module parameters...

-- 
Dmitry
