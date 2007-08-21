From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] Console keyboard events and accessibility
Date: Tue, 21 Aug 2007 22:42:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708210732270.5333@fbirervta.pbzchgretzou.qr>
References: <20070821005718.GD3658@interface.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070821005718.GD3658@interface.famille.thibault.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dtor@mail.ru
List-Id: linux-input@vger.kernel.org


On Aug 21 2007 02:57, Samuel Thibault wrote:
>
>Some external modules like Speakup need to use the PC keyboard to control
>them and also need to get keyboard feedback (caps lock status, etc.)
>
>This adds a keyboard notifier that such modules can use to get the keyboard
>events and possibly eat them, at several stages:
>
>- keycodes: even before translation into keysym.

They can use the raw xlation for that. The "showkeys" utility and Xorg are
likely to do that. (In fact, there is a helping sysrq called Unraw in case
there are problems.)

>- unbound keycodes: when no keysym is bound.
>- unicode: when the keycode would get translated into a unicode character.
>- keysym: when the keycode would get translated into a keysym.
>- post_keysym: after the keysym got interpreted, so as to see the result
>  (caps lock, etc.)

For all these, I think new xlats should be added that have the desired
behavior.

>+	int shift;		/* Current shift mask */
>+	unsigned int value;	/* keycode, unicode value or keysym */
>+};
>+
>+extern int register_keyboard_notifier(struct notifier_block *nb);
>+extern int unregister_keyboard_notifier(struct notifier_block *nb);
> #endif
> 
