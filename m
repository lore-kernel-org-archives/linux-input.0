From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
 adapter
Date: Mon, 11 May 2009 17:51:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111749530.22712@wotan.suse.de>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0848E7.9080301-AlSwsSmVLrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Jussi Kivilinna <jussi.kivilinna-E01nCVcF24I@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 11 May 2009, Jiri Slaby wrote:

> Strictly speaking, it depends on whether the device is able to be 
> managed by the generic layer or not. And it seems it can; this driver 
> adds only a FF support. If we disabled the FF support in the config and 
> the #if macro wasn't there, we would lose the device completely even 
> though it can be handled by the core, without FF though.

That was exactly my point, yes.

> So I think, in this particular case, it is OK to have the conditional 
> line in there.

Actually this should be the case at least for

- all drivers which implement only force feedback features
- all drivers which only add additional key mappings

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
