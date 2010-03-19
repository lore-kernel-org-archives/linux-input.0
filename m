From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Input: implement sysrq as an input handler
Date: Thu, 18 Mar 2010 17:09:31 -0700
Message-ID: <20100319000931.GA5671@core.coreip.homeip.net>
References: <20100317061952.GA19789@core.coreip.homeip.net>
 <20100319000043.GC12017@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100319000043.GC12017@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Linux Input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason Wessel <jason.wessel@windriver.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 18, 2010 at 09:00:43PM -0300, Henrique de Moraes Holschuh wrote:
> Any chance of the user being able to avoid the SysRQ events getting to the
> handle, e.g. by opening the input device in exclusive mode or something like
> that?
>

Yes, it is a possible to suppress SysRq by grabbing an input device.
This possibility exisst with the current implementation too though -
after all legacy keyboard driver implemented as an input handler as
well.

... or am I answering a question different from the one you asked? ;)
 
-- 
Dmitry
