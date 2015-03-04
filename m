From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 2/2] input: goodix: Add device tree support for 5-finger
 chips
Date: Wed, 4 Mar 2015 11:30:40 +0100
Message-ID: <20150304113040.014ca7f2c14c65b5f7e9672c@ao2.it>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	<1425458053-4559-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:9998 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758628AbbCDKar (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2015 05:30:47 -0500
In-Reply-To: <1425458053-4559-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>

On Wed,  4 Mar 2015 11:34:13 +0300
Aleksei Mamlin <mamlinav@gmail.com> wrote:

> This patch adds device tree support for 5-finger chips, like GT911 and GT912.
>

Hi Aleksei,

from a datasheet I found[1](Pag. 11) I see that some devices provide
the information about the max number of touch points in register 0x804C.

Have you tried if this is true on your 5-finger devices too?
If so, please use this mechanism to populate ts->max_touch_num to avoid
passing hardcoded data.

Thanks,
   Antonio

[1] http://www.wpgholdings.com/uploads/bu/bu_3/MID_20141112/GT9271_Datasheet_20130904.pdf

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
