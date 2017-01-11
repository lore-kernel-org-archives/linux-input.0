From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Wed, 11 Jan 2017 17:28:28 +0100
Message-ID: <20170111162828.GA7997@mail.corp.redhat.com>
References: <20170110121718.2992211-1-arnd@arndb.de>
 <e0f66d88-1651-206e-ba13-a3229b9725d7@synaptics.com>
 <4257703.BL932J6KbN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4257703.BL932J6KbN@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lyude Paul <thatslyude@gmail.com>
List-Id: linux-input@vger.kernel.org

On Jan 11 2017 or thereabouts, Arnd Bergmann wrote:
> On Tuesday, January 10, 2017 4:39:43 PM CET Andrew Duggan wrote:
> > On 01/10/2017 04:16 AM, Arnd Bergmann wrote:
> > > If CONFIG_INPUT=m, we get a build error for the rmi4-f03 driver,
> > > added in linux-4.10:
> > >
> > > drivers/input/built-in.o: In function `rmi_f03_attention':
> > > rmi_f03.c:(.text+0xcfe0): undefined reference to `serio_interrupt'
> > > rmi_f03.c:(.text+0xd055): undefined reference to `serio_interrupt'
> > > drivers/input/built-in.o: In function `rmi_f03_remove':
> > > rmi_f03.c:(.text+0xd115): undefined reference to `serio_unregister_port'
> > > drivers/input/built-in.o: In function `rmi_f03_probe':
> > > rmi_f03.c:(.text+0xd209): undefined reference to `__serio_register_port'
> > >
> > > If we make the driver itself a 'tristate' instead of 'bool' symbol,
> > > Kconfig ensures that it can only be a loadable module in this case,
> > > which avoids the problem.
> > 
> > Unfortunately, the RMI4 driver does not support building the function 
> > drivers as modules. If F03 is built as a module it will not be loaded by 
> > the core. If we want f03 to be part of a module then rmi_core needs to 
> > be built as a module. We should remove the module macros currently in 
> > rmi_f03.c.
> > 
> > I was able to get a similar build error by setting CONFIG_RMI_CORE=y and 
> > CONFIG_SERIO=m. Was CONFIG_RMI_CORE=y set when you encountered this 
> > error? If so I think we should figure out a way to have Kconfig set 
> > CONFIG_RMI_CORE=m if serio is built as a module.
> 
> 
> Ok, I see what you mean now in 
> 
> static struct rmi_function_handler *fn_handlers[] = {
>         &rmi_f01_handler,
> #ifdef CONFIG_RMI4_F03
>         &rmi_f03_handler,
> #endif
> #ifdef CONFIG_RMI4_F11
>         &rmi_f11_handler,
> #endif
> ...
> };
> 
> I think we can actually make this more modular and more like other
> drivers work:
> 
> If each of the sub-drivers gets changed to call
> rmi_register_function_handler() on its own handler structure,
> having some drivers as modules would just work.
> 
> It looks like the rmi_bus.c file was written to do it that way,
> but for some reason the references to those drivers are all
> in the same file.
> 

Yep, it was initially written that way, and IIRC there was some issues
depending on how the drivers were compiled. For example, if rmi4_core is
Y and some functions are m, you can't load the device initially, so you
send a -EPROBE_DEFER, but how can you be sure that the function will
ever be loaded?

Given that we need to have all the functions loaded during probe, we
decided to switch to a monolithic rmi4_core driver that has everything
it needs inside.

I think having the dependency on SERIO=m implying RMI4_CORE=m should be
doable and is probably the best solution with the current code.

Cheers,
Benjamin
