From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 16:28:18 +0100
Message-ID: <CAPHpN5NY=1jCaa2yADzvYXkFc4a_1Nkb8JVpbM4pVqy7ZHOYkg@mail.gmail.com>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com>
 <20120214151903.GA5616@polaris.bitmath.org> <4F3A7C84.4000901@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56785 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab2BNP2k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 10:28:40 -0500
Received: by vbjk17 with SMTP id k17so51514vbj.19
        for <linux-input@vger.kernel.org>; Tue, 14 Feb 2012 07:28:39 -0800 (PST)
In-Reply-To: <4F3A7C84.4000901@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Feb 14, 2012 at 4:23 PM, Chase Douglas
<chase.douglas@canonical.com> wrote:
>
> I can add that, it's just superfluous. It doesn't really tell the reader
> anything if they need to know what is going on. Unless the message is
> supposed to copy the definition of the properties themselves, which is
> rather pointless.
>
> It's like documenting a function:
>
> bool is_object_mutable();
> Returns true if object is mutable;
>
> There's really no point.

We don't always have the message+code. In the end we have only commit
msgs like the raw changelog here :
http://www.kernel.org/pub/linux/kernel/v3.0/ChangeLog-3.2.6

i
