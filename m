From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Support special keys on laptop by default?
Date: Tue, 6 Jan 2009 15:26:52 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0901061526200.24105@twin.jikos.cz>
References: <4963594B.9040705@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-laptop-owner@vger.kernel.org>
In-Reply-To: <4963594B.9040705@wincor-nixdorf.com>
Sender: linux-laptop-owner@vger.kernel.org
To: Niels de Vos <niels.devos@wincor-nixdorf.com>
Cc: linux-input@vger.kernel.org, linux-laptop@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 6 Jan 2009, Niels de Vos wrote:

> on my HP/Compaq nc6400 there are three keys (info, presentation and
> battery) not directly recognized. If I press any of the keys, I get:
> 
> atkbd.c: Unknown key released (translated set 2, code 0xd9 on isa0060/serio0).
> atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.
[ ... ]
> Where should I start looking for creating a patch for solving problems 
> of this kind? There seem to be quirks in atkbd.c, but I think they are 
> used for some other workarounds.

Please see 
http://people.freedesktop.org/~hughsient/quirk/quirk-keymap-index.html

-- 
Jiri Kosina
SUSE Labs

