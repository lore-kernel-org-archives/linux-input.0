From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: even newer version of USB HID autosuspend
Date: Mon, 8 Oct 2007 09:44:25 -0400
Message-ID: <d120d5000710080644k1a2a4685x4fbe5b9155e661d6@mail.gmail.com>
References: <200710051329.23385.oliver@neukum.org>
	 <200710061115.53986.oliver@neukum.org>
	 <200710071457.23780.dmitry.torokhov@gmail.com>
	 <200710080902.56049.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710080902.56049.oliver@neukum.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

On 10/8/07, Oliver Neukum <oliver@neukum.org> wrote:
> Am Sonntag 07 Oktober 2007 schrieb Dmitry Torokhov:
> >
> > I'd say do not autosuspend keyboards (and other led-equipped input devices)
> > unless user explicitely requested to do so and then turn the leds off.
>
> So your answer is that we shouldn't care about the LEDs being on and
> suspend regardless?
>

Yes, I think so.

-- 
Dmitry
