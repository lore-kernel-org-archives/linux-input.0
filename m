From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and
	KEY_UNKNOWN (v2)
Date: Sat, 30 Jun 2007 15:20:29 -0300
Message-ID: <20070630182029.GA25474@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <20070531222814.GB4076@khazad-dum.debian.net> <20070606165509.GB18984@khazad-dum.debian.net> <200706290104.53909.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <200706290104.53909.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 29 Jun 2007, Dmitry Torokhov wrote:
> Finally gottent to the patch. It seems a little long-winded, how about
> the patch below instead?

Well, your version of the patch:

1. does not make it clear to *userland* that using EV_SCAN instead of EV_KEY
is something that is not to be done.  If userland wants to use a key that is
not generating an useful EV_KEY, it must remap the key to something.
Otherwise, we are opening our flank to the crap we have with that kludge
from hell AT keyboard reverse scan-code generation all again...  it might
have been unavoidable with the AT keyboard, due to legacy stuff, but there
is no way we should let it happen to anything else.

2. does not make it clear that EV_SCAN events must reflect the scan code
that, when remapped, would reprogram the key that caused that EV_SCAN event
to be generated.

I think these two points need to be addressed by the docs.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
