From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Mouse and keyboard freeze on Ivy Bridge platform
Date: Wed, 3 Oct 2012 10:40:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210031028130.1441-100000@iolanthe.rowland.org>
References: <181608016.271891744.1349250048886.JavaMail.root@zimbra59-e10.priv.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <181608016.271891744.1349250048886.JavaMail.root-J/s0bdte1BApj9y2c1zofRh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sebastien.dinot-GANU6spQydw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 689368-61a8vm9lEZVf4u+23C9RwQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 3 Oct 2012 sebastien.dinot-GANU6spQydw@public.gmane.org wrote:

> Hi,
> 
> I am encountering random keyboard and mouse freezes which can only be
> resolved by a hard reset (by pushing the power switch of the computer
> case).

> The mouse and keyboard are both USB devices and it seems that the bug
> is coming from the echci-hcd module:

> Can I run additional tests or give you additional informations to
> help you resolve this painful bug?

Please build a kernel with CONFIG_USB_DEBUG enabled.  When a hang
occurs, get a list of hang tasks (Alt-SysRq-w probably won't work, but
"echo w >/proc/sysrq-trigger" from a network login should).  Then send
the dmesg output

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
