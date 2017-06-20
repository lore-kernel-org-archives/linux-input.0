From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button
 found on some x86 tablets
Date: Tue, 20 Jun 2017 11:29:01 +0200
Message-ID: <1497950941.2559.13.camel@hadess.net>
References: <1725443.Vzhj3lzWjD@z12> <1497911523.2559.4.camel@hadess.net>
         <1567005.gF9xgO7RRS@z12>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39642 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdFTJ3G (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 05:29:06 -0400
In-Reply-To: <1567005.gF9xgO7RRS@z12>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru, linux-input@vger.kernel.org

On Tue, 2017-06-20 at 19:26 +1000, Sergei A. Trusov wrote:
> 
<snip>
> Thank you for this point. Now I see all the changes above are
> redundant:
> we can use a value returned in the *data buffer. It is enough to add 
> only two lines of code to achieve the behaviour of this entire patch.

A bit more with a comment explaining the reason behind those 2 lines,
but shorter patches get my vote ;)
