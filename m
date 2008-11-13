From: "Alexey Klimov" <klimov.linux@gmail.com>
Subject: Re: next: 6a13378a5 (Don't allow KWorld radio...) is broken
Date: Thu, 13 Nov 2008 05:24:24 +0300
Message-ID: <208cbae30811121824g2e2d4f3bvf2c982c9f54b30a2@mail.gmail.com>
References: <491B3E90.5020307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:54257 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbYKMCYZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 21:24:25 -0500
Received: by rv-out-0506.google.com with SMTP id k40so693258rvb.1
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2008 18:24:24 -0800 (PST)
In-Reply-To: <491B3E90.5020307@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Tobias Lorenz <tobias.lorenz@gmx.net>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Nov 12, 2008 at 11:37 PM, Jiri Slaby <jirislaby@gmail.com> wrote:
> There is a difference between hid_blacklist and hid_ignore_list. One forbids
> generic hid driver to bind the device, while the other forces usbhid to release
> the device and move hands away from it.

I figured that out and remembered that this thing needed to be fixed and
then got side-tracked by other things. Sorry.

On Thu, Nov 13, 2008 at 3:33 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> Alexey, did you actually test it?
> I'd prefer taking this through my tree, if it doesn't impose any problem
> on your side. Could you please fix it up and resend?

It good thing to do. May i make patch against current kernel tree (rc4-git3) ?
I also going to make patch for radio-mr800 that has wrong hidquirks too.
I can send now, because this two patches ready.

-- 
Best regards, Klimov Alexey
