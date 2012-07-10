From: littlebat <dashing.meng@gmail.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as
 "PS/2 Generic Mouse"(with newly dmesg information)
Date: Tue, 10 Jul 2012 12:16:27 +0800
Message-ID: <20120710121627.22558c22.dashing.meng@gmail.com>
References: <20120706113942.40152322.dashing.meng@gmail.com>
	<20120706051141.GA2937@thinkpad-t410>
	<20120707133519.25bf82d4.dashing.meng@gmail.com>
	<20120709144508.GB4985@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:40862 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab2GJD6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jul 2012 23:58:12 -0400
Received: by gglu4 with SMTP id u4so10845862ggl.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jul 2012 20:58:12 -0700 (PDT)
In-Reply-To: <20120709144508.GB4985@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com

On Mon, 9 Jul 2012 09:45:08 -0500
Seth Forshee <seth.forshee@canonical.com> wrote:
> So it sounds like we don't know how to talk to your touchpad, and
> there's no trivial way to add support for it to the driver. There's
> not really anything more I can do to help since I don't have access to
> the hardware.
Thanks.

Three things:
1, Can you provide a simple tutorial (or web page address) of how to
reverse-engineer a Linux ALPS driver if possible? I have very basic
programming knowledge(shell script, read basic C code except hardware
driver). Maybe, I can provide more detail hardware information about
this ALPS touchpad in this way?

2, Is there a tool, it can show the message when I operate on touchpad
edge scrolling? So, according to the output, it is able to get a dirty
solution about edge scrolling function of Lenovo G360 touchpad.
The funciton of "disable touchpad when typing" has a solution using
python script I have mentioned in the previous posts.

3, If you are interest in this and have time and it is helpful, I can
provide a root password for this laptop to you and run ssh service for
you all the time. Then you can operate this laptop via ssh connection
in this way. You can do anything on this machine even format the
disk :-)
