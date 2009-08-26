From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] thinkpad-acpi: use correct key names for sleep states
	in driver
Date: Wed, 26 Aug 2009 14:43:49 +0100
Message-ID: <20090826134349.GA12404@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090302112400.GA2356@khazad-dum.debian.net> <1236164049.3936.17.camel@hughsie-work.lan> <20090304120439.GA31850@khazad-dum.debian.net> <1250625730.2257.11.camel@hidalgo> <20090818201002.GA32638@srcf.ucam.org> <1251286574.32399.3.camel@miria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251286574.32399.3.camel@miria>
Sender: linux-acpi-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 26, 2009 at 01:36:14PM +0200, Yves-Alexis Perez wrote:

> #define XF86XK_Suspend    0x1008FFA7   /* Sleep to RAM                */        
> #define XF86XK_Hibernate  0x1008FFA8   /* Sleep to disk               */
> 
> So (some) userspace seems to have switched already?

Adding those keysyms was, with hindsight, an error.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
