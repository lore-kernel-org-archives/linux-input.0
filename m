From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: Re: [PATCH 2/2] input: goodix: Add device tree support for 5-finger
 chips
Date: Wed, 4 Mar 2015 13:55:08 +0300
Message-ID: <20150304135508.d54656131ed7f6e22c3cb7df@gmail.com>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	<1425458053-4559-1-git-send-email-mamlinav@gmail.com>
	<20150304113040.014ca7f2c14c65b5f7e9672c@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35780 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933066AbbCDKzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 05:55:09 -0500
In-Reply-To: <20150304113040.014ca7f2c14c65b5f7e9672c@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>

On Wed, 4 Mar 2015 11:30:40 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> On Wed,  4 Mar 2015 11:34:13 +0300
> Aleksei Mamlin <mamlinav@gmail.com> wrote:
> 
> > This patch adds device tree support for 5-finger chips, like GT911 and GT912.
> >
> 
> Hi Aleksei,
> 
> from a datasheet I found[1](Pag. 11) I see that some devices provide
> the information about the max number of touch points in register 0x804C.
> 
> Have you tried if this is true on your 5-finger devices too?
> If so, please use this mechanism to populate ts->max_touch_num to avoid
> passing hardcoded data.
> 
Hi Antonio,

I checked datasheets and you are right, seems that all Goodix GT9xx series provides max number of touch points in register 0x804C.
I'll rewrite driver to use data from 0x804C register.


> Thanks,
>    Antonio
> 
> [1] http://www.wpgholdings.com/uploads/bu/bu_3/MID_20141112/GT9271_Datasheet_20130904.pdf
> 
> -- 
> Antonio Ospite
> http://ao2.it
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?


-- 
Thanks and regards,
Aleksei Mamlin
