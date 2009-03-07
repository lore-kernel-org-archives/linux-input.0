From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: suspend / hibernate nomenclature
Date: Sat, 07 Mar 2009 11:37:24 +0300
Message-ID: <E1Lfs2C-0005Eu-00.arvidjaar-mail-ru@mx33.mail.ru>
References: <1235992429.3858.58.camel@hughsie-work.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, hal@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org

Richard Hughes wrote:

> In the last couple of years, I've been striving to make consistent the
> mapping of sleep states consistent. I don't care what we call things in
> a UI, but we need to make sure we're not arguing about whether:
> 
> KEY_SUSPEND should be mapped to XF86Standby, XF86Hibernate or XF86Sleep
> KEY_SLEEP should be mapped to XF86Hibernate or XF86Standby
> 
> You see it's a mess.
> 
> In userspace we've agreed with the following nomenclature:
> 
> standby = sleep CPU and devices (not really used any more)
> suspend = sleep to memory (quite fast)
> hibernate = sleep to disk (slow)
> hybrid = sleep to both (slow, but fast resume)
> 
> In X, and evdev we've also fixed the mapping, so that:
> 
> XF86Sleep : suspend _or_ hibernate (configured in session policy)
> XF86Suspend: suspend
> XF86Hibernate: hibernate
> 
> This means that if a key on a keyboard can be sleep (but the user can
> choose which), the application handles XF86Sleep. If the button decal is
> marked with a disk, or the ram symbol, then we choose XF86Hibernate or
> XF86Suspend as appropriate.
> 
> We've changed this in HAL a few years ago, 

As of "git pull" made five minutes ago, HAL emits "sleep" for KEY_SLEEP and 
"hibernate" for KEY_SUSPEND. So changing kernel semantic of KEY_SUSPEND will 
break any older HAL installation.

> xproto, libX11 and
> xkeyboard-config last year, and nearly all of the session software in
> use uses the same nomenclature for the last few years.
> 
> After reviewing the platform drivers in ACPI, it appears few of them
> know whether KEY_SLEEP corresponds to suspend or hibernate, and
> KEY_SUSPEND seems to be used for hibernate. Basically, it's a mess.
> 

This is exactly what current HAL does :)

> I propose that we add a KEY_HIBERNATE (key 247), and then we can just
> do:
> 
> KEY_HIBERNATE -> XF86Hibernate -> sleep to disk
> KEY_SUSPEND   -> XF86Suspend   -> sleep to ram
> KEY_SLEEP     -> XF86Sleep     -> sleep (configurable)
> 
> Then the drivers can be patched so everyone is doing the same thing. At
> the moment I'm diagnosing bugs and trying to work around the brokenness
> in userspace hal-info every few days, and it's getting tiresome.
> 
> Feedback welcome, although please don't comment on things like "suspend
> sounds more like a suspend to disk" as we spent years talking with
> userspace people working for a compromise, and this is what we've
> settled on. It's not to everyones taste, but we _do_ need to agree on
> something, even if its just an agreed bodge.
> 

This all sounds very reasonable except it is not clear how HAL transition 
should be handled.
