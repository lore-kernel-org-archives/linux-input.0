From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Fri, 15 Oct 2010 18:11:05 +0100
Message-ID: <201010151811.06792.carlos@strangeworlds.co.uk>
References: <4CB8A5290200002300021E79@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4CB8A5290200002300021E79@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dmitry.torokhov@gmail.com, corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Friday 15 October 2010 09:02:01 Joey Lee wrote:
> > Why would user chose one setup over another? I.e do we really need a
> > module option or maybe we should pick up behavior and stick to it?
> 
> When Acer notebook ship with Windows, they will preload a userland
> application, the name is Launch Manager, it provide a GUI for end user
> to change WLAN/BT/3G on/off state.

[...]

> Because the Launch Manager is userland application, so wmi driver only
> can provide the function for it to call and don't have any way can
> detect it from kernel module.

Dmitry's point is still valid - why do we want to provide the userspace 
behaviour? Why not just handle it all in kernel using rfkill?

We don't have Launch Manager for Linux, and quite frankly, I hope we never see 
it - relying on random, vendor specific applications to drive this kind of 
functionality is just asking for trouble.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
