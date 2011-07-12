From: Paul Fox <pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event state
Date: Tue, 12 Jul 2011 16:07:00 -0400
Message-ID: <15489.1310501220@foxharp.boston.ma.us>
References: <20110709132046.90A119D401C@zog.reactivated.net> <20110711121836.GJ5214@nb.net.home> <20110711163917.GA1648@core.coreip.homeip.net> <CAGq3pz4ueyiTg1usRwangBJfuPwYPoOC0k83ygKs2RikfOQyGw@mail.gmail.com> (sfid-20110711_124927_157078_A3E8F7E6)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAGq3pz4ueyiTg1usRwangBJfuPwYPoOC0k83ygKs2RikfOQyGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org> (sfid-20110711_124927_157078_A3E8F7E6)
Content-ID: <15486.1310501220.1-YqHaedqsyMbgnLo7xJiJXVwrdKVBSruJ@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karel Zak <kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

daniel wrote:
 > On 11 July 2011 17:39, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
 > > Now I'd say that this utility probably better fit into linuxconsole
 > > project with the rest of input-related utilities...
 > 
 > http://sourceforge.net/projects/linuxconsole/ ?
 > 
 > This must have been what you were referring to before. Yes, this looks
 > like a more appropriate home. I'll take it in that direction.

i disagree.  the contents of that package seems to be mostly for
testing and legacy support.  access to the state of input switches in
a generic way seems far more generally useful than that.

i would rather not see the sysfs state variable go away in the first
place -- it's too convenient to use, and inexpensive to implement --
needing an ioctl for this seems like a step backwards.  but barring
that, relegating the evstate functionality to linuxconsole seems wrong.
(for instance, i don't think the OLPC laptop distros have a need for
any of the other utilities in linuxconsole.)

paul
=---------------------
 paul fox, pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
