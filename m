From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event state
Date: Tue, 12 Jul 2011 13:35:41 -0700
Message-ID: <201107121335.41556.dmitry.torokhov@gmail.com>
References: <20110709132046.90A119D401C@zog.reactivated.net> <CAGq3pz4ueyiTg1usRwangBJfuPwYPoOC0k83ygKs2RikfOQyGw@mail.gmail.com> <15489.1310501220@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59428 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab1GLUn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 16:43:56 -0400
In-Reply-To: <15489.1310501220@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Fox <pgf@laptop.org>
Cc: Daniel Drake <dsd@laptop.org>, Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>, linux-input@vger.kernel.org

On Tuesday, July 12, 2011 01:07:00 PM Paul Fox wrote:
> daniel wrote:
>  > On 11 July 2011 17:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> 
wrote:
>  > > Now I'd say that this utility probably better fit into linuxconsole
>  > > project with the rest of input-related utilities...
>  > 
>  > http://sourceforge.net/projects/linuxconsole/ ?
>  > 
>  > This must have been what you were referring to before. Yes, this
>  > looks like a more appropriate home. I'll take it in that direction.
> 
> i disagree.  the contents of that package seems to be mostly for
> testing and legacy support.  access to the state of input switches in
> a generic way seems far more generally useful than that.
> 
> i would rather not see the sysfs state variable go away in the first
> place -- it's too convenient to use, and inexpensive to implement --
> needing an ioctl for this seems like a step backwards.  but barring
> that, relegating the evstate functionality to linuxconsole seems wrong.
> (for instance, i don't think the OLPC laptop distros have a need for
> any of the other utilities in linuxconsole.)

You can package only what you need from it, no need to package everything.


-- 
Dmitry
