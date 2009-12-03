From: Will Stephenson <wstephenson-RoXCvvDuEio@public.gmane.org>
Subject: Re: [Kde-hardware-devel] [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Thu, 3 Dec 2009 12:23:04 +0100
Message-ID: <200912031223.04419.wstephenson@kde.org>
References: <1259826317-18809-28-git-send-email-corentincj@iksaif.net> <71cd59b00912030122n3d94236ajfa5e55c3b5a9efcd@mail.gmail.com> <1259833412.12843.7.camel@johannes.local>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259833412.12843.7.camel-YfaajirXv2244ywRPIzf9A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kde-hardware-devel-RoXCvvDuEio@public.gmane.org
Cc: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>, Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dbus-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, networkmanager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thursday 03 December 2009 10:43:32 Johannes Berg wrote:
> On Thu, 2009-12-03 at 10:22 +0100, Corentin Chary wrote:
> > Dear system infrastructure people,
> > Do you think a KEY_WIRELESS_CYCLE key would have any application ?
> 
> Not really.
> 
> The naming of the key ultimately will not matter one bit, because it'll
> be misnamed on most platforms anyway, unless we want to do DMI matching
> or something to name the key. And even then, if there's a wifi key but
> no bluetooth key, users may prefer to have the wifi key act as a cycle
> key instead.
> 
> Therefore, this ought to all be policy in the rfkill daemon.
> rfkill-input will be going away as soon as somebody writes a simple
> daemon that allows doing such things, I really don't see us adding
> support for a cycle key to the kernel code, and for the userspace code
> it doesn't matter since users will configure it independent of the key
> code anyway.

This sounds reasonable to me, as the wireless guy in the KDE camp.  I don't 
want to have to handle these keypresses in a user session anyway - I prefer 
that NetworkManager picks up on them and notifies the client of the state 
change.

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
