From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 3/3] xpad.c: Added Xbox360 gamepad rumble support.
Date: Wed, 9 May 2007 00:31:28 -0400
Message-ID: <200705090031.29817.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705021704180.13550@twin.jikos.cz> <alpine.LRH.0.98.0705031504280.22353@twin.jikos.cz> <alpine.LRH.0.98.0705032326440.22353@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LRH.0.98.0705032326440.22353@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <honza@jikos.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi Jan,

On Thursday 03 May 2007 17:41, Jan Kratochvil wrote:
> Hi again,
>    what do you think about this? (This patch will work only against last 
> gamepad rumble support patch)
> 
> Thanks for your time
>  	Jan Kratochvil
> 
> BigX button on xbox360 gamepad is surrounded by 4 green leds. This
> patch adds support to control them.
> 
> This device understand to 14 messages (described at 
> http://www.free60.org/wiki/Gamepad#LED_Control).
> 
> Control is done through event interface, message type EV_LED. EV_LED isn't 
> perfect match because you are actualy not turning some led on or off but 
> more likely you are telling the gamepad what "flash effect" it should 
> play.
> 

I would rather it used led subsystem for this.

-- 
Dmitry
