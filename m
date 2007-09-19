From: Andreas Herrmann <aherrman@arcor.de>
Subject: Re: [PATCH] xpad: fix Kconfig to avoid compile error
Date: Wed, 19 Sep 2007 21:16:54 +0200
Message-ID: <20070919191654.GA5115@devil>
References: <20070918090033.GB14882@devil> <d120d5000709181052r6ee721d6r2d77d0f6b38a4398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000709181052r6ee721d6r2d77d0f6b38a4398@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jan Kratochvil <honza@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, Sep 18, 2007 at 01:52:11PM -0400, Dmitry Torokhov wrote:
> > To avoid this kernel configuration, do auto-select LEDS_CLASS
> > for JOYSTCK_XPAD_LEDS.
> >
> 
> I'd rather it depend on LEDS_CLASS (but properly). I believe I posted
> a patch yesterday.

Didn't see this as I am not subscribed to one of the input or joystick mailing lists
(and didn't find any archive for that lists either).
So today I have checked your input.git tree on git.kernel.org.

Your patch (commit be1945c47248fa9c0a7cf4a04c1f4c32928656d2)
works fine if you rename LED_CLASS to LEDS_CLASS ...

So better fix that typo before your tree is pulled into Linus' tree.
;-)


Thanks and Regards,

Andreas
