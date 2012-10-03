From: Kay Sievers <kay@vrfy.org>
Subject: Re: Communicating tablet mode status to userspace
Date: Wed, 3 Oct 2012 17:23:30 +0200
Message-ID: <CAPXgP10+ZzLC98VdaQz19413guR-sKLT47iFLbN-mF_isF0n9A@mail.gmail.com>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
 <20121002233640.GB8542@core.coreip.homeip.net> <CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
 <20121003150542.GA8460@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36789 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933157Ab2JCPXw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 11:23:52 -0400
Received: by obbuo13 with SMTP id uo13so7391111obb.19
        for <linux-input@vger.kernel.org>; Wed, 03 Oct 2012 08:23:51 -0700 (PDT)
In-Reply-To: <20121003150542.GA8460@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Daniel Drake <dsd@laptop.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>

On Wed, Oct 3, 2012 at 5:05 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Oct 03, 2012 at 08:52:31AM -0600, Daniel Drake wrote:
>> On Tue, Oct 2, 2012 at 5:36 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Why can't you change event device ownership to the local user?  Then you
>> > can read and act upon events.
>>
>> That would work, I guess.
>>
>> However, it sounds like your suggesting that we add some custom rules
>> in OLPC's own builds and leave it at that. I'm not sure what
>> user/group we could use for a generic rule matching this hardware.
>
> That shouldn't be a custom rule, other distros bind the keyboard / mouse
> to the local user in order to handle the multi-seat situation properly.
> That should all be done already in the console-kit logic (or whatever
> handles it now.)
>
> Have you looked into that?

The usual model is not uid/gid, it's ACLs dynamically applied for
logged-in users with active sessions:
  http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html
  http://cgit.freedesktop.org/systemd/systemd/tree/src/login/70-uaccess.rules

Kay
