From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: wistron_btns - Is polling always required?
Date: Fri, 20 Jul 2007 00:06:35 -0400
Message-ID: <200707200006.35795.dtor@insightbb.com>
References: <f7o5fo$b3c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <f7o5fo$b3c$1@sea.gmane.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, =?iso-8859-1?q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
List-Id: linux-input@vger.kernel.org

Hi Carlos,

On Thursday 19 July 2007 13:03, Carlos Corbacho wrote:
> I've been looking over the wistron_btns driver (again), and am rather
> puzzled by some of the latest additions to it.
> 
> In particular, laptops such as the 3020 and 5020 series (both identical, bar
> different AMD processors) are being polled to map their extra keys -
> however, both these laptops (and, AFAIK, most modern Acer laptops since at
> least 2005) do _not_ require this - all the extra keys are already emitting
> scancodes.
> 
> From what I can see, it would be surely better to drop the BIOS probing and
> polling on the newer laptops, and then either:
> 
> A) Use the setkeycode ioctl for these particular laptops
> 
> Pro: 
> For users with x86-64 Acer laptops that produce scancodes, wistron_btns
> could be made to work, since the BIOS probing and polling code is now
> unnecessary.
> 
> Con:
> Should setkeycode really be used in a kernel driver? (I don't know what the
> official policy is here)
> 
> B) Let userspace map the scancodes to keycodes (such as HAL 0.5.10 and above
> is doing at the moment) (i.e. cut back wistron_btns to _just_ the older
> models that really do need polling to generate keycodes).
> 
> Pro:
> Don't have to update the kernel for every single new Acer model and keyboard
> layout found (in the case of HAL, it would just be the hal-info package,
> which contains all this kind of information).
> 
> Con:
> Not everyone may be using HAL - potential for inconsistency in keyboard
> mappings.
> 

I was not aware that these models can deliver events for hotkeys via
atkbd. I think option B is best since interrupt-driven mode is always
better than polling. I am CC-ing Eric Piel who did most of the work
on new models support in wistron_btns.

-- 
Dmitry
