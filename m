From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] detecting when keys are being pressed on a keyboard
Date: Mon, 24 Sep 2007 15:39:19 +0200
Message-ID: <200709241539.19610.oliver@neukum.org>
References: <200709211033.09698.oliver@neukum.org> <200709241256.05300.oliver@neukum.org> <d120d5000709240550u3bb1d455vc9bb54b2e57f4313@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709240550u3bb1d455vc9bb54b2e57f4313@mail.gmail.com>
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
> Hi Oliver,
> 
> On 9/24/07, Oliver Neukum <oliver@neukum.org> wrote:
> > Am Freitag 21 September 2007 schrieb Jiri Kosina:

> > > Hi Oliver,
> > >
> > > HID doesn't keep any permanent state by itself. If you want to know
> > > whether a given key is currently pressed or not, you'd have to inspect the
> > > bitfields inside input_dev*, I am afraid.
> >
> > I see no way to do this without a race condition. The field isn't locked
> > as far as I can tell.
> 
> You can take input_dev->event_lock to stop event from propagating
> through input core while you are evaluating the bits. Input lcoking
> changes are im -mm and will be merged into 2.6.24.

Hi Dmitry,

I was thinking about a second approach. As all keypresses run through
the interrupt handlers of the hid driver, how about checking the bit field
in the interrupt handler after calling hid_input_report() ?

	Regards
		Oliver
