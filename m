From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Wed, 30 May 2007 08:40:32 -0400
Message-ID: <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
References: <20070529043957.GB6157@rcn.com>
	 <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
	 <20070530002846.GA8595@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070530002846.GA8595@rcn.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Brian Magnuson <bdmagnuson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, honza@jikos.cz
List-Id: linux-input@vger.kernel.org

Hi Brain,

[Added Jan to CC list]

On 5/29/07, Brian Magnuson <bdmagnuson@gmail.com> wrote:
> Hi Dimitri,
>
> Thanks for taking the time to review.  My reponses are inline.
>
> -Brian
>
> * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2007-05-29 20:03]:
> >
> > Thnk you for the patch. Looking at the code I do not see one device
> > supporintg multiple controllers... You have one input device per usb
> > device/interface and the properties of said device are known
> > beforehand. So I would just create and register input device right
> > there in xboxrcvr_probe() and get rid of your build and teardown
> > works. The fact that is it a wireless device and at transmitter may at
> > times be out of range is not important.
>
> Actually, I rather liked the fact that the input devices only show up when
> there is a controller connected to the receiver, since there can be anywhere
> from 0-4 controllers alive.  This way there are no device nodes for
> non-existant controllers.

Let's keep it simple. This way we don't have to worry about races
between build and teardown work pieces and the driver is much
simplier. After all we don't do dynamic device creation for wireless
mice (non blue-tooth). And if we did it would make some programs
unhappy if they did not see that device all the time... Even with
controller - imagine you are playing and somebody calls you - you walk
away with your controller in hand and when you come back it stops
working because we tore down one device and created the a one but
application is still latched to the old device - not nice.

> >
> > Overall I would like support for this wireless receiver to be
> > incorporated into xpad.c driver.
>
> Knew that was coming :).  Should be able to manage it.  Since the wireless
> model returns a expanded data format it needs to be handled specially.
> Another flag in the xpad_device struct?

We have xtype field, I think it should be used.

-- 
Dmitry
