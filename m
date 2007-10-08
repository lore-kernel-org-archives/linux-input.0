From: Oliver Neukum <oliver@neukum.org>
Subject: Re: even newer version of USB HID autosuspend
Date: Mon, 8 Oct 2007 09:02:55 +0200
Message-ID: <200710080902.56049.oliver@neukum.org>
References: <200710051329.23385.oliver@neukum.org> <200710061115.53986.oliver@neukum.org> <200710071457.23780.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710071457.23780.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

Am Sonntag 07 Oktober 2007 schrieb Dmitry Torokhov:
> On Saturday 06 October 2007, Oliver Neukum wrote:
> > > > This leaves me with a planning difficulty. For keyboards it is not fully 
> > > > transparent. The LEDs are switched off when then keyboard is suspended. 
> > > > Should I now implement a mode where active LEDs block suspension and if 
> > > > so, how do I switch it on?
> > > 
> > > Maybe module parameter of usbhid could be used to specify the desired 
> > > behavior?
> > 
> > Yes, but what are the desired behaviors?
> > 
> 
> I'd say do not autosuspend keyboards (and other led-equipped input devices)
> unless user explicitely requested to do so and then turn the leds off.

So your answer is that we shouldn't care about the LEDs being on and
suspend regardless?

	Regards
		Oliver
