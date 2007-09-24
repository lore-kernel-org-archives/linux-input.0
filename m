From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] detecting when keys are being pressed on a keyboard
Date: Mon, 24 Sep 2007 15:54:02 +0200
Message-ID: <200709241554.02290.oliver@neukum.org>
References: <200709211033.09698.oliver@neukum.org> <200709241539.19610.oliver@neukum.org> <d120d5000709240645r7dc61174j157fa69be92baa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709240645r7dc61174j157fa69be92baa4@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Am Montag 24 September 2007 schrieb Dmitry Torokhov:
> > I was thinking about a second approach. As all keypresses run through
> > the interrupt handlers of the hid driver, how about checking the bit field
> > in the interrupt handler after calling hid_input_report() ?
> >
> 
> That should work as well I think.
> 

Thanks, I'll try that.

	Regards
		Oliver
