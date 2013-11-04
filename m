From: simon@mungewell.org
Subject: Re: About the PS3 Sixaxis linux driver
Date: Mon, 4 Nov 2013 16:07:13 -0500
Message-ID: <5c4fb4506c05b41aaab84a03b585b037.squirrel@mungewell.org>
References: <526A697E.7050605@corpsmoderne.net>
    <1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:57352 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab3KDVHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Nov 2013 16:07:17 -0500
In-Reply-To: <1256411740.1745741.1383597450835.JavaMail.root@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <btissoir@redhat.com>
Cc: case <case@corpsmoderne.net>, linux-input@vger.kernel.org

> Hi Marc,
>
> (adding in CC the linux-input mailing list)
>
> Regarding your problem I vaguely remember something about not having
> duplicated axis with the buttons. My memory is rather confuse about this,
> so I may be wrong (but others on the list may have a fresher memory).
> Other than that, if only one axis is not working, then it is definitively
> a bug...
>
> I'll try to add this to my todo list, but I can not guarantee anything
> soon. If someone else can confirm and fix this, I'll be happy.

There was something a couple of years ago with the multi-touch stuff
screening out HID reports for the D-Pad axis.

http://comments.gmane.org/gmane.linux.kernel.input/19632

Don't know the current situation,
Simon

