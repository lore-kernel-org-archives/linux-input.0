From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Dec 24 (ijnput/rmi4)
Date: Sat, 24 Dec 2016 10:56:49 -0800
Message-ID: <d320f691-51e0-f94f-6a13-60c32d74edd8@infradead.org>
References: <20161224145325.3956e16d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20161224145325.3956e16d@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>
List-Id: linux-input@vger.kernel.org

On 12/23/16 19:53, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any material for v4.11 to your linux-next included
> branches until after v4.10-rc1 has been released.
> 
> There will be no linux-next releases from me between Dec 25 and Jan 2
> inclusive (unless I get really bored with my new toys :-)).
> 
> Changes since 20161223:
> 

on x86_64:

when CONFIG_SERIO=m and CONFIG_RMI4_F03=y:

drivers/built-in.o: In function `rmi_f03_attention':
rmi_f03.c:(.text+0xf8ef8): undefined reference to `serio_interrupt'
rmi_f03.c:(.text+0xf8fbd): undefined reference to `serio_interrupt'
drivers/built-in.o: In function `rmi_f03_remove':
rmi_f03.c:(.text+0xf9082): undefined reference to `serio_unregister_port'
drivers/built-in.o: In function `rmi_f03_probe':
rmi_f03.c:(.text+0xf9260): undefined reference to `__serio_register_port'




-- 
~Randy
