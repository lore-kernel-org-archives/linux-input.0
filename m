From: Richard Hughes <hughsient@gmail.com>
Subject: Re: screen auto brightness key
Date: Tue, 05 Jun 2007 18:30:50 +0100
Message-ID: <1181064650.15192.54.camel@work>
References: <1181064431.25009.181.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1181064431.25009.181.camel@cookie.hadess.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Dmitry Torokhov <dtor@insightbb.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-06-05 at 18:27 +0100, Bastien Nocera wrote:
> Heya,
> 
> We've just landed some HAL software to map "unknown scancodes" to proper
> input keys, as listed in linux/input.h and I can't seem to find a good
> match for the "ALS" key on my Dell computer.
> 
> The "Auto Light Sensing" key turns on/off the hardware monitor for
> brightness and ajusts the screen brightness in consequence.
> 
> It's similar to KEY_KBDILLUMTOGGLE, but for screens. Is there a match I
> couldn't find, or should I kindly ask for the key to be added?

KEY_BRIGHTNESSTOGGLE is probably best IMO.

Richard.
