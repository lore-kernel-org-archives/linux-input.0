From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic Mouse"
Date: Wed, 4 Jul 2012 22:20:09 -0500
Message-ID: <20120705032009.GA8748@burratino>
References: <CAAT31jY5_P13xjybsYFm3oix0pjbbzRihCrjecQ+cXkrHhnrCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55192 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab2GEDUR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 23:20:17 -0400
Received: by obbuo13 with SMTP id uo13so12370673obb.19
        for <linux-input@vger.kernel.org>; Wed, 04 Jul 2012 20:20:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAAT31jY5_P13xjybsYFm3oix0pjbbzRihCrjecQ+cXkrHhnrCQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: linux-input@vger.kernel.org, seth.forshee@canonical.com

(dropping Debian bug from cc list)
Hi,

littlebat wrote:

>                                                               I report a
> kernel bug about ALPS touchpad to you.
>
> My lenovo G360 has an ALPS touchpad, show in Windows 7 Home Editition
> OEM in this laptop. Under Debian Squeeze or Ubuntu 12.04 LTS LiveCD in same
> laptop, the left and
> right key, single and double tap, tracking  of touchpad works well.
> But, there isn't touchpad tab in gnome mouse setting dialog, so I
> can't setup edge scrolling and disable touchpad on typing. xinput
> shows it is a "PS/2 Generic Mouse".
[...]
> Tell me If need more detail information.

Thanks.  Forgive me for being dense: can you spell this out a little
more for me?

Is the following summary correct?

 - 2.6.32.y (Debian squeeze) works well, using xinput or synclient to
   configure
 - 3.2.y (Ubuntu 12.04 LTS) sees a generic mouse, unconfigurable
 - 3.2.y (Debian squeeze-backports) is likewise unconfigurable
 - 3.4.4 (Debian experimental) is also unconfigurable

Could you provide full "dmesg" output from booting a working and
non-working kernel?

Hope that helps,
Jonathan
