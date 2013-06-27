From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/2] input: document gamepad API and add extra
 keycodes
Date: Thu, 27 Jun 2013 11:47:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306271147150.3538@pobox.suse.cz>
References: <1371303165-1802-1-git-send-email-dh.herrmann@gmail.com> <1371303165-1802-2-git-send-email-dh.herrmann@gmail.com> <20130626160727.GA32420@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130626160727.GA32420@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, Todd Showalter <todd@electronjump.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 26 Jun 2013, Dmitry Torokhov wrote:

> On Sat, Jun 15, 2013 at 03:32:44PM +0200, David Herrmann wrote:
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -507,10 +507,14 @@ struct input_keymap_entry {
> >  
> >  #define BTN_GAMEPAD		0x130
> >  #define BTN_A			0x130
> > +#define BTN_SOUTH		0x130
> 
> Could we do:
> 
> #define BTN_SOUTH		0x130
> #define BTN_A			BTN_SOUTH
> 
> so that it is clear that BTN_A, BTN_B, etc are legacy definitions and
> not an accidental typos that need their own key codes.

Makes sense, will do that modification.

> Otherwise:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks Dmitry. Will be taking it (with the above modification) through my 
tree.

-- 
Jiri Kosina
SUSE Labs
