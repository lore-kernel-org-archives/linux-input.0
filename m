From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Fri, 1 Jun 2007 00:33:27 +0100
Message-ID: <20070531233326.GA1947@srcf.ucam.org>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com> <20070531005305.GC6883@khazad-dum.debian.net> <200705310033.51230.dtor@insightbb.com> <20070531222814.GB4076@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070531222814.GB4076@khazad-dum.debian.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, May 31, 2007 at 07:28:14PM -0300, Henrique de Moraes Holschuh wrote:
> We have all the pieces needed to have sane, generic userland keyboard handling
> in place for a while now, but it was not sufficiently documented (or used!).
> 
> If EV_KEY input drivers always generate scan codes that can be used to
> reprogram their keycode maps, and always generate EV_MSC MSC_SCAN events when
> they output an EV_KEY KEY_UNKNOWN event, userspace can trap those and feed it
> to a generic helper that can ask the user to assign a key code and function to
> that key.

I still disagree that this is the best approach. Userspace already has 
the functionality to map keys if they produce a keycode. Producing 
KEY_UNKNOWN would require the implementation of a stack of extra code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
