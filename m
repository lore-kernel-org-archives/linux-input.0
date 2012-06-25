From: Jarod Wilson <jarod@redhat.com>
Subject: Re: Missing Key-codes from <linux/input.h> file
Date: Mon, 25 Jun 2012 10:26:06 -0400
Message-ID: <20120625142606.GA13212@redhat.com>
References: <CAOt5+pRZ=qqEZ2Ra3yFbLqoHhDGFkzHs4cEXvFv5trbukd4MdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43560 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388Ab2FYO0K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 10:26:10 -0400
Content-Disposition: inline
In-Reply-To: <CAOt5+pRZ=qqEZ2Ra3yFbLqoHhDGFkzHs4cEXvFv5trbukd4MdA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dharam Kumar <dharam.kumar.gupta@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Jun 25, 2012 at 07:39:25PM +0530, Dharam Kumar wrote:
> Hi,
> I'm working on a module which is an input device and hence it needs to
> report certain key events.
> 
> While browsing through the <linux/input.h>, I did find most of the
> key-codes(which I need to use) already defined but not all.
> 
> Few of the KEY_xxx which i could not find are:
> 
> a.) A Key for going to the previous channel.

I believe that's what this one is intended for:

#define KEY_PREVIOUS            0x19c

> b.) Keys for Moving upper-right, lower-right, upper-left and
> lower-left direction(probably a GUI(or a grid of icons),where you move
> diagonally)

Sounds a bit like joystick functionality, which already exists.

> d.) A key for Subpicture (this 'subpicture' key is defined in CEA-931C).

Could have sworn there was a picture-in-picture button, which may or may
not be the same thing, but I don't see it now...

-- 
Jarod Wilson
jarod@redhat.com

